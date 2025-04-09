<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>kkFileView版本记录</title>
    <link rel="icon" href="./favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/theme.css"/>
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="https://kkview.cn" target='_blank'>kkFileView</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="./index">front page</a></li>
            <li><a href="./integrated">Access instructions</a></li>
            <li class="active"><a href="./record">Version release record</a></li>
            <li><a href="./sponsor">Sponsor open source</a></li>
        </ul>
    </div>
</nav>

<div class="container theme-showcase" role="main">
    <#--  Version release record  -->
    <div class="page-header">
        <h1>Version release record</h1>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">April 15, 2024, v4.4.0-beta version</h3>
        </div>
        <div class="panel-body">
            <div>
                1. Ofd fixes some known issues. Optimize OFD mobile preview page is not adaptive <br>
                2. Update the xlsx front-end parsing component, add support for printing functions, and speed up parsing <br>
                3. Fix the defect that the forceUpdatedCache attribute is set but local cache files are not updated <br>
                4. Added the configuration file to enable GZIP compression <br>
                5. Upgraded CAD components, added support for CAD format, converted to svg tif format, added timeout, added thread management <br>
                6. Delete function and add verification code method <br>
                7. Office function adjustments support comments, convert page number restrictions, generate watermarks, etc. <br>
                8. Added xbrl format <br>
                9. Fixed the problem of background error reporting after successful conversion of PDF decrypted encrypted files <br>
10. Upgrade the markdown component to fix the problem of markdown being escaped <br>
                11. Upgrade dcm parsing component <br>
                12. Upgrade PDF.JS parsing component. Added: control signature/drawing/illustration control methods <br>
                13. Change the video playback plug-in to ckplayer <br>
                14. TIF parsing is more intelligent and supports modified image formats <br>
                15. Fix the problem that bpmn does not support cross-domain <br>
                16. Fixed the problem of secondary reverse special symbol error in compressed package <br>
                17. Added search to the home page to locate the page number and define how much content to display <br>
                18. Fixed the problem that video cannot be previewed due to cross-domain configuration of video <br>
                19. Detect the accuracy of character encoding for large and small text files; deal with hidden dangers of concurrency <br>
20. Fix the problem of secondary loading of txt text class in paging <br>
                21. Added front-end analysis of csv format <br>
                22. Reconstruct the code for downloading files and add a universal file server authentication access design <br>
                23. Update bootstrap components and streamline unnecessary files <br>
                24. Added dockerfile under arm64 <br>
                25. Update the epub version, optimize the epub display effect, and fix the epub cross-domain error reporting problem <br>
                26. Fix drawio missing base64 component problem <br>
                27. Solve the problem that when clearing the cache regularly, for multimedia type files, only the disk cache files are deleted <br>
                28. Automatically detect installed Office components and add the default path for LibreOffice7.5 & 7.6 versions <br>
29. Modify drawio to default to preview mode <br>
                30. Added office conversion timeout attribute function <br>
                31. Added preview file host blacklist mechanism <br>
                32. Fix url special symbol problem <br>
                33. Other function optimizations and known issue fixes <br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2023年07月04日，v4.3.0版本</h3>
        </div>
        <div class="panel-body">
            <div>
               1. Added preview of medical digital images such as dcm<br>
                2. Added drawio drawing preview<br>
                3. Added a new command to regenerate when caching is enabled &forceUpdatedCache=true <br>
                4. Added dwg CAD file preview <br>
                5. Added password support for PDF files <br>
                6. Fixed the error in obtaining the compressed package path in case of reverse generation <br>
                7. Added custom dpi configuration for generating images from PDF files <br>
                8. Fixed the problem that if the URL of the preview image contains &, .click will report an error <br>
                9. Added configuration for deleting converted OFFICE, CAD, TIFF, and compressed package source files. Enabled by default to save disk space <br>
                10. Adjust the generated PDF file and add a file suffix to the file name to prevent files with the same name from being generated <br>
11. Added pages format support and adjusted SQL file preview method <br>
                12. OFD fixes some known bugs and improves OFD compatibility processing. <br>
                13. Added front-end parsing xlsx method. <br>
                14. OFD fixes the problem that some text is not displayed, and improves OFD compatibility processing <br>
                15. Beautify the display of TXT text paging box <br>
                16. Fixed the problem that when previewing a compressed package, if you click on a file directory (tree node), the page will report an error <br>
                17. Upgrade the built-in office of Linux and Docker versions to LibreOffice-7.5.3 version
                18. Upgrade Windows built-in office to LibreOffice-7.5.3 Portable version <br>
