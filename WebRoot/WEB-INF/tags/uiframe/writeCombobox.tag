<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-10-20上午10:08
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
<%@attribute name="key" rtexprvalue="true" required="true" description="搜索列传的值,必填" %>
<%@attribute name="value" rtexprvalue="true" required="false" description="下拉列表对应的value值" %>
<%@attribute name="valueText" rtexprvalue="true" required="false" description="下拉列表显示的value值" %>
<%@attribute name="parentText" rtexprvalue="true" required="false" description="前缀关联文本值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载数据的url" %>
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
    Boolean readOnlyFlag = false;
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        disableBtnClass="uiframe-selBtn-disabled";
        disableInputClass="uiframe-textinput-disabled";
    }
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonly="true";
        readOnlyFlag=true;
    } else {
        readonly="false";
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
    if(valueText==null||valueText.equalsIgnoreCase("")){
        valueText="";
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
var writeComboxSelect${id}<%=uuid%> = {
    selectName: "",                //load条件
    selectData: "",                //加载的数据
    changeUrl:"<%=url%>",         //修改时传的url
    selectValue:"",               //value真实值
    selectText:"",               //text显示值
    totalCount:0,                //加载的数据总数
    selectEdit:""                //修改时传递的数据（字符串类型）
};
//加载数据方法
writeComboxSelect<%=id%><%=uuid%>.loadajax = function(){
    var hidevalue = $("#${id}").val();
    writeComboxSelect<%=id%><%=uuid%>.search_name = writeComboxSelect<%=id%><%=uuid%>.selectName;
    $.ajax({
        type: "POST",
        url: writeComboxSelect<%=id%><%=uuid%>.changeUrl,
        dataType: "json",
        data:writeComboxSelect<%=id%><%=uuid%>.search_name,
        success:function(data_name){
            if(data_name){
                var data=data_name.<%=dataRoot%>;
                if(data==undefined){return;}
                writeComboxSelect<%=id%><%=uuid%>.selectData = data.resultSet||[];
                writeComboxSelect<%=id%><%=uuid%>.totalCount = data.recordtotal||0;
            }
            if(writeComboxSelect<%=id%><%=uuid%>.totalCount == 0){
                $("#select_bbar${id}").hide();
                $("#writeCombox_ul_${id}"+<%=uuid%>).hide();
                $("#writeCombox_ul_${id}"+<%=uuid%>).height(0);
                $("#dataNone${id}").show();
            } else {
                $("#dataNone${id}").hide();
            }
            var ulDiv=$("#writeCombox_ul_${id}"+<%=uuid%>);
            ulDiv.empty();       //清空数据
            var ul=$('<ul></ul>');
            if(<%=height%>){
                var maxHeight = <%=height%>;
                var trueHeight = 26 * writeComboxSelect<%=id%><%=uuid%>.selectData.length;
                if(trueHeight > maxHeight){
                    $("#writeCombox_ul_${id}"+<%=uuid%>).height(maxHeight);
                    if($.browser.msie && $.browser.version==6){
                        var ulW = $("#writeCombox_ul_${id}"+<%=uuid%>).width();
                        $("#writeCombox_ul_${id}"+<%=uuid%>).width(ulW - 17);
                    }
                } else {
                    $("#writeCombox_ul_${id}"+<%=uuid%>).css("height", "100%");
                }
            } else {
                var trueHeight = 26 * writeComboxSelect<%=id%><%=uuid%>.selectData.length;
                if(trueHeight > 300){
                    $("#writeCombox_ul_${id}"+<%=uuid%>).height(300);
                    if($.browser.msie && $.browser.version==6){
                        var ulW = $("#writeCombox_ul_${id}"+<%=uuid%>).width();
                        $("#writeCombox_ul_${id}"+<%=uuid%>).width(ulW - 17);
                    }
                } else {
                    $("#writeCombox_ul_${id}"+<%=uuid%>).css("height", "100%");
                }
            }
            for(var i=0;i<writeComboxSelect<%=id%><%=uuid%>.selectData.length;i++){
                var record=writeComboxSelect<%=id%><%=uuid%>.selectData[i];
                if(record){
                    var key=record["<%=key%>"]||"";
                    var value=record["<%=value%>"]||"";
                    if(hidevalue == value) {
                        ul.append('<li tabindex=0 class="click-option uiframe-selected" val="' + key + '">'+value+'</li>');
                    } else {
                        ul.append('<li tabindex=0 class="click-option" val="' + key + '">'+value+'</li>');
                    }
                }
                ulDiv.append(ul);
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){

        }
    });
};
//修改url地址
writeComboxSelect<%=id%><%=uuid%>.setUrl = function (newurl) {
    writeComboxSelect<%=id%><%=uuid%>.changeUrl = newurl;
};
//下拉按钮绑定事件
writeComboxSelect${id}<%=uuid%>.setClick = function(){
    $("#writeSelect_btn${id}"+<%=uuid%>).on("mouseover" , function () {
        $(this).prev("input").addClass("uiframe-selectbox-text-hover");
        $(this).addClass("uiframe-selBtn-hover");
    });
    $("#writeSelect_btn${id}"+<%=uuid%>).on("mouseout" , function () {
        $(this).prev("input").removeClass("uiframe-selectbox-text-hover");
        $(this).removeClass("uiframe-selBtn-hover");
    });
    //组件不为只读时，下拉列表数据显示隐藏操作
    if("<%=readonly%>" !== "true"){
        $("#writeSelect_btn${id}"+<%=uuid%>).on("click", function (e) {
             $(this).prev("input").focus();
             var select_s = $(this).parent().children('.uiframe-selectbox-wrapper').css('display');
             if (select_s === "none") {
                 var showH = $(this).parent().children('.uiframe-selectbox-wrapper').height();
                 var win = $("#writeCombox_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
                 var winH = win.height() - 77;
                 var winTop = parseInt(win.css("top"));
                 if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                     var topSelect = $("#writeCombox_select${id}"+<%=uuid%>).position().top;
                     if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                         if(e.pageY + showH - 16 - winTop > winH){
                             $("#writeSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                         } else {
                             $("#writeSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
                         }
                     } else {
                         if(e.pageY + showH + 30 > $(window).height()){
                             $("#writeSelect_div_${id}"+<%=uuid%>).css("top", topSelect - showH - 22);
                         } else {
                             $("#writeSelect_div_${id}"+<%=uuid%>).css("top", topSelect);
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
                         if(e.pageY + showH + 30 > $(window).height()){
                             $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", -(showH + 1));
                         } else {
                             $(this).parent().children('.uiframe-selectbox-wrapper').css("margin-top", "22px");
                         }
                     }
                 }
                 $(this).prev("input").addClass("uiframe-selectbox-text-click");
                 $(this).addClass("uiframe-selBtn-click");
                 $("#writeSelect_div_${id}"+<%=uuid%>).css("z-index", sywFunction.selection_zindex);
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
    }
};
(function(){
    var writeCombox=function(){
        //水印文字脚本
        if ($("#${id}").attr("emptyText") !== undefined) {
            $("#${id}").val($("#${id}").attr("emptyText"));
            $("#${id}").addClass("uiframe-emptyTextColor");
        }
        //下拉框划过样式脚本
        $("#${id}").on("mouseover" , function () {
            $(this).addClass("uiframe-selectbox-text-hover");
            $(this).next("span").addClass("uiframe-selBtn-hover");
        });
        $("#${id}").on("mouseout" , function () {
            $(this).removeClass("uiframe-selectbox-text-hover");
            $(this).next("span").removeClass("uiframe-selBtn-hover");
        });
        //未设置禁用属性时执行
        if("<%=disableBtnClass%>" !== "uiframe-selBtn-disabled"){
            writeComboxSelect${id}<%=uuid%>.setClick();
        }
        writeComboxSelect<%=id%><%=uuid%>.loadajax(); //加载数据
        //下拉列表赋值操作
        $("#writeSelect_div_${id}"+<%=uuid%>).find(".click-option").live("click", function () {
            $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
            var text = $(this).text();
            var val = $(this).attr("val");
            if("<%=parentText%>" == "" || "<%=parentText%>" == "null" ){
                $("#${id}").val(text);
                $("#${id}").val(val);
                $("#${id}").attr("text", text);
            	
            } else {
                $("#${id}").val("<%=parentText%>."+text);
                $("#${id}").val("<%=parentText%>."+val);
                $("#${id}").attr("text", "<%=parentText%>."+text);
            }
            $("#${id}").attr("jsonValue",$(this).attr("jsonValue"));
            $("#${id}").removeClass("uiframe-selectbox-text-click");
            $("#${id}").next("span").removeClass("uiframe-selBtn-click");
            if ($("#${id}").val() === '') {
                $("#${id}").val($("#${id}").attr("emptyText"));
                if ($("#${id}").attr("emptyText") !== undefined) {
                    $("#${id}").addClass("uiframe-emptyTextColor");
                }
            } else {
                $("#${id}").removeClass("uiframe-emptyTextColor");
            }
            $("#<%=id%>").removeClass("error");
            $("#<%=id%>").next("label.error").remove();
            //为此组件id绑定点击tr时的方法
            $("#${id}").trigger("change",[val,text]);
        });
        //光标移走移除点击样式
        $("#${id}").on("blur", function(){
            $(this).removeClass("uiframe-selectbox-text-click");
            $(this).next("span").removeClass("uiframe-selBtn-click");
        });
        //键盘输入监听事件
        $("#${id}").bind("keyup", function (e) {
        	if(e.keyCode === 40 || e.keyCode === 39 ||e.keyCode === 38 || e.keyCode === 37 || e.keyCode === 27 || e.keyCode === 13 ) return;
            var hideValue = $(this).val();
            $("#${id}").val(hideValue);
        });
        //清空选中value
        $("#clearBtn${id}").on("click", function(){
            var text = "";
            var val = "";
            $("#${id}").val("");
            $("#${id}").attr("text", "");
            if ($("#${id}").attr("emptyText") !== undefined) {
                $("#${id}").val($("#${id}").attr("emptyText"));
                $("#${id}").addClass("uiframe-emptyTextColor");
            }
            $("#${id}").trigger("change",[val,text]);
        });
        //点击下拉框之外的元素，下拉列表隐藏
        $("body").on("click", function () {
            if ($("#writeSelect_div_${id}"+<%=uuid%>).css("display") === "block") {
                $("#writeSelect_div_${id}"+<%=uuid%>).hide();
                $("#${id}").removeClass("uiframe-selectbox-text-click");
                $("#${id}").next("input").removeClass("uiframe-selBtn-click");
            }
        });
        //键盘UP监听事件
        widget.hotKey.regist($("#writeCombox_select${id}"+<%=uuid%>),widget.hotKey.UP,function(){
            var showDiv = $("#writeSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#writeCombox_ul_${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
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
        widget.hotKey.regist($("#writeCombox_select${id}"+<%=uuid%>),widget.hotKey.DOWN,function(){
            var showDiv = $("#writeSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#writeCombox_ul_${id}"+<%=uuid%>);                                     //下拉框中显示div的jQuery对象
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
        widget.hotKey.regist($("#writeCombox_select${id}"+<%=uuid%>),widget.hotKey.ENTER,function(){
            var showDiv = $("#writeSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#writeCombox_ul_${id}"+<%=uuid%>);                                    //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                var myTr = listDiv.find("li.uiframe-hover");
                myTr.trigger("click");
                myTr.removeClass("uiframe-hover");
            } else {
                showDiv.show();
            }
        });
        //键盘ESC监听事件
        widget.hotKey.regist($("#writeCombox_select${id}"+<%=uuid%>),widget.hotKey.ESC,function(){
            var showDiv = $("#writeSelect_div_${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#writeCombox_ul_${id}"+<%=uuid%>);                 //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                $("#writeSelect_div_${id}"+<%=uuid%>).css("display", "none");
                $("#${id}").removeClass("uiframe-selectbox-text-click");
                $("#writeSelect_btn${id}"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            }
        });
        //事件
        $("#${id}").on("setValue",function(e,v){
            $("#writeSelect_div_${id}"+<%=uuid%>).find("li[val="+v+"]").trigger("click");
        });
        //取页面缓存值（滕维佳需求）
        $("#${id}").on("writeValue",function(e,v){
            $(this).val(v);
            $("#${id}" + <%=uuid%>).val(v);
        });
        //为此组件id绑定只读方法
        $("#${id}").on("readonly", function () {
            $("#writeSelect_btn${id}"+<%=uuid%>).off("click");
        });
        //为此组件id绑定取消只读方法
        $("#${id}").on("unreadonly", function () {
            $("#writeSelect_btn${id}"+<%=uuid%>).off("mouseover");
            $("#writeSelect_btn${id}"+<%=uuid%>).off("mouseout");
            writeComboxSelect${id}<%=uuid%>.setClick();
        });
        //禁用
        $("#${id}").on("disabled",function(){
            $("#${id}").attr("disabled",true).addClass("uiframe-textinput-disabled");
            $("#writeSelect_btn${id}"+<%=uuid%>).off("mouseover");
            $("#writeSelect_btn${id}"+<%=uuid%>).off("mouseout");
            $("#writeSelect_btn${id}"+<%=uuid%>).off("click");
        });
        //取消禁用
        $("#${id}").on("enable",function(){
            $("#${id}").removeAttr("disabled").removeClass("uiframe-textinput-disabled");
            writeComboxSelect${id}<%=uuid%>.setClick();
        });
        //清空
        $("#${id}").on("clearValue",function(){
            $(this).val("");
            $("#${id}").val($("#<%=id%>").attr("emptytext")||"");
            $("#${id}").addClass("uiframe-emptyTextColor");
        });
        //判断谷歌浏览器
        if(widget.browser.isChrome()){
            $("#writeCombox_select${id}"+<%=uuid%>).width($("#writeSelect_div_${id}"+<%=uuid%>).width() + 6);
        }
    };
    writeCombox.orderNumber=46;
    executeQueue.push(writeCombox);
})();
</script>
<div id="writeCombox_select${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="text" id="${id}" <%=name%> style="width: <%=w-22%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="<%=valueText%>" <%if(readOnlyFlag){%> readonly="readonly" <%}%> class="uiframe-writeSelect-text <%=disableInputClass%> <%=cls%>">
    <span type="button" id="writeSelect_btn${id}<%=uuid%>" class="uiframe-form-btnClick uiframe-selBtn"></span>
    <div id="writeSelect_div_${id}<%=uuid%>" class="uiframe-selectbox-wrapper uiframe-selectHide" style="width: <%=(w+10)%>px;*-width:<%=w%>px;*margin-left: -<%=w+12%>px;">
        <div id="writeCombox_ul_${id}<%=uuid%>" style="width: <%=(w+10)%>px;*-width:<%=w%>px;overflow-y: auto;">
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
        <div class="uiframe-select-bbar" id="dataNone${id}" style="display: none;padding-left: 8px;*-width:<%=(w+2)%>px">无数据</div>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -20px 0 0 <%=w+16%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>
