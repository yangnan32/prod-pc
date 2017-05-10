<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    List<String> jsList=new ArrayList<String>(12);
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/TreeGrid.packed.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/AbstractTreeStore.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/AdjacencyListStore.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/EditorGridPanel.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/sysEditTreeGridPanel.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/ExtOverride.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/GridPanel.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/GridView.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/NestedSetStore.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/NS.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/PagingToolbar.js");
    jsList.add("/uiframe/js/ext3.4/ux/treegridlib/XType.js");
    String jsName=UiframeUtil.mergeJs(jsList, "extjsTreeGridLibAll.js");
%>
<script type="text/javascript" src="<%=basePath%><%=jsName%>"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/sysTreeGrid.css" />
<script type="text/javascript">
    Ext.ux.maximgb.tg.sysEditTreeGridPanel.prototype.columnLines=false;//
//    Ext.ux.maximgb.tg.sysEditTreeGridPanel.prototype.trackMouseOver =true
    Ext.ux.maximgb.tg.sysEditTreeGridPanel.prototype.stripeRows=true;
</script>