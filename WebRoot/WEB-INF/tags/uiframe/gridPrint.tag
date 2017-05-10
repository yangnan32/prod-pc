<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ tag import="java.util.*" %>
<%@ tag pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("basePath",basePath);
	Enumeration em=request.getAttributeNames();
	String[] excludePrefix=new String[]{"javax.servlet","org.springframework","Spring OpenEntityManagerInViewFilter.FILTERED","com.opensymphony.sitemesh.APPLIED_ONCE","Set Character Encoding.FILTERED","isAdministrator"};
	while(em.hasMoreElements()){
		String key=(String)em.nextElement();
		if(key==null)continue;
		boolean isExcluded=false;
		for(String prefix:excludePrefix){
			if(key.startsWith(prefix)){
				isExcluded=true;
				break;
			}
		}
		if(isExcluded)continue;
		%>
		&nbsp;&nbsp;&nbsp;<b><%=key %>:</b><br/>
		<%
		Object attr=request.getAttribute(key);
		if(attr==null)continue;
		Class attrType = attr.getClass();
		if ( Collection.class.isAssignableFrom( attrType ) ) {
			int i=0;
			for(Object c:(Collection)attr){
				%>
				   <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=++i %>:&nbsp;</b><%=c %><br/>
				<%
			}
		}else if ( attrType.isArray() ) {
			int i=0;
			for(Object c:( Object[] )attr){
				%>
				   <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=++i %>:&nbsp;</b><%=c %><br/>
				<%
			}
		}else {
			%>
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=attr %><br/>
			<%
		}
	}
%>