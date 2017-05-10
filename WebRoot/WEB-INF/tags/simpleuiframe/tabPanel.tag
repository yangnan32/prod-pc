<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-5-5上午11:03
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="active" rtexprvalue="true" required="false" description="默认激活第几页" %>
<%@attribute name="activeUrl" rtexprvalue="true" required="false" description="默认激活页的url,废弃" %>
<%@attribute name="tabMap" rtexprvalue="true" type="java.util.Map" description="标签页对应的LinkedHashMap对象"  required="true" %>
<%
    int activeNub = 0;
    if(active != null && !active.equalsIgnoreCase("")){
        activeNub = Integer.parseInt(active);
    }
    request.setAttribute("activeNub",activeNub);
%>
<div id="<%=id%>" class="uiframe-layoutDiv">
    <div class="uiframe-tabpanel-tabDiv" id="<%=id%>-menu">
        <ul class="uiframe-tab-ul">
            <c:forEach var="item" items="<%=tabMap%>"  varStatus="s">
                <c:set var="tabLiActiveCls" value=""/>
                <c:if test="${s.index==activeNub}">
                    <c:set var="tabLiActiveCls" value="tab-active"/>
                </c:if>
                <c:set var="liCls" value="widgetTabLi"/>
                <c:if test="${item.value == 'uiframe/404.action' || item.value == ''}">
                    <c:set var="liCls" value="tabLiMask"/>
                </c:if>
                <li class="uiframe-tabLi ${tabLiActiveCls} ${liCls}" liItem="${s.index}" showDivId="<%=id%>-box" myUrl ="${basePath}/${item.value}">
                    ${item.key}
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="uiframe-line10"></div>
    <div class="uiframe-tabpanel-content uiframe-fit tabPanel" id="<%=id%>-box">
        <c:forEach var="item" items="<%=tabMap%>" varStatus="s">
            <c:if test="${s.index == activeNub}">
                <div class="tab-html-content" style="display:block;">
                    <jsp:include page="/${item.value}"></jsp:include>
                </div>
            </c:if>
            <c:if test="${s.index != activeNub}">
                <div class="tab-html-content"></div>
            </c:if>
        </c:forEach>
    </div>
</div>