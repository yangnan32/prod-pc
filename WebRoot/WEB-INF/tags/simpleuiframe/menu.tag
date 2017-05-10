<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-6-4上午11:26
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true"  required="true" description="控件的名称，必填" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="下拉按钮显示的宽度，不填则取默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="iconCls" rtexprvalue="true"  required="false" description="图标样式代码" %>
<%@attribute name="tooltip" rtexprvalue="true"  required="false" description="提示文字" %>
<%@attribute name="hidden" rtexprvalue="true"  required="false" description="是否隐藏按钮，默认false" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String clickCls="widgetToolbarBtn";
    String centerText="";
    String tooltipText="";
    String tooltipClass="";
    String hiddenText = "";

    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls = "";
        centerText = "uiframe-toolbarBtn-disabled";
    } else {
        disableText="";
        centerText = "";
    }
    if(StringUtils.isNotBlank(tooltip)){
        tooltipText="myTitle='"+tooltip+"'";
        tooltipClass="tooltip";
    }else {
        tooltipText="";
        tooltipClass="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="80";
    }
    float w=80;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=80;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="200";
    }
    float h=200;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=200;
    }

    if(StringUtils.isNotEmpty(hidden) && hidden.equalsIgnoreCase("true")){
        hiddenText="uiframe-hide";
    } else {
        hiddenText = "";
    }
%>
<span class="uiframe-menu <%=centerText %>" id="btnParent${id}">
	<button id="${id}" type="button" class="widgetMenuBtn <%=clickCls%> tool-button uiframe-menu-rightbg <%=tooltipClass%>" <%=tooltipText%> style="text-align: left;padding-left:0" <%=disableText%>>
     	<span class="<%=iconCls%>" style="_padding-bottom:2px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
     	<span class="toolbarText"><%=title%></span>
	</button>
    <div class="uiframe-submenu uiframe-selectHide" id="submenu${id}" style="width:<%=w+5%>px;overflow-y: auto;overflow-x: hidden;">
        <jsp:doBody />
    </div>
</span>