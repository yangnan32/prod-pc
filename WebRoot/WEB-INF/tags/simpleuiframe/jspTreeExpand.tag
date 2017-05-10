<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-7-30上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="treeGridHeader" fragment="true"%>
<%@attribute name="treeGridMain" fragment="true"%>
<%@attribute name="paramsString" rtexprvalue="true" required="false" description="第一次加载的参数字符串" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    if(paramsString==null||paramsString.equalsIgnoreCase("")){
        paramsString="";
    }
    request.setAttribute("paramsString", paramsString);
%>
<div id="<%=id%>" class="uiframe-fit widget-jspTreeExpand" data-url="<%=basePath%><%=url%>" data-id="<%=id%>">
    <div style="width:100%;" id="gridId" class="uiframe-jspGrid-panel">
        <div class="uiframe-grid">
            <div class="uiframe-jspGrid-header" id="<%=id%>HeaderDiv">
                <table class="sywTreeGridHeader">
                    <tbody>
                    <%-- 表格表头 --%>
                    <jsp:invoke fragment="treeGridHeader"/>
                    </tbody>
                </table>
            </div>
            <div class="uiframe-jspGrid-main" id="<%=id%>MainDiv" style="width:100%;position:relative;">
                <table class="sywTreeGridMain" id="<%=id%>MainTable">
                    <tbody>
                    <%-- 树表数据 --%>
                    <c:set var="seperator" value="?"/>
                    <c:if test="${fn:indexOf(url, '?')!=-1}">
                        <c:set var="seperator" value="&"/>
                    </c:if>
                    <jsp:include page="${url}${seperator}${paramsString}"></jsp:include>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>