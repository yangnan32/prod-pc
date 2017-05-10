<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-28下午3:16
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>

<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="style样式代码" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="日期默认值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="dateType" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="只读,true为只读" %>
<%@attribute name="editable" rtexprvalue="true"  required="false" description="是否可输入,true为可输入" %>



<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("disabled")){
        disableText="disabled='disabled'";
        disableBtnClass="uiframe-input-date-disabled";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
%>
<script type="text/javascript">
    (function(){
        var date=function(){
            $("#${id}").on("disabled",function(e){
                $("#${id}").attr("disabled","disabled");
                $("#${id}").addClass("uiframe-input-date-disabled");
                e.preventDefault();
            });
            $("#${id}").on("enable",function(e){
                $("#${id}").removeAttr("disabled");
                $("#${id}").removeClass("uiframe-input-date-disabled");
                e.preventDefault();
            });
            $("#${id}").on("keyup", function() {
                $("#_my97DP").hide();
            });
        };
        date.orderNumber=34;
        executeQueue.push(date);
    })();
</script>
<input type="text" class="uiframe-input-date ${cls} <%=disableBtnClass%> ${group}" value="<%=value%>" id="${id}" name="${name}" style="${style}" <% if(!(readonly!=null && readonly.equalsIgnoreCase("true"))){%>  onFocus="WdatePicker({${dateType}});$('.uiframe-selectHide').hide();" <%}else {%>  readonly="readonly" <%}%>  <%=disableText%> />
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <span class="mustWrite" style="*-margin-left:-1px;">*</span>
    </c:when>
</c:choose>

