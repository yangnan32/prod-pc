<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-11-22上午11:11
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="leftWidth" rtexprvalue="true" required="false" description="左侧区域宽度" %>
<%@attribute name="tabMap" rtexprvalue="true" type="java.util.Map" description="标签页对应的LinkedHashMap对象"  required="true" %>
<%@attribute name="activeItem" rtexprvalue="true" required="false" description="默认激活第几个" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    long uuid = new Date().getTime();
    int activeItemNub = 0;
    if(StringUtils.isEmpty(leftWidth)){
        leftWidth="200";
    }else if(leftWidth.endsWith("px")){
        leftWidth=leftWidth.substring(0,leftWidth.length()-2);
    }
    if(StringUtils.isEmpty(activeItem) || activeItem==null){
        activeItemNub = 0;
    } else {
        activeItemNub = Integer.parseInt(activeItem);
    }
    request.setAttribute("activeItemNub", activeItemNub);
    request.setAttribute("basePath",basePath);
%>
<script type="text/javascript">
    (function(){
        var accordionTab = function(){
            sywFunction.initFit("<%=id%>Right");
            var myLi = $("#<%=id%>Left").find("li").eq(${activeItemNub});
            $("#<%=id%>").load(myLi.attr("myUrl"),{time:new Date().getTime()},function(){
                if(loadCallBack){
                    loadCallBack();
                }
            });
            var $div_li =$("#<%=id%>Left ul li");
            $div_li.click(function(){
                var that = $(this);
                $(this).addClass("accordionLiClick")
                        .siblings().removeClass("accordionLiClick");

                var url = $(this).attr("myUrl");
                $("#<%=id%>").empty();
                $("#<%=id%>").load(url,function(){
                    that.attr("loaded","false");
                    if(loadCallBack){
                        loadCallBack();
                    }
                });
            })
        };
        accordionTab.orderNumber=12;
        executeQueue.push(accordionTab);
    })();
</script>
<div class="uiframe-layoutDiv" id="<%=id%>Layout">
    <div class="uiframe-two-row-left" id="<%=id%>Left" style="width:<%=leftWidth%>px;">
        <div class="uiframe-accordionTabLeft">
            <ul>
                <c:forEach var="item" items="<%=tabMap%>"  varStatus="s">
                    <c:choose>
                        <c:when test="${s.index == activeItemNub}">
                            <li id="<%=id%>Item${s.index}" class="accordionTabLi accordionLiClick" myUrl ="${basePath}/${item.value}"><a href="javascript:void(0)">${item.key}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li id="<%=id%>Item${s.index}" class="accordionTabLi" myUrl ="${basePath}/${item.value}"><a href="javascript:void(0)">${item.key}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <%--<li><a href="#"><div class="uiframe-accordionTabLeft-liIcon icon-folder-closed"></div><div>左侧导航san</div></a></li>--%>
            </ul>
        </div>
    </div>
    <!-- split bar -->
    <div class="uiframe-left-split-tool" ref_left_panel="<%=id%>Left"
         ref_right_panel="<%=id%>Right" id="uiframe_split_tool<%=uuid%>"></div>
    <!-- right panel -->
    <div class="uiframe-two-row-right" id="<%=id%>Right">
        <div class="uiframe-fit" id="<%=id%>"></div>
    </div>
</div>
