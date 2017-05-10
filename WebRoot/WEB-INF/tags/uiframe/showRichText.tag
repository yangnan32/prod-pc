
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="com.widget.framework.i18n.I18nManager" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="width" rtexprvalue="true" required="false" description="控件宽度" %>
<%@attribute name="height" rtexprvalue="true" required="false" description="控件高度" %>
<%@attribute name="value" rtexprvalue="true" required="true" description="显示值" %>
<%
    if(StringUtils.isBlank(width)){
        width = "100%";
    }
    if(StringUtils.isBlank(height)){
        height = "100%";
    }
%>

<script type="text/javascript">
(function(){
    var richText=function(){
        setTimeout(function(){
            $(window.frames["<%=id%>"].document.body).append($("#<%=id%>").val());
            $("#<%=id%>").remove();
        },10);
    };
    richText.orderNumber=49;
    executeQueue.push(richText);
})();
</script>
<iframe frameborder="0" width="<%=width%>" height="<%=height%>" name="<%=id%>" src="">
    <div id="<%=id%>Div"></div>
</iframe>
<input type="hidden" id="<%=id%>" value='<%=value%>' />



