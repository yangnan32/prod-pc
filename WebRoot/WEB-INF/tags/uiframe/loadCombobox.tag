<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-8-11下午1:30
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
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="hasClear" rtexprvalue="true"  required="false" description="是否可清空,true or false" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载数据的url" %>
<%@attribute name="key" rtexprvalue="true" required="false" description="json数据中key的名称,选填" %>
<%@attribute name="val" rtexprvalue="true" required="false" description="json数据中value的名称,选填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
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
    if(key==null||key.equalsIgnoreCase("")){
        key="key";
    }
    if(val==null||val.equalsIgnoreCase("")){
        val="value";
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
    var loadComboxSelect${id}<%=uuid%> = {
        selectName: "",                //load条件
        selectData: "",                //加载的数据
        changeUrl:"<%=url%>",         //修改时传的url
        selectEdit:""                //修改时传递的数据（字符串类型）
    };
    //加载数据方法
    loadComboxSelect<%=id%><%=uuid%>.loadajax = function(){
        loadComboxSelect<%=id%><%=uuid%>.search_name = loadComboxSelect<%=id%><%=uuid%>.selectName;
        $.ajax({
            type: "POST",
            url: loadComboxSelect<%=id%><%=uuid%>.changeUrl,
            dataType: "json",
            data:loadComboxSelect<%=id%><%=uuid%>.search_name,
            success:function(data_name){
                if(data_name){
                    var data=data_name.<%=dataRoot%>;
                    if(data==undefined){return;}
                    loadComboxSelect<%=id%><%=uuid%>.selectData = data.resultSet||[];
                }
                var ulDiv=$("#loadCombox_ul_${id}"+<%=uuid%>);
                ulDiv.empty();       //清空数据
                var ul=$('<ul></ul>');
                if(<%=height%>){
                    var maxHeight = <%=height%>;
                    var trueHeight = 26 * loadComboxSelect<%=id%><%=uuid%>.selectData.length;
                    if(trueHeight > maxHeight){
                        $("#loadCombox_ul_${id}"+<%=uuid%>).height(maxHeight);
                        if($.browser.msie && $.browser.version==6){
                            var ulW = $("#loadCombox_ul_${id}"+<%=uuid%>).width();
                            $("#loadCombox_ul_${id}"+<%=uuid%>).width(ulW - 17);
                        }
                    } else {
                        $("#loadCombox_ul_${id}"+<%=uuid%>).css("height", "100%");
                    }
                } else {
                    var trueHeight = 26 * loadComboxSelect<%=id%><%=uuid%>.selectData.length;
                    if(trueHeight > 300){
                        $("#loadCombox_ul_${id}"+<%=uuid%>).height(300);
                        if($.browser.msie && $.browser.version==6){
                            var ulW = $("#loadCombox_ul_${id}"+<%=uuid%>).width();
                            $("#loadCombox_ul_${id}"+<%=uuid%>).width(ulW - 17);
                        }
                    } else {
                        $("#loadCombox_ul_${id}"+<%=uuid%>).css("height", "100%");
                    }
                }
                for(var i=0;i<loadComboxSelect<%=id%><%=uuid%>.selectData.length;i++){
                    var record=loadComboxSelect<%=id%><%=uuid%>.selectData[i];
                    if(record){
                        var key=record["<%=key%>"]||"";
                        var value=record["<%=val%>"]||"";
                        ul.append('<li tabindex=0 class="click-option" val="' + key + '">'+value+'</li>');
                    }
                    ulDiv.append(ul);
                }
                //下拉列表修改传值操作
                if($("#${id}").val() != ""){
                    loadComboxSelect${id}<%=uuid%>.getValue();
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){

            }
        });
    };
    //修改url地址
    loadComboxSelect<%=id%><%=uuid%>.setUrl = function (newurl) {
        loadComboxSelect<%=id%><%=uuid%>.changeUrl = newurl;
        loadComboxSelect<%=id%><%=uuid%>.loadajax();
    };
    loadComboxSelect${id}<%=uuid%>.getValue = function(){
        var selectText;
        $("#loadSelect_div_${id}"+<%=uuid%>).find(".click-option").each(function () {
            if ($(this).attr("val") == $("#${id}").val()){
                selectText = $(this).text();
                $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
            }
        });
        $("#${id}").attr("text", selectText);
        $("#loadSelect_text${id}"+<%=uuid%>).val(selectText);
        if ($("#loadSelect_text${id}"+<%=uuid%>).val() == "" || $("#loadSelect_text${id}"+<%=uuid%>).val() == $("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText")) {               //todo
            if ($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
                $("#loadSelect_text${id}"+<%=uuid%>).val($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText"));
                $("#loadSelect_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
            }
        } else {
            $("#loadSelect_text${id}"+<%=uuid%>).removeClass("uiframe-emptyTextColor");
        }
    };
    //下拉按钮绑定事件
    loadComboxSelect${id}<%=uuid%>.setClick = function(){
        $("#loadSelect_btn${id}"+<%=uuid%>).on("mouseover" , function () {
            $(this).prev("input").addClass("uiframe-selectbox-text-hover");
            $(this).addClass("uiframe-selBtn-hover");
        });
        $("#loadSelect_btn${id}"+<%=uuid%>).on("mouseout" , function () {
            $(this).prev("input").removeClass("uiframe-selectbox-text-hover");
            $(this).removeClass("uiframe-selBtn-hover");
        });
        //组件不为只读时，下拉列表数据显示隐藏操作
        if("<%=readonly%>" !== "true"){
            $("#loadSelect_btn${id}"+<%=uuid%>).on("click", function (e) {//todo-yangn 需要重构
                $(this).prev("input").focus();
                var select_s = $(this).parent().children('.uiframe-selectbox-wrapper').css('display');
                if (select_s === "none") {
                    var showH = $(this).parent().children('.uiframe-selectbox-wrapper').height();
                    var win = $("#loadCombox_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                    var winH = win.height() - 77;
                    var winTop = parseInt(win.css("top"));
                    var bodyH = $(window).height();
                    if ($("#body").height() > $(window).height()){
                        bodyH = $("#body").height();
                    }
                    if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                        var topSelect = $("#loadCombox_select${id}"+<%=uuid%>).position().top;
                        if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                            if(e.pageY + showH - 16 - winTop > winH){
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                            } else {
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
                            }
                        } else {
                            if(e.pageY + showH + 30 > bodyH){
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                            } else {
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
                            }
                        }
                    } else {
                        if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                            if(e.pageY + showH - 16 - winTop > winH){
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", -(showH + 1));
                            } else {
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", "22px");
                            }
                        } else {
                            if(e.pageY + showH + 30 > bodyH){
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", -(showH + 1));
                            } else {
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", "22px");
                            }
                        }
                    }
                    $(this).prev("input").addClass("uiframe-selectbox-text-click");
                    $(this).addClass("uiframe-selBtn-click");
                    $("#loadSelect_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                    sywFunction.selection_zindex++;
                    $("#body").find("div.uiframe-selectHide").each(function(){
                        $(this).hide();//隐藏所有下拉框显示框
                    });
                    $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "block");
                    $('.click-option').css("display", "block");
                } else {
                    $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "none");
                    $(this).prev("input").removeClass("uiframe-selectbox-text-click");
                    $(this).removeClass("uiframe-selBtn-click");
                }
                return false;  //阻止事件冒泡
            });
            $("#loadSelect_text${id}"+<%=uuid%>).on("click", function (e) {
                var select_s = $(this).parent().children('.uiframe-selectbox-wrapper').css('display');
                if (select_s === "none") {
                    var showH = $(this).parent().children('.uiframe-selectbox-wrapper').height();
                    var win = $("#loadCombox_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                    var winH = win.height() - 77;
                    var winTop = parseInt(win.css("top"));
                    var bodyH = $(window).height();
                    if ($("#body").height() > $(window).height()){
                        bodyH = $("#body").height();
                    }
                    if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                        var topSelect = $("#loadCombox_select${id}"+<%=uuid%>).position().top;
                        if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                            if(e.pageY + showH - 16 - winTop > winH){
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                            } else {
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
                            }
                        } else {
                            if(e.pageY + showH + 30 > bodyH){
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                            } else {
                                $("#loadSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
                            }
                        }
                    } else {
                        if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                            if(e.pageY + showH - 16 - winTop > winH){
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", -(showH + 1));
                            } else {
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", "22px");
                            }
                        } else {
                            if(e.pageY + showH + 30 > bodyH){
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", -(showH + 1));
                            } else {
                                $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", "22px");
                            }
                        }
                    }
                    $(this).addClass("uiframe-selectbox-text-click");
                    $(this).next("input").addClass("uiframe-selBtn-click");
                    $("#loadSelect_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
                    sywFunction.selection_zindex++;
                    $("#body").find("div.uiframe-selectHide").each(function(){
                        $(this).hide();//隐藏所有下拉框显示框
                    });
                    $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "block");
                    $('.click-option').css("display", "block");
                } else {
                    $(this).parent().children('.uiframe-selectbox-wrapper').css("display", "none");
                    $(this).removeClass("uiframe-selectbox-text-click");
                    $(this).next("input").removeClass("uiframe-selBtn-click");
                }
                return false;  //阻止事件冒泡
            });
        }
        //键盘UP监听事件
        widget.hotKey.regist($("#loadCombox_select${id}"+<%=uuid%>),widget.hotKey.UP,function(){
            var showDiv = $("#loadSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#loadCombox_ul_${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
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
        widget.hotKey.regist($("#loadCombox_select${id}"+<%=uuid%>),widget.hotKey.DOWN,function(){
            var showDiv = $("#loadSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#loadCombox_ul_${id}"+<%=uuid%>);                                     //下拉框中显示div的jQuery对象
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
        widget.hotKey.regist($("#loadCombox_select${id}"+<%=uuid%>),widget.hotKey.ENTER,function(){
            if("<%=readonly%>" !== "true"){
                var showDiv = $("#loadSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
                var listDiv = $("#loadCombox_ul_${id}"+<%=uuid%>);                                    //下拉框中显示div的jQuery对象
                if(showDiv.css('display') !== "none"){
                    var myTr = listDiv.find("li.uiframe-hover");
                    myTr.trigger("click");
                    myTr.removeClass("uiframe-hover");
                } else {
                    showDiv.show();
                }
            }
        });
        //键盘ESC监听事件
        widget.hotKey.regist($("#loadCombox_select${id}"+<%=uuid%>),widget.hotKey.ESC,function(){
            var showDiv = $("#loadSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#loadCombox_ul_${id}"+<%=uuid%>);                 //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                $("#loadSelect_div_${id}"+<%=uuid%>).css("display", "none");
                $("#loadSelect_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
                $("#loadSelect_btn${id}"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            }
        });
    };
    (function(){
        var loadCombox=function(){
            //下拉框划过样式脚本
            $("#loadSelect_text${id}"+<%=uuid%>).on("mouseover" , function () {
                $(this).addClass("uiframe-selectbox-text-hover");
                $(this).next("span").addClass("uiframe-selBtn-hover");
            });
            $("#loadSelect_text${id}"+<%=uuid%>).on("mouseout" , function () {
                $(this).removeClass("uiframe-selectbox-text-hover");
                $(this).next("span").removeClass("uiframe-selBtn-hover");
            });
            //未设置禁用属性时执行
            if("<%=disableBtnClass%>" !== "uiframe-selBtn-disabled"){
                loadComboxSelect${id}<%=uuid%>.setClick();
            }
            loadComboxSelect<%=id%><%=uuid%>.loadajax();
            //下拉列表赋值操作
            $("#loadSelect_div_${id}"+<%=uuid%>).find(".click-option").live("click", function () {
                    $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
                    var text = $(this).text();
                    var val = $(this).attr("val");
                    $("#loadSelect_text${id}"+<%=uuid%>).val(text);
                    $("#${id}").val(val);
                    $("#${id}").attr("jsonValue",$(this).attr("jsonValue"));
                    $("#${id}").attr("text", text);
                    $("#loadSelect_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
                    $("#loadSelect_text${id}"+<%=uuid%>).next("span").removeClass("uiframe-selBtn-click");
                    if ($("#loadSelect_text${id}"+<%=uuid%>).val() === '') {
                        $("#loadSelect_text${id}"+<%=uuid%>).val($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText"));
                        if ($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
                            $("#loadSelect_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
                        }
                    } else {
                        $("#loadSelect_text${id}"+<%=uuid%>).removeClass("uiframe-emptyTextColor");
                    }
                $("#loadSelect_text<%=id%>"+<%=uuid%>).removeClass("error");
                $("#loadSelect_text<%=id%>"+<%=uuid%>).next("label.error").remove();
                    //为此组件id绑定点击tr时的方法
                    $("#${id}").trigger("change",[val,text]);
            });
            //光标移走移除点击样式
            $("#loadSelect_text${id}"+<%=uuid%>).on("blur", function(){
                $(this).removeClass("uiframe-selectbox-text-click");
                $(this).next("span").removeClass("uiframe-selBtn-click");
            });
            //清空选中value
            $("#clearBtn${id}").on("click", function(){
                var text = "";
                var val = "";
                $("#loadSelect_text${id}"+<%=uuid%>).val("");
                $("#${id}").val("");
                $("#${id}").attr("text", "");
                if ($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText") !== undefined) {
                    $("#loadSelect_text${id}"+<%=uuid%>).val($("#loadSelect_text${id}"+<%=uuid%>).attr("emptyText"));
                    $("#loadSelect_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
                }
                $("#${id}").trigger("change",[val,text]);
            });
            //点击下拉框之外的元素，下拉列表隐藏
            $("body").on("click", function () {
                if ($("#loadSelect_div_${id}"+<%=uuid%>).css("display") === "block") {
                    $("#loadSelect_div_${id}"+<%=uuid%>).hide();
                    $("#loadSelect_text${id}"+<%=uuid%>).removeClass("uiframe-selectbox-text-click");
                    $("#loadSelect_text${id}"+<%=uuid%>).next("input").removeClass("uiframe-selBtn-click");
                }
            });

            //为此组件id绑定更换url方法
            $("#${id}").on("setUrl", function (event,url) {
            	loadComboxSelect<%=id%><%=uuid%>.setUrl(url);
            });
            //事件
            $("#${id}").on("setValue",function(e,v){
                $("#loadSelect_div_${id}"+<%=uuid%>).find("li[val="+v+"]").trigger("click");
            });
            //为此组件id绑定只读方法
            $("#${id}").on("readonly", function () {
                $("#loadSelect_btn${id}"+<%=uuid%>).off("click");
                $("#loadSelect_text${id}"+<%=uuid%>).off("click");
                $("#loadSelect_text${id}"+<%=uuid%>).off("keydown");
            });
            //为此组件id绑定取消只读方法
            $("#${id}").on("unreadonly", function () {
                $("#loadSelect_btn${id}"+<%=uuid%>).off("mouseover");
                $("#loadSelect_btn${id}"+<%=uuid%>).off("mouseout");
                loadComboxSelect${id}<%=uuid%>.setClick();
            });
            //禁用
            $("#${id}").on("disabled",function(){
                $("#loadSelect_text${id}"+<%=uuid%>).attr("disabled",true).addClass("uiframe-textinput-disabled");
                $("#loadSelect_btn${id}"+<%=uuid%>).off("mouseover");
                $("#loadSelect_btn${id}"+<%=uuid%>).off("mouseout");
                $("#loadSelect_text${id}"+<%=uuid%>).off("keydown");
                $("#loadSelect_btn${id}"+<%=uuid%>).off("click");
            });
            //取消禁用
            $("#${id}").on("enable",function(){
                $("#loadSelect_text${id}"+<%=uuid%>).removeAttr("disabled").removeClass("uiframe-textinput-disabled");
                loadComboxSelect${id}<%=uuid%>.setClick();
            });
            //清空
            $("#${id}").on("clearValue",function(){
                $(this).val("");
                $("#loadSelect_text${id}"+<%=uuid%>).val($("#loadSelect_text<%=id%>"+<%=uuid%>).attr("emptytext")||"");
                $("#loadSelect_text${id}"+<%=uuid%>).addClass("uiframe-emptyTextColor");
            });
            //判断谷歌浏览器
            if(widget.browser.isChrome()){
                $("#loadCombox_select${id}"+<%=uuid%>).width($("#loadSelect_div_${id}"+<%=uuid%>).width() + 6);
            }
        };
        loadCombox.orderNumber=40;
        executeQueue.push(loadCombox);
    })();
</script>
<div id="loadCombox_select${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="hidden" class="${group}" id="${id}" value="${value}" text="" <%=name%> />
    <input type="text" id="loadSelect_text${id}<%=uuid%>" readonly="readonly" name="<%=id%><%=uuid%>" style="width: <%=w-22%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="" class="uiframe-selectbox-text  <%=disableInputClass%> <%=cls%>">
    <span id="loadSelect_btn${id}<%=uuid%>" class="uiframe-form-btnClick uiframe-selBtn"></span>
    <div id="loadSelect_div_${id}<%=uuid%>" class="uiframe-selectbox-wrapper uiframe-selectHide" style="width: <%=(w+10)%>px;*-width:<%=w%>px;*margin-left: -<%=w+12%>px;">
        <div id="loadCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=w%>px;overflow-y: auto;">
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
