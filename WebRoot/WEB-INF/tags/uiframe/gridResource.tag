<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe" %>
<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:forEach items="${syw_css}" var="css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>${css}">
</c:forEach>
<c:forEach items="${syw_js}" var="gridJS">
			<c:if test="${gridJS.isRef!='false'}" >
				<script type="text/javascript" src="<%=basePath%>${gridJS.src}"></script>
			</c:if>
			<c:if test="${gridJS.isRef=='false'}">
				<script type="text/javascript">
				        ${gridJS.content}
				</script>
			</c:if>
</c:forEach>


