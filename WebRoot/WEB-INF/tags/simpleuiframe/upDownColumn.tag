<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-5-4下午20:01
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="upHeight" rtexprvalue="true" required="false" description="上部区域高度" %>
<%@attribute name="upId" rtexprvalue="true" required="false" description="上部区域id" %>
<%@attribute name="downId" rtexprvalue="true" required="false" description="下部区域id" %>
<%@attribute name="topPanel" fragment="true"%>
<%@attribute name="downPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(upId)){
        upId="uiframe_layout_top"+uuid;
    }
    if(StringUtils.isEmpty(downId)){
        downId="uiframe_layout_down"+uuid;
    }
    if(StringUtils.isEmpty(upHeight)){
        upHeight="100";
    }else if(upHeight.endsWith("px")){
        upHeight=upHeight.substring(0,upHeight.length()-2);
    }
%>
<div class="uiframe-layoutDiv" id="<%=upId%>UpDownColumn">
    <div class="uiframe-two-row-top" id="<%=upId%>" style="height:<%=upHeight%>px;">
        <!-- top panel -->
        <jsp:invoke fragment="topPanel"/>
    </div>
    <!-- split bar -->
    <div class="uiframe-upDown-split-tool upDownSplitTool" id="uiframe_split_tool<%=uuid%>" upHeight="<%=upHeight%>" parentDivId="<%=upId%>UpDownColumn" upId="<%=upId%>"></div>
    <!-- down panel -->
    <div class="uiframe-two-row-down uiframe-fit" id="<%=downId%>">
        <jsp:invoke fragment="downPanel"/>
    </div>
</div>