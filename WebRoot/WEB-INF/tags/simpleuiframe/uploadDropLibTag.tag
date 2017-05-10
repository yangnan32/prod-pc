<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.progressbar.js"></script>
<script src="<%=basePath%>/ui/js/widgetui/plugins/uploadDrog/jquery.drop.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>/ui/js/widgetui/plugins/uploadDrog/jquery.upload_drag.js" type="text/javascript" charset="utf-8"></script>