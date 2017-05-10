<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.*" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="ID" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style" %>
<script type="text/javascript">
    (function(){
        var s=function(){
               sywFunction.init("${id}");
        };
        s.orderNumber=10;
        executeQueue.push(s);
    })();

</script>
<div class="uiframe_layout_viewport" id="${id}" style="overflow: hidden;_position: relative;<%=style%>">
    <jsp:doBody/>
</div>