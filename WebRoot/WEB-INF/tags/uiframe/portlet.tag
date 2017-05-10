<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="ID" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style" %>
<%@attribute name="cls" rtexprvalue="true" required="false" description="cls" %>
<%@attribute name="iconCls" rtexprvalue="true" required="false" description="icon图标" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="门户模块的url" %>
<%@attribute name="iframeUrl" rtexprvalue="true" required="false" description="门户模块的iframeUrl" %>
<%@attribute name="moreUrl" rtexprvalue="true" required="false" description="更多数据的加载地址" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="title" %>
<%@attribute name="contentHeight" rtexprvalue="true" required="true" description="内容高度" %>
<%@attribute name="autoLoad" rtexprvalue="true" required="false" description="是否自动加载" %>
<%@attribute name="collapsible" rtexprvalue="true" required="false" description="是否收起" %>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String height="235px";
    if (url!=null && iframeUrl!=null){
        throw new Exception("url 和 iframeUrl不能同时赋值!");
    }

    if(url.contains("?")){
        url+="&time="+new Date().getTime();
    }else{
        url+="?time="+new Date().getTime();
    }

    boolean autoLoadText;
    boolean collapsibleText;
    boolean moreUrlText;
    if(StringUtils.isNotEmpty(autoLoad) && autoLoad.equalsIgnoreCase("false")){
        autoLoadText=false;
    } else {
        autoLoadText=true;
    }
    if(StringUtils.isNotEmpty(collapsible) && collapsible.equalsIgnoreCase("true")){
        collapsibleText=true;
    } else {
        collapsibleText=false;
    }
    if(moreUrl==null||moreUrl.equalsIgnoreCase("")){
        moreUrl="";
        moreUrlText=false;
    } else {
        moreUrlText=true;
    }
%>
<script type="text/javascript">

    (function(){
        executeQueue.push(function(){
            var model=new $.SywPortalItemModel({
                url:"<%=url%>",
                cid:"${id}",
                autoLoad:<%=autoLoadText%>,
                moreIcon:<%=moreUrlText%>,
                collapsible:<%=collapsibleText%>,
                iframeUrl:"<%=iframeUrl%>",
                width:($("body").width()-70)/2,
                height:<%=contentHeight%>+40
            });
            var view=new $.SywPortalItemView({model:model,el:$("#<%=id%>")});
        });
    })();
</script>
<div style="<%=style%>;width: 300px;" class="<%=cls%> portletItem" id="${id}">
    <table style="width:100%">
        <tr>
            <td class="portlet_top_l"> </td>
            <td class="portlet_top_c"> </td>
            <td class="portlet_top_r"> </td>
        </tr>
        <tr class="widget-header">
            <td class="portlet_c1_l"> </td>
            <td class="portlet_c1_c">
                <%--<div class="iconExpand fr" expanded="false"></div>--%>
                <div class="portlet_more_div fr"><a target="_blank" href="<%=basePath%>/<%=moreUrl%>" class="portlet_more">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                <div class="iconClose collapsibleBtn fr" collapsible="false" autoload="false"></div>
                <div class="portlet_title fl" style="margin-left:4px;padding:0;"><span style="margin-right: 4px;" class="uiframe-toolbarBtnIcon <%=iconCls%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>${title}</div>
            </td>
            <td class="portlet_c1_r"> </td>
        </tr>

        <tr class="widget-content">
            <td class="portlet_c2_l"> </td>
            <td class="">
                <div id="portlet_conten_${id}" style="height: ${contentHeight}px;overflow-x: auto;" class="clear portletItemBody">
                    <jsp:doBody/>
                </div>
            </td>
            <td class="portlet_c2_r"> </td>
        </tr>

        <tr>
            <td class="portlet_b_l"> </td>
            <td class="portlet_b_c"></td>
            <td class="portlet_b_r"> </td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="3"></td>
        </tr>
    </table>
</div>