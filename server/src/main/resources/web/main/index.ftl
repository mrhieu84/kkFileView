<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>kkFileView demo home page</title>
    <link rel="icon" href="./favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/loading.css"/>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.min.css"/>
    <link rel="stylesheet" href="css/theme.css"/>
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="js/base64.min.js"></script>
    <style>
        <#-- Delete file password pop-up window in the center -->
        .alert {
            width: 50%;
        }
        <#-- Delete the file verification code pop-up window in the center -->
        .modal {
            width:100%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
        }
    </style>
</head>

<body>

<#-- Delete file verification code pop-up window  -->
<#if deleteCaptcha >
<div id="deleteCaptchaModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Delete files</h4>
            </div>
            <br>
            <input type="text" id="deleteCaptchaFileName" style="display: none">
            <div class="modal-body input-group">
                <span style="display: table-cell; vertical-align: middle;">
                    <img id="deleteCaptchaImg" alt="deleteCaptchaImg" src="">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                </span>
                <input type="text" id="deleteCaptchaText" class="form-control" placeholder="Please enter the verification code">
            </div>
            <div class="modal-footer" style="text-align: center">
                <button type="button" id="deleteCaptchaConfirmBtn" class="btn btn-danger">Confirm deletion</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
</#if>

<!-- Fixed navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#" >kkFileView</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="./index">Introduce</a></li>
           
        </ul>
    </div>
</nav>

<div class="container theme-showcase" role="main">
    <#--  Access instructions  -->
    <div class="page-header">
        <h1>Supported file types</h1>
        
    </div>
    <div >
        <ol>
            <li>support doc, docx, xls, xlsx, xlsm, ppt, pptx, csv, tsv, dotm, xlt, xltm, dot, dotx, xlam, xla, pages wait Office Office documents</li>
            <li>support wps, dps, et, ett, wpt Waiting for domestic production WPS Office Office documents</li>
            <li>support odt, ods, ots, odp, otp, six, ott, fodt, fods OpenOffice、LibreOffice Office documents</li>
            <li>support vsd, vsdx  Visio flowchart file</li>
            <li>support wmf, emf  Windows system image file</li>
            <li>support psd, eps  Photoshop software model file</li>
            <li>support pdf ,ofd, rtf Other documents</li>
            <li>support xmind software model file</li>
            <li>support bpmn workflow document</li>
            <li>support eml mail file</li>
            <li>support epub Book documents</li>
            <li>support obj, 3ds, stl, ply, gltf, glb, off, 3dm, fbx, dae, wrl, 3mf, ifc, brep, step, iges, fcstd, bim 3D model file</li>
            <li>support dwg, dxf, dwf, iges , igs, dwt, dng, ifc, dwfx, stl, cf2, plt  wait CAD model file</li>
            <li>support txt, xml(rendering), md(rendering), java, php, py, js, css etc. all plain text</li>
            <li>support zip, rar, jar, tar, gzip, 7z Waiting for compressed package</li>
            <li>support jpg, jpeg, png, gif, bmp, ico, jfif, webp Wait for picture preview (flip, zoom, mirror)</li>
            <li>support tif, tiff graph information model file</li>
            <li>support tga image format file</li>
            <li>support svg vector image format file</li>
            <li>support mp3,wav,mp4,flv Audio and video format files</li>
            <li>support avi,mov,rm,webm,ts,rm,mkv,mpeg,ogg,mpg,rmvb,wmv,3gp,ts,swf Video format transcoding preview</li>
            <li>support dcm Waiting for medical digital image preview</li>
            <li>support drawio Drawing preview</li>
        </ol>
    </div>
    <#--  Enter the download address to preview the file  -->
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">Enter Url Preview</h3>
        </div>
        <div class="panel-body">
            <form>
                <div class="row">
                    <div class="col-md-10">
                        <div class="form-group">
                            <input type="url" class="form-control" id="_url" placeholder="Please enter preview file url">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button id="previewByUrl" type="button" class="btn btn-success">Preview</button>
                    </div>
                </div>

                <div class="alert alert-danger alert-dismissable hide" role="alert" id="previewCheckAlert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <strong>Please enter the correct url</strong>
                </div>

            </form>
        </div>
    </div>

    <#--  preview test  -->
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">Upload</h3>
        </div>
        <div class="panel-body">
            <#if fileUploadDisable == false>
                <form enctype="multipart/form-data" id="fileUpload">
                    <input type="file" id="file" name="file" style="float: left; margin: 0 auto; font-size:22px;" placeholder="Please select file"/>
                    <input type="button" id="fileUploadBtn" class="btn btn-success" value=" Upload "/>
                </form>
            </#if>
            <table id="table" data-pagination="true"></table>
        </div>
    </div>
