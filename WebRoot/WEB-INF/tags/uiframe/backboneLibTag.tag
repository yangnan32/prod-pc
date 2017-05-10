<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    List<String> jsList=new ArrayList<String>(3);
    jsList.add("/uiframe/js/backbone/underscore.js");
    jsList.add("/uiframe/js/backbone/mustache.js");
    jsList.add("/uiframe/js/backbone/backbone.js");

    String jsName=UiframeUtil.mergeJs(jsList, "backboneAll.js");
%>
<script type="text/javascript" src="<%=basePath%><%=jsName%>"></script>
