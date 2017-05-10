<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-6-1下午4:19
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="控件名称，必填" %>
<%@attribute name="iconCls" rtexprvalue="true" required="false" description="控件图标样式，选填" %>
<%@attribute name="toolPanel" fragment="true" description="工具按钮片段" %>
<%@attribute name="returnPanel" fragment="true" description="返回按钮片段" %>
<div class="uiframe-title-short">
    <div class="uiframe-title-shortTitle">
        <span id="${id}" style="padding-left: 4px;"><%=title%></span>
    </div>
    <div class="uiframe-title-return">
        <jsp:invoke fragment="returnPanel"/>
    </div>
    <div class="uiframe-title-tool">
        <jsp:invoke fragment="toolPanel"/>
    </div>
</div>