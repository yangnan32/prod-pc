<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-7-30上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="rightId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="rightPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_right"+uuid;
    }
    if(leftWidth==null||leftWidth.equalsIgnoreCase("")){
        leftWidth="300";
    }
    float w = 300;
    try{
        w = Float.parseFloat(leftWidth);
    }catch (NumberFormatException ex){
        w = 300;
    }
%>
<div class="uiframe-border-two-left" id="<%=leftId%>" style="width:<%=w%>px;">
    <!-- left panel -->
    <jsp:invoke fragment="leftPanel"/>
</div>
<div id="<%=rightId%>" style="height:99.5%;overflow:auto;">
    <!-- right panel -->
    <jsp:invoke fragment="rightPanel"/>
</div>
