<%--
  Created by IntelliJ IDEA.
  User: yangn
  Date: 12-4-24
  Time: 下午2:54
  To change this template use File | Settings | File Templates.
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="true" description="控件下拉框name,后台根据name获取选择的值，必填" %>
<%@attribute name="columns" rtexprvalue="true" required="true" description="控件列名,必填" %>
<%@attribute name="key" rtexprvalue="true" required="true" description="搜索列传的值,必填" %>
<%@attribute name="value" rtexprvalue="true" required="false" description="下拉列表对应的value值" %>
<%@attribute name="valueText" rtexprvalue="true"  required="false" description="控件的默认显示值" %>
<%@attribute name="searchUrl" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="editUrl" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="data" rtexprvalue="true" type="java.lang.String" required="true" description="data 查询条件,必填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="toolPage" rtexprvalue="true" required="false" description="翻页工具栏" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="每页显示条数" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="editFalse" rtexprvalue="true"  required="false" description="是否可编辑,值为true或者false" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="textAlign" rtexprvalue="true"  required="false" description="下拉框内容对齐方式" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件样式class名称" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="下拉框显示框高度" %>
<%@attribute name="searchable" rtexprvalue="true"  required="false" description="true或false，默认true" %>
<%@attribute name="editTrue" rtexprvalue="true"  required="false" description="加载组件时是否先加载回显数据true或false，默认false" %>
<%@attribute name="tooltipFlag" rtexprvalue="true"  required="false" description="是否加载划过提示true或false，默认false" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String readonlyText="";
    String editFalseText="";
    String editFalseCls="";
    String disableInputClass="";
    String nameText="";
    String toolPageText="";
    String emptyTextk="";
    String textAlignk="";
    String searchableText="";
    String tooltipCls="";
    String clickCls="widgetSelect";
    String hotKeyFlag="true";
    String emptyTextCls="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls="";
        hotKeyFlag="false";
        disableInputClass="uiframeTextDisabled";
    }
    if(StringUtils.isNotEmpty(editFalse) && editFalse.equalsIgnoreCase("true")){
        editFalseText="readonly='readonly'";
        editFalseCls = "uiframe-pointer";
    } else {
        editFalseText="";
    }
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonlyText="readonly='readonly'";
        hotKeyFlag="false";
        clickCls="";
    } else {
        readonlyText="";
    }
    if(StringUtils.isNotEmpty(tooltipFlag) && tooltipFlag.equalsIgnoreCase("true")){
        tooltipCls="tooltip";
    } else {
        tooltipCls="";
    }
    if(StringUtils.isNotEmpty(searchable) && searchable.equalsIgnoreCase("false")){
        searchableText="readonly='readonly'";
        editFalseCls = "uiframe-pointer";
    } else {
        searchableText ="";
    }
    if(StringUtils.isNotEmpty(toolPage) && toolPage.equalsIgnoreCase("false")){
        toolPageText="style='display:none'";
    }

    if(StringUtils.isNotBlank(valueText)){
        valueText = valueText.replaceAll("\"","&quot;");
    }else {
        valueText="";
    }

    if(emptyText !=null && !emptyText.equalsIgnoreCase("")){
        emptyTextk="emptyText='"+emptyText+"'";
        if (valueText.equalsIgnoreCase("")) {
            valueText = emptyText;
            emptyTextCls = "uiframe-emptyTextColor";
        } else {
            emptyTextCls = "";
        }
    }else {
        emptyTextk="";
        emptyTextCls="";
    }
    if(value==null || value.equalsIgnoreCase("")){
        value="";
    } else {
        value = value.replaceAll("\"","&quot;");
    }
    if(StringUtils.isNotBlank(textAlign)){
        textAlignk="text-align:"+textAlign+"";
    }else {
        textAlign = "left";
        textAlignk="text-align:left";
    }
    if(StringUtils.isNotBlank(name)){
        nameText="name='"+name+"'";
    }else {
        nameText="";
    }
    float H= 0;
    if(height != null && StringUtils.isNotBlank(height)){
        H = Float.parseFloat(height);
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
%>
<div class="uiframe-mainCon widget-selectSearch" data-id="<%=id%>" data-url="<%=searchUrl%>" data-key="<%=key%>" data-xtype="search" data-dataName="<%=data%>" data-dataRoot="<%=dataRoot%>" data-columns="<%=columns%>" data-height="<%=H%>" data-editurl="<%=editUrl%>" data-editdata="<%=editTrue%>" data-tooltipcls="<%=tooltipCls%>" data-textalign="<%=textAlign%>" id="search_select<%=id%><%=uuid%>" hotKeyFlag="<%=hotKeyFlag%>">
    <input type="hidden" class="widgetComboxInput ${group}" id="${id}" value="<%=value%>" <%=nameText%> <%=disableText%> />
    <input type="text" id="${id}Input" name="<%=id%><%=uuid%>" value="<%=valueText%>" <%=editFalseText%> <%=searchableText%> <%=emptyTextk%> <%=disableText%> <%=readonlyText%> class="<%=clickCls%> uiframe-selectbox-text-ajax <%=disableInputClass%> <%=emptyTextCls%> <%=cls%> <%=editFalseCls%>" style="width:<%=(w)%>px;">
    <span id="${id}Btn" class="<%=clickCls%> uiframe-form-btnClick uiframe-selBtn-ajax <%=disableInputClass%>"></span>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -30px 0 0 <%=w+30%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>