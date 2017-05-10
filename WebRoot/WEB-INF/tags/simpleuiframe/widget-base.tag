<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe" %>
<%@ tag pageEncoding="UTF-8" %>
<%-- 模板html --%>
<%@ include file="/ui/js/widgetui/htmltpl/sywSimpleTpl.html" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<script type="text/javascript">
    var basePath="<%=basePath%>";/*设置js的basePath*/
</script>
<link rel="stylesheet" href="<%=basePath%>/ui/css/theme/widget-ui.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetbase/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetbase/widget-base.js"></script>
<%-- widgets --%>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/jspTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/jspGrid.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/jspTreeGrid.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/jspTreeExpand.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/selectTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/selectSearch.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/selectInput.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/searchInput.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/file.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/multifile.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/uploadify.js"></script>
<script type="text/javascript" src="<%=basePath%>/ui/js/widgetui/plugins/widgets/uiDesign.js"></script>
<%--<widget:mergejs moduleName="uiframe/frame/widgetBase"/>--%>

