package cn.keking.service.impl;

import cn.keking.config.ConfigConstants;
import cn.keking.model.FileAttribute;
import cn.keking.model.FileType;
import cn.keking.model.ReturnResponse;
import cn.keking.service.FileHandlerService;
import cn.keking.service.FilePreview;
import cn.keking.utils.DownloadUtils;
import org.bytedeco.ffmpeg.global.avcodec;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FFmpegFrameRecorder;
import org.bytedeco.javacv.Frame;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;

import java.io.File;

/**
 * @author : kl
 * @authorboke : kailing.pub
 * @create : 2018-03-25 上午11:58
 * @description:
 **/
@Service
public class MediaFilePreviewImpl implements FilePreview {

    private final FileHandlerService fileHandlerService;
    private final OtherFilePreviewImpl otherFilePreview;
    private static final String mp4 = "mp4";

    public MediaFilePreviewImpl(FileHandlerService fileHandlerService, OtherFilePreviewImpl otherFilePreview) {
        this.fileHandlerService = fileHandlerService;
        this.otherFilePreview = otherFilePreview;
    }

    @Override
    public String filePreviewHandle(String url, Model model, FileAttribute fileAttribute) {
        String fileName = fileAttribute.getName();
        String suffix = fileAttribute.getSuffix();
        String cacheName = fileAttribute.getCacheName();
        String outFilePath = fileAttribute.getOutFilePath();
        boolean forceUpdatedCache = fileAttribute.forceUpdatedCache();
        FileType type = fileAttribute.getType();
        String[] mediaTypesConvert = FileType.MEDIA_CONVERT_TYPES;  //Get supported conversion formats
        boolean mediaTypes = false;
        for (String temp : mediaTypesConvert) {
            if (suffix.equals(temp)) {
                mediaTypes = true;
                break;
            }
        }
        if (!url.toLowerCase().startsWith("http") || checkNeedConvert(mediaTypes)) {  //Not http protocol //Enable conversion mode and support conversion format
            if (forceUpdatedCache || !fileHandlerService.listConvertedFiles().containsKey(cacheName) || !ConfigConstants.isCacheEnabled()) {  //查询是否开启缓存
                ReturnResponse<String> response = DownloadUtils.downLoad(fileAttribute, fileName);
                if (response.isFailure()) {
                    return otherFilePreview.notSupportedFile(model, fileAttribute, response.getMsg());
                }
                String filePath = response.getContent();
                String convertedUrl = null;
                try {
                    if (mediaTypes) {
                        convertedUrl = convertToMp4(filePath, outFilePath, fileAttribute);
                    } else {
                        convertedUrl = outFilePath;  //Files of other protocols that do not require conversion are output directly.
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (convertedUrl == null) {
                    return otherFilePreview.notSupportedFile(model, fileAttribute, "Video conversion abnormality, please contact the administrator");
                }
                if (ConfigConstants.isCacheEnabled()) {
                    // Add to cache
                    fileHandlerService.addConvertedFile(cacheName, fileHandlerService.getRelativePath(outFilePath));
                }
                model.addAttribute("mediaUrl", fileHandlerService.getRelativePath(outFilePath));
            } else {
                model.addAttribute("mediaUrl", fileHandlerService.listConvertedFiles().get(cacheName));
            }
            return MEDIA_FILE_PREVIEW_PAGE;
        }
        if (type.equals(FileType.MEDIA)) {  // Supports output in default format only
            model.addAttribute("mediaUrl", url);
            return MEDIA_FILE_PREVIEW_PAGE;
        }
        return otherFilePreview.notSupportedFile(model, fileAttribute, "The system does not yet support online preview of files in this format.");
    }

    /**
     * Check whether video file conversion is turned on and whether the current file needs to be converted
     *
     * @return
     */
    private boolean checkNeedConvert(boolean mediaTypes) {
        //1.Check if the switch is on
        if ("true".equals(ConfigConstants.getMediaConvertDisable())) {
            return mediaTypes;
        }
        return false;
    }

    private static String convertToMp4(String filePath, String outFilePath, FileAttribute fileAttribute) throws Exception {
        FFmpegFrameGrabber frameGrabber = FFmpegFrameGrabber.createDefault(filePath);
        Frame captured_frame;
        FFmpegFrameRecorder recorder = null;
        try {
            File desFile = new File(outFilePath);
            //Make a judgment to prevent repeated conversions
            if (desFile.exists()) {
                return outFilePath;
            }
            if (fileAttribute.isCompressFile()) { //Determine whether it is a compressed package and create a new directory.
                int index = outFilePath.lastIndexOf("/");  //Capture the content before the last slash
                String folder = outFilePath.substring(0, index);
                File path = new File(folder);
                //Directory does not exist Create a new directory
                if (!path.exists()) {
                    path.mkdirs();
                }
            }
            frameGrabber.start();
            recorder = new FFmpegFrameRecorder(outFilePath, frameGrabber.getImageWidth(), frameGrabber.getImageHeight(), frameGrabber.getAudioChannels());
            // recorder.setImageHeight(640);
            // recorder.setImageWidth(480);
            recorder.setFormat(mp4);
            recorder.setFrameRate(frameGrabber.getFrameRate());
            recorder.setSampleRate(frameGrabber.getSampleRate());
            //Video encoding property configuration H.264 H.265 MPEG
            recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264);
            //Set video bitrate,单位:b
            recorder.setVideoBitrate(frameGrabber.getVideoBitrate());
            recorder.setAspectRatio(frameGrabber.getAspectRatio());
            // Set audio universal encoding format
            recorder.setAudioCodec(avcodec.AV_CODEC_ID_AAC);
            //Set the audio bitrate, unit: b (the higher the bitrate, the better the clarity/sound quality, and of course the larger the file will be 128000 = 182kb)
            recorder.setAudioBitrate(frameGrabber.getAudioBitrate());
            recorder.setAudioOptions(frameGrabber.getAudioOptions());
            recorder.setAudioChannels(frameGrabber.getAudioChannels());
            recorder.start();
            while (true) {
                captured_frame = frameGrabber.grabFrame();
                if (captured_frame == null) {
                    System.out.println("Transcoding completed:" + filePath);
                    break;
                }
                recorder.record(captured_frame);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (recorder != null) {   //closure
                recorder.stop();
                recorder.close();
            }
            frameGrabber.stop();
            frameGrabber.close();
        }
        return outFilePath;
    }

}
