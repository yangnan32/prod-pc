<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-6-19上午10:47
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.*" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件css样式名称" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="下拉列表对应的List对象" %>
<%@attribute name="valueText" rtexprvalue="true"  required="false" description="控件的默认显示值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="key" rtexprvalue="true" required="false" description="ajax reload时key的名称,选填" %>
<%@attribute name="val" rtexprvalue="true" required="false" description="ajax reload时value的名称,选填" %>
<%@attribute name="url" rtexprvalue="true"  required="false" description="加载数据的url" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="false" description="ajax data root,必填" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="toolbar" rtexprvalue="true"  required="false" description="多选框工具栏" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="下拉列表对应的LinkedHashMap对象"  required="true" %><%--控件的下拉框键值对--%>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    String disableInputClass="";
    String emptyTextk="";
    String toolbarText="";
    String heightText="";
    String emptyTextCls="";
    String clickCls="widgetSelect";
    String hotKeyFlag="true";
    List valueList = null;
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        hotKeyFlag="false";
        clickCls="";
    } else {
        readonly="false";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls="";
        hotKeyFlag="false";
        disableInputClass="uiframeTextDisabled";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(StringUtils.isNotBlank(cls)){
    }else {
        cls ="";
    }

    if(valueText == null || valueText.equalsIgnoreCase("")){
        valueText="";
    } else {
        valueText = valueText.replaceAll("\"","&quot;");
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
        String[] valueArray = value.split(",");
        valueList = java.util.Arrays.asList(valueArray);
    }

    if(StringUtils.isNotEmpty(toolbar) && toolbar.equalsIgnoreCase("true")){
        toolbarText="display:block";
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
    request.setAttribute("valueList",valueList);

%>
<div id="select_checkbox<%=id%><%=uuid%>" class="uiframe-mainCon" data-toolflag="true" data-id="${id}" data-url="<%=url%>" data-dataroot="<%=dataRoot%>" data-xtype="checkbox" data-key="<%=key%>" data-val="<%=val%>" data-height="<%=H%>" data-useToolPage="<%=toolbar%>" hotKeyFlag="<%=hotKeyFlag%>">
    <input type="hidden" class="widgetComboxInput ${group}" <%=name%> id="${id}" value="<%=value%>">
    <input type="text" id="${id}Input" name="${id}<%=uuid%>" readonly="readonly" style="width: <%=w%>px;" <%=emptyTextk%> <%=disableText%> value="<%=valueText%>" class="<%=clickCls%> uiframe-selectbox-checkbox-text <%=emptyTextCls%> <%=disableInputClass%> <%=cls%>">
    <span id="${id}Btn" class="<%=clickCls%> uiframe-form-btnClick uiframe-selBtn-checkbox <%=disableInputClass%>"></span>
    <div id="${id}SelectDiv" class="comboxCheckboxDiv uiframe-selectbox-checkbox uiframe-selectHide" style="width: <%=(w+24)%>px;_margin-left: -<%=w+26%>px;overflow:hidden;">
        <%
            if(height==null||height.equalsIgnoreCase("")){
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = 300;
                if(maxHeight >= 300){
                    heightText = "height:300px;";
        %>
        <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                }else{
        %>
        <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-2)%>px; overflow-y: auto;">
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
            <div id="${id}SelectTable" style="width: <%=(w+24)%>px;*-width:<%=(w-2)%>px; overflow-y: auto;">
        <%
                }
            }
        %>
            <ul>
                <c:forEach var="item" items="${valueMap}" varStatus="s">
                    <c:set var="selectCls" value="" />
                    <c:set var="checkValue" value="" />
                    <c:forEach var="value" items="${valueList}" varStatus="m">
                        <c:if test="${value == item.key}">
                            <c:set var="selectCls" value="uiframe-checkbox-selected" />
                            <c:set var="checkValue" value="true" />
                        </c:if>
                    </c:forEach>
                    <li class="widgetCheckboxLi click-select-checkbox ${selectCls}" val="${item.key}" check="${checkValue}"><div class="uiframe-selectbox-select uiframe-text-overflow" style="width:<%=(w-40)%>px">${item.value}</div></li>
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
