<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 14-5-26下午1:46
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="rootId" rtexprvalue="true" required="true" description="根节点的id" %>
<%@attribute name="idProperty" rtexprvalue="true" required="true" description="异步加载节点时固定参数名" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="paramsString" rtexprvalue="true" required="false" description="第一次加载的参数字符串" %>
<%@attribute name="autoLoad" rtexprvalue="true" required="false" description="第一次是否加载数据，默认加载" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    if(paramsString==null||paramsString.equalsIgnoreCase("")){
        paramsString="";
    }
    request.setAttribute("paramsString", paramsString);
%>
<div id="<%=id%>" class="uiframe-fit widget-jspTree" data-url="<%=basePath%><%=url%>" data-id="<%=id%>" data-idproperty="<%=idProperty%>" data-rootid="<%=rootId%>" >
    <div class="uiframe-jspTree" style="height:99.5%;" id="<%=id%>MainDiv">
        <div style="width:100%;" id="<%=id%>MainTableDiv">
            <%
                if(autoLoad == null || StringUtils.isEmpty(autoLoad) || !"false".equalsIgnoreCase(autoLoad)){
            %>
            <%-- 树数据 --%>
            <c:set var="seperator" value="?"/>
            <c:if test="${fn:indexOf(url, '?')!=-1}">
                <c:set var="seperator" value="&"/>
            </c:if>
            <jsp:include page="${url}${seperator}${paramsString}"></jsp:include>
            <%
                }
            %>
        </div>
    </div>
</div>
