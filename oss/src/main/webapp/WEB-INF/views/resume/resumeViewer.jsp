<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr" mozdisallowselectionprint moznomarginboxes>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>运营支撑系统OSS-译员原始简历预览</title>
  </head>
  <body>
  		<iframe src="${cbasePath}/resources/pdfjs/web/viewer.html?file=${cbasePath}/resume/previewResume_${param.resumePdfPath}" height="700" width="100%" frameBorder=0 scrolling=no></iframe>
  </body>
</html>

