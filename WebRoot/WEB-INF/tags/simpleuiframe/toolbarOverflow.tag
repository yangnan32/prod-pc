<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-7-18上午10:11
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="下拉按钮显示的宽度，不填则取默认值" %>
<%
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
%>
<span class="uiframe-toolbarOverflow" id="btnParent${id}">
 	<div class="uiframe-toolbarOverflow-btn widgetToolbarBtn widgetMenuBtn" id="${id}"></div>
    <div class="uiframe-sub-toolbarOverflow uiframe-selectHide" id="sub-toolbarOverflow${id}" style="width:<%=w%>px;overflow-y: auto; overflow-x: hidden;">
        <jsp:doBody />
    </div>
</span>