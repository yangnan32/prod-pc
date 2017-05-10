<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @team	       :
    * @author      : yangn
    *description   :工具栏按钮
--%>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="按钮ID" %>
<%@attribute name="btnCls" rtexprvalue="true" required="false" description="按钮class样式名" %>
<%@attribute name="iconCls" rtexprvalue="true" required="false" description="图标class样式名" %>
<%@attribute name="title" rtexprvalue="true" required="false" description="提示的标题" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style行内样式" %>
<%@attribute name="text" rtexprvalue="true" required="false" description="按钮是否有文字，true和false，默认是true" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="hidden" rtexprvalue="true"  required="false" description="是否隐藏,值为true或者false" %>
<%@attribute name="attr" rtexprvalue="true"  required="false" description="标签属性的值" %>
<%
    String noTextClass = "";
    String noText = "";
    String titleText = "";
    String titleClass = "";
    String btnText = "";
    String disableText = "";
    String hiddenText = "";

    if(id==null){
        id=String.valueOf(new Date().getTime());
    }

    if(StringUtils.isNotBlank(title)){
        titleText="myTitle='"+title+"'";
        titleClass="tooltip";
        noText="&nbsp;";
    }else {
        titleText="";
        titleClass="";
        noText = "";
    }
    if(StringUtils.isBlank(btnCls))btnCls="";
    if(StringUtils.isBlank(style))style="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equals("true")){
        disableText="disabled='disabled'";
        btnText = "uiframe-toolbarBtn-disabled";
    } else {
        disableText="";
        btnText = "";
    }
    if(StringUtils.isBlank(iconCls))iconCls="";
    if(StringUtils.isNotEmpty(text) && text.equalsIgnoreCase("false")){
        noTextClass="tool-button-noText";
    } else {
        noTextClass = "";
    }
    if(StringUtils.isNotEmpty(hidden) && hidden.equalsIgnoreCase("true")){
        hiddenText="uiframe-hide";
    } else {
        hiddenText = "";
    }
%>
<span id="btnParent${id}" <%=titleText%> class="uiframe-toolbarBtnDiv <%=btnText%> <%=titleClass%> <%=hiddenText%>">
    <button type="button" <%=attr%> id="${id}" class="widgetToolBtn tool-button uiframe-toolbarBtnIcon <%=btnCls%> <%=noTextClass%>  <%=iconCls%>" style="<%=style%>" <%=disableText%>>
        <span><%=noText%><jsp:doBody/></span>
    </button>
</span>