<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="false" description="id" %>
<%
    if(id==null||id.equals("null")){
        id=String.valueOf(new Date().getTime());
    }
%>
<div id="${id}" class="uiframe-menu">
    <jsp:doBody/>
</div>