19. Added support for pages, eps, iges, igs, dwt, dng, ifc, dwfx, stl, cf2, plt and other formats <br>
                20. Other function optimizations and known issue fixes <br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">April 18, 2023, version v4.2.1</h3>
        </div>
        <div class="panel-body">
            <div>
                1. 修复 dwg 等 CAD Type file reports null pointer bug<br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">April 13, 2023, v4.2.Version 0</h3>
        </div>
        <div class="panel-body">
            <div>
               1. Added SVG format file preview support<br>
                2. Added preview support for encrypted Office files<br>
                3. Added preview support for encrypted zip, rar and other compressed package files<br>
                4. Added xmind software model file preview support<br>
                5. Added bpmn workflow model file preview support<br>
                6. Added eml email file preview support<br>
                7. Added epub e-book file preview support<br>
                8. Added support for previewing office documents in dotm, ett, xlt, xltm, wpt, dot, xlam, xla, dotx and other formats<br>
9. Added preview support for obj, 3ds, stl, ply, gltf, glb, off, 3dm, fbx, dae, wrl, 3mf, ifc, brep, step, iges, fcstd, bim and other 3D model files<br>
                10. Added the function of configurable restrictions on high-risk file uploads, such as exe files<br>
                11. Added registration information for configurable sites<br>
                12. Added the function of requiring a password to delete files on the demo site<br>
                13. Add text document preview to cache<br>
                14. Beautify 404 and 500 error pages<br>
                15. Optimize the rendering compatibility of previews of invoices and other OFD files<br>
                16. Remove the office-plugin module and use the new version of jodconverter component<br>
17. Optimize the preview effect of Excel files<br>
                18. Optimize the preview effect of CAD files<br>
                19. Update the versions of xstream, junrar, pdfbox and other dependencies<br>
                20. Update the plug-in for converting TIF files to PDF and add conversion cache<br>
                21. Optimize demo page UI deployment<br>
                22. Compressed package file preview supported directory<br>
                23. Fixed some interface XSS issues<br>
                24. Fixed the problem that the demo address printed by the console does not follow the content-path configuration<br>
                25. Fix the cross-domain problem of ofd file preview<br>
                26. Fixed the problem that the internal self-signed certificate https protocol url file cannot be downloaded<br>
27. Fixed the problem that files with special symbols cannot be deleted<br>
                28. Fixed the OOM problem caused by the inability to recycle memory when converting PDF to images<br>
                29. Fixed the problem of garbled file preview in xlsx7.4 and above versions<br>
                30. Fixed the problem that TrustHostFilter did not intercept cross-domain interfaces. This is a security issue. Those who use the TrustHost function must upgrade<br>
                31. Fixed the problem of garbled file names in the compressed package file preview under Linux system<br>
                32. Fixed the problem that ofd file preview page number can only display 10 pages<br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">December 14, 2022, version v4.1.0</h3>
        </div>
        <div class="panel-body">
            <div>
               1. New homepage visual @wsd7747 <br>
                2. TIF image preview is compatible with multi-page TIF PDF conversion, jpg conversion, and jpg online multi-page preview function @zhangzhen1979<br>
                3. Optimize the docker construction plan and use the layered construction method @yl-yue<br>
                4. Implement caching of encrypted files based on userToken @yl-yue<br>
                5. Achieve preview of encrypted word, ppt, excel files @yl-yue<br>
                6. Linux & Docker image upgrade to LibreOffice 7.3<br>
                7. Update OFD preview component, update tif preview component, update PPT watermark support<br>
                8. A large number of other upgrades and optimizations & known issue fixes<br>
                <br>
