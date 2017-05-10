<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe"%>
<%@ taglib prefix="p2m" tagdir="/WEB-INF/tags/p2m"%>

<%@ tag pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<c:if test="${fn:length(syw_tbar)>0}">
	<widget:toolbar id="${id}">
		<p2m:gridButtons></p2m:gridButtons>
	</widget:toolbar>
</c:if>