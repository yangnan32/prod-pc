<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-5-4下午21:01
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="centerWidth" rtexprvalue="true" required="false" description="中间区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="centerId" rtexprvalue="true" required="false" description="中间区域id" %>
<%@attribute name="rightId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="centerPanel" fragment="true"%>
<%@attribute name="rightPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_center"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_right"+uuid;
    }
    if(StringUtils.isEmpty(leftWidth)){
        leftWidth="200";
    }else if(leftWidth.endsWith("px")){
        leftWidth=leftWidth.substring(0,leftWidth.length()-2);
    }
    if(StringUtils.isEmpty(centerWidth)){
        centerWidth="300";
    }else if(centerWidth.endsWith("px")){
        centerWidth=centerWidth.substring(0,centerWidth.length()-2);
    }
%>
<div class="uiframe-layoutDiv threeColumn" data-leftWidth="<%=leftWidth%>" data-centerWidth="<%=centerWidth%>" data-id="<%=leftId%>" id="<%=leftId%>ThreeColumn">
    <div class="uiframe-two-row-left" id="<%=leftId%>" style="width:<%=leftWidth%>px;">
        <!-- left panel -->
        <jsp:invoke fragment="leftPanel"/>
    </div>
    <!-- split bar -->
    <div class="uiframe-left-split-tool uiframe-three-split-tool widget-LayoutSplitTool"></div>
    <div class="uiframe-three-center" id="<%=centerId%>" style="width:<%=centerWidth%>px;">
        <!-- center panel -->
        <jsp:invoke fragment="centerPanel"/>
    </div>
    <!-- right panel -->
    <div class="uiframe-three-center" style="width:1px;background:#dde8ec"></div>
    <div class="uiframe-two-row-right threeColumnRight" id="<%=rightId%>">
        <jsp:invoke fragment="rightPanel"/>
    </div>
</div>