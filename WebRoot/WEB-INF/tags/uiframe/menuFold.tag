<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-31下午2:48
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true"  required="true" description="菜单名称" %>
<%@attribute name="iconCls" rtexprvalue="true"  required="false" description="图标样式" %>
<%@attribute name="subMenuShow" rtexprvalue="true"  required="false" description="子菜单是否显示，true和false，默认flase" %>
<%
    long uuid=new Date().getTime();
    String subMenuText="";
    if(StringUtils.isNotEmpty(subMenuShow) && subMenuShow.equalsIgnoreCase("true")){
        subMenuText="uiframe-menuFold-child-show";
    }
%>
<script type="text/javascript">
    (function(){
        var menuFold=function(){
            //菜单标题头部绑定事件
            $("#${id}").children(".uiframe-menuFold-title").on("click", function () {
                if ($(this).next(".uiframe-menuFold-child").css("display") === "block") {
                    $("#${id}").removeClass("uiframe-menuFold-child-show");
                } else {
                    $("#${id}").addClass("uiframe-menuFold-child-show");
                }
            });
        };
        menuFold.orderNumber=17;
        executeQueue.push(menuFold);
    })();
</script>
<div class="uiframe-menuFold-parent <%=subMenuText%> ${cls}" id="${id}">
    <div class="uiframe-menuFold-title">
        <div class="${iconCls}">&nbsp;</div>
        <div class="uiframe-submenuFold-collapse">&nbsp;</div>
        <span><%=title%></span>
    </div>
    <div class="uiframe-menuFold-child">
        <jsp:doBody />
    </div>
</div>