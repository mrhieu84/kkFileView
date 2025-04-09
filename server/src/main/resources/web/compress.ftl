<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>${file.name}Compressed package preview</title>
   <script src="js/jquery-3.6.1.min.js"></script>
     <#include "*/commonHeader.ftl">
   <script src="js/base64.min.js" type="text/javascript"></script>
   <link href="css/zTreeStyle.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" src="js/jquery.ztree.core.js"></script>
        <style type="text/css">
        body {
            background-color: #404040;
        }
        h1 {font-size: 24px;line-height: 34px;text-align: center;}
        a {color:#3C6E31;text-decoration: underline;}
        a:hover {background-color:#3C6E31;color:white;}
        code {color: #2f332a;}
       div.zTreeDemoBackground {
           max-width: 880px;
           text-align:center;
            margin:0 auto;
            border-radius:3px;
            box-shadow:rgba(0,0,0,0.15) 0 0 8px;
            background:#FBFBFB;
            border:1px solid #ddd;
            margin:1px auto;
            padding:5px;
       }
       
    </style>
</head>
<body>
<div class="zTreeDemoBackground left">
<h1>kkFileView</h1>
    <ul id="treeDemo" class="ztree"></ul>
</div>
<script>
    var settings = {
        data: {
            simpleData: {
                enable: true,  //true 、 false Represents respectively using and not using simple data mode
                idKey: "id",   //The attribute name that stores the unique identifier in the node data
                pIdKey: "pid", //The attribute name that uniquely identifies its parent node is stored in the node data.
                rootPId: ""
            }
        },
        callback: {
            onClick: chooseNode,
        }
    };

function isNotEmpty(value) {
  return value !== null && value !== undefined && value !== '' && value !== 0 && !(value instanceof Array && value.length === 0) && !isNaN(value);
}
function getQueryParam(url, param) {
  var urlObj = new URL(url);
  return urlObj.searchParams.get(param);
}
var currentUrl = window.location.href;
var keyword = getQueryParam(currentUrl, 'watermarkTxt');
    function chooseNode(event, treeId, treeNode) {
        if (!treeNode.isParent) {
            var path = '${baseUrl}'+treeNode.id+"?kkCompressfileKey="+'${fileTree}'+"&kkCompressfilepath="+encodeURIComponent(treeNode.id)+"&fullfilename="+encodeURIComponent(treeNode.name);
           if (isNotEmpty(keyword)){
             location.href = "${baseUrl}onlinePreview?url=" + encodeURIComponent(Base64.encode(path))+"&watermarkTxt="+keyword;
           }else{
             location.href = "${baseUrl}onlinePreview?url=" + encodeURIComponent(Base64.encode(path));}
         
        }
    }
    $(document).ready(function () {
    var url = "http://"+'${fileTree}';  //Add http protocol method
       $.ajax({
            type: "get",
            url: "${baseUrl}directory?urls="+encodeURIComponent(Base64.encode(url)),
            success: function (res) {
                zTreeObj = $.fn.zTree.init($("#treeDemo"), settings, res); //initialization tree
                zTreeObj.expandAll(true);   //true Expand all nodes, and shrink nodes if false
            }
        });
    });
        window.onload = function () {
        initWaterMark();
    }
</script>
</body>
</html>