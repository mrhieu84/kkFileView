<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${file.name}player</title>
		<link type="text/css" rel="stylesheet" href="ckplayer/css/ckplayer.css" />
		<#if "${file.suffix?lower_case}" == "m3u8" >
		<script type="text/javascript" src="ckplayer/hls.js/hls.min.js"></script>
	 <#elseif "${file.suffix?lower_case}" == "flv">
		<script type="text/javascript" src="ckplayer/flv.js/flv.min.js"></script>
			<#elseif "${file.suffix?lower_case}" == "ts">
			<script type="text/javascript" src="ckplayer/mpegts.js/mpegts.js"></script>
            <#elseif "${file.suffix?lower_case}" == "mpd">
			<script type="text/javascript" src="ckplayer/js/dash.all.min.js"></script>
		</#if>
	<script type="text/javascript" src="ckplayer/js/ckplayer.min.js" charset="UTF-8"></script>
		<#include "*/commonHeader.ftl">
		<style>
			.adpause{
				width: 90%;
				height: 90%;
				max-width: 580px;
				max-height: 360px;
				color: #FFF;
				position: absolute;
				background: #07141E;
				top:0;
				bottom: 0;
				left: 0;
				right: 0;
				margin: auto;
				font-size: 30px;
				line-height: 38px;
				box-sizing:border-box;
				-moz-box-sizing:border-box; /* Firefox */
				-webkit-box-sizing:border-box; /* Safari */	
				padding: 50px;
				display: none;
			}
     .video{
		width: 100%; 
		height: 600px;
		max-width: 900px;  
		margin: auto;
         position: absolute;
        top: 0;
       left: 0;
       bottom: 0;
       right: 0;
     background-color: green;
			}
		</style>
	</head>
	<body>
	<div class="video">play container</div>
				<script>
                <#if "${file.suffix?lower_case}" == "mpd" >
                function dashPlayer(video,fileUrl){
				video.attr('data-dashjs-player',' ');
				video.attr('src',fileUrl);
			} 
            </#if>
	var videoObject = {
				container: '.video', //video container
				//autoplay:true,//Autoplay
               // live:true,//designated as live broadcast
               //  crossOrigin:'Anonymous',//Send cross-domain information, example: Anonymous
			    plug:<#if "${file.suffix?lower_case}" == "m3u8" >'hls.js'<#elseif "${file.suffix?lower_case}" == "ts" >'mpegts.js'<#elseif "${file.suffix?lower_case}" == "flv" >'flv.js'<#elseif "${file.suffix?lower_case}" == "mpd" >dashPlayer<#else>''</#if>,//Set up using plugins
                loop: false,//Do you need to loop playback?
                rightBar:true,
                screenshot:true,//Is the screenshot function enabled?
                webFull:true,//Whether to enable the page full screen button, not enabled by default
				//poster:'ckplayer/poster.png',//cover image
				menu:[
			{
				title:'kkFileView',
				link:'https://www.kkview.cn',
				underline:true
			},
			{
				title:'play/pause',
				click:'player.playOrPause',
			},
			{
				title:'About video',
				click:'aboutShow'
			}
		],
         	information:{
			'Loaded:':'{loadTime}Second',
			'Total duration:':'{duration}Second',
			'Video size:':'{videoWidth}x{videoHeight}',
			'volume:':'{volume}%',
			'FPS：':'{fps}',
			'Audio decoding:':'{audioDecodedByteCount} Byte',
			'Video decoding:':'{videoDecodedByteCount} Byte',
		},
		video:'${mediaUrl}'//Video address
			};
			var player=new ckplayer(videoObject)//Call the player and assign it to the variable player
			  		 /*Initialize watermark*/
 if (!!window.ActiveXObject || "ActiveXObject" in window)
{
}else{
 initWaterMark();
}
		</script>
			

	</body>
</html>
