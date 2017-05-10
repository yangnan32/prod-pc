<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-1-23下午4:10
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
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="readonly" rtexprvalue="true"   required="false" description="只读,值为readonly" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="style样式代码" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="外部div行内样式" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="maxLength" rtexprvalue="true"  required="false" description="最大限定的字数" %>
<%
    long uuid=new Date().getTime();
    boolean readOnlyFlag=false;
    boolean disabledFlag=false;
    boolean maxLengthFlag=false;
    boolean mustFlag=false;
    String emptyTextk = "";

    if(StringUtils.isEmpty(name)){
        name="textTag"+id+uuid;
    }
    if(StringUtils.isNotBlank(emptyText)){
        emptyTextk="emptyText='"+emptyText+"'";
    }else {
        emptyTextk="";
    }
    if(StringUtils.isNotEmpty(readonly)&&(readonly.equalsIgnoreCase("readonly")||readonly.equalsIgnoreCase("true"))){
        readOnlyFlag=true;
    }
    if(StringUtils.isNotEmpty(disabled)&&(disabled.equalsIgnoreCase("disabled")||disabled.equalsIgnoreCase("true"))){
        System.out.println("disabled...");
        disabledFlag=true;
    }
    if(StringUtils.isNotEmpty(must)&&(must.equalsIgnoreCase("must")||must.equalsIgnoreCase("true"))){
        mustFlag=true;
    }
    if(StringUtils.isNotBlank(value)){
        value=value.replaceAll("\"","&quot;");
    }else {
        value="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="500";
    }
    float w=500;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=500;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="90";
    }
    float h=90;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=90;
    }
    if(maxLength==null||maxLength.equalsIgnoreCase("")){
        maxLengthFlag = false;
    } else {
        maxLengthFlag = true;
    }
%>
<script type="text/javascript">
    (function(){
        var textarea=function(){
            if ($("#<%=id%>").val() == "" && $("#<%=id%>").attr("emptyText") !== undefined) {
                $("#<%=id%>").val($("#<%=id%>").attr("emptyText"));
                $("#<%=id%>").addClass("uiframe-emptyTextColor");
            }
            //文本域划过点击样式
            $('#${id}').on("focus", function () {
                if(!$('#parentDiv${id}').hasClass("uiframe-textarea-click")){
                	$('#parentDiv${id}').addClass('uiframe-textarea-click');
                }
                if ($("#<%=id%>").hasClass("uiframe-emptyTextColor")) {
                    $("#<%=id%>").val("");
                    $("#<%=id%>").removeClass("uiframe-emptyTextColor");
                }
            });
            $('#${id}').on("blur", function () {
                $('#parentDiv${id}').removeClass('uiframe-textarea-click');
                $('#parentDiv${id}').removeClass('uiframe-textarea-hover');
                if ($("#<%=id%>").val() == "" && $("#<%=id%>").attr("emptyText") !== undefined) {
                    $("#<%=id%>").val($("#<%=id%>").attr("emptyText"));
                    $("#<%=id%>").addClass("uiframe-emptyTextColor");
                }
            });
            $('#parentDiv${id}').on("mouseover", function () {
                if(!$(this).hasClass("uiframe-textarea-hover")){
                    $(this).addClass('uiframe-textarea-hover');
                }
            });
            <%if(maxLengthFlag){%>
                $("#${id}").on("keyup", function(){
                    var myLength = $(this).val().length;
                    var maxLength = parseInt("<%=maxLength%>");
                    if(maxLength >= myLength){
                        $("#showLabel${id}").text("还可输入");
                        $("#showText${id}").text(maxLength-myLength).css("color","#b3b3b3");
                    } else {
                        $("#showLabel${id}").text("已超出");
                        $("#showText${id}").text(myLength-maxLength).css("color","#FF0000");
                    }
                });
            <%}%>
            if($("#<%=id%>").val() != "" && !$("#<%=id%>").hasClass("uiframe-emptyTextColor")){
                $("#showText${id}").text(parseInt("<%=maxLength%>") - $("#<%=id%>").val().length);
            }
            $("#${id}").on("setValue",function(event, value){
                $(this).val($.trim(value));
                $("#showText${id}").text(parseInt("<%=maxLength%>") - value.length);
                $(this).trigger("keyup");
            });
            $("#${id}").on("setHeight",function(event, height){
                $("#parentDiv<%=id%>").height(height);
                <%if(!maxLengthFlag){%>
                    $(this).height(height - 2);
                <%}else{%>
                    $(this).height(height - 23);
                <%}%>;
            });
        };
        textarea.orderNumber=35;
        executeQueue.push(textarea);
    })();
</script>
<div id="parentDiv<%=id%>" class="uiframe-textareaDiv" style="width:<%=w-2%>px;height:<%=h-2%>px;<%=outStyle%>">
    <textarea id="<%=id%>" class="uiframe-textarea ${cls} ${group}" name="<%=name%>"
            style="width:<%=w-9%>px;<%if(!maxLengthFlag){%>height:<%=h-2%>px<%}else{%>height:<%=h-25%>px<%}%>; ${style}"
            <%if(readOnlyFlag){%> readonly="readonly" <%}%>  <%=emptyTextk%>
            <%if(disabledFlag){%> disabled="disabled" <%}%>><%=value%></textarea>
    <div class="uiframe-textareaBottom" <%if(!maxLengthFlag){%>style="display:none"<%}%>><span id="showLabel<%=id%>">还可输入</span><span id="showText<%=id%>" style="font-size:14px;padding:0 2px;"><%=maxLength%></span>字</div>
</div>
<span class="mustWrite" style="float:left;margin-left:4px;<%if(!mustFlag){%> display:none<%}%>">*</span>


