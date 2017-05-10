<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%-- 模板html --%>
<%@ include file="/uiframe/js/uicomponent/sywTpl.html" %>
<%
    List<String> jsList=new ArrayList<String>(20);
    jsList.add("/uiframe/js/widget/uiFrame.js");
    jsList.add("/uiframe/js/uicomponent/sywMask.js");
    jsList.add("/uiframe/js/uicomponent/sywDialog.js");
    jsList.add("/uiframe/js/uicomponent/sywWindow.js");
    jsList.add("/uiframe/js/uicomponent/sywToolbarButton.js");
    jsList.add("/uiframe/js/uicomponent/sywToolbarMenu.js");
    jsList.add("/uiframe/js/uicomponent/sywToolbarOverflow.js");
    jsList.add("/uiframe/js/uicomponent/sywText.js");
    jsList.add("/uiframe/js/uicomponent/sywButton.js");
    jsList.add("/uiframe/js/uicomponent/sywBtnText.js");
    jsList.add("/uiframe/js/uicomponent/sywDate.js");
    jsList.add("/uiframe/js/uicomponent/sywTime.js");
    jsList.add("/uiframe/js/uicomponent/sywFile.js");
    jsList.add("/uiframe/js/uicomponent/sywCombox.js");
    jsList.add("/uiframe/js/uicomponent/sywComboxTree.js");
    jsList.add("/uiframe/js/uicomponent/sywSearchCombox.js");
    jsList.add("/uiframe/js/uicomponent/sywMultiSelect.js");
    jsList.add("/uiframe/js/uicomponent/sywGrid.js");
    jsList.add("/uiframe/js/uicomponent/sywTreeGrid.js");
    jsList.add("/uiframe/js/widget/I18nManager.js");
    jsList.add("/uiframe/js/jquery/plugin/jqwidgets/jqxsplitter.js");
    String jsName= UiframeUtil.mergeJs(jsList, "uiframeLibAll.js");
%>
<script type="text/javascript" src="<%=basePath%><%=jsName%>"></script>
<link rel="stylesheet" href="<%=basePath%>/uiframe/loginPortal/css/frame.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/reset.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/uiframe.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/toolbar.css" type="text/css"/>