</div>

<div class="loading_container" style="position: fixed;">
    <div class="spinner">
        <div class="spinner-container container1">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container2">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container3">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
    </div>
</div>
<#if beian?? && beian != "default">
    <div style="display: grid; place-items: center;">
        <div>
            <a target="_blank"  href="https://beian.miit.gov.cn/">${beian}</a>
        </div>
    </div>
</#if>
<script>
    <#if deleteCaptcha >
        $("#deleteCaptchaImg").click(function() {
            $("#deleteCaptchaImg").attr("src","${baseUrl}deleteFile/captcha?timestamp=" + new Date().getTime());
        });
        $("#deleteCaptchaConfirmBtn").click(function() {
            var fileName = $("#deleteCaptchaFileName").val();
            var deleteCaptchaText = $("#deleteCaptchaText").val();
            $.get('${baseUrl}deleteFile?fileName=' + fileName +'&password=' + deleteCaptchaText, function(data){
                if ("Failed to delete file, wrong password!" === data.msg) {
                    alert(data.msg);
                } else {
                    $('#table').bootstrapTable("refresh", {});
                    $("#deleteCaptchaText").val("");
                    $("#deleteCaptchaModal").modal("hide");
                }
            });
        });
        function deleteFile(fileName) {
            $("#deleteCaptchaImg").click();
            $("#deleteCaptchaFileName").val(fileName);
            $("#deleteCaptchaText").val("");
            $("#deleteCaptchaModal").modal("show");
        }
    <#else>
        function deleteFile(fileName) {
            if (window.confirm('Are you sure you want to delete the file?')) {
                password = prompt("Please enter default password:123456");
                $.ajax({
                    url: '${baseUrl}deleteFile?fileName=' + fileName +'&password='+password,
                    success: function (data) {
                        if ("Failed to delete file, wrong password!" === data.msg) {
                            alert(data.msg);
                        } else {
                            $("#table").bootstrapTable("refresh", {});
                        }
                    }
                });
            } else {
                return false;
            }
        }
    </#if>

    function showLoadingDiv() {
        var height = window.document.documentElement.clientHeight - 1;
        $(".loading_container").css("height", height).show();
    }

    function onFileSelected() {
        var file = $("#fileSelect").val();
        $("#fileName").text(file);
    }

    function checkUrl(url) {
        //url= 协议://(ftp的登录信息)[IP|域名](:端口号)(/或?请求参数)
        var strRegex = '^((https|http|ftp)://)'//(https或http或ftp)
            + '(([\\w_!~*\'()\\.&=+$%-]+: )?[\\w_!~*\'()\\.&=+$%-]+@)?' //ftp的user@  Dispensable
            + '(([0-9]{1,3}\\.){3}[0-9]{1,3}' // URL in IP form -3 digits. 3 digits. 3 digits. 3 digits
            + '|' // Allow IP and DOMAIN (domain name)
            + '(localhost)|'	//match localhost
            + '([\\w_!~*\'()-]+\\.)*' // Domain name -at least one [English or numeric_!~*\'()-] plus.
            + '\\w+\\.' // First-level domain name -English or numeric plus.
            + '[a-zA-Z]{1,6})' // Top-level domain name -1-6 digits in English
            + '(:[0-9]{1,5})?' // Port-:80,1-5 digits
            + '((/?)|' // url no parameter ending -slash or this nothing
            + '(/[\\w_!~*\'()\\.;?:@&=+$,%#-]+)+/?)$';//End of request parameters -English or numbers and various characters within []
        var re = new RegExp(strRegex, 'i');//i is not case sensitive
        //Convert the url to uri and then match it to eliminate the impact of Chinese and empty characters in the request parameters.
        return re.test(encodeURI(url));
    }

    $(function () {
        $('#table').bootstrapTable({
            url: 'listFiles',
            pageNumber: ${homePageNumber},//Initial load the first page
            pageSize:${homePageSize}, //Initialize the number of records on a single page
            pagination: ${homePagination}, //Whether to paginate
            pageList: [5, 10, 20, 30, 50, 100, 200, 500],
            search: ${homeSearch}, //Show query box
            columns: [{
                field: 'fileName',
                title: 'File Name'
            }, {
                field: 'action',
                title: 'Operate',
                align: 'center',
                width: 160
            }]
        }).on('pre-body.bs.table', function (e, data) {
            // Add a column to each data for operation
            $(data).each(function (index, item) {
                item.action = "<a class='btn btn-success' target='_blank' href='${baseUrl}onlinePreview?url=" + encodeURIComponent(Base64.encode('${baseUrl}' + item.fileName)) + "'>Preview</a>" +
                    "<a class='btn btn-danger' style='margin-left:10px;' href='javascript:void(0);' onclick='deleteFile(\"" +  encodeURIComponent(Base64.encode('${baseUrl}' + item.fileName)) + "\")'>delete</a>";
            });
            return data;
        }).on('post-body.bs.table', function (e, data) {
            return data;
        });

        $('#previewByUrl').on('click', function () {
            var _url = $("#_url").val();
            if (!checkUrl(_url)) {
                $("#previewCheckAlert").addClass("show");
                window.setTimeout(function () {
                    $("#previewCheckAlert").removeClass("show");
                }, 3000);//displayed time
                return false;
            }

            var b64Encoded = Base64.encode(_url);

            window.open('${baseUrl}onlinePreview?url=' + encodeURIComponent(b64Encoded));
        });


        $("#fileUploadBtn").click(function () {
            var filepath = $("#file").val();
            if(!checkFileSize(filepath)) {
                return false;
            }
            showLoadingDiv();
            $("#fileUpload").ajaxSubmit({
                success: function (data) {
                    // After the upload is completed, refresh the table
                    if (1 === data.code) {
                        alert(data.msg);
                    } else {
                        $('#table').bootstrapTable('refresh', {});
                    }
                    $("#fileName").text("");
                    $(".loading_container").hide();
                },
                error: function () {
                    alert('Upload failed, please contact the administrator');
                    $(".loading_container").hide();
                },
                url: 'fileUpload', /*Set the page to which post is submitted*/
                type: "post", /*Set the form to submit using the post method*/
                dataType: "json" /*Set the return value type to text*/
            });
        });
    });
    function checkFileSize(filepath) {
        var daxiao= "${size}";
        daxiao= daxiao.replace("MB","");
        // console.log(daxiao)
        var maxsize = daxiao * 1024 * 1024;
        var errMsg = "The uploaded file cannot exceed ${size}！！！";
        var tipMsg = "Your browser does not currently support uploading. Make sure the uploaded file does not exceed ${size}. It is recommended to use IE, FireFox, and Chrome browsers.";
        try {
            var filesize = 0;
            var ua = window.navigator.userAgent;
            if (ua.indexOf("MSIE") >= 1) {
                //IE
                var img = new Image();
                img.src = filepath;
                filesize = img.fileSize;
            } else {
                filesize = $("#file")[0].files[0].size; //byte
            }
            if (filesize > 0 && filesize > maxsize) {
                alert(errMsg);
                return false;
            } else if (filesize === -1) {
                alert(tipMsg);
                return false;
            }
        } catch (e) {
            alert("Upload failed, please try again");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
