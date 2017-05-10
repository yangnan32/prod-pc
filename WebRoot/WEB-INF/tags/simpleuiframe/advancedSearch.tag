<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 12-5-25下午6:18
    * @team	    :
    * @author      : yangn
    * @ps      : 业务定制组件，单独维护
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="advancedSearchPageUrl" rtexprvalue="true" required="true" description="高级搜索页面的url,必填" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="搜索下拉列表对应的LinkedHashMap对象"  required="true" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableInputClass="";
    String emptyTextk="";
    String heightText="";
    String emptyTextCls = "";
    String clickCls="advancedSearchClick";
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        clickCls="";
    } else {
        readonly="false";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        clickCls="";
        disableInputClass="uiframeMask";
    }
    if(emptyText !=null && !emptyText.equalsIgnoreCase("")){
        emptyTextk="emptyText='"+emptyText+"'";
        emptyTextCls = "uiframe-emptyTextColor";
    }else {
        emptyTextk="";
        emptyText="";
        emptyTextCls="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="300";
    }
    float w=300;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=300;
    }
%>
<div id="advancedSearchLayout${id}" class="uiframe-advancedSearch-mainCon" data-id="${id}">
    <input type="text" id="${id}" value="<%=emptyText%>" style="width: <%=w-22%>px;" <%=emptyTextk%> <%=disableText%> class="advancedSearchInput uiframe-selectbox-text <%=emptyTextCls%> <%=disableInputClass%>">
    <span id="${id}Btn" class="uiframe-form-btnClick uiframe-selBtn <%=clickCls%> <%=disableInputClass%>"></span>
    <div id="${id}SelectDiv" class="uiframe-advancedSearch" style="width: <%=(w+2)%>px;_margin-left: -<%=w+4%>px;">
        <div id="${id}Table" style="width: <%=(w+2)%>px;_width: <%=(w-24)%>px;;">
            <ul>
                <li tabindex=0 class="widgetAdvancedSearchLi click-option" xtype="all"><h3>&nbsp;</h3><h4 style="width:<%=(w-84)%>px;">包含<span class="advancedSearchText"></span>的知识</h4></li>
                <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
                    <li tabindex=0 class="widgetAdvancedSearchLi click-option" xtype="${item.key}">
                        <h3>${item.value}</h3><h4 style="width:<%=(w-84)%>px;">包含<span class="advancedSearchText"></span>的知识</h4>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div id="${id}FormDiv" class="advancedSearch_form_div" style="width: <%=(w+2)%>px;">
            <jsp:include page="${advancedSearchPageUrl}"></jsp:include>
        </div>
        <div id="${id}ToolbarDiv" class="uiframe-advancedSearch-bbar" style="width: <%=(w+2)%>px;">
            <div class="widgetAdvancedSearchBbar">高级搜索</div>
        </div>
    </div>
</div>