Thanks to @yl-yue @wsd7747 @zhangzhen1979 @tomhusky @shenghuadun @kischn.sun for the code contribution
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">July 6, 2021, version v4.0.0</h3>
        </div>
        <div class="panel-body">
            <div>
               1. The underlying integrated OpenOffice is replaced with LibreOffice, the compatibility of Office files is enhanced, and the preview effect is improved<br>
                2. Fix directory traversal vulnerability in compressed files<br>
                3. Fixed the problem that PPT preview in PDF mode is invalid<br>
                4. Fixed the abnormal front-end display in PPT picture preview mode<br>
                5. New feature: The file upload function on the homepage can be enabled or disabled in real time through configuration<br>
                6. Optimize and add Office process shutdown log<br>
                7. Optimize the search for Office component logic in Windows environment (built-in LibreOffice takes priority)<br>
                8. Optimize the startup of Office process and change it to synchronous execution
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">June 17, 2021, version v3.6.0</h3>
        </div>
        <div class="panel-body">
            <div>
               **Ofd type file supports version. The important functions of this version are developed and contributed by the community. Thanks to @gaoxingzaq and @zhangxiaoxiao9527 for their code contributions **<br>
                1. Added preview support for ofd type files. ofd is a domestic file similar to pdf format<br>
                2. Added ffmpeg video file transcoding preview support. After turning on the transcoding function, theoretically supports the preview of all mainstream videos, such as rm, rmvb, flv, etc.<br>
                3. Beautified the preview effect of ppt and pptx type files, which looks much better than the previous version<br>
                4. Updated dependent versions of pdfbox, xstream, common-io, etc.
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">April 06, 2021, version v3.5.1</h3>
        </div>
        <div class="panel-body">
            <div>
              Version 3.5.1 released, known issues fixed<br>
                1. Fix the problem that the initial memory of tif and tiff file preview is too small and the preview fails<br>
                2. Fix cross-domain issue in PDF preview mode<br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">March 17, 2021, version v3.5.0</h3>
        </div>
        <div class="panel-body">
            <div>
                v3.5 performance upgrade version released in the first quarter of 2021<br>
                1. Added office-plugin conversion process and configurable task timeout<br>
                2. Update spring-boot to the latest v2.4.2 version<br>
                3. Added preview support for tiff and tif image file formats<br>
                4. Added dependency highlightjs code file preview highlighting support<br>
                5. Added wps document preview support<br>
                6. Added stars growth trend chart<br>
                7. Added startup completion, printing startup time, and demo page access address<br>
                8. Added kkFIleView banner information<br>
                9. Optimize startup script<br>
                10. Optimize project structure and maven structure<br>
11. Remove redundant repositories configuration and remove configuration for tomcat<br>
                12. Optimize download file io operation<br>
                13. Fix: After optimizing the project directory structure, the error "office component not found" is reported when starting under Windows<br>
                14. Fixed: jodd.io.NetUtil.downloadFile reported an error when downloading a file larger than 16M<br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">January 28, 2021, version v3.3.1</h3>
        </div>
        <div class="panel-body">
            <div>
                **The last version of the 2020 Lunar New Year is released, which mainly includes some UI improvements and solves bugs reported by QQ group friends and Issues.
                Repair, the most important thing is to release a new version, have a good year **<br>
                1. Introduce galimatias to solve the problem of abnormal file download caused by non-standard file names<br>
                2. Update the UI style of the index access demo interface<br>
                3. Update markdown file preview UI style<br>
                4. Update the XML file preview UI style and adjust the text-like preview structure to make it easier to expand<br>
                5. Update simTxT file preview UI style<br>
                6. Adjust the UI for continuous preview of multiple images and flip up and down images<br>
                7. Use the apache-common-io package to simplify all file download io operations<br>
                8. XML file preview supports switching to plain text mode<br>
9. Enhance the prompt message when URL base64 decoding fails<br>
                10. Fix package import error and image preview bug<br>
                11. Fixed the problem that the log directory cannot be found when running the distribution package<br>
                12. Fixed the bug of continuous preview of multiple images in the compressed package<br>
                13. Fixed the problem that uppercase and lowercase file type suffixes are not universally matched<br>
                14. Specify Base64 transcoding to use the implementation in Apache Commons-code, and fix the exceptions that occur in some jdk versions of base64<br>
                15. Fixed bug in text-like HTML file preview<br>
                16. Fix: Unable to switch between jpg and pdf types when previewing dwg files<br>
                17. escaping of dangerous characters to prevent reflected xss<br>
18. Fixed the problem of failed document conversion to image preview due to repeated encoding & coding standards
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">December 27, 2020, version v3.3.0</h3>
        </div>
        <div class="panel-body">
            <div>
               **The major version update at the end of 2020, the architecture is comprehensively designed, the code is comprehensively reconstructed, the code quality is comprehensively improved, and secondary development is more convenient. Welcome to pull the source code for tasting, submit issues, and PR for joint construction
                **<br>
                1. Architecture module adjustment, extensive code refactoring, code quality improved by N levels, welcome to review<br>
                2. Enhanced XML file preview effect, added XML document structure preview<br>
                3. Added markdown file preview support, the preview supports md rendering and source text switching support<br>
                4. Switch the underlying web server to jetty to solve this issue: <a href="https://github.com/kekingcn/kkFileView/issues/168">#issues/168</a><br>
                5. Introduce cpdetector to solve the problem of file encoding identification<br>
                6. The URL uses base64+urlencode dual encoding to completely solve the problem of previewing various weird file names<br>
