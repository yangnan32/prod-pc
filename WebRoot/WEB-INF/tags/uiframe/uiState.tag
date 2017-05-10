<%@ tag import="com.widget.eap.app.system.Identity" %>
<%@ tag import="com.widget.framework.system.engine.SystemContext" %>
<%--
<%@ tag import="com.widget.uiframe.uistate.ComponentStateService" %>
<%@ tag import="com.widget.uiframe.uistate.ComponentStateVo" %>
 --%> 
<%@attribute name="stateId" rtexprvalue="true" required="true" description="" %>

<%@ tag pageEncoding="UTF-8" %>
<%
     //ComponentStateService componentStateService=(ComponentStateService)SystemContext.getBean("componentStateServiceImpl");
    //Identity identity=(Identity)SystemContext.getBean("identity");
    //ComponentStateVo vo=new ComponentStateVo();
    //vo.setGroupId(identity.getUserId());
    //vo.setComponentId(stateId);
    //vo=componentStateService.fetchComponentState(vo);
    //String states ="{}";
    //if(vo!=null)states=vo.getState(); 
    String states = "planning";
%>
<script type="text/javascript">
    stateProvider.set("${stateId}",<%=states.toString()%>);
</script>