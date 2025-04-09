package cn.keking.utils;

import cn.keking.config.ConfigConstants;
import cn.keking.model.FileAttribute;
import cn.keking.model.ReturnResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.mola.galimatias.GalimatiasParseException;
import org.apache.commons.io.FileUtils;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultRedirectStrategy;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RequestCallback;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;

import static cn.keking.utils.KkFileUtils.isFtpUrl;
import static cn.keking.utils.KkFileUtils.isHttpUrl;

/**
 * @author yudian-it
 */
public class DownloadUtils {

    private final static Logger logger = LoggerFactory.getLogger(DownloadUtils.class);
    private static final String fileDir = ConfigConstants.getFileDir();
    private static final String URL_PARAM_FTP_USERNAME = "ftp.username";
    private static final String URL_PARAM_FTP_PASSWORD = "ftp.password";
    private static final String URL_PARAM_FTP_CONTROL_ENCODING = "ftp.control.encoding";
    private static final RestTemplate restTemplate = new RestTemplate();
    private static  final HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
    private static final ObjectMapper mapper = new ObjectMapper();


    /**
     * @param fileAttribute fileAttribute
     * @param fileName      file name
     * @return Absolute path to local file
     */
    public static ReturnResponse<String> downLoad(FileAttribute fileAttribute, String fileName) {
        // ignore ssl certificate
        String urlStr = null;
        try {
            SslUtils.ignoreSsl();
            urlStr = fileAttribute.getUrl().replaceAll("\\+", "%20").replaceAll(" ", "%20");
        } catch (Exception e) {
            logger.error("Ignore SSL certificate exception:", e);
        }
        ReturnResponse<String> response = new ReturnResponse<>(0, "Download successful!!!", "");
        String realPath = getRelFilePath(fileName, fileAttribute);

        // Determine whether the address is illegal
        if (KkFileUtils.isIllegalFileName(realPath)) {
            response.setCode(1);
            response.setContent(null);
            response.setMsg("Download failed:The file name is illegal!" + urlStr);
            return response;
        }
        if (!KkFileUtils.isAllowedUpload(realPath)) {
            response.setCode(1);
            response.setContent(null);
            response.setMsg("Download failed:Unsupported type!" + urlStr);
            return response;
        }
        if (fileAttribute.isCompressFile()) { //The compressed package file is directly assigned a path and will not be downloaded.
            response.setContent(fileDir + fileName);
            response.setMsg(fileName);
            return response;
        }
        // If the file already exists and no update is forced, return the file path directly.
        if (KkFileUtils.isExist(realPath) && !fileAttribute.forceUpdatedCache()) {
            response.setContent(realPath);
            response.setMsg(fileName);
            return response;
        }
        try {
            URL url = WebUtils.normalizedURL(urlStr);
            if (!fileAttribute.getSkipDownLoad()) {
                if (isHttpUrl(url)) {
                    File realFile = new File(realPath);
                    factory.setConnectionRequestTimeout(2000);  //Set timeout
                    factory.setConnectTimeout(10000);
                    factory.setReadTimeout(72000);
                    HttpClient httpClient = HttpClientBuilder.create().setRedirectStrategy(new DefaultRedirectStrategy()).build();
                    factory.setHttpClient(httpClient);  //Add redirect method
                    restTemplate.setRequestFactory(factory);
                    RequestCallback requestCallback = request -> {
                        request.getHeaders().setAccept(Arrays.asList(MediaType.APPLICATION_OCTET_STREAM, MediaType.ALL));
                        String proxyAuthorization = fileAttribute.getKkProxyAuthorization();
                        if(StringUtils.hasText(proxyAuthorization)){
                            Map<String,String>  proxyAuthorizationMap = mapper.readValue(proxyAuthorization, Map.class);
                            proxyAuthorizationMap.forEach((key, value) -> request.getHeaders().set(key, value));
                        }
                    };
                    try {
                        restTemplate.execute(url.toURI(), HttpMethod.GET, requestCallback, fileResponse -> {
                            FileUtils.copyToFile(fileResponse.getBody(), realFile);
                            return null;
                        });
                    }  catch (Exception e) {
                            response.setCode(1);
                            response.setContent(null);
                            response.setMsg("Download failed:" + e);
                            return response;
                    }
                } else if (isFtpUrl(url)) {
                    String ftpUsername = WebUtils.getUrlParameterReg(fileAttribute.getUrl(), URL_PARAM_FTP_USERNAME);
                    String ftpPassword = WebUtils.getUrlParameterReg(fileAttribute.getUrl(), URL_PARAM_FTP_PASSWORD);
                    String ftpControlEncoding = WebUtils.getUrlParameterReg(fileAttribute.getUrl(), URL_PARAM_FTP_CONTROL_ENCODING);
                    FtpUtils.download(fileAttribute.getUrl(), realPath, ftpUsername, ftpPassword, ftpControlEncoding);
                } else {
                    response.setCode(1);
                    response.setMsg("url cannot recognize url" + urlStr);
                }
            }
            response.setContent(realPath);
            response.setMsg(fileName);
            return response;
        } catch (IOException | GalimatiasParseException e) {
            logger.error("File download failed, url:{}", urlStr);
            response.setCode(1);
            response.setContent(null);
            if (e instanceof FileNotFoundException) {
                response.setMsg("File does not exist!!!");
            } else {
                response.setMsg(e.getMessage());
            }
            return response;
        }
    }


    /**
     * Get the absolute path of the real file
     *
     * @param fileName file name
     * @return file path
     */
    private static String getRelFilePath(String fileName, FileAttribute fileAttribute) {
        String type = fileAttribute.getSuffix();
        if (null == fileName) {
            UUID uuid = UUID.randomUUID();
            fileName = uuid + "." + type;
        } else { // When the file suffixes are inconsistent, type shall prevail (for simText [convert txt-like files to txt])
            fileName = fileName.replace(fileName.substring(fileName.lastIndexOf(".") + 1), type);
        }

        String realPath = fileDir + fileName;
        File dirFile = new File(fileDir);
        if (!dirFile.exists() && !dirFile.mkdirs()) {
            logger.error("Failed to create directory [{}]. It may be due to insufficient permissions. Please check.", fileDir);
        }
        return realPath;
    }

}
