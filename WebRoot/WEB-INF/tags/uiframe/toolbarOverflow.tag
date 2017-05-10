<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 11-7-18上午10:11
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="下拉按钮显示的宽度，不填则取默认值" %>
<%
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
%>
<script type="text/javascript">
    (function(){
        var toolbarOverflow=function(){
            //判断下拉按钮下是否有按钮，确定此按钮是否显示
            if($("#sub-toolbarOverflow${id}").children().is("span") === false) {
                $("#${id}").hide();
            }
            //判断下拉显示按钮的高度
            if(<%=height%>){
                var maxHeight = <%=height%>;
                var trueHeight = 25 * $("#sub-toolbarOverflow${id}").children("span").length + 2;
                if(trueHeight > maxHeight){
                    $("#sub-toolbarOverflow${id}").height(maxHeight)
                }
            }
            $("#${id}").on("click",function(){
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                if ($("#sub-toolbarOverflow${id}").css("display") === "block") {
                    $("#sub-toolbarOverflow${id}").css("display","none");
                } else {
                    $("#sub-toolbarOverflow${id}").css("display","block");
                }
                return false;  //阻止事件冒泡
            });
            //点击子菜单之外的元素，子菜单列表隐藏
            $("body").on("click", function () {
                if ($("#sub-toolbarOverflow${id}").css("display") === "block") {
                    $("#sub-toolbarOverflow${id}").hide();
                }
            });
            $("#sub-toolbarOverflow${id}").children("span").removeClass("uiframe-toolbarHover").addClass("uiframe-menuHover")
                                                               .css({width:<%=w%>+"px",display:"inline-block", float:"none"});
            $("#sub-toolbarOverflow${id}").children("span").find("button").css({width:<%=w%>+"px"});

            $("#${id}").hover(function(){
                $(this).addClass("uiframe-toolbarOverflow-btn-hover");
            },function(){
                $(this).removeClass("uiframe-toolbarOverflow-btn-hover");
            });
        };
        toolbarOverflow.orderNumber=16;
        executeQueue.push(toolbarOverflow);
    })();
</script>
<span class="uiframe-toolbarOverflow" id="btnParent${id}">
    <div class="uiframe-toolbarOverflow-btn" id="${id}"></div>
    <div class="uiframe-sub-toolbarOverflow uiframe-selectHide" id="sub-toolbarOverflow${id}" style="width:<%=w%>px;overflow-y: auto; overflow-x: hidden;">
        <jsp:doBody />
    </div>
</span>