<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-25下午7:46
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="value" rtexprvalue="true"  required="true" description="控件的名称，必填" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="style样式代码" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="iconCls" rtexprvalue="true"  required="false" description="图标样式代码" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String iconClsText="";
    String fontText="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("disabled")){
        disableText="disabled='disabled'";
        fontText="color:#b3b3b3";
    }
    if(StringUtils.isNotEmpty(iconCls)){
        iconClsText="class="+iconCls;
    }

%>
<button type="reset" id="${id}" class="uiframe-button ${cls}" style="<%=fontText%> ${style}" <%=disableText%> ><span <%=iconClsText%> ><%=value%></span></button>