7. Added a new configuration item office.preview.switch.disabled to control the office file preview switch<br>
                8. Optimize the preview logic of text type files and use Base64 to transmit content to avoid requesting file content again during preview<br>
                9. The office preview picture mode disables the picture enlargement effect to achieve the same experience as the picture and PDF preview effect<br>
                10. Static setting of pdfbox with direct code is compatible with lower versions of jdk, and there will be no warning prompts when running in IDEA<br>
                11. Remove unnecessary tool packages such as guava and hutool to reduce code size<br>
                12. Office components are loaded asynchronously, speeding up application startup to within 5 seconds<br>
                13. Properly set the number of threads in the preview consumption queue<br>
                14. Fixed the bug that the files in the compressed package failed to be previewed again<br>
                15. Fix image preview bug
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">August 12, 2020, version v2.2.1</h3>
        </div>
        <div class="panel-body">
            <div>
              1. Support plain text preview and output in original format<br>
                2. Fixed the problem of missing text in PDF preview and upgraded the pdf.js component<br>
                3. The bottom layer of the docker image uses ubuntu, which makes the image smaller and faster to build<br>
                4. The preview interface supports both get and post requests<br>
                5. Fixed preview exception of compressed files uploaded to demo<br>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">May 20, 2020, version v2.2.0</h3>
        </div>
        <div class="panel-body">
            <div>
              1. Added support for global watermarks and dynamically changing watermark content through parameters<br>
                2. Added support for CAD file preview<br>
                3. Added base.url configuration to support the use of nginx reverse proxy and context-path<br>
                4. Supports reading of all configuration items from environment variables, facilitating Docker image deployment and large-scale use in clusters<br>
                5. Supports configuring trust-limited sites (only file sources from trusted points can be previewed) to protect the preview service from being abused<br>
                6. Support configuring custom cache cleaning time (cron expression)<br>
                7. All recognized plain text can be previewed directly without jumping to download, such as .md .java .py, etc.<br>
                8. Support configuration restrictions for downloading converted PDF files<br>
                9. Optimize maven packaging configuration to solve the problem of line breaks that may occur in .sh script<br>
10. Put all front-end CDN dependencies locally to facilitate users without external network connections<br>
                11. The homepage comment service is switched from Sohu Changyan to Gitalk<br>
                12. Fix the preview exception that may be caused by special characters in the URL<br>
                13. Fix addTask exception in conversion file queue<br>
                14. Fix other existing problems<br>
                15. Official website construction: <a href="https://kkview.cn">https://kkview.cn</a><br>
                16. Official Docker image warehouse construction: <a href="https://hub.docker.com/r/keking/kkfileview">https://hub.docker.com/r/keking/kkfileview</a>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">June 20, 2019</h3>
        </div>
        <div class="panel-body">
            <div>
              1. Support automatic cleaning of cache and preview files<br>
                2. Support http/https download stream url file preview<br>
                3. Support FTP url file preview<br>
                4. Add Docker build
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2019年04月08日</h3>
        </div>
        <div class="panel-body">
            <div>
              1. Cache and queue implementation abstraction, providing two implementations: JDK and REDIS (REDIS becomes an optional dependency)<br>
                2. The packaging method provides zip and tar.gz packages, and provides a one-click startup script.
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2018年01月19日</h3>
        </div>
        <div class="panel-body">
            <div>
              1. Large files are queued and processed in advance<br>
                2. Added addTask file conversion into queue interface<br>
                3. Use redis queue to support kkFIleView interface and heterogeneous system joining the queue.
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2018年01月15日</h3>
        </div>
        <div class="panel-body">
            <div>
                1. Added social comment box to homepage
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2018年01月12日</h3>
        </div>
        <div class="panel-body">
            <div>
               1. Added multiple pictures to preview at the same time<br>
                2. Supports preview of images in compressed packages in turn
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2018年01月02日</h3>
        </div>
        <div class="panel-body">
            <div>
               1. Fixed text encoding issues such as txt causing garbled preview<br>
                2. Fix the problem that project module dependencies cannot be introduced<br>
                3. Added spring boot profile to support multi-environment configuration<br>
                4. Introduce pdf.js to preview doc and other files, support doc title generation pdf preview menu, and support mobile phone preview
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">2017年12月12日</h3>
        </div>
        <div class="panel-body">
            <div>
               1. 项目gitee开源:<a href="https://gitee.com/kekingcn/file-online-preview" target="_blank">https://gitee.com/kekingcn/file-online-preview</a><br>
                2. 项目github开源:<a href="https://github.com/kekingcn/kkFileView" target="_blank">https://github.com/kekingcn/kkFileView</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
