<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-6-19上午10:47
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.*" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件css样式名称" %>
<%@attribute name="value" rtexprvalue="true"  required="false" type="java.util.List" description="下拉列表对应的List对象" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="key" rtexprvalue="true" required="false" description="ajax reload时key的名称,选填" %>
<%@attribute name="val" rtexprvalue="true" required="false" description="ajax reload时value的名称,选填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="false" description="ajax data root,必填" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="toolbar" rtexprvalue="true"  required="false" description="多选框工具栏" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="下拉列表对应的LinkedHashMap对象"  required="true" %><%--控件的下拉框键值对--%>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    String disableInputClass="";
    String emptyTextk="";
    String toolbarText="";
    String heightText="";
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
    } else {
        readonly="false";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        disableBtnClass="uiframe-selBtn-disabled";
        disableInputClass="uiframe-textinput-disabled";
    } else {
        disableInputClass = "";
        disableBtnClass="";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(StringUtils.isNotBlank(cls)){
    }else {
        cls ="";
    }
    if(StringUtils.isNotBlank(emptyText)){
        emptyTextk="emptyText='"+emptyText+"'";
    }else {
        emptyTextk="";
    }
    if(StringUtils.isNotEmpty(toolbar) && toolbar.equalsIgnoreCase("true")){
        toolbarText="display:block";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="190";
    }
    float w=190;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=190;
    }
%>
<%
    List newValue = new ArrayList();
    newValue.add("aaaa");
    newValue.add("wwww");
    newValue.add("bbbb");
    request.setAttribute("n",newValue);
%>

