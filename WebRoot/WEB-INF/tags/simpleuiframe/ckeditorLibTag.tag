<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!-- CKEDITOR tag libs -->
<%--<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ckeditor/ckeditor.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ckeditor/config.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ckeditor/adapters/jquery.js"></script>--%>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ckeditor-4.5.8/ckeditor.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ckeditor-4.5.8/ckeditor-config.js"></script>