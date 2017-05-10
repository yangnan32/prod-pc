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
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="valueText" rtexprvalue="true"  required="false" description="控件的默认显示值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="下拉列表对应的LinkedHashMap对象"  required="true" %><%--控件的下拉框键值对--%>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableInputClass="";
    String emptyTextk="";
    String heightText="";
    String emptyTextCls = "";
    String clickCls="widgetSelect";
    String hotKeyFlag = "true";
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        hotKeyFlag = "false";
        clickCls="";
    } else {
        readonly="false";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        hotKeyFlag = "false";
        clickCls="";
        disableInputClass="uiframeTextDisabled";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
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
    if(value==null || value.equalsIgnoreCase("")){
        value="";
    }else {
    	if(valueMap.get(value)!=null){
    		valueText = valueMap.get(value).toString();
    	}
    }
    if(showId==null||showId.equalsIgnoreCase("")){
        showId= "showId" + uuid;
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
<div id="combo_select${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" data-toolflag="true" data-id="${id}" style="${outStyle}" data-height="<%=H%>" data-useToolPage="<%=hasClear%>" hotKeyFlag="<%=hotKeyFlag%>">
    <input type="hidden" class="widgetComboxInput ${group}" id="${id}" value="${value}" <%=name%> />
    <input type="text" id="${id}Input" readonly="readonly" name="<%=id%><%=uuid%>" style="width: <%=w%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="<%=valueText%>" class="<%=clickCls%> uiframe-selectbox-text <%=emptyTextCls%> <%=disableInputClass%> <%=cls%>">
    <span id="${id}Btn" class="uiframe-form-btnClick uiframe-selBtn <%=clickCls%> <%=disableInputClass%>"></span>
    <div id="${id}SelectDiv" class="uiframe-selectbox-wrapper uiframe-selectHide" style="width: <%=(w+24)%>px;_margin-left: -<%=w+26%>px;">
        <%
            if(height==null||height.equalsIgnoreCase("")){
                int len = valueMap.size();
                int maxHeight = 26 * len;
                if(maxHeight >= 300){
                    heightText = "height:300px;";
        %>
            <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                }else{
        %>
            <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-2)%>px;">
        <%
                }
            } else {
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = Integer.parseInt(height);
                if(maxHeight >= trueHeight){
                    heightText = "height:"+height+"px;";

        %>
            <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                } else {
        %>
                <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-2)%>px;">
        <%
                }
            }
        %>
            <ul>
                <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
                    <li tabindex=0 class="widgetComboxLi click-option" val="${item.key}">${item.value}</li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -26px 0 0 <%=w+30%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>
