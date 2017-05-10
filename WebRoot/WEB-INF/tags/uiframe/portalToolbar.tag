<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @team	       :
    * @author      : hemq
    *description   :工具栏
--%>
<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@attribute name="id" rtexprvalue="true" required="false" description="工具栏唯一标识" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="工具栏style" %>
<%
    long uuid=new Date().getTime();
    if(id==null||id.equalsIgnoreCase("")){
        id=String.valueOf(new Date().getTime());
    }
%>
<div id="<%=id%>" class="uiframe-poratlToolbar" style="${style};">
    <jsp:doBody/>
</div>
