<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 14-5-20下午4:19
    * @team	    :
    * @author      : yangn
--%>
<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="false" description="工具栏唯一标识" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="工具栏style" %>
<%
    if(id==null||id.equalsIgnoreCase("")){
        id=String.valueOf(new Date().getTime());
    }
%>
<div id="<%=id%>" class="uiframe-toolbar" style="${style};">
    <jsp:doBody/>
</div>
