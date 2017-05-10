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
    int iMaxLength = 0;
    String emptyTextk = "";
    String emptyTextCls = "";
    String disableBtnClass = "";

    if(StringUtils.isEmpty(name)){
        name="textTag"+id+uuid;
    }
    if(StringUtils.isNotEmpty(readonly)&&(readonly.equalsIgnoreCase("readonly")||readonly.equalsIgnoreCase("true"))){
        readOnlyFlag=true;
    }
    if(StringUtils.isNotEmpty(disabled)&&(disabled.equalsIgnoreCase("disabled")||disabled.equalsIgnoreCase("true"))){
        disabledFlag=true;
        disableBtnClass="uiframe-textinput-disabled";
    }
    if(StringUtils.isNotEmpty(must)&&(must.equalsIgnoreCase("must")||must.equalsIgnoreCase("true"))){
        mustFlag=true;
    }
    if(maxLength==null||maxLength.equalsIgnoreCase("")){
        maxLengthFlag = false;
        iMaxLength = 0;
    } else {
        maxLengthFlag = true;
        iMaxLength = Integer.parseInt(maxLength);
    }

    if(StringUtils.isNotBlank(value)){
        iMaxLength = iMaxLength - value.length();
        value=value.replaceAll("\"","&quot;");
    }else {
        value="";
    }
    if(StringUtils.isNotBlank(emptyText)){
        emptyTextk="emptyText='"+emptyText+"'";
        emptyTextCls = "uiframe-emptyTextColor";
        if (StringUtils.isEmpty(value)) {
            value = emptyText;
        } else {
            emptyTextCls = "";
        }
    }else {
        emptyTextk="";
        emptyTextCls = "";
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
%>
<div id="parentDiv<%=id%>" class="uiframe-textareaDiv <%=disableBtnClass%>" style="width:<%=w-4%>px;height:<%=h-2%>px;<%=outStyle%>">
    <textarea id="<%=id%>" class="widgetDisable widgetTextarea <%if(maxLengthFlag){%>widgetAreaMax<%}%> widgetEmptyText uiframe-textarea <%=emptyTextCls%> ${cls} ${group} <%=disableBtnClass%>" textMaxLength="<%=maxLength%>" name="<%=name%>"
            style="width:<%=w-30%>px;<%if(!maxLengthFlag){%>height:<%=h-12%>px<%}else{%>height:<%=h-35%>px<%}%>; ${style}"
            showLabelId="showLabel${id}" showTextId="showText${id}" showParentId="parentDiv${id}"
            <%if(readOnlyFlag){%> readonly="readonly" <%}%>  <%=emptyTextk%>
            <%if(disabledFlag){%> disabled="disabled" <%}%>><%=value%></textarea>
    <div class="uiframe-textareaBottom" <%if(!maxLengthFlag){%>style="display:none"<%}%>><span id="showLabel<%=id%>">还可输入</span><span id="showText<%=id%>" style="font-size:14px;padding:0 2px;"><%=iMaxLength%></span>字</div>
</div>
<span class="mustWrite" style="float:left;margin-left:4px;<%if(!mustFlag){%> display:none<%}%>">*</span>