<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 15-3-17上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="topHeight" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="topId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="downId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="topPanel" fragment="true"%>
<%@attribute name="downPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(topId)){
        topId="uiframe_layout_top"+uuid;
    }
    if(StringUtils.isEmpty(downId)){
        downId="uiframe_layout_down"+uuid;
    }
    if(StringUtils.isEmpty(topHeight)){
        topHeight="100";
    }else if(topHeight.endsWith("px")){
        topHeight=topHeight.substring(0,topHeight.length()-2);
    }
%>
<div class="uiframe-layout-contentRow" id="twoRow<%=topId%>">
    <div class="uiframe-twoRow-top" id="<%=topId%>" style="height:<%=topHeight%>px;">
        <!-- top panel -->
        <jsp:invoke fragment="topPanel"/>
    </div>
    <!-- down panel -->
    <div class="uiframe-twoRow-down" id="<%=downId%>">
        <jsp:invoke fragment="downPanel"/>
    </div>
</div>
<script type="text/javascript">
    $('#twoRow<%=topId%>').jqxSplitter({orientation: 'horizontal', panels: [{ size: <%=topHeight%> }, { size: $("#twoRow${topId}").height() - 7 - <%=topHeight%>}] });
    $(function(){
        $("#<%=topId%>").resize(function(){
            $("#body").trigger("resizeLayoutHeight", [$("#<%=topId%>").height(), $("#<%=downId%>").height()]);
        });
    });
</script>