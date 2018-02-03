package com.thinkgem.jeesite.modules.sign.utils;

import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.parser.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by bb on 2018-01-04.
 */
public class XyzmoSignatureDataExtractor {


    public static final String SRC = "c:/test-sign5.pdf";
    final PdfReader reader;

    public XyzmoSignatureDataExtractor(PdfReader reader) {
        this.reader = reader;
    }

    public PdfImageObject extractImage(String signatureName) throws IOException {
        MyImageRenderListener listener = new MyImageRenderListener();

        PdfDictionary sigFieldDic = reader.getAcroFields().getFieldItem(signatureName).getMerged(0);
        PdfDictionary appearancesDic = sigFieldDic.getAsDict(PdfName.AP);
        PdfStream normalAppearance = appearancesDic.getAsStream(PdfName.N);

        PdfDictionary resourcesDic = normalAppearance.getAsDict(PdfName.RESOURCES);

        PdfContentStreamProcessor processor = new PdfContentStreamProcessor(listener);
        processor.processContent(ContentByteUtils.getContentBytesFromContentObject(normalAppearance), resourcesDic);

        return listener.image;
    }

    class MyImageRenderListener implements RenderListener {
        public void beginTextBlock() {
        }

        public void endTextBlock() {
        }

        public void renderImage(ImageRenderInfo renderInfo) {
            try {
                image = renderInfo.getImage();
            } catch (IOException e) {
                throw new RuntimeException("Failure retrieving image", e);
            }
        }

        public void renderText(TextRenderInfo renderInfo) {
        }

        PdfImageObject image = null;
    }


    public static void main(String[] args) throws Exception {
        PdfReader reader = new PdfReader(SRC);
        XyzmoSignatureDataExtractor extractor = new XyzmoSignatureDataExtractor(reader);
        AcroFields acroFields = reader.getAcroFields();

        for (String name: acroFields.getSignatureNames())
        {
            System.out.printf("\n signature '%s'.\n", name);
            PdfImageObject image = extractor.extractImage(name);

            //1.若签章为印章
            /*FileOutputStream os = new FileOutputStream("c:/" + name + "." + image.getFileType());
            os.write(image.getImageAsBytes());
            os.close();*/
            InputStream imageInputStream = new ByteArrayInputStream(image.getImageAsBytes());
            DealWithPicUtil.transferAlpha(imageInputStream,0);

            PdfDictionary imageDictionary = image.getDictionary();
            PRStream maskStream = (PRStream) imageDictionary.getAsStream(PdfName.SMASK);
            if (maskStream != null)
            {
                PdfImageObject maskImage = new PdfImageObject(maskStream);

                //2.若签章为签名
                /*os = new FileOutputStream("c:/" + name + "-mask." + maskImage.getFileType());
                os.write(maskImage.getImageAsBytes());
                os.close();*/
                imageInputStream = new ByteArrayInputStream(maskImage.getImageAsBytes());
                DealWithPicUtil.changeGrayColorImage(imageInputStream);

            }
        }

    }

}