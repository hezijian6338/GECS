package com.thinkgem.jeesite.modules.sign.utils;

import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.PRStream;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.PdfImageObject;
import com.lowagie.text.pdf.PdfPKCS7;
import com.thinkgem.jeesite.modules.sign.dto.VerifyResultDTO;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.SignatureException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;

/**
 * 读取证书信息的工具类.
 */
public class VerifyUtil {

	private static final String VALID = "有效";
	private static final String INVALID = "无效";
	private static final String TRUST_VALID_Cer = "受信任的有效证书";
	private static final String NO_TRUST_VALID_Cer = "不受信任的有效证书";
	private static final String INVALID_Cer = "无效证书";
	private static final String DOCUMENT_VALID = "验证通过，文档完整！";
	private static final String DOCUMENT_INVALID = "文档失效，已被篡改！";

	/**
	 *
	 * @param verifyPath
	 * @return
	 * @throws KeyStoreException
	 * @throws IOException
	 * @throws SignatureException
	 */
	public static List<VerifyResultDTO> getCerInfo(String verifyPath) throws GeneralSecurityException, IOException {
		
		        List<VerifyResultDTO> list = new ArrayList<VerifyResultDTO>();
					
                //加载所有的密钥库
		        KeyStore kall = PdfPKCS7.loadCacertsKeyStore();
		        Enumeration aliases = kall.aliases();
		        //显示所有的证书别名
		        while (aliases.hasMoreElements()) {
					aliases.nextElement();
		            //System.out.println(aliases.nextElement());
		        }
		        //读取pdf文档
		        PdfReader reader = new PdfReader(verifyPath);
		        AcroFields af = reader.getAcroFields();
		        com.lowagie.text.pdf.PdfReader reader2 = new com.lowagie.text.pdf.PdfReader(verifyPath);
		        com.lowagie.text.pdf.AcroFields af2 = reader2.getAcroFields();
		        ArrayList<String> names = af.getSignatureNames();

		        //遍历每个章
		        for (int k = 0; k < names.size(); ++k) {
		        	
			        VerifyResultDTO verifyResultDTO = new VerifyResultDTO();
		        	
		            String name = (String) names.get(k);
					System.out.printf("\n signature '%s'.\n", name);

					PdfPKCS7 pk = af2.verifySignature(name);
		            
		            Calendar cal = pk.getSignDate();
		            
		            java.security.cert.Certificate[] pkc = pk.getCertificates();
		            
		            //签名有效性
		            if (af.signatureCoversWholeDocument(name)) {
		            	verifyResultDTO.setIsSignValid(VALID);
		            	System.out.println("签章有效性: "+ VALID);
					}else {
						verifyResultDTO.setIsSignValid(INVALID);
		            	System.out.println("签章有效性: "+ INVALID);
					}
		            
		            //签章所用证书当前状态
		            Object fails[] = PdfPKCS7.verifyCertificates(pkc, kall, null, cal);
		            if (fails == null) {
			            verifyResultDTO.setCerState(TRUST_VALID_Cer);
		            	System.out.println("签章所用证书当前状态: " + TRUST_VALID_Cer);
		            } else if (fails[0] == null){
			            verifyResultDTO.setCerState(INVALID_Cer);
		                System.out.println("签章所用证书当前状态: " + INVALID_Cer);
		            } else {
			            verifyResultDTO.setCerState(NO_TRUST_VALID_Cer);
		                System.out.println("签章所用证书当前状态: " + NO_TRUST_VALID_Cer);
		            }
		            
		            //文档完整性
		            if (pk.verify()) {
		            	System.out.println("文档完整性: " + DOCUMENT_VALID);
					}else {
						System.out.println("文档完整性: " + DOCUMENT_INVALID);
					}

					//获取签章图
					XyzmoSignatureDataExtractor extractor = new XyzmoSignatureDataExtractor(reader);
					PdfImageObject image = extractor.extractImage(name);
		            String base64Image = null;

					//1.若签章为印章
					InputStream imageInputStream = new ByteArrayInputStream(image.getImageAsBytes());
					base64Image = DealWithPicUtil.transferAlpha(imageInputStream,0);

					PdfDictionary imageDictionary = image.getDictionary();
					PRStream maskStream = (PRStream) imageDictionary.getAsStream(PdfName.SMASK);
					System.out.println("maskStream:"+maskStream);
					//2.若签章为签名
					if (maskStream != null)
					{
						PdfImageObject maskImage = new PdfImageObject(maskStream);
						imageInputStream = new ByteArrayInputStream(maskImage.getImageAsBytes());
						base64Image = DealWithPicUtil.changeGrayColorImage(imageInputStream);

					}

					//截取签章用户
					int start = PdfPKCS7.getSubjectFields(pk.getSigningCertificate()).toString().indexOf("CN=");
					String signer = PdfPKCS7.getSubjectFields(pk.getSigningCertificate()).toString();
					String a = PdfPKCS7.getSubjectFields(pk.getSigningCertificate()).toString().substring(0,start+4);
					signer = signer.replace(a, "");
					int end = signer.indexOf("]");
					String b = signer.substring(end);
					signer = signer.replace(b,"");

					verifyResultDTO.setSigner(signer);
					verifyResultDTO.setSignImage(base64Image);
		            verifyResultDTO.setTotalRevisions(String.valueOf(af.getTotalRevisions()));
		            verifyResultDTO.setRevisions(String.valueOf(af.getRevision(name)));
		            verifyResultDTO.setSignDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime()));
		            verifyResultDTO.setCerHolder(String.valueOf(PdfPKCS7.getSubjectFields(pk.getSigningCertificate())));
		            verifyResultDTO.setCerAuthority(String.valueOf(PdfPKCS7.getIssuerFields(pk.getSigningCertificate())));
		            verifyResultDTO.setCerDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pk.getSigningCertificate().getNotBefore())+" 至 "+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pk.getSigningCertificate().getNotAfter()));
		            verifyResultDTO.setCerReason(pk.getReason());
		            verifyResultDTO.setCerLocation(pk.getLocation());
					verifyResultDTO.setIsDocumentUseful(String.valueOf(pk.verify()));


					System.out.println("签章用户: " + signer);
                    System.out.println("本文档共包含电子签章个数: " + af.getTotalRevisions());
                    System.out.println("签章序号: " + af.getRevision(name) );
                    System.out.println("签章日期:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime()));
                    System.out.println("证书持有人: " + PdfPKCS7.getSubjectFields(pk.getSigningCertificate()));
                    System.out.println("证书颁发机构: " + PdfPKCS7.getIssuerFields(pk.getSigningCertificate()));
                    System.out.println("证书有效期: " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pk.getSigningCertificate().getNotBefore())+" 至 "+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(pk.getSigningCertificate().getNotAfter()));
                    System.out.println("签章地点: " + pk.getLocation());
                    System.out.println("签章原因: " + pk.getReason());
                    System.out.println("签章图: " + base64Image);

                    //System.out.println("Certificate" + Arrays.toString(pkc));

			        list.add(verifyResultDTO);
		        }
		        
				return list;
		
	}
	
	public static void main(String[] args) throws GeneralSecurityException, IOException {
		List list =  getCerInfo("C:\\0412_demo3.pdf");
	}
}
