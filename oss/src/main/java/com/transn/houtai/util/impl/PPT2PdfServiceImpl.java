package com.transn.houtai.util.impl;

import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aspose.slides.Presentation;
import com.aspose.slides.SaveFormat;
import com.transn.houtai.util.AsposeLicenseUtil;
import com.transn.houtai.util.ConvertStatus;
import com.transn.houtai.util.File2PdfService;

/**
 * 将ppt文件转换为pdf文件
 * @author barry.wang
 * @version 2.0.0
 * @history 2017-03-13 barry.wang 创建 
 */
public class PPT2PdfServiceImpl implements File2PdfService {
    private Logger logger = LoggerFactory.getLogger(PPT2PdfServiceImpl.class);

    @Override
    public ConvertStatus convert2Pdf(InputStream inputStream, OutputStream outputStream) {
        try {
            if (AsposeLicenseUtil.setSlidesLicense()) {
                long start = System.currentTimeMillis();

                Presentation presentation = new Presentation(inputStream);
                presentation.save(outputStream, SaveFormat.Pdf);

                long end = System.currentTimeMillis();
                logger.debug("convert ppt2pdf completed, elapsed " + (end - start) / 1000.0 + " seconds!");
                return ConvertStatus.SUCCESS;
            } else {
                return ConvertStatus.LICENSE_ERROR;
            }
        } catch (Exception e) {
            logger.error("convert ppt2pdf error!", e);
            return ConvertStatus.CONVERT_PPT2PDF_ERROR;
        }
    }
}
