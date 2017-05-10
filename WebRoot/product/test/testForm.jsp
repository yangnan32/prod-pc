<%--
    * copyright    : Sysware Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-8-9下午4:04
    * @team	    :
    * @author      : yangn
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    long uuid=new Date().getTime();
%>
<script type="text/javascript">
	loadCallBack=function(){
		$("#testForm").validate({meta:'validate'});
	}
</script>
<div class="uiframe-winForm" id="testFormDiv>">
    <form id="testForm">
        <input type="hidden" name="id" id="id" value="${data.id}"/>
        <input type="hidden" name="myTime" id="myTime" value='${data.createTime}'/>
        <div class="uiframe-winForm-div">
            <div class="uiframe-winForm-lable oneColumn-lable"><label>名称：</label></div>
            <div class="uiframe-winForm-oneColumn"><widget:text name="name" value="${data.name}" id="iconSortName" must="true" cls="{validate:{required:true}}"/></div>
        </div>
        <div class="uiframe-winForm-div-textarea">
            <div class="uiframe-winForm-lable-textarea oneColumn-lable"><label>描述：</label></div>
            <div class="uiframe-winForm-textarea">
                <widget:textarea id="testDescription" width="400" height="90" name="description" value="${data.description}" />
            </div>
        </div>
    </form>
</div>
