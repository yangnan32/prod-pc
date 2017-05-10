<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-6-4上午9:25
    * @team	    : 
    * @author      : yangn
    *@modify   :增加国际化
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="控件名称，必填" %>
<%@attribute name="maxWidth" rtexprvalue="true" required="false" description="控件最大宽度，选填" %>
<%@attribute name="returnPanel" fragment="true" description="返回按钮片段" %>
<%@attribute name="toolPanel" fragment="true" description="工具栏片段" %>
<%
    if(maxWidth==null||maxWidth.equalsIgnoreCase("")){
        maxWidth="300";
    }
    float w = 300;
    try{
        w = Float.parseFloat(maxWidth);
    }catch (NumberFormatException ex){
        w = 300;
    }
%>
<script type="text/javascript">

    (function(){
        executeQueue.push(function(){
            var maxWidth = parseInt("<%=w%>");
            var nowWidth = $("#${id}Title").width();
            if(nowWidth > maxWidth){
                $("#${id}Title").width(maxWidth);
            }
        });
    })();
</script>
<div class="uiframe-title-long">
    <div class="uiframe-title-longTitle">
        <div class="uiframe-title-long-left"></div>
        <div class="uiframe-title-long-center uiframe-text-overflow" id="${id}Title"><span id="${id}"><%=title%></span></div>
        <div class="uiframe-title-long-right"></div>
    </div>
    <div class="uiframe-title-return">
        <jsp:invoke fragment="returnPanel"/>
    </div>
    <div class="uiframe-title-tool">
        <jsp:invoke fragment="toolPanel"/>
    </div>
</div>