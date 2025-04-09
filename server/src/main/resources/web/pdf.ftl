<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0">
    <title>PDF preview</title>
    <#include "*/commonHeader.ftl">
    <script src="js/base64.min.js" type="text/javascript"></script>
</head>

<body>
<#if pdfUrl?contains("http://") || pdfUrl?contains("https://")>
    <#assign finalUrl="${pdfUrl}">
<#else>
    <#assign finalUrl="${baseUrl}${pdfUrl}">
</#if>
<iframe src="" width="100%" frameborder="0"></iframe>
<#if "false" == switchDisabled>
    <img src="images/jpg.svg" width="48" height="48" style="position: fixed; cursor: pointer; top: 40%; right: 48px; z-index: 999;" alt="Use image preview" title="Use image preview" onclick="goForImage()"/>
</#if>
</body>

<script type="text/javascript">
    var url = '${finalUrl}';
    var baseUrl = '${baseUrl}'.endsWith('/') ? '${baseUrl}' : '${baseUrl}' + '/';
    if (!url.startsWith(baseUrl)) {
        url = baseUrl + 'getCorsFile?urlPath=' + encodeURIComponent(Base64.encode(url));
    }
    document.getElementsByTagName('iframe')[0].src = "${baseUrl}pdfjs/web/viewer.html?file=" + encodeURIComponent(url) + "&disablepresentationmode=${pdfPresentationModeDisable}&disableopenfile=${pdfOpenFileDisable}&disableprint=${pdfPrintDisable}&disabledownload=${pdfDownloadDisable}&disablebookmark=${pdfBookmarkDisable}&disableediting=${pdfDisableEditing}";
    document.getElementsByTagName('iframe')[0].height = document.documentElement.clientHeight - 10;
    /**
     * Page changes to adjust height
     */
    window.onresize = function () {
        var fm = document.getElementsByTagName("iframe")[0];
        fm.height = window.document.documentElement.clientHeight - 10;
    }

    function goForImage() {
        var url = window.location.href
        
        if (url.indexOf("tifPreviewType=pdf") != -1) {
            url = url.replace("tifPreviewType=pdf", "tifPreviewType=jpg");
        } else {
            url = url + "&tifPreviewType=jpg";
        }

        if (url.indexOf("officePreviewType=pdf") != -1) {
            url = url.replace("officePreviewType=pdf", "officePreviewType=image");
        } else {
            url = url + "&officePreviewType=image";
        }
        window.location.href = url;
    }

    /*Initialize watermark*/
    window.onload = function () {
        initWaterMark();
    }
</script>
</html>
