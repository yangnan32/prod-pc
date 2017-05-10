<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="com.widget.framework.i18n.I18nManager" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@ tag import="java.util.Date" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="id" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style样式" %>
<%@attribute name="height" rtexprvalue="true" required="true" description="高度" %>
<div style="<%=style%>">
    <table style="width: 100%;">
        <tr>
            <td class="rtl"></td>
            <td class="rtc"></td>
            <td class="rtr"></td>
        </tr>
        <tr style="height: <%=height%>px;">
            <td class="rcl"></td>
            <td style="vertical-align: top;padding-right: 5px;">
                <jsp:doBody/>
            </td>
            <td class="rcr"></td>
        </tr>
        <tr>
            <td class="rbl"></td>
            <td class="rbc"></td>
            <td class="rbr"></td>
        </tr>

    </table>
</div>