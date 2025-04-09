package cn.keking.service;

import cn.keking.config.ConfigConstants;
import cn.keking.model.FileAttribute;
import cn.keking.model.FileType;
import cn.keking.service.cache.CacheService;
import cn.keking.service.cache.NotResourceCache;
import cn.keking.utils.EncodingDetects;
import cn.keking.utils.KkFileUtils;
import cn.keking.utils.UrlEncoderUtils;
import cn.keking.utils.WebUtils;
import cn.keking.web.filter.BaseUrlFilter;
import com.aspose.cad.*;
import com.aspose.cad.fileformats.cad.CadDrawTypeMode;
import com.aspose.cad.fileformats.tiff.enums.TiffExpectedFormat;
import com.aspose.cad.imageoptions.*;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.apache.poi.EncryptedDocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.*;
import java.util.stream.IntStream;

/**
 * @author yudian-it
 * @date 2017/11/13
 */
@Component
@DependsOn(ConfigConstants.BEAN_NAME)
public class FileHandlerService implements InitializingBean {

    private static final String PDF2JPG_IMAGE_FORMAT = ".jpg";
    private static final String PDF_PASSWORD_MSG = "password";
    private final Logger logger = LoggerFactory.getLogger(FileHandlerService.class);
    private final String fileDir = ConfigConstants.getFileDir();
    private final CacheService cacheService;
    @Value("${server.tomcat.uri-encoding:UTF-8}")
    private String uriEncoding;

    public FileHandlerService(CacheService cacheService) {
        this.cacheService = cacheService;
    }

    /**
     * @return Converted file collection(缓存)
     */
    public Map<String, String> listConvertedFiles() {
        return cacheService.getPDFCache();
    }

    /**
     * @return Converted files, obtained based on file name
     */
    public String getConvertedFile(String key) {
        return cacheService.getPDFCache(key);
    }

    /**
     * @param key pdf local path
     * @return The local relative path of the image that has been converted from pdf to image
     */
    public Integer getPdf2jpgCache(String key) {
        return cacheService.getPdfImageCache(key);
    }


    /**
     * Get file negative from path
     *
     * @param path Something like this: C:\Users\yudian-it\Downloads
     * @return file name
     */
    public String getFileNameFromPath(String path) {
        return path.substring(path.lastIndexOf(File.separator) + 1);
    }

    /**
     * Get relative path
     *
     * @param absolutePath absolute path
     * @return relative path
     */
    public String getRelativePath(String absolutePath) {
        return absolutePath.substring(fileDir.length());
    }

    /**
     * Added PDF caching after conversion
     *
     * @param fileName pdf file name
     * @param value    cache relative path
     */
    public void addConvertedFile(String fileName, String value) {
        cacheService.putPDFCache(fileName, value);
    }

    /**
     * Add cache of converted picture groups
     *
     * @param pdfFilePath pdf file absolute path
     * @param num         Number of pictures
     */
    public void addPdf2jpgCache(String pdfFilePath, int num) {
        cacheService.putPdfImageCache(pdfFilePath, num);
    }

    /**
     * Get the image files in the compressed package in redis
     *
     * @param compressFileKey compressFileKey
     * @return Image file access URL list
     */
    public List<String> getImgCache(String compressFileKey) {
        return cacheService.getImgCache(compressFileKey);
    }

    /**
     * Set the image files in the compressed package in redis
     *
     * @param fileKey fileKey
     * @param imgs    Image file access URL list
     */
    public void putImgCache(String fileKey, List<String> imgs) {
        cacheService.putImgCache(fileKey, imgs);
    }

    /**
     * cad defines thread pool
     */
    private ExecutorService pool = null;

    @Override
    public void afterPropertiesSet() throws Exception {
        pool = Executors.newFixedThreadPool(ConfigConstants.getCadThread());
    }

