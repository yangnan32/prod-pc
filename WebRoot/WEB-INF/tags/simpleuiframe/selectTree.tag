<!--
copyright : widget Technology Co., Ltd

下拉框标签

@version : 1.0
@created : 2012-4-8
@team : uiframe
@author : yangn
-->
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="showId" rtexprvalue="true" required="false" description="下拉框显示div的id,选填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="hasClear" rtexprvalue="true"  required="false" description="是否可清空,true or false" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载树数据的地址" %>
<%@attribute name="classifyUrl" rtexprvalue="true"  required="false" description="默认分类url" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="checkbox" rtexprvalue="true"  required="false" description="树节点是否显示复选框" %>
<%@attribute name="nodeName" rtexprvalue="true"  required="false" description="树节点显示字段名称" %>
<%@attribute name="idKey" rtexprvalue="true"  required="false" description="树节点id" %>
<%@attribute name="pidKey" rtexprvalue="true"  required="false" description="树父节点id" %>
<%@attribute name="rootId" rtexprvalue="true"  required="false" description="根节点id值" %>
<%@attribute name="valueText" rtexprvalue="true"  required="false" description="控件的默认显示值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    long uuid = new Date().getTime();

    String disableText="";
    String disableInputClass="";
    String emptyTextk="";
    String emptyTextCls = "";
    String clickCls="widgetSelect";
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        clickCls="";
    } else {
        readonly="false";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls="";
        disableInputClass="uiframeTextDisabled";
    }

    if(valueText == null || valueText.equalsIgnoreCase("")){
        valueText="";
    } else {
        valueText = valueText.replaceAll("\"","&quot;");
    }
    if(emptyText !=null && !emptyText.equalsIgnoreCase("")){
        emptyTextk="emptyText='"+emptyText+"'";
        if (valueText.equalsIgnoreCase("")) {
            emptyTextCls = "uiframe-emptyTextColor";
            valueText = emptyText;
        } else {
            emptyTextCls = "";
        }
    }else {
        emptyTextk="";
        emptyTextCls="";
    }

    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        classifyUrl="";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(nodeName==null||nodeName.equalsIgnoreCase("")){
        nodeName="text";
    }
    if(idKey==null||idKey.equalsIgnoreCase("")){
        idKey="id";
    }
    if(pidKey==null||pidKey.equalsIgnoreCase("")){
        pidKey="pId";
    }
    if(rootId == null || rootId.equalsIgnoreCase("")) {
        rootId="0";
    }
    if(showId==null||showId.equalsIgnoreCase("")){
        showId= "showId" + uuid;
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="200";
    }
    float w=200;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=200;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="200";
    }
    float h=250;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=250;
    }
%>
<div id="selectTree${id}<%=uuid%>" class="uiframe-mainCon widget-selectTree ${outCls}" data-id="<%=id%>" data-url="<%=url%>" data-height="<%=h%>" data-classifyUrl="<%=classifyUrl%>" data-idkey="<%=idKey%>" data-pidkey="<%=pidKey%>" data-nodename="<%=nodeName%>" data-checkbox="<%=checkbox%>" data-rootid="<%=rootId%>" style="${outStyle}">
    <input type="hidden" class="widgetComboxInput" id="<%=id%>" value="<%=value%>" <%=name%> />
    <input type="text" id="<%=id%>Input" name="<%=id%>Text" readonly="readonly" style="width: <%=w%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="<%=valueText%>" class="<%=clickCls%> uiframe-selectbox-text <%=emptyTextCls%>  <%=disableInputClass%> <%=cls%>">
    <span id="<%=id%>Btn" class="uiframe-form-btnClick uiframe-selBtn <%=clickCls%>  <%=disableInputClass%>"></span>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -20px 0 0 6px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>
