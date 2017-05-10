<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-10-20上午10:08
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="hasClear" rtexprvalue="true"  required="false" description="是否可清空,true or false" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="key" rtexprvalue="true" required="true" description="搜索列传的值,必填" %>
<%@attribute name="value" rtexprvalue="true" required="false" description="下拉列表对应的value值" %>
<%@attribute name="valueText" rtexprvalue="true" required="false" description="下拉列表显示的value值" %>
<%@attribute name="parentText" rtexprvalue="true" required="false" description="前缀关联文本值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载数据的url" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>


<%
    long uuid=new Date().getTime();
    String disableText="";
    String clickCls="widgetSelect";
    String disableInputClass="";
    String emptyTextk="";
    String parentTexts="";
    String emptyTextCls="";
    String hotKeyFlag="true";
    Boolean readOnlyFlag = false;
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls="";
        hotKeyFlag="false";
        disableInputClass="uiframeTextDisabled";
    }
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        clickCls="";
        hotKeyFlag="false";
        readOnlyFlag=true;
    } else {
        readonly="false";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(valueText==null||valueText.equalsIgnoreCase("")){
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
    if(parentText != null && StringUtils.isNotBlank(parentText)){
        parentTexts="parentText='"+parentText+"'";
    } else {
        parentTexts="";
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
<div id="writeCombox_select${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" data-loadflag="true" data-url="<%=url%>" data-dataroot="<%=dataRoot%>" data-id="${id}" data-key="<%=key%>" data-val="<%=value%>" data-useToolPage="<%=hasClear%>" style="${outStyle}" data-height="<%=H%>" data-parentText="<%=parentTexts%>" hotKeyFlag="<%=hotKeyFlag%>">
    <input type="hidden" id="${id}" class="widgetComboxInput" value="<%=valueText%>" text="<%=valueText%>">
    <input type="text" id="${id}Input" <%=name%> style="width: <%=w%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="<%=valueText%>" <%if(readOnlyFlag){%> readonly="readonly" <%}%> class="uiframe-writeSelect-text <%=emptyTextCls%> <%=clickCls%> <%=disableInputClass%> <%=cls%>">
    <span id="${id}Btn" class="uiframe-form-btnClick uiframe-selBtn <%=clickCls%> <%=disableInputClass%>"></span>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -26px 0 0 <%=w+30%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>