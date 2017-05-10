<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe" %>
<%@ tag pageEncoding="UTF-8" %> <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%-- 模板html --%>
<link rel="stylesheet" href="<%=basePath%>/ui/js/widgetui/plugins/zTree-3.5.14/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-validation-1.9.0/jquery.validate.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-validation-1.9.0/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-validation-1.9.0/messages_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/pnotify-1.1.0/jquery.pnotify.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/backbone/underscore.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/backbone/mustache.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/backbone/backbone.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/widget-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/uicomponent/sywMask.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/uicomponent/sywDialog.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/uicomponent/sywWindow.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/ajaxFileUpload/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/zTree-3.5.14/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.resizable.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/jquery-ui-1.9.2.custom/development-bundle/ui/jquery.ui.sortable.js"></script>
<script type="text/javascript">
    $(function(){
        // 窗口拖拽监听
        $(window).resize(function(){
            sywBase.initFit("uiFrame-container");
            $("#body").trigger("resizeWindow", [$("#body").width(), $("#body").height()]);
        });
    });
</script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/My97DatePicker/WdatePicker.js"></script>
<%--<widget:mergejs moduleName="ui/frame/widgetUi"/>--%>