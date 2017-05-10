<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<link rel="stylesheet" href="<%=basePath%>/ui/js/widgetui/plugins/uploadify3.2.1/uploadify.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/uploadify3.2.1/jquery.uploadify.js"></script>
