<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>${file.name}Preview</title>
    <link rel='stylesheet' href='xlsx/plugins/css/pluginsCss.css' />
    <link rel='stylesheet' href='xlsx/plugins/plugins.css' />
    <link rel='stylesheet' href='xlsx/css/luckysheet.css' />
    <link rel='stylesheet' href='xlsx/assets/iconfont/iconfont.css' />
    <script src="xlsx/plugins/js/plugin.js"></script>
    <script src="xlsx/luckysheet.umd.js"></script>
    <script src="js/watermark.js" type="text/javascript"></script>
    <script src="js/base64.min.js" type="text/javascript"></script>
</head>
<#if pdfUrl?contains("http://") || pdfUrl?contains("https://") || pdfUrl?contains("ftp://")>
    <#assign finalUrl="${pdfUrl}">
<#else>
    <#assign finalUrl="${baseUrl}${pdfUrl}">
</#if>
<script>
    /**
     * Initialize watermark
     */
    function initWaterMark() {

        let watermarkTxt = '${watermarkTxt}';
        if (watermarkTxt !== '') {
            watermark.init({
                watermark_txt: '${watermarkTxt}',
                watermark_x: 0,
                watermark_y: 0,
                watermark_rows: 0,
                watermark_cols: 0,
                watermark_x_space: ${watermarkXSpace},
                watermark_y_space: ${watermarkYSpace},
                watermark_font: '${watermarkFont}',
                watermark_fontsize: '${watermarkFontsize}',
                watermark_color: '${watermarkColor}',
                watermark_alpha: ${watermarkAlpha},
                watermark_width: ${watermarkWidth},
                watermark_height: ${watermarkHeight},
                watermark_angle: ${watermarkAngle},
            });
        }
    }

</script>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    html, body {
        height: 100%;
        width: 100%;
    }

</style>
<body>
<div id="lucky-mask-demo" style="position: absolute;z-index: 1000000;left: 0px;top: 0px;bottom: 0px;right: 0px; background: rgba(255, 255, 255, 0.8); text-align: center;font-size: 40px;align-items:center;justify-content: center;display: none;">加载中</div>
<p style="text-align:center;">
<div id="button-area">
    <label><button onclick="tiaozhuan()">Jump to HTML preview</button></label>
    <button id="confirm-button" onclick="print()">Print</button>
</div>
<div id="luckysheet" style="margin:0px;padding:0px;position:absolute;width:100%;left: 0px;top: 20px;bottom: 0px;outline: none;"></div>

<script src="xlsx/luckyexcel.umd.js"></script>
<script>
    function tiaozhuan(){
        var test = window.location.href;
        test = test.replace(new RegExp("&officePreviewType=xlsx",("gm")),"");
        test = test+'&officePreviewType=html';
        window.location.href=test;
    }
    var url = '${finalUrl}';
    var baseUrl = '${baseUrl}'.endsWith('/') ? '${baseUrl}' : '${baseUrl}' + '/';
    if (!url.startsWith(baseUrl)) {
        url = baseUrl + 'getCorsFile?urlPath=' + encodeURIComponent(Base64.encode(url));
    }
    let mask = document.getElementById("lucky-mask-demo");
    function loadText() {
        initWaterMark(); // Whether to display watermark
        var value = url;
        var name = '${file.name}';
        if(value==""){
            return;
        }
        // mask.style.display = "flex";
         LuckyExcel.transformExcelToLuckyByUrl(value, name, function(exportJson, luckysheetfile){
            if(exportJson.sheets==null || exportJson.sheets.length==0){
                alert("Failed to read excel file content!");
                return;
            }
            mask.style.display = "none";
            window.luckysheet.destroy();
            window.luckysheet.create({
                container: 'luckysheet', //luckysheet is the container id
                lang: "en",
                showtoolbarConfig:{
                    image: true,
                    print: true, //It won't work even if the print button is turned off. It will depend on the situation later.
                    exportXlsx: true, //It won't work even if you turn off the export button. It will depend on the situation later.
                },
                allowCopy: true, // Whether to allow copying
                showtoolbar: true, // Whether to display the toolbar
                showinfobar: false, // Whether to display the top information bar
                // myFolderUrl: "/",//Function: Link to the <back button in the upper left corner
                showsheetbar: true, // Whether to display the bottom sheet button
                showstatisticBar: true, // Whether to display the bottom count bar
                sheetBottomConfig: true, // Add row button and return to top button configuration at the bottom of the sheet page
                allowEdit: true, // Whether to allow foreground editing
                enableAddRow: false, // Allow adding rows
                enableAddCol: false, // Allow adding columns
                userInfo: false, // User information display style in the upper right corner
                showRowBar: true, // Whether to display the line number area
                showColumnBar: false, // Whether to display the column number area
                sheetFormulaBar: false, // Whether to display the formula bar
                enableAddBackTop: true,//Return to header button
                forceCalculation: false, //The following is the export plug-in, which is closed by default.
                        data: exportJson.sheets,
                        title: exportJson.info.name,
                        userInfo: exportJson.info.name.creator,
            });
        }, 1000);
    }
    loadText();
    // When printing, get the html content of the specified area of ​​luckysheet, splice it into div, hide the luckysheet container and display the printing area html
    function to_print() {
        const html = luckysheet.getRangeHtml();
        document.querySelector('#print-html').innerHTML = html;
        document.querySelector('#print-area').style.display = 'block';
        document.querySelector('#button-area').style.display = 'none';
    }
</script>
</body>
</html>