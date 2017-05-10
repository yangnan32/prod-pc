<%--
    * copyright : widget Technology Co., Ltd
    * @version : 1.0
    * @created : 13-11-11 下午5:05
    * @team :
    * @author : caort
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ tag import="java.util.Date"%>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@ attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@ attribute name="stepNum" rtexprvalue="true" required="true" description="步骤序号" %>
<%@ attribute name="stepName" rtexprvalue="true" required="true" description="步骤名称" %>
<%@ attribute name="stepForm" fragment="true"%>
<script type="text/javascript">
    if(navigator.userAgent.indexOf('MSIE') >= 0) { // 如果是IE
        DD_belatedPNG.fix('.uiframe-portal-step-num, background');
    }
</script>
<div class="uiframe-portal-step">
    <div class="uiframe-portal-step-title">
        <div class="uiframe-portal-step-num"><%=stepNum %></div>
        <div class="uiframe-portal-step-name"><%=stepName %></div>
    </div>
    <div class="uiframe-portal-step-line"></div>
</div>
<div class="uiframe-portal-step-form">
    <jsp:invoke fragment="stepForm"/>
</div>