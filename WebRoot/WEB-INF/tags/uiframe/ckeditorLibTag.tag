<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!-- CKEDITOR tag libs -->
<script type="text/javascript"src="<%=basePath%>/uiframe/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript"src="<%=basePath%>/uiframe/js/ckeditor/config.js"></script>
<script type="text/javascript"src="<%=basePath%>/uiframe/js/ckeditor/adapters/jquery.js"></script>