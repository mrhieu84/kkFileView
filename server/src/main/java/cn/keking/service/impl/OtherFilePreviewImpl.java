package cn.keking.service.impl;

import cn.keking.model.FileAttribute;
import cn.keking.service.FilePreview;
import cn.keking.utils.KkFileUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 * Created by kl on 2018/1/17.
 * Content :Other documents
 */
@Service
public class OtherFilePreviewImpl implements FilePreview {


    @Override
    public String filePreviewHandle(String url, Model model, FileAttribute fileAttribute) {
        return this.notSupportedFile(model, fileAttribute, "The system does not yet support online preview of files in this format.");
    }

    /**
     * Universal preview fails, directed to unsupported file response page
     *
     * @return page
     */
    public String notSupportedFile(Model model, FileAttribute fileAttribute, String errMsg) {
        return this.notSupportedFile(model, fileAttribute.getSuffix(), errMsg);
    }

    /**
     * Universal preview fails, directed to unsupported file response page
     *
     * @return page
     */
    public String notSupportedFile(Model model, String errMsg) {
        return this.notSupportedFile(model, "unknown", errMsg);
    }

    /**
     * Universal preview fails, directed to unsupported file response page
     *
     * @return page
     */
    public String notSupportedFile(Model model, String fileType, String errMsg) {
        model.addAttribute("fileType",  KkFileUtils.htmlEscape(fileType));
        model.addAttribute("msg", KkFileUtils.htmlEscape(errMsg));
        return NOT_SUPPORTED_FILE_PAGE;
    }


}
