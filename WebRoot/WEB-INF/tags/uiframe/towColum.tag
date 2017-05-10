<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="leftId" rtexprvalue="true" required="false" description="左侧区域id" %>
<%@attribute name="rightId" rtexprvalue="true" required="false" description="右侧区域id" %>
<%@attribute name="leftPanel" fragment="true"%>
<%@attribute name="rightPanel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    if(StringUtils.isEmpty(leftId)){
        leftId="uiframe_layout_left"+uuid;
    }
    if(StringUtils.isEmpty(rightId)){
        rightId="uiframe_layout_right"+uuid;
    }
    if(StringUtils.isEmpty(leftWidth)){
        leftWidth="300";
    }else if(leftWidth.endsWith("px")){
        leftWidth=leftWidth.substring(0,leftWidth.length()-2);
    }
%>
<div class="uiframe-layout-content">
    <div class="uiframe-two-row-left" id="<%=leftId%>" style="width:<%=leftWidth%>px;">
        <!-- left panel -->
        <jsp:invoke fragment="leftPanel"/>
    </div>
    <!-- split bar -->
    <div class="uiframe-left-split-tool" ref_left_panel="<%=leftId%>"
         ref_right_panel="<%=rightId%>" id="uiframe_split_tool<%=uuid%>"></div>

    <!-- right panel -->
    <div class="uiframe-two-row-right" id="<%=rightId%>">
          <jsp:invoke fragment="rightPanel"/>
    </div>
</div>
