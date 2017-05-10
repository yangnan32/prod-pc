<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-10-20上午10:33
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
<script type="text/javascript">
(function(){
    var towColum=function(){
        $("#uiframe_split_tool"+<%=uuid%>).live("mouseover", function () {
            if($(this).hasClass("uiframe-top-split-tool-normal")){
                $(this).addClass('uiframe-top-split-tool-normal-hover');
            }
            if($(this).hasClass("uiframe-top-split-tool-click")){
                $(this).addClass('uiframe-top-split-tool-click-hover');
            }
        });
        $("#uiframe_split_tool"+<%=uuid%>).live("mouseout", function () {
            if($(this).hasClass("uiframe-top-split-tool-normal")){
                $(this).removeClass('uiframe-top-split-tool-normal-hover');
            }
            if($(this).hasClass("uiframe-top-split-tool-click")){
                $(this).removeClass('uiframe-top-split-tool-click-hover');
            }
        });

        var layoutW = $("#twoRow${topId}").width();
        var layoutH = $("#twoRow${topId}").height();
        $("#${downId}").height(layoutH - 7 - <%=topHeight%>);
    };
    towColum.orderNumber=11;
    executeQueue.push(towColum);
})();
</script>
<div class="uiframe-layout-contentRow" id="twoRow<%=topId%>">
    <div class="uiframe-two-row-top" id="<%=topId%>" style="height:<%=topHeight%>px;">
        <!-- top panel -->
        <jsp:invoke fragment="topPanel"/>
    </div>
    <!-- split bar -->
    <div class="uiframe-top-split-tool uiframe-top-split-tool-normal" ref_top_panel="<%=topId%>"
         ref_down_panel="<%=downId%>" id="uiframe_split_tool<%=uuid%>"></div>

    <!-- down panel -->
    <div class="uiframe-two-row-down" id="<%=downId%>">
        <jsp:invoke fragment="downPanel"/>
    </div>
</div>