    /**
     * Operate the converted file (change the encoding method)
     *
     * @param outFilePath absolute file path
     */
    public void doActionConvertedFile(String outFilePath) {
        String charset = EncodingDetects.getJavaEncode(outFilePath);
        StringBuilder sb = new StringBuilder();
        try (InputStream inputStream = new FileInputStream(outFilePath); BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, charset))) {
            String line;
            while (null != (line = reader.readLine())) {
                if (line.contains("charset=gb2312")) {
                    line = line.replace("charset=gb2312", "charset=utf-8");
                }
                sb.append(line);
            }
            // Add sheet control header
            sb.append("<script src=\"js/jquery-3.6.1.min.js\" type=\"text/javascript\"></script>");
            sb.append("<script src=\"excel/excel.header.js\" type=\"text/javascript\"></script>");
            sb.append("<link rel=\"stylesheet\" href=\"excel/excel.css\">");
        } catch (IOException e) {
            e.printStackTrace();
        }
        // rewrite file
        try (FileOutputStream fos = new FileOutputStream(outFilePath); BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(fos, StandardCharsets.UTF_8))) {
            writer.write(sb.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Get the web access address after converting local pdf to image
     *
     * @param pdfFilePath pdf file name
     * @param index       Image index
     * @return Image access address
     */
    private String getPdf2jpgUrl(String pdfFilePath, int index) {
        String baseUrl = BaseUrlFilter.getBaseUrl();
        pdfFilePath = pdfFilePath.replace(fileDir, "");
        String pdfFolder = pdfFilePath.substring(0, pdfFilePath.length() - 4);
        String urlPrefix;
        try {
            urlPrefix = baseUrl + URLEncoder.encode(pdfFolder, uriEncoding).replaceAll("\\+", "%20");
        } catch (UnsupportedEncodingException e) {
            logger.error("UnsupportedEncodingException", e);
            urlPrefix = baseUrl + pdfFolder;
        }
        return urlPrefix + "/" + index + PDF2JPG_IMAGE_FORMAT;
    }

    /**
     * Get the pdf in the cache and convert it to a jpg picture set
     *
     * @param pdfFilePath pdf file path
     * @return Picture access collection
     */
    private List<String> loadPdf2jpgCache(String pdfFilePath) {
        List<String> imageUrls = new ArrayList<>();
        Integer imageCount = this.getPdf2jpgCache(pdfFilePath);
        if (Objects.isNull(imageCount)) {
            return imageUrls;
        }
        IntStream.range(0, imageCount).forEach(i -> {
            String imageUrl = this.getPdf2jpgUrl(pdfFilePath, i);
            imageUrls.add(imageUrl);
        });
        return imageUrls;
    }

    /**
     * Convert pdf files to jpg picture sets
     * fileNameFilePath pdf file path
     * pdfFilePath pdf output file path
     * pdfName     pdf file name
     * loadPdf2jpgCache Picture access collection
     */
    public List<String> pdf2jpg(String fileNameFilePath, String pdfFilePath, String pdfName, FileAttribute fileAttribute) throws Exception {
        boolean forceUpdatedCache = fileAttribute.forceUpdatedCache();
        boolean usePasswordCache = fileAttribute.getUsePasswordCache();
        String filePassword = fileAttribute.getFilePassword();
        PDDocument doc;
        final String[] pdfPassword = {null};
        final int[] pageCount = new int[1];
        if (!forceUpdatedCache) {
            List<String> cacheResult = this.loadPdf2jpgCache(pdfFilePath);
            if (!CollectionUtils.isEmpty(cacheResult)) {
                return cacheResult;
            }
        }
        List<String> imageUrls = new ArrayList<>();
        File pdfFile = new File(fileNameFilePath);
        if (!pdfFile.exists()) {
            return null;
        }
        int index = pdfFilePath.lastIndexOf(".");
        String folder = pdfFilePath.substring(0, index);
        File path = new File(folder);
        if (!path.exists() && !path.mkdirs()) {
            logger.error("Failed to create conversion file [{}] directory, please check directory permissions！", folder);
        }
        try {
            doc = Loader.loadPDF(pdfFile, filePassword);
            doc.setResourceCache(new NotResourceCache());
            pageCount[0] = doc.getNumberOfPages();
        } catch (IOException e) {
            Throwable[] throwableArray = ExceptionUtils.getThrowables(e);
            for (Throwable throwable : throwableArray) {
                if (throwable instanceof IOException || throwable instanceof EncryptedDocumentException) {
                    if (e.getMessage().toLowerCase().contains(PDF_PASSWORD_MSG)) {
                        pdfPassword[0] = PDF_PASSWORD_MSG;  //Query that the file is a password file and output the value with password
                    }
                }
            }
            if (!PDF_PASSWORD_MSG.equals(pdfPassword[0])) {  //The file is abnormal. The error reason is not password reason. The output error is
                logger.error("Convert pdf exception, pdfFilePath：{}", pdfFilePath, e);
            }
            throw new Exception(e);
        }
        Callable <List<String>> call = () ->  {
            try {
                String imageFilePath;
                BufferedImage image = null;
                PDFRenderer pdfRenderer = new PDFRenderer(doc);
                pdfRenderer.setSubsamplingAllowed(true);
                for (int pageIndex = 0; pageIndex < pageCount[0]; pageIndex++) {
                    imageFilePath = folder + File.separator + pageIndex + PDF2JPG_IMAGE_FORMAT;
                    image = pdfRenderer.renderImageWithDPI(pageIndex, ConfigConstants.getPdf2JpgDpi(), ImageType.RGB);
                    ImageIOUtil.writeImage(image, imageFilePath, ConfigConstants.getPdf2JpgDpi());
                    String imageUrl = this.getPdf2jpgUrl(pdfFilePath, pageIndex);
                    imageUrls.add(imageUrl);
                }
                image.flush();
            } catch (IOException e) {
                throw new Exception(e);
            } finally {
                doc.close();
            }
            return imageUrls;
        };
        Future<List<String>> result = pool.submit(call);
        int pdftimeout;
        if(pageCount[0] <=50){
            pdftimeout = ConfigConstants.getPdfTimeout();
        }else if(pageCount[0] <=200){
            pdftimeout = ConfigConstants.getPdfTimeout80();
        }else {
            pdftimeout = ConfigConstants.getPdfTimeout200();
        }
        try {
            result.get(pdftimeout, TimeUnit.SECONDS);
            // If no data is returned within the timeout period: a TimeoutException is thrown
        } catch (InterruptedException | ExecutionException e) {
            throw new Exception(e);
        } catch (TimeoutException e) {
            throw new Exception("overtime");
        } finally {
            //closure
            doc.close();
        }
        if (usePasswordCache || ObjectUtils.isEmpty(filePassword)) {   //Encrypt files to determine whether to enable caching commands
            this.addPdf2jpgCache(pdfFilePath, pageCount[0]);
        }
        return imageUrls;
    }

    /**
     * Convert cad files to pdf
     *
     * @param inputFilePath  cad file path
     * @param outputFilePath pdf output file path
     * @return Is the conversion successful?
     */
    public String cadToPdf(String inputFilePath, String outputFilePath, String cadPreviewType, FileAttribute fileAttribute) throws Exception {
        final InterruptionTokenSource source = new InterruptionTokenSource();//CAD delay
        final SvgOptions SvgOptions = new SvgOptions();
        final PdfOptions pdfOptions = new PdfOptions();
        final  TiffOptions TiffOptions =  new TiffOptions(TiffExpectedFormat.TiffJpegRgb);
        if (fileAttribute.isCompressFile()) { //Determine whether it is a compressed package and create a new directory.
            int index = outputFilePath.lastIndexOf("/");  //Capture the content before the last slash
            String folder = outputFilePath.substring(0, index);
            File path = new File(folder);
            //Directory does not exist Create a new directory
            if (!path.exists()) {
                path.mkdirs();
            }
        }
        File outputFile = new File(outputFilePath);
        try {
            LoadOptions opts = new LoadOptions();
            opts.setSpecifiedEncoding(CodePages.SimpChinese);
            final Image cadImage = Image.load(inputFilePath, opts);
            try {
                RasterizationQuality rasterizationQuality = new RasterizationQuality();
                rasterizationQuality.setArc(RasterizationQualityValue.High);
                rasterizationQuality.setHatch(RasterizationQualityValue.High);
                rasterizationQuality.setText(RasterizationQualityValue.High);
                rasterizationQuality.setOle(RasterizationQualityValue.High);
                rasterizationQuality.setObjectsPrecision(RasterizationQualityValue.High);
                rasterizationQuality.setTextThicknessNormalization(true);
                CadRasterizationOptions cadRasterizationOptions = new CadRasterizationOptions();
                cadRasterizationOptions.setBackgroundColor(Color.getWhite());
                cadRasterizationOptions.setPageWidth(cadImage.getWidth());
                cadRasterizationOptions.setPageHeight(cadImage.getHeight());
                cadRasterizationOptions.setUnitType(cadImage.getUnitType());
                cadRasterizationOptions.setAutomaticLayoutsScaling(false);
                cadRasterizationOptions.setNoScaling(false);
                cadRasterizationOptions.setQuality(rasterizationQuality);
                cadRasterizationOptions.setDrawType(CadDrawTypeMode.UseObjectColor);
                cadRasterizationOptions.setExportAllLayoutContent(true);
                cadRasterizationOptions.setVisibilityMode(VisibilityMode.AsScreen);
                switch (cadPreviewType) {  //New format method
                    case "svg":
                        SvgOptions.setVectorRasterizationOptions(cadRasterizationOptions);
                        SvgOptions.setInterruptionToken(source.getToken());
                        break;
                    case "pdf":
                        pdfOptions.setVectorRasterizationOptions(cadRasterizationOptions);
                        pdfOptions.setInterruptionToken(source.getToken());
                        break;
                    case "tif":
                        TiffOptions.setVectorRasterizationOptions(cadRasterizationOptions);
                        TiffOptions.setInterruptionToken(source.getToken());
                        break;
                }
                Callable<String> call = ()  ->  {
                    try (OutputStream stream = new FileOutputStream(outputFile)) {
                        switch (cadPreviewType) {
                            case "svg":
                                cadImage.save(stream, SvgOptions);
                                break;
                            case "pdf":
                                cadImage.save(stream, pdfOptions);
                                break;
                            case "tif":
                                cadImage.save(stream, TiffOptions);
                                break;
                        }
                    } catch (IOException e) {
                        logger.error("CADFileNotFoundException，inputFilePath：{}", inputFilePath, e);
                        return null;
                    } finally {
                        cadImage.dispose();
                        source.interrupt();  //end task
                        source.dispose();
                    }
                    return "true";
                };
                Future<String> result = pool.submit(call);
                try {
                    result.get(Long.parseLong(ConfigConstants.getCadTimeout()), TimeUnit.SECONDS);
                    // If no data is returned within the timeout period: a TimeoutException is thrown
                } catch (InterruptedException e) {
                    logger.error("CAD conversion file exception:", e);
                    return null;
                } catch (ExecutionException e) {
                    logger.error("CAD Translation errors while trying to obtain task results:", e);
                    return null;
                } catch (TimeoutException e) {
                    logger.error("CAD conversion timeout:", e);
                    return null;
                } finally {
                    source.interrupt();  //end task
                    source.dispose();
                    cadImage.dispose();
                    // pool.shutdownNow();
                }
            } finally {
                source.dispose();
                cadImage.dispose();
            }
        } finally {
            source.dispose();
        }
        return "true";
    }

    /**
     * @param str    Original string (original string to be intercepted)
     * @param posStr Specify string
     * @return Intercept the data after intercepting the specified string
     */
    public static String getSubString(String str, String posStr) {
        return str.substring(str.indexOf(posStr) + posStr.length());
    }

    /**
     * Get file attributes
     *
     * @param url url
     * @return file properties
     */
    public FileAttribute getFileAttribute(String url, HttpServletRequest req) {
        FileAttribute attribute = new FileAttribute();
        String suffix;
        FileType type;
        String originFileName; //original file name
        String outFilePath; //path to generated file
        String originFilePath; //Original file path
        String fullFileName = WebUtils.getUrlParameterReg(url, "fullfilename");
        String compressFileKey = WebUtils.getUrlParameterReg(url, "kkCompressfileKey"); //Get the file name of the compressed package
        String compressFilePath = WebUtils.getUrlParameterReg(url, "kkCompressfilepath"); //Get the file path of the compressed package
        if (StringUtils.hasText(fullFileName)) {
            originFileName = fullFileName;
            type = FileType.typeFromFileName(fullFileName);
            suffix = KkFileUtils.suffixFromFileName(fullFileName);
            // Remove fullfilename parameter
            url = WebUtils.clearFullfilenameParam(url);
        } else {
            originFileName = WebUtils.getFileNameFromURL(url);
            type = FileType.typeFromUrl(url);
            suffix = WebUtils.suffixFromUrl(url);
        }
        boolean isCompressFile = !ObjectUtils.isEmpty(compressFileKey);
        if (isCompressFile) {  //Determine whether to use specific compression package symbols
            try {
                originFileName = URLDecoder.decode(originFileName, uriEncoding);  //Escaped file name to extract the original file name
                attribute.setSkipDownLoad(true);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        if (UrlEncoderUtils.hasUrlEncoded(originFileName)) {  //Determine whether the file name is escaped
            try {
                originFileName = URLDecoder.decode(originFileName, uriEncoding);  //Escaped file name to extract the original file name
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }else {
            url = WebUtils.encodeUrlFileName(url); //Escape unescaped urls
        }
        originFileName = KkFileUtils.htmlEscape(originFileName);  //File name handling
        boolean isHtmlView = suffix.equalsIgnoreCase("xls") || suffix.equalsIgnoreCase("xlsx") || suffix.equalsIgnoreCase("csv") || suffix.equalsIgnoreCase("xlsm") || suffix.equalsIgnoreCase("xlt") || suffix.equalsIgnoreCase("xltm") || suffix.equalsIgnoreCase("et") || suffix.equalsIgnoreCase("ett") || suffix.equalsIgnoreCase("xlam");
        String cacheFilePrefixName = null;
        try {
            cacheFilePrefixName = originFileName.substring(0, originFileName.lastIndexOf(".")) + suffix + "."; //Unified file name processing here. More types below. Add suffixes to each.
        } catch (Exception e) {
            logger.error("Getting filename suffix error:", e);
            //  e.printStackTrace();
        }
        String cacheFileName = this.getCacheFileName(type, originFileName, cacheFilePrefixName, isHtmlView, isCompressFile);
        outFilePath = fileDir + cacheFileName;
        originFilePath = fileDir + originFileName;
        String cacheListName = cacheFilePrefixName + "ListName";  //File list cache file name
        attribute.setType(type);
        attribute.setName(originFileName);
        attribute.setCacheName(cacheFileName);
        attribute.setCacheListName(cacheListName);
        attribute.setHtmlView(isHtmlView);
        attribute.setOutFilePath(outFilePath);
        attribute.setOriginFilePath(originFilePath);
        attribute.setSuffix(suffix);
        attribute.setUrl(url);
        if (req != null) {
            String officePreviewType = req.getParameter("officePreviewType");
            String forceUpdatedCache = req.getParameter("forceUpdatedCache");
            String usePasswordCache = req.getParameter("usePasswordCache");
            if (StringUtils.hasText(officePreviewType)) {
                attribute.setOfficePreviewType(officePreviewType);
            }
            if (StringUtils.hasText(compressFileKey)) {
                attribute.setCompressFile(isCompressFile);
                attribute.setCompressFileKey(compressFileKey);
            }
            if ("true".equalsIgnoreCase(forceUpdatedCache)) {
                attribute.setForceUpdatedCache(true);
            }

            String tifPreviewType = req.getParameter("tifPreviewType");
            if (StringUtils.hasText(tifPreviewType)) {
                attribute.setTifPreviewType(tifPreviewType);
            }

            String filePassword = req.getParameter("filePassword");
            if (StringUtils.hasText(filePassword)) {
                attribute.setFilePassword(filePassword);
            }
            if ("true".equalsIgnoreCase(usePasswordCache)) {
                attribute.setUsePasswordCache(true);
            }
            String kkProxyAuthorization = req.getHeader("kk-proxy-authorization");
            attribute.setKkProxyAuthorization(kkProxyAuthorization);

        }

        return attribute;
    }

    /**
     * Get the cached file name
     *
     * @return file name
     */
    private String getCacheFileName(FileType type, String originFileName, String cacheFilePrefixName, boolean isHtmlView, boolean isCompressFile) {
        String cacheFileName;
        if (type.equals(FileType.OFFICE)) {
            cacheFileName = cacheFilePrefixName + (isHtmlView ? "html" : "pdf"); //Add type suffix to generated files to prevent files with the same name
        } else if (type.equals(FileType.PDF)) {
            cacheFileName = originFileName;
        } else if (type.equals(FileType.MEDIACONVERT)) {
            cacheFileName = cacheFilePrefixName + "mp4";
        } else if (type.equals(FileType.CAD)) {
            String cadPreviewType = ConfigConstants.getCadPreviewType();
            cacheFileName = cacheFilePrefixName + cadPreviewType; //Add type suffix to generated files to prevent files with the same name
        } else if (type.equals(FileType.COMPRESS)) {
            cacheFileName = originFileName;
        } else if (type.equals(FileType.TIFF)) {
            cacheFileName = cacheFilePrefixName + ConfigConstants.getTifPreviewType();
        } else {
            cacheFileName = originFileName;
        }
        if (isCompressFile) {  //Determine whether to use specific compression package symbols
            cacheFileName = "_decompression" + cacheFileName;
        }
        return cacheFileName;
    }

    /**
     * @return Collection of converted video files(cache)
     */
    public Map<String, String> listConvertedMedias() {
        return cacheService.getMediaConvertCache();
    }

    /**
     * Add cache of converted video files
     *
     * @param fileName
     * @param value
     */
    public void addConvertedMedias(String fileName, String value) {
        cacheService.putMediaConvertCache(fileName, value);
    }

    /**
     * @return Converted video file cache, obtained based on file name
     */
    public String getConvertedMedias(String key) {
        return cacheService.getMediaConvertCache(key);
    }
}
