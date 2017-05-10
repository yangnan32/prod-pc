<!--
copyright : widget Technology Co., Ltd

下拉框标签

@version : 1.0
@created : 2012-4-8
@team : uiframe
@author : yangn
-->
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="showId" rtexprvalue="true" required="false" description="下拉框显示div的id,选填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="hasClear" rtexprvalue="true"  required="false" description="是否可清空,true or false" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="valueMap" rtexprvalue="true" type="java.util.Map" description="下拉列表对应的LinkedHashMap对象"  required="true" %><%--控件的下拉框键值对--%>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>


<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    String disableInputClass="";
    String emptyTextk="";
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
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(StringUtils.isNotBlank(emptyText)){
        emptyTextk="emptyText='"+emptyText+"'";
    }else {
        emptyTextk="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(showId==null||showId.equalsIgnoreCase("")){
        showId= "showId" + uuid;
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
<script type="text/javascript">
var comboxSelect${id}<%=uuid%> = {
    selectEdit:""      //修改时传递的数据（字符串类型）
};
comboxSelect${id}<%=uuid%>.getValue = function(){
    var selectText;
    $("#select_div_${id}"+<%=uuid%>).find(".click-option").each(function () {
        if ($(this).attr("val") === $("#${id}").val()){
            selectText = $(this).text();
            $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
        }
    });
    $("#${id}").attr("text", selectText);
    $("#select_text${id}"+<%=uuid%>).val(selectText);
    if ($("#select_text${id}"+<%=uuid%>).val() === '') {
        if ($("#select_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
            $("#select_text${id}"+<%=uuid%>).val($("#select_text${id}"+<%=uuid%>).attr("emptyText"));
            $("#select_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
        }
    } else {
        $("#select_text${id}"+<%=uuid%>).removeClass("uiframe-emptyTextColor");
    }
};
//下拉按钮绑定事件
comboxSelect${id}<%=uuid%>.setClick = function(){
    $("#select_btn${id}"+<%=uuid%>).on("mouseover" , function () {
        $(this).prev("input").addClass("uiframe-selectbox-text-hover");
        $(this).addClass("uiframe-selBtn-hover");
    });
    $("#select_btn${id}"+<%=uuid%>).on("mouseout" , function () {
        $(this).prev("input").removeClass("uiframe-selectbox-text-hover");
        $(this).removeClass("uiframe-selBtn-hover");
    });
    if("<%=readonly%>" !== "true"){
        $("#select_btn${id}"+<%=uuid%>).on("click", function (e) {//todo-yangn 需要重构
            var select_s = $(this).parent().children('.uiframe-selectbox-wrapper').css('display');
            if (select_s === "none") {
                var showH = $(this).parent().children('.uiframe-selectbox-wrapper').height();
                var win = $("#combo_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                var winH = win.height() - 77;
                var winTop = parseInt(win.css("top"));
                var bodyH = $(window).height();
                if ($("#body").height() > $(window).height()){
                    bodyH = $("#body").height();
                }
                if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                    var topSelect = $("#combo_select${id}"+<%=uuid%>).position().top;
                    if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect);
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect - showH -22);
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect);
                        }
                    }
                } else {
                    if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", "22px");
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", "22px");
                        }
                    }
                }
                $(this).prev("input").addClass("uiframe-selectbox-text-click");
                $(this).addClass("uiframe-selBtn-click");
                $("#select_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "block");
                $('.click-option').css("display", "block").removeClass("uiframe-hover");
                $("#select_text${id}"+<%=uuid%>).focus();
            } else {
                $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "none");
                $(this).prev("input").removeClass("uiframe-selectbox-text-click");
                $(this).removeClass("uiframe-selBtn-click");
                $("#select_text${id}"+<%=uuid%>).focus();
            }
            return false;  //阻止事件冒泡
        });
        //组件不为只读时，下拉列表数据显示隐藏操作
        $("#select_text${id}"+<%=uuid%>).on("click", function (e) {
            var select_s = $("#select_div_${id}"+<%=uuid%>).css('display');
            if (select_s === "none") {
                var showH = $("#select_div_${id}"+<%=uuid%>).height();
                var win = $("#combo_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                var winH = win.height() - 77;
                var winTop = parseInt(win.css("top"));
                var bodyH = $(window).height();
                if ($("#body").height() > $(window).height()){
                    bodyH = $("#body").height();
                }
                if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                    var topSelect = $("#combo_select${id}"+<%=uuid%>).position().top;
                    if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect);
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("top", topSelect);
                        }
                    }
                } else {
                    if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                        if(e.pageY + showH - 16 - winTop > winH){
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", "22px");
                        }
                    } else {
                        if(e.pageY + showH + 30 > bodyH){
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                        } else {
                            $("#select_div_${id}"+<%=uuid%>).css("margin-top", "22px");
                        }
                    }
                }
                $(this).addClass("uiframe-selectbox-text-click");
                $(this).next("span").addClass("uiframe-selBtn-click");
                $("#select_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $("#select_div_${id}"+<%=uuid%>).css("display", "block");
                $('.click-option').css("display", "block").removeClass("uiframe-hover");
            } else {
                $("#select_div_${id}"+<%=uuid%>).css("display", "none");
                $(this).removeClass("uiframe-selectbox-text-click");
                $(this).next("span").removeClass("uiframe-selBtn-click");
            }
            return false;  //阻止事件冒泡
        });
    }
    //键盘UP监听事件
    widget.hotKey.regist($("#combo_select${id}"+<%=uuid%>),widget.hotKey.UP,function(){
        var showDiv = $("#select_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
        var listDiv = $("#<%=showId%>");         //下拉框中显示div的jQuery对象
        if(showDiv.css('display') !== "none"){
            if(listDiv.find("li.uiframe-hover").length === 1){
                var myTr = listDiv.find("li.uiframe-hover");
                myTr.removeClass("uiframe-hover");
                if(myTr.prev("li").length === 0) {
                    listDiv.find("li:last").addClass("uiframe-hover");
                    listDiv.find("li:last").focus();
                } else {
                    myTr.prev("li").addClass("uiframe-hover");
                    myTr.next("li").focus();
                }
            }
        }
    });
    //键盘DOWN监听事件
    widget.hotKey.regist($("#combo_select${id}"+<%=uuid%>),widget.hotKey.DOWN,function(){
        var showDiv = $("#select_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
        var listDiv = $("#<%=showId%>");                                     //下拉框中显示div的jQuery对象
        if(showDiv.css('display') !== "none"){
            if(listDiv.find("li.uiframe-hover").length === 0){
                listDiv.find("li:first").addClass("uiframe-hover");
            } else if(listDiv.find("li.uiframe-hover").length === 1){
                var myTr = listDiv.find("li.uiframe-hover");
                myTr.removeClass("uiframe-hover");
                if(myTr.next("li").length === 0) {
                    listDiv.find("li:first").addClass("uiframe-hover");
                    listDiv.find("li:first").focus();
                } else {
                    myTr.next("li").addClass("uiframe-hover");
                    myTr.next("li").focus();
                }
            }
        }
    });
    //键盘ENTER监听事件
    widget.hotKey.regist($("#combo_select${id}"+<%=uuid%>),widget.hotKey.ENTER,function(){
        if("<%=readonly%>" !== "true"){
            var showDiv = $("#select_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#<%=showId%>");                                    //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                var myTr = listDiv.find("li.uiframe-hover");
                myTr.trigger("click");
                myTr.removeClass("uiframe-hover");
            } else {
                showDiv.show();
            }
        }
    });
    <%--//键盘alt+ENTER监听事件--%>
    <%--widget.hotKey.registAltKey($("#combo_select${id}"+<%=uuid%>),widget.hotKey.ENTER,function(){--%>
    <%--var showDiv = $("#select_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象--%>
    <%--if(showDiv.css('display') !== "none"){--%>
    <%--showDiv.hide();--%>
    <%--}--%>
    <%--$("#${id}").trigger("saveForm");--%>
    <%--return false;--%>
    <%--});--%>
    //键盘ESC监听事件
    widget.hotKey.regist($("#combo_select${id}"+<%=uuid%>),widget.hotKey.ESC,function(){
        var showDiv = $("#select_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
        var listDiv = $("#<%=showId%>");                                    //下拉框中显示div的jQuery对象
        if(showDiv.css('display') !== "none"){
            $("#select_div_${id}"+<%=uuid%>).css("display", "none");
            $("#select_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
            $("#select_btn${id}"+<%=uuid%>).removeClass("uiframe-selBtn-click");
        }
    });
};
(function(){
    var combox=function(){
        //水印文字脚本
        if ($("#select_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
            $("#select_text${id}"+<%=uuid%>).val($("#select_text${id}"+<%=uuid%>).attr("emptyText"));
            $("#select_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
        }
        //下拉框划过样式脚本
        $("#select_text${id}"+<%=uuid%>).hover(function () {
            $(this).addClass("uiframe-selectbox-text-hover");
            $(this).next("span").addClass("uiframe-selBtn-hover");
        },function(){
            $(this).removeClass("uiframe-selectbox-text-hover");
            $(this).next("span").removeClass("uiframe-selBtn-hover");
        });
        //未设置禁用属性时执行
        if("<%=disableBtnClass%>" !== "uiframe-selBtn-disabled"){
            comboxSelect${id}<%=uuid%>.setClick();
        }
        //下拉列表赋值操作
        $("#select_div_${id}"+<%=uuid%>).find(".click-option").each(function () {
            $(this).bind("click", function () {
                $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
                var text = $(this).text();
                var val = $(this).attr("val");
                $("#select_text${id}"+<%=uuid%>).val(text);
                $("#${id}").val(val);
                $("#${id}").attr("jsonValue",$(this).attr("jsonValue"));
                $("#${id}").attr("text", text);
                $("#select_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
                $("#select_text${id}"+<%=uuid%>).next("span").removeClass("uiframe-selBtn-click");
                if ($("#select_text${id}"+<%=uuid%>).val() === '') {
                    $("#select_text${id}"+<%=uuid%>).val($("#select_text${id}"+<%=uuid%>).attr("emptyText"));
                    if ($("#select_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
                        $("#select_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
                    }
                } else {
                    $("#select_text${id}"+<%=uuid%>).removeClass("uiframe-emptyTextColor");
                }
                $("#select_text<%=id%>"+<%=uuid%>).removeClass("error");
                $("#select_text<%=id%>"+<%=uuid%>).next("label.error").remove();
                //为此组件id绑定点击tr时的方法
                $("#${id}").trigger("change",[val,text]);
                $("#select_text${id}"+<%=uuid%>).focus();
            });
        });
        //光标移走移除点击样式
        $("#select_text${id}"+<%=uuid%>).on("blur", function(){
            $(this).removeClass("uiframe-selectbox-text-click");
            $(this).next("span").removeClass("uiframe-selBtn-click");
        });

        //清空选中value
        $("#clearBtn${id}").on("click", function(){
            var text = "";
            var val = "";
            $("#select_text${id}"+<%=uuid%>).val("");
            $("#${id}").val("");
            $("#${id}").attr("text", "");
            if ($("#select_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
                $("#select_text${id}"+<%=uuid%>).val($("#select_text${id}"+<%=uuid%>).attr("emptyText"));
                $("#select_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");;
            }
            $("#${id}").trigger("change",[val,text]);
        });
        //点击下拉框之外的元素，下拉列表隐藏
        $("body").on("click", function () {
            if ($("#select_div_${id}"+<%=uuid%>).css("display") === "block") {
                $("#select_div_${id}"+<%=uuid%>).hide();
                $("#select_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
                $("#select_text${id}"+<%=uuid%>).next("input").removeClass("uiframe-selBtn-click");
            }
        });
        //下拉列表修改传值操作
        if($("#${id}").val() != ""){
            comboxSelect${id}<%=uuid%>.getValue();
        }
        //事件
        $("#${id}").on("setValue",function(e,v){
            $("#select_div_${id}"+<%=uuid%>).find("li[val="+v+"]").trigger("click");
        });
        //改变下拉框的文本值方法
        $("#${id}").on("setText",function(e,text){
            $("#select_text${id}"+<%=uuid%>).val(text);
        });

        //为此组件id绑定只读方法
        $("#${id}").on("readonly", function () {
            $("#select_btn${id}"+<%=uuid%>).off("click");
            $("#select_text${id}"+<%=uuid%>).off("click");
            $("#combo_select${id}"+<%=uuid%>).off("keydown");
        });
        //为此组件id绑定取消只读方法
        $("#${id}").on("unreadonly", function () {
            $("#select_btn${id}"+<%=uuid%>).off("mouseover");
            $("#select_btn${id}"+<%=uuid%>).off("mouseout");
            comboxSelect${id}<%=uuid%>.setClick();
        });
        //禁用
        $("#${id}").on("disabled",function(){
            $("#select_text${id}"+<%=uuid%>).attr("disabled",true).addClass("uiframe-textinput-disabled");
            $("#select_btn${id}"+<%=uuid%>).off("mouseover");
            $("#select_btn${id}"+<%=uuid%>).off("mouseout");
            $("#combo_select${id}"+<%=uuid%>).off("keydown");
            $("#select_btn${id}"+<%=uuid%>).off("click");
        });
        //取消禁用
        $("#${id}").on("enable",function(){
            $("#select_text${id}"+<%=uuid%>).removeAttr("disabled").removeClass("uiframe-textinput-disabled");
            comboxSelect${id}<%=uuid%>.setClick();
        });
        //清空
        $("#${id}").on("clearValue",function(){
            $(this).val("");
            $(this).attr("text", "");
            $("#select_text${id}"+<%=uuid%>).val($("#select_text<%=id%>"+<%=uuid%>).attr("emptytext")||"");
            $("#select_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
        });
        $("#select_bbar${id}").width($("#select_div_${id}"+<%=uuid%>).width());
        //判断谷歌浏览器
        if(widget.browser.isChrome()){
            $("#combo_select${id}"+<%=uuid%>).width($("#select_div_${id}"+<%=uuid%>).width() + 6);
        }
    };
    combox.orderNumber=39;
    executeQueue.push(combox);
})();
</script>
<div id="combo_select${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="hidden" class="${group}" id="${id}" value="${value}" text="" <%=name%> />
    <input type="text" id="select_text${id}<%=uuid%>" readonly="readonly" name="<%=id%><%=uuid%>" style="width: <%=w-22%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="" class="uiframe-selectbox-text  <%=disableInputClass%> <%=cls%>">
    <span id="select_btn${id}<%=uuid%>" class="uiframe-form-btnClick uiframe-selBtn"></span>
    <div id="select_div_${id}<%=uuid%>" class="uiframe-selectbox-wrapper uiframe-selectHide" style="width: <%=(w+10)%>px;*-width:<%=w%>px;*margin-left: -<%=w+12%>px;">
        <%
            if(height==null||height.equalsIgnoreCase("")){
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = 300;
                if(maxHeight >= 300){
                    heightText = "height:300px;";
        %>
            <div id="<%=showId%>" style="width: <%=(w+10)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                }else{
        %>
            <div id="<%=showId%>" style="width: <%=(w+10)%>px;*-width:<%=(w-2)%>px;">
        <%
                }
            } else {
                int len = valueMap.size();
                int maxHeight = 26 * len;
                int trueHeight = Integer.parseInt(height);
                if(maxHeight >= trueHeight){
                    heightText = "height:"+height+"px;";

        %>
            <div id="<%=showId%>" style="width: <%=(w+10)%>px;*-width:<%=(w-17)%>px;<%=heightText%> overflow-y: auto;">
        <%
                } else {
        %>
                <div id="<%=showId%>" style="width: <%=(w+10)%>px;*-width:<%=(w-2)%>px;">
        <%
                }
            }
        %>
            <ul>
                <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
                    <li tabindex=0 class="click-option" val="${item.key}">${item.value}</li>
                </c:forEach>
            </ul>
        </div>
        <%
           if(hasClear!=null && hasClear.equalsIgnoreCase("true")){
        %>

        <div class="uiframe-select-bbar" id="select_bbar<%=id%>" style="width: <%=(w+10)%>px;border-top: 1px solid #ebebeb;">
            <div style="float: left;margin-top: 1px;">
                <table>
                    <tr>
                        <td class="uiframe-grid-span"></td>
                        <td>
                            <input type="button" class="uiframe-module-btn" id="clearBtn${id}" style="padding: 0 4px;*-padding:0 2px;" value="清空" />
                        </td>
                        <td class="uiframe-grid-span"></td>
                    </tr>
                </table>
            </div>
        </div>
    <%
        }
    %>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -20px 0 0 <%=w+16%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>
