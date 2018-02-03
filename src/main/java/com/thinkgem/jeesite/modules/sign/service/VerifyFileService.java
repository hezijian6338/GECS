package com.thinkgem.jeesite.modules.sign.service;

import com.thinkgem.jeesite.common.condition.Condition;
import com.thinkgem.jeesite.modules.sign.dto.VerifyResultDTO;
import com.thinkgem.jeesite.modules.sign.utils.VerifyUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.SignatureException;
import java.util.List;

/**
 * Created by bb on 2018-01-30.
 */
@Service
@Transactional(readOnly = true)
public class VerifyFileService {

    private static final String DOCUMENT_VALID = "验证通过，文档完整！";
    private static final String DOCUMENT_INVALID = "文档失效，已被篡改！";

    public Condition verifyByFile(String checkPath) {

        //获得当前文件
        checkPath = checkPath.replace("/img","C:/test");

        try {
            //验证证书信息
            List<VerifyResultDTO> list2 = VerifyUtil.getCerInfo(checkPath);
            for (VerifyResultDTO verifyResultDTO : list2) {
                if ("false".equals(verifyResultDTO.getIsDocumentUseful())) {
                    verifyResultDTO.setIsDocumentUseful(DOCUMENT_INVALID);
                    return new Condition(Condition.ERROR_CODE, "文件验证失败！查无此验章文件信息，或文件已被篡改！");
                }
                verifyResultDTO.setIsDocumentUseful(DOCUMENT_VALID);
            }

            return new Condition(Condition.SUCCESS_CODE, "验证成功!", list2);
        } catch (SignatureException e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "文件验证发生错误!");
        } catch (GeneralSecurityException e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "文件验证发生错误!");
        } catch (IOException e) {
            e.printStackTrace();
            return new Condition(Condition.ERROR_CODE, "文件验证发生错误!");
        }


    }
}
