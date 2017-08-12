<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr" mozdisallowselectionprint moznomarginboxes>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="google" content="notranslate">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>PDF.js viewer</title>
    <script src="/jquery-1.8.3.js"></script>
    <script type="text/javascript">
		var DEFAULT_URL = "";
		/* $(function(){
	        var PDFData = "";  
	        $.ajax({  
	            type:"post",  
	            async:false,  
	            mimeType: 'text/plain; charset=x-user-defined',  
	            url: "previewPdf",
	            success:function(data){  
	               PDFData = data;
	            }
	        });
	        var rawLength = PDFData.length;  
	        //转换成pdf.js能直接解析的Uint8Array类型,见pdf.js-4068  
	        var array = new Uint8Array(new ArrayBuffer(rawLength));    
	        for(i = 0; i < rawLength; i++) {  
	          array[i] = PDFData.charCodeAt(i) & 0xff;  
	        }
	        DEFAULT_URL = array;
		}); */
    </script>
  </head>
  <body>
  	<iframe src="/pdfjs/web/viewer.html?file=/previewPdf" frameBorder=0 scrolling=no width="100%" height="700"></iframe>
  </body>
</html>

