<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-1-31上午11:02
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="rightId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="resizable" rtexprvalue="true" required="false" description="是否可拖拽" %>
<%@attribute name="minLeftWidth" rtexprvalue="true" required="false" description="左侧区域最小宽度" %>
<%@attribute name="minRightWidth" rtexprvalue="true" required="false" description="右侧区域最小宽度" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="rightPanel" fragment="true"%>
<%@attribute name="collapsed" rtexprvalue="true" required="false" description="左侧区域是否闭合"%>
<%
    long uuid=new Date().getTime();
    boolean resizableText;
    boolean collapsedText;
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_right"+uuid;
    }
    if(StringUtils.isEmpty(leftWidth)){
        leftWidth="300";
    }else if(leftWidth.endsWith("px")){
        leftWidth=leftWidth.substring(0,leftWidth.length()-2);
    }
    if(StringUtils.isEmpty(minLeftWidth)){
        minLeftWidth="150";
    }else if(leftWidth.endsWith("px")){
        minLeftWidth=minLeftWidth.substring(0,minLeftWidth.length()-2);
    }
    if(StringUtils.isEmpty(minRightWidth)){
        minRightWidth="300";
    }else if(leftWidth.endsWith("px")){
        minRightWidth=minRightWidth.substring(0,minRightWidth.length()-2);
    }
    if(StringUtils.isNotEmpty(resizable) && resizable.equalsIgnoreCase("true")){
        resizableText = false;
    } else {
        resizableText = true;
    }
    if("true".equalsIgnoreCase(collapsed)){
    	collapsedText= true;
    }else{
    	collapsedText= false;
    }
%>
<div id="mainSplitter<%=leftId%><%=uuid%>">
    <div class="splitter-panel" id="<%=leftId%>">
        <!-- left panel -->
        <jsp:invoke fragment="leftPanel"/>
    </div>
    <!-- right panel -->
    <div class="splitter-panel" id="<%=rightId%>">
        <jsp:invoke fragment="rightPanel"/>
    </div>
</div>
<script type="text/javascript">
    var h = document.documentElement.clientHeight;
    var topHeight=0;
    if($("#uiframe-header").css("display")!="none"){
        topHeight+=$("#uiframe-header").height();
    }
    if($("#uiframe-myplace-nav").css("display")!="none"){
        topHeight+=$("#uiframe-myplace-nav").height();
    }
    if($("#uiframe-top").css("display")=="none"){
        topHeight=0;
    }
    $("#uiFrame-container").css("height",h - topHeight);
    $(".uiframe_layout_viewport:first").css("height", h - topHeight );

    var leftWidth = parseInt("<%=leftWidth%>");
    var minLeftWidth = parseInt("<%=minLeftWidth%>");
    var minRightWidth = parseInt("<%=minRightWidth%>");
    var partentW;
    var partentH;
    function twoColumnResize(){
        partentW = $("#mainSplitter<%=leftId%><%=uuid%>").parent("div").width();
        partentH = $("#mainSplitter<%=leftId%><%=uuid%>").parent("div").height();
        $("#mainSplitter<%=leftId%>"+<%=uuid%>).jqxSplitter({width: partentW,height:partentH,panels: [{ size: leftWidth, min: minLeftWidth, collapsed:<%=collapsedText%>}, { min: minRightWidth }] });
    }
    $("#mainSplitter<%=leftId%>"+<%=uuid%>).parent("div").resize(function() {
        if($("#mainSplitter<%=leftId%><%=uuid%>").parent("div").width() > partentW || $("#mainSplitter<%=leftId%><%=uuid%>").parent("div").height() > partentH) {
            twoColumnResize();
        }
    });
    twoColumnResize();
    $(function(){
        $("#<%=leftId%>").resize(function(){
            $("#body").trigger("resizeLayoutWidth", [$("#<%=leftId%>").width(), $("#<%=rightId%>").width()]);
        });
    });
</script>
