<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-7-24下午2:28
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>

<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="hiddenId" rtexprvalue="true" required="false" description="控件隐藏域ID,选填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="true" description="控件的name,后台根据name获取选择的值" %>
<%@attribute name="hiddenName" rtexprvalue="true"  required="true" description="控件隐藏域name,后台根据name获取选择的值" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件默认值" %>
<%@attribute name="btnTitle" rtexprvalue="true"  required="true" description="控件按钮的名称" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读，默认true" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String fontText="";
    String nameText="";
    String hiddenText="";
    String disableClass="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        fontText="color:#b3b3b3";
        disableClass="uiframe-textinput-disabled";
    }

    if(StringUtils.isNotBlank(name)){
        nameText="name='"+name+"'";
    }else {
        nameText="";
    }

    if(StringUtils.isNotBlank(hiddenName)){
        hiddenText="name='"+hiddenName+"'";
    }else {
        hiddenText="";
    }

    if(StringUtils.isNotBlank(value)){
        value="value='"+value+"'";
    }else {
        value="";
    }

    if(width==null||width.equalsIgnoreCase("")){
        width="334";
    }
    float w=334;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=334;
    }
%>

<script type="text/javascript">
    (function(){
        var btnText=function(){
            //按钮文本框组合划过样式
            $('#btnText${id}'+<%=uuid%>).on("mouseover", function () {
                $(this).children("input.uiframe-btntext").addClass('uiframe-textinput-hover');
                $(this).children(".uiframe-module-btn").addClass('uiframe-module-btn-hover');
            });
            $('#btnText${id}'+<%=uuid%>).on("mouseout", function () {
                $(this).children("input.uiframe-btntext").removeClass('uiframe-textinput-hover');
                $(this).children(".uiframe-module-btn").removeClass('uiframe-module-btn-hover');
            });
            $("#${id}").on("disabled",function(e){
                $("#${id}").attr("disabled","disabled");
                $("#${id}").addClass("uiframe-textinput-disabled");
                $("#btn${id}").addClass("uiframe-emptyTextColor");
                e.preventDefault();

            });
            $("#${id}").on("enable",function(e){
                $("#${id}").removeAttr("disabled");
                $("#${id}").removeClass("uiframe-textinput-disabled");
                $("#btn${id}").removeClass("uiframe-emptyTextColor");
                e.preventDefault();
            });
//            赋值操作
           $("#${id}").on("setValue",function(e,hiddenValue,displayValue){
               $("#${hiddenId}").val(hiddenValue);
               $("#${id}").val(displayValue);

           })
        };
        btnText.orderNumber=31;
        executeQueue.push(btnText);
    })();
</script>
<div class="uiframe-btntext-container" id="btnText<%=id%><%=uuid%>">
    <input type="hidden" id="${hiddenId}" <%=hiddenText%> />
    <input type="text" id="${id}"<% if(!(readonly!=null && readonly.equalsIgnoreCase("false"))){%> readonly="readonly"<%}%> <%=nameText%> <%=value%> class="uiframe-btntext ${group} <%=disableClass%> ${cls}" style="float:left;width:<%=w%>px;<%=fontText%>" <%=disableText%> >
    <span id="btn${id}" class="uiframe-btnText-btn" <%=disableText%> style="<%=fontText%>"><%=btnTitle%></span>
    <c:choose>
        <c:when test="${not empty must and must=='true'}">
            <span class="mustWrite" style="margin-left: 4px;*-margin-left: 0px;">*</span>
        </c:when>
    </c:choose>
</div>

