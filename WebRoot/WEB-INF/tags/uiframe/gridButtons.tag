<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe"%>
<%@ tag pageEncoding="UTF-8"%>
<%@ tag import="java.util.Date" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<c:if test="${fn:length(syw_tbar)>0}">

		<c:forEach items="${syw_tbar}" var="menu">
			<c:if test="${fn:length(menu.buttons)==0}">
				<widget:toolbarButton id="${menu.id}" iconCls="${menu.iconCls}"
						disabled="${menu.disabled}" hidden="${menu.hidden}" title="${menu.title}">${menu.name}</widget:toolbarButton>
			</c:if>
			<c:if test="${fn:length(menu.buttons)>0}">
				<widget:menu id="${menu.id}" title="${menu.name}"
					iconCls="${menu.iconCls}" width="${menu.width}" disabled="${menu.disabled}" hidden="${menu.hidden}">
					<c:forEach items="${menu.buttons}" var="button">
						<widget:toolbarButton id="${button.id}"
							iconCls="${button.iconCls}" disabled="${button.disabled}" hidden="${menu.hidden}" title="${button.title}" >${button.name}</widget:toolbarButton>
					</c:forEach>
				</widget:menu>
			</c:if>
			<script type="text/javascript">
				if('${menu.hidden}' == 'true'){
					$("#btnParent" + '${menu.id}').hide();
				}else{
					$("#btnParent" + '${menu.id}').show();
				}
			</script>
		</c:forEach>

	
	
</c:if>