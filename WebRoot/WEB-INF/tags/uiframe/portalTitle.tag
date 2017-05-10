<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-11-6上午10:24
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="控件名称，必填" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="行内样式" %>
<%@attribute name="returnText" rtexprvalue="true" required="false" description="行内样式" %>
<%@attribute name="returnUrl" rtexprvalue="true" required="false" description="行内样式" %>
<div class="uiframe-title-portal" style="<%=style%>">
    <div class="uiframe-title-portalTitle" id="<%=id%>"><%=title%></div>
    <c:if test="${returnUrl != null && returnText != null}">
        <div class="uiframe-title-portalTitle-back" style="float:right;"><a href="${returnUrl}">${returnText}</a></div>
    </c:if>
</div>