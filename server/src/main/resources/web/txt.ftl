<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0">
    <title>${file.name}Normal text preview</title>
    <#include "*/commonHeader.ftl">
    <script src="js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/base64.min.js" type="text/javascript"></script>
</head>
<body>
<input hidden id="textData" value="${textData}"/>
<#if "${file.suffix?html}" == "txt" || "${file.suffix?html}" == "log"  || "${file.suffix?html}" == "TXT"  || "${file.suffix?html}" == "LOG">
  <style type="text/css">
DIV.black{line-height:25px;PADDING-RIGHT:1px;PADDING-LEFT:1px;FONT-SIZE:100%;MARGIN:1px;COLOR:#909090;BACKGROUND-COLOR:#000;TEXT-ALIGN:left}
DIV.black A{BORDER-RIGHT:#909090 1px solid;PADDING-RIGHT:5px;BACKGROUND-POSITION:50% bottom;BORDER-TOP:#909090 1px solid;PADDING-LEFT:5px;BACKGROUND-IMAGE:url();PADDING-BOTTOM:2px;BORDER-LEFT:#909090 1px solid;COLOR:#fff;MARGIN-RIGHT:3px;PADDING-TOP:2px;BORDER-BOTTOM:#909090 1px solid;TEXT-DECORATION:none}
DIV.black A:hover{BORDER-RIGHT:#f0f0f0 1px solid;BORDER-TOP:#f0f0f0 1px solid;BACKGROUND-IMAGE:BORDER-LEFT:#f0f0f0 1px solid;COLOR:#ffffff;BORDER-BOTTOM:#f0f0f0 1px solid;BACKGROUND-COLOR:#404040}
DIV.black A:active{BORDER-RIGHT:#f0f0f0 1px solid;BORDER-TOP:#f0f0f0 1px solid;BACKGROUND-IMAGE:BORDER-LEFT:#f0f0f0 1px solid;COLOR:#ffffff;BORDER-BOTTOM:#f0f0f0 1px solid;BACKGROUND-COLOR:#404040}
.divContent{color:#fff;font-size：30px；
line-height：30px；
font-family：“SimHei”；
text-indent:2em;padding-bottom:10px;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-wrap:break-word;background-color:#000}
input{
color:#ffffff;
background-color:#000000
}
    </style>


	<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                    ${file.name}
                </a>
            </h4>
        </div>
        <div class="panel-body">
          <div id="divPagenation" class="black" >

    </div>
        <div id="divContent" class="panel-body">
           </div>
        </div>
    </div>
</div>
 <script type="text/javascript">
        var base64data = $("#textData").val()
        var s = Base64.decode(base64data);
         var imgReg = /(<img\s+src='\S+'\s*(\/)?>)/gi;
         matchContent = s.match(imgReg);
         imgContent = s;
         if(imgReg.test(s))
         {
            //Replace img tag with ❈
            imgContent =  s.replace(imgReg,"❈");
         }
        var Length= 20000;
        // EncapsulationDHTMLpagenation
        function DHTMLpagenation(content)
        {
            this.content=content; // content
            this.contentLength=imgContent.length; // content length
            this.pageSizeCount; // Total pages
            this.perpageLength= Length; //default perpage byte length.
            this.currentPage=1; // The starting page is page 1
            this.regularExp=/\d+/; // Create a regular expression to match numeric strings.
            this.divDisplayContent;
            this.contentStyle=null;
            this.strDisplayContent="";
            this.divDisplayPagenation;
            this.strDisplayPagenation="";

            // Assign the second parameter to perpageLength;
            arguments.length==2 ? perpageLength = arguments[1] : '';

            try {
                //Create a DIV to display
                divExecuteTime=document.createElement("DIV");
                document.body.appendChild(divExecuteTime);
            }
            catch(e)
            {
            }

            // Get the divPagenation container.
            if(document.getElementById("divPagenation"))
            {
                divDisplayPagenation=document.getElementById("divPagenation");
            }
            else
            {
                try
                {
                    //Create paginated information
                    divDisplayPagenation=document.createElement("DIV");
                    divDisplayPagenation.id="divPagenation";
                    document.body.appendChild(divDisplayPagenation);
                }
                catch(e)
                {
                    return false;
                }
            }

            // Get divContent container
            if(document.getElementById("divContent"))
            {
                divDisplayContent=document.getElementById("divContent");
            }
            else
            {
                try
                {
                    //Create a DIV with a message to display content on each page
                    divDisplayContent=document.createElement("DIV");
                    divDisplayContent.id="divContent";
                    document.body.appendChild(divDisplayContent);
                }
                catch(e)
                {
                    return false;
                }
            }
            DHTMLpagenation.initialize();
            return this;

        };

        //Initialize paging;
        //Including adding CSS to check whether paging is needed
        DHTMLpagenation.initialize=function()
        {
            divDisplayContent.className= contentStyle != null ? contentStyle : "divContent";

            if(contentLength<=perpageLength)
            {
                strDisplayContent=content;
                divDisplayContent.innerHTML=strDisplayContent;
                return null;
            }

            pageSizeCount=Math.ceil((contentLength/perpageLength));

            DHTMLpagenation.goto(currentPage);

            DHTMLpagenation.displayContent();
        };

       //Show pagination bar
        DHTMLpagenation.displayPage=function()
        {
            strDisplayPagenation="";
            if(currentPage && currentPage !=1)
            {
             
                 strDisplayPagenation+='<button  onclick="DHTMLpagenation.previous()">上一页</button>';
            }
            else
            {
                strDisplayPagenation+="上一页  ";
            }

            for(var i=1;i<=pageSizeCount;i++)
            {
                if(i!=currentPage)
                {
                  
                     strDisplayPagenation+='<button onclick="DHTMLpagenation.goto('+i+');">'+i+'</button>';
                }
                else
                {
                    strDisplayPagenation+=i+"  ";
                }
            }

            if(currentPage && currentPage!=pageSizeCount)
            {
             strDisplayPagenation+='<button  onclick="DHTMLpagenation.next()">Next page</button>';
            }
            else
            {
                strDisplayPagenation+="Next page  ";
            }
           strDisplayPagenation+="common " + pageSizeCount + " Page.<br>per page" + perpageLength + " characters, adjust the number of characters：<input type='text' value='"+perpageLength+"' id='ctlPerpageLength' /><input type='button' value='Sure' onclick='DHTMLpagenation.change()' />";
          divDisplayPagenation.innerHTML=strDisplayPagenation;
         };

        //Previous page
        DHTMLpagenation.previous=function()
        {
            DHTMLpagenation.goto(currentPage-1);
        };

        //Next page
        DHTMLpagenation.next=function()
        {

            DHTMLpagenation.goto(currentPage+1);
        };

        //Jump to a page
        DHTMLpagenation.goto=function(iCurrentPage)
        {
            if(regularExp.test(iCurrentPage))
            {
                currentPage=iCurrentPage;

                var tempContent = "";
                //Get the current content which contains ❈
                var currentContent = imgContent.substr((currentPage-1)*perpageLength,perpageLength);
                tempContent = currentContent;
                //Whether there is ❈ on the current page. Get the position of the last ❈
                var indexOf = currentContent.indexOf("❈");
                if(indexOf >= 0)
                {
                      //Get the content from the starting position to the current page position
                      var beginToEndContent = imgContent.substr(0,currentPage*perpageLength);

                      //Get the last subscript of *in the content starting from the current page position
                      var reCount = beginToEndContent.split("❈").length - 1;

                      var contentArray = currentContent.split("❈");

                      tempContent = replaceStr(contentArray,reCount,matchContent);

                }

                strDisplayContent=tempContent;
            }
            else
            {
                alert("Page parameter error");
            }
            DHTMLpagenation.displayPage();
            DHTMLpagenation.displayContent();
        };
        //Show current page content
        DHTMLpagenation.displayContent=function()
        {
            divDisplayContent.innerHTML=strDisplayContent;
        };

        //Change the number of bytes per page
        DHTMLpagenation.change=function()
        {

            var iPerpageLength = document.getElementById("ctlPerpageLength").value;
            if(regularExp.test(iPerpageLength))
            {

                DHTMLpagenation(s,iPerpageLength);
            }
            else
            {
                alert("Please enter a number");
            }
        };

        /*  currentArray:The array of the current page separated by *
            replaceCount:The number of items from the start content to the content of the current page *
            matchArray ： Matching content of img tag
        */
        function replaceStr(currentArray,replaceCount,matchArray)
        {
            var result = "";
            for(var i=currentArray.length -1,j = replaceCount-1 ;i>=1; i--)
            {

               var temp = (matchArray[j] + currentArray[i]);

               result = temp + result;

               j--;
            }

            result = currentArray[0] + result ;

            return result;
        }
       
         DHTMLpagenation(s,Length);

		   /**
     * initialization
     */
    window.onload = function () {
        initWaterMark();
    }
</script>
 <#else/>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                    ${file.name}
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <div id="text"></div>
        </div>
    </div>
</div>

<script>

    /**
     *Load normal text
     */
    function loadText() {
        var base64data = $("#textData").val()
        var textData = Base64.decode(base64data);
        var textPreData = "<xmp style='background-color: #FFFFFF;overflow-y: scroll;border:none'>" + textData + "</xmp>";
        $("#text").append(textPreData);
    }
   /**
     * initialization
     */
    window.onload = function () {
        initWaterMark();
        loadText();
    }
</script>
	 </#if>
</body>
</html>
