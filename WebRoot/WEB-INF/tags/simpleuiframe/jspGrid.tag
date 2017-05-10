<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-4-28下午3:33
    * @team        :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="分页条数" %>
<%@attribute name="width" rtexprvalue="true" required="false" description="表格宽度" %>
<%@attribute name="url" rtexprvalue="true" required="true" description="刷新数据地址" %>
<%@attribute name="start" rtexprvalue="true" required="false" description="加载条数" %>
<%@attribute name="paramsString" rtexprvalue="true" required="false" description="第一次加载的参数字符串" %>
<%@attribute name="useToolPage" rtexprvalue="true" required="false" description="是否显示翻页工具栏" %>
<%@attribute name="simpleTool" rtexprvalue="true" required="false" description="是否显示简化版翻页" %>
<%@attribute name="gridHeader" fragment="true"%>
<%@attribute name="autoLoad" rtexprvalue="true" required="false" description="第一次是否加载数据，默认加载" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    if(limit==null||limit.equalsIgnoreCase("")){
        limit="15";
    }
    if(start==null||start.equalsIgnoreCase("")){
        start="0";
    }
    if(StringUtils.isNotEmpty(useToolPage) && useToolPage.equalsIgnoreCase("false")){
        useToolPage = "false";
    } else {
        useToolPage = "true";
    }
    if(paramsString==null||paramsString.equalsIgnoreCase("")){
        paramsString="";
    }
    request.setAttribute("paramsString", paramsString);
    if(width==null||width.equalsIgnoreCase("")){
        width="760";
    }
    float w=760;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=760;
    }
    request.setAttribute("start", start);
    request.setAttribute("limit", limit);
%>
<div id="<%=id%>" class="uiframe-jspGrid-panel widget-jspGrid" data-usePage="<%=useToolPage%>" data-simpleTool="<%=simpleTool%>" data-url="<%=basePath%><%=url%>" data-id="<%=id%>" data-params="${paramsString}" data-limit="<%=limit%>" data-start="<%=start%>">
    <div class="uiframe-jspGrid">
        <div class="uiframe-jspGrid-header" id="<%=id%>HeaderDiv">
            <table>
                <tbody>
                <%-- 表格表头 --%>
                <jsp:invoke fragment="gridHeader"/>
                </tbody>
            </table>
        </div>
        <div class="uiframe-jspGrid-main" id="<%=id%>MainDiv" >
            <table id="<%=id%>MainTableDiv">
                <tbody id="<%=id%>MainTable">
                <%
                    if(autoLoad == null || StringUtils.isEmpty(autoLoad) || !"false".equalsIgnoreCase(autoLoad)){
                %>
                <%-- 表格数据 --%>
                <jsp:include page="${url}?start=${start}&limit=${limit}&${paramsString}"></jsp:include>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>