<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.*" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="ID" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style" %>
<div class="uiframe-layoutDiv" id="${id}" style="_position: relative;<%=style%>">
    <jsp:doBody/>
</div>