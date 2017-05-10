<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-4-28下午16:01
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="rightId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="collapsed" rtexprvalue="true" required="false" description="是否可折叠" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="rightPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    String clickCls="";
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_right"+uuid;
    }
    if(StringUtils.isNotEmpty(collapsed) && collapsed.equalsIgnoreCase("true")){
        clickCls="widget-LayoutSplitTool";
    } else {
        clickCls="split-noClick";
    }
    if(StringUtils.isEmpty(leftWidth)){
        leftWidth="300";
    }else if(leftWidth.endsWith("px")){
        leftWidth=leftWidth.substring(0,leftWidth.length()-2);
    }
%>
<div class="uiframe-layoutDiv twoColumn" data-leftWidth="<%=leftWidth%>" data-id="<%=leftId%>" id="<%=leftId%>TwoColumn">
    <div class="uiframe-two-row-left" id="<%=leftId%>" style="width:<%=leftWidth%>px;">
        <!-- left panel -->
        <jsp:invoke fragment="leftPanel"/>
    </div>
    <!-- split bar -->
    <div class="uiframe-left-split-tool uiframe-centerTool"></div>
    <!-- right panel -->
    <div class="uiframe-two-row-right twoColumnRight" id="<%=rightId%>">
        <jsp:invoke fragment="rightPanel"/>
    </div>
</div>