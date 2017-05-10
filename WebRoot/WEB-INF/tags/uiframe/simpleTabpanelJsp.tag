<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-7-30上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="tabMap" rtexprvalue="true" type="java.util.Map" description="标签页对应的LinkedHashMap对象"  required="true" %>
<div id="<%=id%>Layout" class="uiframe-layoutDiv">
    <div class="uiframe-tabpanel-tab-content" id="<%=id%>">
        <div class="uiframe-tabpanel-tab-content" id="<%=id%>-menu">
            <ul class="uiframe-tabpanel-mover uiframe-tab-ul">
                <c:forEach var="item" items="<%=tabMap%>"  varStatus="s">
                    <c:choose>
                        <c:when test="${s.index==0}">
                            <li class="uiframe-tabLi tab-active" myUrl ="${basePath}${item.value}" style="width:${fn:length(item.key) * 14 +20}px">
                        </c:when>
                        <c:otherwise>
                            <li class="uiframe-tabLi" myUrl ="${basePath}${item.value}" style="width:${fn:length(item.key) * 14 +20}px">
                        </c:otherwise>
                    </c:choose>
                    <div class="uiframe-tabLeft"></div>
                    <div class="uiframe-tabCenter uiframe-tab-liCenter">
                        <div class="tab-title">${item.key}</div>
                    </div>
                    <div class="uiframe-tabRight"></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="uiframe-tabpanel-tab-spacer"></div>
    </div>
    <div class="uiframe-tabpanel-content uiframe-fit" id="<%=id%>-box">
        <c:forEach var="item" items="<%=tabMap%>"  varStatus="s">
            <div class="tab-html-content"></div>
        </c:forEach>
    </div>
</div>