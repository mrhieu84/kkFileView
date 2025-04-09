<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Access instructions</title>
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
            <li class="active"><a href="./integrated">Access instructions</a></li>
            <li><a href="./record">Version release record</a></li>
            <li><a href="./sponsor">Sponsor open source</a></li>
        </ul>
    </div>
</nav>

<div class="container theme-showcase" role="main">
    <#--  Access instructions  -->
    <div class="page-header">
        <h1>Access instructions</h1>
        This document is for front-end project access kkFileView description, and assume that the service address of kkFileView is：http://127.0.0.1:8012。
    </div>
    <div class="well">

        <div style="font-size: 16px;">
            【http/https Resource file preview】If your project needs to access the file preview project to achieve the preview effect of docx, excel, ppt, jpg and other files, then you can successfully achieve it by adding the following code to your project:
            <p style="background-color: #2f332a;color: #cccccc;font-size: 14px;padding:10px;margin-top:10px;">
                var url = 'http://127.0.0.1:8080/file/test.txt'; //The access address of the file to be previewed <br>
                window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(base64Encode(url)));
            </p>
        </div>
        <br>
        <div style="font-size: 16px;">
            【http/https Streaming resource file preview】In many systems, the file download address is not directly exposed, but the request is passed through a unified interface through parameters such as id and code. The backend locates the file through parameters such as id or code, and then outputs the download through OutputStream. At this time, the download URL does not include the file. For suffix names, you need to get the file name when previewing. Pass a parameter fullfilename=xxx.xxx to specify the file name. The example is as follows
            <p style="background-color: #2f332a;color: #cccccc;font-size: 14px;padding:10px;margin-top:10px;">
                var originUrl = 'http://127.0.0.1:8080/filedownload?fileId=1'; //The access address of the file to be previewed<br>
                var previewUrl = originUrl + '&fullfilename=test.txt'<br>
                window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(Base64.encode(previewUrl)));
            </p>
        </div>
        <br>
        <div style="font-size: 16px;">
            【ftp Resource file preview】If the FTP url you want to preview can be accessed anonymously (no username or password is required), you can preview it directly through the download url. The example is as follows
            <p style="background-color: #2f332a;color: #cccccc;font-size: 14px;padding:10px;margin-top:10px;">
                var url = 'ftp://127.0.0.1/file/test.txt'; //The access address of the file to be previewed<br>
                window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(Base64.encode(url)));
            </p>
        </div>
        <br>
        <div style="font-size: 16px;">
            【ftp Encrypted resource file preview】If FTP requires authentication to access the server, you can preview it by adding username, password and other parameters to the URL. The example is as follows.
            <p style="background-color: #2f332a;color: #cccccc;font-size: 14px;padding:10px;margin-top:10px;">
                var originUrl = 'ftp://127.0.0.1/file/test.txt'; //The access address of the file to be previewed<br>
                var previewUrl = originUrl + '?ftp.username=xx&ftp.password=xx&ftp.control.encoding=xx';<br>
                window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(Base64.encode(previewUrl)));
            </p>
        </div>
    </div>
</div>

</body>
</html>
