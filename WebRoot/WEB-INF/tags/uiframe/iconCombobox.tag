<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-8-17下午4:07
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="iconId" rtexprvalue="true" required="true" description="icon控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="下拉列表对应的LinkedHashMap对象"  required="true" %><%--控件的下拉框键值对--%>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>


<%
    long uuid=new Date().getTime();
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(height==null||height.equalsIgnoreCase("")){
        height = "";
    } else {
        height = "height:"+height+"px;";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="20";
    }
    float w=20;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=20;
    }
%>
<script type="text/javascript">
    (function(){
        var iconCombox=function(){
            //下拉列表数据显示隐藏操作
            $("#${iconId}Div").bind("click", function () {
                var select_s = $(this).next('.uiframe-comboIcon-wrapper').css('display');
                if (select_s === "none") {
                    $(this).addClass("uiframe-btnIcon-border");
                    $("#icon_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                    sywFunction.selection_zindex++;
                    $("#body").find("div.uiframe-selectHide").each(function(){
                        $(this).hide();//隐藏所有下拉框显示框
                    });
                    $(this).next('.uiframe-comboIcon-wrapper').css("display", "block");
                    $('.click-option').css("display", "block");
                } else {
                    $(this).removeClass("uiframe-btnIcon-border");
                    $(this).next('.uiframe-comboIcon-wrapper').css("display", "none");
                }
                return false;  //阻止事件冒泡
            });
            //下拉列表赋值操作
            $("#icon_div_${id}"+<%=uuid%>).find(".click-option").each(function () {
                $(this).bind("click", function () {
                    $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
                    var text = $(this).children("input").attr("val");
                    var val = $(this).attr("val");
                    $("#${iconId}").removeAttr("class").addClass(text);
                    $("#${id}").val(val);
                    $("#${id}").attr("text", text);
                    //为此组件id绑定点击tr时的方法
                    $("#${id}").trigger("change",[val,text]);
                    $("#${iconId}Div").removeClass("uiframe-btnIcon-border");
                    $("#${id}").next("div").removeClass("uiframe-btnIcon-error tooltip").removeAttr("title");
                });
            });
            //点击下拉框之外的元素，下拉列表隐藏
            $("body").on("click", function () {
                $("#iconComboDiv${id}"+<%=uuid%>).find(".uiframe-comboIcon-wrapper").each(function () {
                    if ($(this).css("display") === "block") {
                        $(this).hide();
                        $("#${iconId}Div").removeClass("uiframe-btnIcon-border");
                    }
                });
            });
            //事件
            $("#${id}").on("setValue",function(e,v){
                $("#icon_div_${id}"+<%=uuid%>).find("li[val="+v+"]").trigger("click");
            });
        };
        iconCombox.orderNumber=45;
        executeQueue.push(iconCombox);
    })();
</script>
<div id="iconComboDiv${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="hidden" class="${group}" id="${id}" value="<%=value%>" text="" <%=name%> />
    <div id="${iconId}Div" class="uiframe-btnIconDiv">
        <button type="button" id="${iconId}" class="uiframe-combox-initial ${cls}"  value=" " style="width:<%=w%>px;height:20px;float: left;${style}"> </button>
        <button type="button" id="btnIcon<%=id%><%=uuid%>" class="uiframe-menu-overflow"> </button>
    </div>
    <div id="icon_div_${id}<%=uuid%>" class="uiframe-comboIcon-wrapper uiframe-selectHide" style="width: <%=w+6%>px;">
        <div style="<%=height%> overflow-y: auto;">
            <ul>
                <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
                    <li class="click-option" val="${item.key}"><input type="button" style="width: <%=w%>px;" class="${item.value}" val="${item.value}" value=" " /></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin-left: <%=w+10%>px;*-margin-left:<%=(w+10)/2%>px;margin-top: -19px;">*</div>
    </c:when>
</c:choose>