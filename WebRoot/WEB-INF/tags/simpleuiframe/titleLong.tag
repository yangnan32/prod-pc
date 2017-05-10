<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-6-4上午9:25
    * @team	    : 
    * @author      : yangn
    *@modify   :增加国际化
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="控件名称，必填" %>
<%@attribute name="returnPanel" fragment="true" description="返回按钮片段" %>
<%@attribute name="toolPanel" fragment="true" description="工具栏片段" %>
<div class="uiframe-title-long" id="${id}Title">
    <div class="uiframe-title-longTitle" id="${id}"><%=title%></div>
    <div class="uiframe-title-return">
        <jsp:invoke fragment="returnPanel"/>
    </div>
    <div class="uiframe-title-tool">
        <jsp:invoke fragment="toolPanel"/>
    </div>
</div>