<script type="text/javascript">
var checkboxSelect<%=id%><%=uuid%> = {
     selectValue:"",         //value真实值
     selectText:"",          //text显示值
     selectEdit:[],          //修改时传递的数据（数组类型）
     loadData:"",             //reload数据
     showY : 0                       //显示数据Y轴距离
};
checkboxSelect<%=id%><%=uuid%>.getValue = function(){
    var selectedValue=[];
    var selectedText=[];
    $("#selectCheckbox_div${id}"+<%=uuid%>).find(".click-select-checkbox").each(function () {
        if ($(this).attr("check") === "true"){
            selectedValue.push($(this).attr("val"));
            selectedText.push($(this).text());
        }
    });
    $("#${id}").val(selectedValue.join(","));
    $("#selectCheckbox_text${id}"+<%=uuid%>).val(selectedText.join(","));
    if ($("#selectCheckbox_text${id}"+<%=uuid%>).val() === '') {
        if ($("#selectCheckbox_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
            $("#selectCheckbox_text${id}"+<%=uuid%>).val($("#selectCheckbox_text${id}"+<%=uuid%>).attr("emptyText"));
            $("#selectCheckbox_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
        }
    } else {
        $("#selectCheckbox_text${id}"+<%=uuid%>).removeClass("uiframe-emptyTextColor");
    }
};
//下拉按钮绑定事件
checkboxSelect${id}<%=uuid%>.setClick = function(){
    $("#selectCheckbox_btn${id}"+<%=uuid%>).on("mouseover" , function () {
        $(this).prev("input").addClass("uiframe-selectbox-text-checkbox-hover");
        $(this).addClass("uiframe-selBtn-checkbox-hover");
    }).on("mouseout" , function () {
                $(this).prev("input").removeClass("uiframe-selectbox-text-checkbox-hover");
                $(this).removeClass("uiframe-selBtn-checkbox-hover");
            });
    //组件不为只读时，下拉列表数据显示/隐藏操作
    if("<%=readonly%>" !== "true"){
        $("#selectCheckbox_btn${id}"+<%=uuid%>).on("click", function (e) {//todo-yangn 需要重构
            $(this).prev("input").focus();
            var select_s = $(this).parent().children('.uiframe-selectbox-checkbox').css('display');
            if (select_s === "none") {
                checkboxSelect<%=id%><%=uuid%>.showY = e.pageY;
                var showH = $(this).parent().children('.uiframe-selectbox-checkbox').height();
                var win = $("#select_checkbox<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                var winH = win.height() - 77;
                var winTop = parseInt(win.css("top"));
                var bodyH = $(window).height();
                if ($("#body").height() > $(window).height()){
                    bodyH = $("#body").height();
                }
                if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                    var topSelect = $("#select_checkbox${id}"+<%=uuid%>).position().top;
                    if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                        } else {
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect + 23);
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                        } else {
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect + 23);
                        }
                    }
                } else {
                    if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                        if(e.pageY + showH - 16 - winTop > winH){
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", -(showH + 1));
                        } else {
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", "22px");
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", -(showH + 1));
                        } else {
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", "22px");
                        }
                    }
                }
                $(this).prev("input").addClass("uiframe-selectbox-text-checkbox-click");
                $(this).addClass("uiframe-selBtn-checkbox-click");
                $("#selectCheckbox_div${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $(this).parent().children('.uiframe-selectbox-checkbox').css("display", "block");
                $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").css("display", "block");
            } else {
                $(this).parent().children('.uiframe-selectbox-checkbox').css("display", "none");
                $(this).prev("input").removeClass("uiframe-selectbox-text-checkbox-click");
                $(this).removeClass("uiframe-selBtn-checkbox-click");
            }
            return false;  //阻止事件冒泡
        });
        $("#selectCheckbox_text${id}"+<%=uuid%>).on("click", function (e) {
            var select_s = $(this).parent().children('.uiframe-selectbox-checkbox').css('display');
            if (select_s === "none") {
                checkboxSelect<%=id%><%=uuid%>.showY = e.pageY;
                var showH = $(this).parent().children('.uiframe-selectbox-checkbox').height();
                var win = $("#select_checkbox<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                var winH = win.height() - 77;
                var winTop = parseInt(win.css("top"));
                var bodyH = $(window).height();
                if ($("#body").height() > $(window).height()){
                    bodyH = $("#body").height();
                }
                if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                    var topSelect = $("#select_checkbox${id}"+<%=uuid%>).position().top;
                    if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                        } else {
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect + 23);
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                        } else {
                            $("#selectCheckbox_div${id}"+<%=uuid%>).css("top", topSelect + 23);
                        }
                    }
                } else {
                    if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                        if(e.pageY + showH - 16 - winTop > winH){
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", -(showH + 1));
                        } else {
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", "22px");
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", -(showH + 1));
                        } else {
                            $(this).parent().children('.uiframe-selectbox-checkbox').css("margin-top", "22px");
                        }
                    }
                }
                $(this).addClass("uiframe-selectbox-text-checkbox-click");
                $(this).next("span").addClass("uiframe-selBtn-checkbox-click");
                $("#selectCheckbox_div${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $(this).parent().children('.uiframe-selectbox-checkbox').css("display", "block");
                $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").css("display", "block");
            } else {
                $(this).parent().children('.uiframe-selectbox-checkbox').css("display", "none");
                $(this).removeClass("uiframe-selectbox-text-checkbox-click");
                $(this).next("span").removeClass("uiframe-selBtn-checkbox-click");
            }
            return false;
        });
    }
};
(function(){
    var checkCombox=function(){
        //水印文字脚本
        if ($("#selectCheckbox_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
            $("#selectCheckbox_text${id}"+<%=uuid%>).val($("#selectCheckbox_text${id}"+<%=uuid%>).attr("emptyText"));
            $("#selectCheckbox_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
        }
        //下拉框划过样式脚本
        $("#selectCheckbox_text${id}"+<%=uuid%>).on("mouseover" , function () {
            $(this).addClass("uiframe-selectbox-text-checkbox-hover");
            $(this).next("span").addClass("uiframe-selBtn-checkbox-hover");
        }).on("mouseout" , function () {
                    $(this).removeClass("uiframe-selectbox-text-checkbox-hover");
                    $(this).next("span").removeClass("uiframe-selBtn-checkbox-hover");
                });
        //未设置禁用属性时执行
        if("<%=disableBtnClass%>" !== "uiframe-selBtn-disabled"){
            checkboxSelect${id}<%=uuid%>.setClick();
        }
        //下拉列表赋值操作
        $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").on("click",function(){
            if ($(this).attr("check") === "false") {
                $(this).addClass('uiframe-checkbox-selected');
                $(this).attr("check", "true");
                $("#selectCheckbox_text<%=id%>"+<%=uuid%>).removeClass("error");
                $("#selectCheckbox_text<%=id%>"+<%=uuid%>).next("label.error").remove();
            } else {
                $(this).removeClass('uiframe-checkbox-selected');
                $(this).attr("check", "false");
            }
            checkboxSelect<%=id%><%=uuid%>.getValue();
            <%--$("#selectCheckbox_text${id}"+<%=uuid%>).trigger("change");--%>
        });
        //光标移走移除点击样式
        $("#selectCheckbox_text${id}"+<%=uuid%>).on("blur", function(){
            $(this).removeClass("uiframe-selectbox-text-checkbox-click");
            $(this).next("span").removeClass("uiframe-selBtn-checkbox-click");
        });
        //全部选择
        $("#allselectBtn${id}").on("click", function(){
            $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").each(function () {
                if ($(this).attr("check") === "false") {
                    $(this).addClass('uiframe-checkbox-selected');
                    $(this).attr("check", "true");
                }
            });
            checkboxSelect<%=id%><%=uuid%>.getValue();
        });
        //全部清空
        $("#clearBtn${id}").on("click", function(){
            $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").each(function () {
                if ($(this).attr("check") !== "false") {
                    $(this).removeClass('uiframe-checkbox-selected');
                    $(this).attr("check", "false");
                }
            });
            checkboxSelect<%=id%><%=uuid%>.getValue();
        });
        //点击下拉框之外的元素，下拉列表隐藏
        $("body").on("click", function () {
            if ($("#selectCheckbox_div${id}"+<%=uuid%>).css("display") === "block") {
                $("#selectCheckbox_div${id}"+<%=uuid%>).hide();
                $("#selectCheckbox_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-checkbox-click");
                $("#selectCheckbox_text${id}"+<%=uuid%>).next("input").removeClass("uiframe-selBtn-checkbox-click");
                $("#${id}").trigger("collapse",[$("#${id}").val()]);
            }
        });
        $("#selectCheckbox_div<%=id%>"+<%=uuid%>).on("click", function (event) {
            event.stopPropagation();
        });
        //下拉列表修改传值操作
        if("<%=value%>"!=""){
            //为空数组赋值（赋予需要删除的按钮id值）
            <c:forEach var="arrayValue" items="${value}">
                checkboxSelect<%=id%><%=uuid%>.selectEdit.push("${arrayValue}");
            </c:forEach>
            for (var i = 0;i< checkboxSelect<%=id%><%=uuid%>.selectEdit.length;i++) {
                var newValue = checkboxSelect<%=id%><%=uuid%>.selectEdit[i];
                $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").each(function () {
                    if ($(this).attr("val") === newValue) {
                        $(this).addClass('uiframe-checkbox-selected');
                        $(this).attr("check", "true");
                    }
                });
            }
            checkboxSelect<%=id%><%=uuid%>.getValue();

        }

        $("#${id}").on("setValue",function(e,v){
            checkboxSelect<%=id%><%=uuid%>.selectEdit = v;
            for (var i = 0;i< checkboxSelect<%=id%><%=uuid%>.selectEdit.length;i++) {
                var newValue = checkboxSelect<%=id%><%=uuid%>.selectEdit[i];
                $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").each(function () {
                    if ($(this).attr("val") === newValue) {
                        $(this).addClass('uiframe-checkbox-selected');
                        $(this).attr("check", "true");
                    }
                });
            }
            checkboxSelect<%=id%><%=uuid%>.getValue();
        });

        //为此组件id绑定只读方法
        $("#${id}").on("readonly", function () {
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("click");
            $("#selectCheckbox_text${id}"+<%=uuid%>).off("click");
        });
        //为此组件id绑定取消只读方法
        $("#${id}").on("unreadonly", function () {
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("mouseover");
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("mouseout");
            checkboxSelect${id}<%=uuid%>.setClick();
        });
        //禁用
        $("#${id}").on("disabled",function(){
            $("#selectCheckbox_text${id}"+<%=uuid%>).attr("disabled",true).addClass("uiframe-textinput-disabled");
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("mouseover");
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("mouseout");
            $("#selectCheckbox_btn${id}"+<%=uuid%>).off("click");
        });
        //取消禁用
        $("#${id}").on("enable",function(){
            $("#selectCheckbox_text${id}"+<%=uuid%>).removeAttr("disabled").removeClass("uiframe-textinput-disabled");
            checkboxSelect${id}<%=uuid%>.setClick();

        });
        //清空
        $("#${id}").on("clearValue",function(){
            $(this).val("");
            $("#selectCheckbox_text${id}"+<%=uuid%>).val($("#selectCheckbox_text<%=id%>"+<%=uuid%>).attr("emptytext")||"");
            $("#select_checkbox<%=id%>"+<%=uuid%>).find(".click-select-checkbox").each(function () {
                if ($(this).attr("check") !== "false") {
                    $(this).removeClass('uiframe-checkbox-selected');
                    $(this).attr("check", "false");
                }
            });
            checkboxSelect<%=id%><%=uuid%>.getValue();
        });
        <%
            if (StringUtils.isNotEmpty(dataRoot)){
        %>
            //重新加载url地址
            $("#${id}").on("reLoad", function(event,url){
                $.ajax({
                    type: "POST",
                    url: url,
                    dataType: "json",
                    success:function(dataName){
                        if(dataName){
                            var data=dataName.<%=dataRoot%>;
                            if(data==undefined){return;}
                            checkboxSelect<%=id%><%=uuid%>.loadData = data.resultSet||[];
                        }
                        var ulDiv=$("#checkCombox_ul_${id}"+<%=uuid%>);
                        ulDiv.empty();       //清空数据
                        var ul=$('<ul></ul>');
                        if(<%=height%>){
                            var maxHeight = <%=height%>;
                            var trueHeight = 26 * checkboxSelect<%=id%><%=uuid%>.loadData.length;
                            if(trueHeight >= maxHeight){
                                $("#checkCombox_ul_${id}"+<%=uuid%>).height(maxHeight);
                                if($.browser.msie && $.browser.version==6){
                                    var ulW = $("#checkCombox_ul_${id}"+<%=uuid%>).width();
                                    $("#checkCombox_ul_${id}"+<%=uuid%>).width(ulW - 13);
                                }
                            } else {
                                $("#checkCombox_ul_${id}"+<%=uuid%>).css("height","100%");
                            }
                        } else {
                            var trueHeight = 26 * checkboxSelect<%=id%><%=uuid%>.loadData.length;
                            if(trueHeight >= 300){
                                $("#checkCombox_ul_${id}"+<%=uuid%>).height(300);
                                if($.browser.msie && $.browser.version==6){
                                    var ulW = $("#checkCombox_ul_${id}"+<%=uuid%>).width();
                                    $("#checkCombox_ul_${id}"+<%=uuid%>).width(ulW - 13);
                                }
                            } else {
                                $("#checkCombox_ul_${id}"+<%=uuid%>).css("height","100%");
                            }
                        }
                        for(var i=0;i<checkboxSelect<%=id%><%=uuid%>.loadData.length;i++){
                            var record=checkboxSelect<%=id%><%=uuid%>.loadData[i];
                            if(record){
                                var key = record["<%=key%>"]||"";
                                var value = record["<%=val%>"]||"";
                                var checkbox = record["check"]||"";
                                if(checkbox !== "" && checkbox === true){
                                    ul.append('<li class="click-select-checkbox uiframe-checkbox-selected" check="'+ checkbox +'" val="' + key + '"><span class="uiframe-selectbox-select">'+value+'</span></li>');
                                } else {
                                    ul.append('<li class="click-select-checkbox" check="'+ checkbox +'" val="' + key + '"><span class="uiframe-selectbox-select">'+value+'</span></li>');
                                }
                            }
                            ulDiv.append(ul);
                        }
                        ulDiv.find("li.click-select-checkbox").each(function(){
                            $(this).on("click" , function(){
                                if ($(this).attr("check") !== "" && $(this).attr("check") === "true") {
                                    $(this).removeClass('uiframe-checkbox-selected');
                                    $(this).attr("check", "false");
                                } else {
                                    $(this).addClass('uiframe-checkbox-selected');
                                    $(this).attr("check", "true");
                                    $("#selectCheckbox_text<%=id%>"+<%=uuid%>).removeClass("error");
                                    $("#selectCheckbox_text<%=id%>"+<%=uuid%>).next("label.error").remove();
                                }
                                checkboxSelect<%=id%><%=uuid%>.getValue();
                            });
                        });
                        //判断下拉列表显示文本上方或下方
                        var showH = $("#selectCheckbox_div<%=id%>"+<%=uuid%>).height();
                        var win = $("#select_checkbox<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                        if(win.attr("winwin") === "window") {//todo-hemq 需要重构
                            if(checkboxSelect<%=id%><%=uuid%>.showY + showH + 10 > win.height()){
                                    $("#select_div${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                                if(checkboxSelect<%=id%><%=uuid%>.showY >= showH) {
                                    $("#select_div${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                                } else {
                                    $("#checkCombox_ul_${id}"+<%=uuid%>).height(checkboxSelect<%=id%><%=uuid%>.showY - 40);
                                    $("#select_div${id}"+<%=uuid%>).css("margin-top", -(checkboxSelect<%=id%><%=uuid%>.showY - 15));
                                }
                            } else {
                                $("#select_div${id}"+<%=uuid%>).css("margin-top", "22px");
                            }
                        } else {
                            if(checkboxSelect<%=id%><%=uuid%>.showY + showH + 30 > $(window).height()){
                                $("#select_div${id}"+<%=uuid%>).css("margin-top", -(showH + 1));

                            } else {
                                $("#select_div${id}"+<%=uuid%>).css("margin-top", "22px");
                            }
                        }
                        checkboxSelect<%=id%><%=uuid%>.getValue();
                    },
                    error:function(XMLHttpRequest, textStatus, errorThrown){

                    }
                });
            });
        <%
            }
        %>
        //判断谷歌浏览器
        if(widget.browser.isChrome()){
            $("#select_checkbox${id}"+<%=uuid%>).width($("#selectCheckbox_div${id}"+<%=uuid%>).width() + 6);
        }
    };
    checkCombox.orderNumber=41;
    executeQueue.push(checkCombox);
})();
</script>
<div id="select_checkbox<%=id%><%=uuid%>" class="uiframe-mainCon">
    <input type="hidden" class="${group}" <%=name%> id="${id}" value="">
    <input type="text" id="selectCheckbox_text${id}<%=uuid%>" name="${id}<%=uuid%>" readonly="readonly" style="width: <%=w-22%>px;" <%=emptyTextk%> <%=disableText%> value="" class="uiframe-selectbox-checkbox-text <%=disableInputClass%> <%=cls%>">
    <span id="selectCheckbox_btn${id}<%=uuid%>" class="uiframe-form-btnClick uiframe-selBtn-checkbox"></span>
    <div id="selectCheckbox_div${id}<%=uuid%>" class="uiframe-selectbox-checkbox uiframe-selectHide" style="width: <%=(w+10)%>px;*margin-left: -<%=w+12%>px;overflow:hidden;">
        <%
            if(height==null||height.equalsIgnoreCase("")){
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = 300;
                if(maxHeight >= 300){
                    heightText = "height:300px;";
        %>
        <div id="checkCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                }else{
        %>
        <div id="checkCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=(w-2)%>px; overflow-y: auto;">
        <%
                }
            } else {
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = Integer.parseInt(height);
                if(maxHeight >= trueHeight){
                    heightText = "height:"+height+"px;";

        %>
        <div id="checkCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                } else {
        %>
            <div id="checkCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=(w-2)%>px; overflow-y: auto;">
        <%
                }
            }
        %>
            <ul>
                <c:forEach var="item" items="${valueMap}" varStatus="s">
                    <li class="click-select-checkbox" val="${item.key}" check="false"><span class="uiframe-selectbox-select">${item.value}</span></li>
                </c:forEach>
            </ul>
        </div>
        <div class="uiframe-select-bbar" id="selectCheckbox_bbar<%=id%>" style="width: <%=(w+10)%>px;display:none;<%=toolbarText%>;border-top: 1px solid #ebebeb;">
            <div style="float: left;margin-top: 1px;">
                <table>
                    <tr>
                        <td class="uiframe-grid-span"></td>
                        <td>
                            <input type="button" class="uiframe-module-btn" id="allselectBtn<%=id%>" style="padding: 0 4px;*-padding:0 2px;" value="全选" />
                        </td>
                        <td class="uiframe-grid-span"></td>
                        <td>
                            <input type="button" class="uiframe-module-btn" id="clearBtn<%=id%>" style="padding: 0 4px;*-padding:0 2px;" value="清空" />
                        </td>
                        <td class="uiframe-grid-span"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
            <div class="mustWrite" style="float: left;margin: -20px 0 0 <%=w+16%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>
