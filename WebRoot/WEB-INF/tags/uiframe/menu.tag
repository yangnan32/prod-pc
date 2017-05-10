<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-6-4上午11:26
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="title" rtexprvalue="true"  required="true" description="控件的名称，必填" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="下拉按钮显示的宽度，不填则取默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="iconCls" rtexprvalue="true"  required="false" description="图标样式代码" %>
<%@attribute name="tooltip" rtexprvalue="true"  required="false" description="提示文字" %>
<%@attribute name="hidden" rtexprvalue="true"  required="false" description="是否隐藏按钮，默认false" %>
<%
    long uuid=new Date().getTime();
    String disableText="";
    String btnText="";
    String centerText="";
    String tooltipText="";
    String tooltipClass="";
    String hiddenText = "";

    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        btnText = "uiframe-toolbarNormal";
        centerText = "uiframe-toolbarBtn-disabled";
    } else {
        disableText="";
        btnText = "uiframe-toolbarHover";
        centerText = "";
    }
    if(StringUtils.isNotBlank(tooltip)){
        tooltipText="myTitle='"+tooltip+"'";
        tooltipClass="tooltip";
    }else {
        tooltipText="";
        tooltipClass="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="80";
    }
    float w=80;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=80;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="200";
    }
    float h=200;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=200;
    }

    if(StringUtils.isNotEmpty(hidden) && hidden.equalsIgnoreCase("true")){
        hiddenText="uiframe-hide";
    } else {
        hiddenText = "";
    }
%>
<script type="text/javascript">
    (function(){
        var menu=function(){
            //判断下拉按钮下是否有按钮，确定此按钮是否显示
            if($("#submenu${id}").children().is("span") === false) {
                $("#menu${id}").hide();
            }
            //判断下拉显示按钮的高度
            if(<%=height%>){
                var maxHeight = <%=height%>;
                var trueHeight = 25 * $("#submenu${id}").children("span").length + 2;
                if(trueHeight > maxHeight){
                    $("#submenu${id}").height(maxHeight);
                    $("#submenu${id}").css({"overflow-y":"auto", "overflow-x":"hidden"});
                }
            }
            $("#${id},#menuIcon${id}").on("click",function(){
            	$("#btnParent${id}").css("float","left");
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                if ($("#submenu${id}").css("display") === "block") {
                    $("#submenu${id}").css("display","none");
                    $("#menu${id}").removeClass("uiframe-toolbarBtn-click");
                } else {
                    $("#submenu${id}").css("display","block");
                    $("#menu${id}").removeClass("uiframe-toolbarBtn-hover").removeClass("uiframe-toolbarBtn-click");
                    $("#menu${id}").addClass("uiframe-toolbarBtn-click");
                }
                return false;  //阻止事件冒泡
            });
            //点击子菜单之外的元素，子菜单列表隐藏
            $("body").on("click", function () {
                if ($("#submenu${id}").css("display") === "block") {
                    $("#submenu${id}").hide();
                    $("#menu${id}").removeClass("uiframe-toolbarBtn-click");
                }
            });
            $("#submenu${id}").children("span").removeClass("uiframe-toolbarHover").addClass("uiframe-menuHover")
                                                  .css({width:<%=w+5%>+"px", float:"none"}).addClass("uiframe-inline");
            $("#submenu${id}").children("span").find("button").css({width:<%=w+5%>+"px"});

            $("#${id}").on("disabled",function(e){
                $("#${id}").attr("disabled",true);
                $("#${id}").next("button").attr("disabled",true);
                $("#center${id}").removeClass("uiframe-toolbarHover").addClass("uiframe-toolbarBtn-disabled");
                e.preventDefault();

            });
            $("#${id}").on("enable",function(e){
                $("#${id}").removeAttr("disabled");
                $("#${id}").next("button").removeAttr("disabled");
                $("#center${id}").removeClass("uiframe-toolbarBtn-disabled").addClass("uiframe-toolbarHover");
                e.preventDefault();

            });
            if("<%=disabled%>" == "true"){
            	$("#${id}").trigger("disabled");	                      //本页刷新时判断是否禁用
            }
            if ("<%=hiddenText%>" == "uiframe-hide") {
                $("#submenu${id}").children("span").addClass("uiframe-hide");
            }
        };
        menu.orderNumber=16;
        executeQueue.push(menu);
    })();
</script>
<span class="uiframe-menu" id="btnParent${id}">
    <span class="<%=btnText%> <%=tooltipClass%>" id="menu${id}" <%=tooltipText%>>
        <div class="toolbar-left"></div>
        <div class="toolbar-center <%=centerText%>" id="center${id}">
            <button id="${id}" type="button" class="tool-button" style="text-align: left;" <%=disableText%>><span class="uiframe-menuIcon <%=iconCls%>">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=title%></button>
            <button type="button" class="uiframe-menu-overflow" id="menuIcon${id}" <%=disableText%>> </button>
        </div>
        <div class="toolbar-right"></div>
    </span>
    <div class="uiframe-submenu uiframe-selectHide" id="submenu${id}" style="width:<%=w+5%>px;">
        <jsp:doBody />
    </div>
</span>