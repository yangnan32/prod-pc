<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-5-12上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="rootId" rtexprvalue="true" required="true" description="根节点的id" %>
<%@attribute name="idProperty" rtexprvalue="true" required="true" description="异步加载节点时固定参数名" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="treeGridHeader" fragment="true"%>
<%@attribute name="useToolPage" rtexprvalue="true" required="false" description="是否显示翻页工具栏" %>
<%@attribute name="expendOneLevel" rtexprvalue="true" required="false" description="是否只允许展开一级节点" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="分页条数" %>
<%@attribute name="start" rtexprvalue="true" required="false" description="加载条数" %>
<%@attribute name="paramsString" rtexprvalue="true" required="false" description="第一次加载的参数字符串" %>
<%@attribute name="autoLoad" rtexprvalue="true" required="false" description="第一次是否加载数据，默认加载" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String useToolPageText = "false";
    if(limit==null||limit.equalsIgnoreCase("")){
        limit="15";
    }
    if(start==null||start.equalsIgnoreCase("")){
        start="0";
    }
    if(StringUtils.isNotEmpty(useToolPage) && useToolPage.equalsIgnoreCase("true")){
        useToolPage = "";
        useToolPageText = "true";
    } else {
        useToolPage = "style='display:none;height:0;'";
    }
    if(StringUtils.isNotEmpty(expendOneLevel) && expendOneLevel.equalsIgnoreCase("true")){
        expendOneLevel = "true";
    } else {
        expendOneLevel = "false";
    }
    if(paramsString==null||paramsString.equalsIgnoreCase("")){
        paramsString="";
    }
    request.setAttribute("start", start);
    request.setAttribute("limit", limit);
    request.setAttribute("paramsString", paramsString);
%>
<div id="<%=id%>" class="uiframe-jspGrid-panel widget-jspTreeGrid" data-url="<%=basePath%><%=url%>" data-id="<%=id%>" data-limit="<%=limit%>" data-start="<%=start%>" data-idproperty="<%=idProperty%>" data-rootid="<%=rootId%>">
    <div class="uiframe-jspGrid">
        <div class="uiframe-jspGrid-header" id="<%=id%>HeaderDiv">
            <table>
                <tbody>
                <%-- 树表表头 --%>
                <jsp:invoke fragment="treeGridHeader"/>
                </tbody>
            </table>
        </div>
        <div class="uiframe-jspGrid-main" id="<%=id%>MainDiv" style="width:100%;position:relative;">
            <div id="<%=id%>ContentDiv">
                <%
                    if(autoLoad == null || StringUtils.isEmpty(autoLoad) || !"false".equalsIgnoreCase(autoLoad)){
                %>
                <%-- 树表数据 --%>
                <jsp:include page="${url}?start=${start}&limit=${limit}&${paramsString}"></jsp:include>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>