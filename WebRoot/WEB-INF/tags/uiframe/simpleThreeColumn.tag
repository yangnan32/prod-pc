<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-11-23下午1:32
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="topWidth" rtexprvalue="true" required="false" description="右上侧区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="topId" rtexprvalue="true" required="false" description="右上侧区域id" %>
<%@attribute name="downId" rtexprvalue="true" required="false" description="右下侧区域id" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="topPanel" fragment="true"%>
<%@attribute name="downPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(topId)){
        topId="uiframe_layout_right"+uuid;
    }
    if(StringUtils.isEmpty(downId)){
        downId="uiframe_layout_right"+uuid;
    }
    if(leftWidth==null||leftWidth.equalsIgnoreCase("")){
        leftWidth="200";
    }
    float w = 200;
    try{
        w = Float.parseFloat(leftWidth);
    }catch (NumberFormatException ex){
        w = 200;
    }
    if(topWidth==null||topWidth.equalsIgnoreCase("")){
        topWidth="300";
    }
    float h = 300;
    try{
        h = Float.parseFloat(topWidth);
    }catch (NumberFormatException ex){
        h = 300;
    }
%>
<div class="uiframe-border-two-left" id="<%=leftId%>" style="width:<%=w%>px;">
    <!-- left panel -->
    <jsp:invoke fragment="leftPanel"/>
</div>
<div id="<%=leftId%>Right" style="height:99.5%;overflow:auto;">
    <div id="<%=topId%>" class="uiframe-twoColumn-top" style="height:<%=h%>px;">
        <jsp:invoke fragment="topPanel"/>
    </div>
    <div id="<%=downId%>" class="uiframe-fit">
        <!-- right panel -->
        <jsp:invoke fragment="downPanel"/>
    </div>
</div>
