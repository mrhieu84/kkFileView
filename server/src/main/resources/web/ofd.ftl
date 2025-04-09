<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0">
    <title>${file.name}OFD preview</title>
    <#include "*/commonHeader.ftl">
    <script src="js/base64.min.js" type="text/javascript"></script>
</head>
<body>
<#if currentUrl?contains("http://") || currentUrl?contains("https://")>
    <#assign finalUrl="${currentUrl}">
<#else>
    <#assign finalUrl="${baseUrl}${currentUrl}">
</#if>
<iframe src="" width="100%" frameborder="0"></iframe>
</body>
<script type="text/javascript">
    var url = '${finalUrl}';
    var baseUrl = '${baseUrl}'.endsWith('/') ? '${baseUrl}' : '${baseUrl}' + '/';
    if (!url.startsWith(baseUrl)) {
        url = baseUrl + 'getCorsFile?urlPath=' + encodeURIComponent(Base64.encode(url));
    }
     if(IsPhone()){
   	document.getElementsByTagName('iframe')[0].src = "${baseUrl}ofd/index.html?file=" + encodeURIComponent(url)+"&scale=width";
    }else{
    document.getElementsByTagName('iframe')[0].src = "${baseUrl}ofd/index.html?file="+ encodeURIComponent(url)+"";
    }
    document.getElementsByTagName('iframe')[0].height = document.documentElement.clientHeight - 10;
    /**
     * Page changes to adjust height
     */
    window.onresize = function () {
        var fm = document.getElementsByTagName("iframe")[0];
        fm.height = window.document.documentElement.clientHeight - 10;
    }

 function IsPhone() {
        var info = navigator.userAgent;
        //Determine whether the "Mobile" string is included through the test method of the regular expression
        var isPhone = /mobile/i.test(info);
        //Returns true if "Mobile" is included (it is a mobile phone device)
        return isPhone;
    }
    /*Initialize watermark*/
    window.onload = function () {
        initWaterMark();
    }
</script>
</html>
