<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0">
    <title>File preview</title>
    <#include "*/commonHeader.ftl">
    <#include "*/needFilePasswordHeader.ftl">
</head>
<body>
<iframe src="${pdfUrl}" width="100%" frameborder="0"></iframe>
</body>

<script type="text/javascript">
    needFilePassword();
</script>

<script type="text/javascript">
    document.getElementsByTagName('iframe')[0].height = document.documentElement.clientHeight - 10;
    /**
     * Page changes to adjust height
     */
    window.onresize = function () {
        var fm = document.getElementsByTagName("iframe")[0];
        fm.height = window.document.documentElement.clientHeight - 10;
    }
    /*Initialize watermark*/
    window.onload = function () {
        initWaterMark();
    }
</script>
</html>
