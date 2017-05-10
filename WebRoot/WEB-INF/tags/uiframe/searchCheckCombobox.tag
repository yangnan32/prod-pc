<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-4-11上午9:24
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="true" description="控件下拉框name,后台根据name获取选择的值，必填" %>
<%@attribute name="columns" rtexprvalue="true" required="true" description="控件列名,必填" %>
<%@attribute name="key" rtexprvalue="true" required="true" description="搜索列传的值,必填" %>
<%@attribute name="value" rtexprvalue="true" required="false" description="下拉列表对应的value值" %>
<%@attribute name="searchUrl" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="data" rtexprvalue="true" type="java.lang.String" required="true" description="data 查询条件,必填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="toolPage" rtexprvalue="true" required="false" description="翻页工具栏" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="每页显示条数" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="textAlign" rtexprvalue="true"  required="false" description="下拉框内容对齐方式" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件样式class名称" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="searchable" rtexprvalue="true"  required="false" description="true或false，默认true" %>


<%
    long uuid=new Date().getTime();
    String disableText="";
    String readonlyText="";
    String editFalseCls="";
    String editFlagText = "false";
    String disableInputClass="";
    String disableBtnClass="";
    String valueText="";
    String nameText="";
    String toolPageText="";
    String textAlignk="";
    String searchableText="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        disableBtnClass="uiframe-selBtn-disabled";
        disableInputClass="uiframe-textinput-disabled";
    }
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonlyText="readonly='readonly'";
        readonly="true";
    } else {
        readonlyText="";
        readonly="false";
    }
    if(StringUtils.isNotEmpty(searchable) && searchable.equalsIgnoreCase("false")){
        searchableText="readonly='readonly'";
        editFlagText = "true";
        editFalseCls = "uiframe-pointer";
    } else {
        searchableText ="";
    }
    if(StringUtils.isNotEmpty(toolPage) && toolPage.equalsIgnoreCase("false")){
        toolPageText="style='display:none'";
    }
    if(StringUtils.isNotBlank(textAlign)){
        textAlignk="text-align:"+textAlign+"";
    }else {
        textAlignk="text-align:left";
    }
    if(StringUtils.isNotBlank(value)){
        valueText="value='"+value+"'";
    }else {
        valueText="";
    }
    if(StringUtils.isNotBlank(name)){
        nameText="name='"+name+"'";
    }else {
        nameText="";
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
var searchCheckSelect<%=id%><%=uuid%> = {
    searchName: "",                //load搜索条件
    recordPage: 5,                 //每页显示条数
    totalPage: "",                 //显示总页数
    selectData: "",                //加载的数据
    totalCount: "",                //数据总条数
    start: 0,                       //开始条数
    startPage: 1,                  //开始页数
    changeUrl:"<%=searchUrl%>",   //修改时传的url
    textval : "",                  //text显示值
    selectedValArray : [],         //value真实值
    showY : 0                       //显示数据Y轴距离
};
//每页显示条目
if(!<%=limit%>) {
    searchCheckSelect<%=id%><%=uuid%>.recordPage=5;
}else{
    searchCheckSelect<%=id%><%=uuid%>.recordPage = "<%=limit%>"
}
//加载数据方法
searchCheckSelect<%=id%><%=uuid%>.loadajax_search = function(){
    var hidevalue = $("#${id}").val();
    var columns= <%=columns%>;
    var columnlength = <%=columns%>.length;
    searchCheckSelect<%=id%><%=uuid%>.search_name = "<%=data%>="+searchCheckSelect<%=id%><%=uuid%>.searchName;
    $.ajax({
        type: "POST",
        url: searchCheckSelect<%=id%><%=uuid%>.changeUrl,
        dataType: "json",
        data:searchCheckSelect<%=id%><%=uuid%>.search_name+'&start='+searchCheckSelect<%=id%><%=uuid%>.start+'&limit='+searchCheckSelect<%=id%><%=uuid%>.recordPage,
        success:function(data_name){
            if(data_name){
                var data=data_name.<%=dataRoot%>;
                if(data==undefined){return;}
                searchCheckSelect<%=id%><%=uuid%>.totalCount = data.recordtotal||0;
                searchCheckSelect<%=id%><%=uuid%>.selectData = data.resultSet||[];
            }
            var table=$("#select_table_main${id}");
            table.find("tbody").empty();       //清空数据
            var tdW = $("#select_div<%=id%>"+<%=uuid%>).width()/columnlength -12;
            for(var i=0;i<searchCheckSelect<%=id%><%=uuid%>.selectData.length;i++){
                var record=searchCheckSelect<%=id%><%=uuid%>.selectData[i];
                if(record){
                    var tr=$('<tr class="click-ajax-tr"></tr>');
                    for(var k=0;k<columnlength;k++){
                        var column=columns[k];
                        var dataIndex=column.dataIndex;
                        var showValue=column.showValue;
                        var data=record[dataIndex]||"";
                        if(showValue==true){
                            var columnKey=record["<%=key%>"];
                            tr.append('<td style="<%=textAlignk%>" value="'+columnKey+'" class="search<%=id%><%=uuid%>"><div class="uiframe-searchCombo-td" style="width:'+tdW+'px;">'+data+"["+columnKey+"]"+'</div></td>');
                        } else{
                            tr.append('<td style="<%=textAlignk%>"><div class="uiframe-searchCombo-td" style="width:'+tdW+'px;">'+data+'</div></td>');
                        }
                    }
                    table.append(tr);
                }
            }
            searchCheckSelect<%=id%><%=uuid%>.totalPage = Math.ceil(searchCheckSelect<%=id%><%=uuid%>.totalCount/searchCheckSelect<%=id%><%=uuid%>.recordPage);
            $("#page${id}").text(searchCheckSelect<%=id%><%=uuid%>.startPage);
            $("#totalpage${id}").text(searchCheckSelect<%=id%><%=uuid%>.totalPage);
            if(searchCheckSelect<%=id%><%=uuid%>.totalCount <= searchCheckSelect<%=id%><%=uuid%>.recordPage){
                $("#toolBarRight${id}").hide();
            } else {
                $("#toolBarRight${id}").show();
            }
            if(searchCheckSelect<%=id%><%=uuid%>.totalPage == 0){
                $("#select_bbar${id}").hide();
                $("#dataNone${id}").show();
                $("#page${id}").text("0");
            }  else {
                $("#dataNone${id}").hide();
                $("#select_bbar${id}").show();
                if(searchCheckSelect<%=id%><%=uuid%>.startPage == searchCheckSelect<%=id%><%=uuid%>.totalPage){
                    $("#next${id}").attr("disabled","disabled").removeClass("uiframe-module-btn-hover");
                }else{
                    $("#next${id}").removeAttr("disabled","disabled");
                }
            }
            if(searchCheckSelect<%=id%><%=uuid%>.startPage == 1){
                $("#prev${id}").attr("disabled","disabled").removeClass("uiframe-module-btn-hover");
            }else{
                $("#prev${id}").removeAttr("disabled","disabled");
            }
            $("#select_table_main${id}").find("td").each( function () {
                var get_value = $(this).attr("value");
                if (get_value == hidevalue) {
                    $(this).parent("tr").addClass("uiframe-selected");
                }
            });
            //判断下拉列表显示文本上方或下方
            var showH = $("#select_div<%=id%>"+<%=uuid%>).height();
            var win = $("#search_select<%=id%>"+<%=uuid%>).parents("div.uiframe-win");
            var winH = win.height() - 77;
            var winTop = parseInt(win.css("top"));
            if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
                var topSelect = $("#search_select${id}"+<%=uuid%>).position().top + 1;
                if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                    if(searchCheckSelect<%=id%><%=uuid%>.showY + showH - 16 - winTop > winH){
                        $("#select_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                    } else {
                        $("#select_div${id}"+<%=uuid%>).css("top", topSelect + 22);
                    }
                } else {
                    if(searchCheckSelect<%=id%><%=uuid%>.showY + showH + 30 > $(window).height()){
                        $("#select_div${id}"+<%=uuid%>).css("top", topSelect - showH);
                    } else {
                        $("#select_div${id}"+<%=uuid%>).css("top", topSelect + 22);
                    }
                }
            } else {
                if(win.attr("winwin") === "window" && showH < winH) { //todo  if(win.attr("winw") === "window")
                    if(searchCheckSelect<%=id%><%=uuid%>.showY + showH - 16 > winH){
                        $("#select_div${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                    } else {
                        $("#select_div${id}"+<%=uuid%>).css("margin-top", "22px");
                    }
                } else {
                    if(searchCheckSelect<%=id%><%=uuid%>.showY + showH + winTop + 30 > $(window).height()){
                        $("#select_div${id}"+<%=uuid%>).css("margin-top", -(showH + 1));
                    } else {
                        $("#select_div${id}"+<%=uuid%>).css("margin-top", "22px");
                    }
                }
            }
            $("#select_div<%=id%>"+<%=uuid%>).show();
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){

        }
    });
};
//只读方法
searchCheckSelect<%=id%><%=uuid%>.readonly = function (id) {
    $("#"+id).attr("readonly", "readonly");
    $("#btn"+id+<%=uuid%>).off("click");
};
//取消只读方法
searchCheckSelect<%=id%><%=uuid%>.unreadonly = function (id) {
    $("#"+id).removeAttr("readonly", "readonly");
    $("#btn"+id+<%=uuid%>).off("mouseover");
    $("#btn"+id+<%=uuid%>).off("mouseout");
    searchCheckSelect${id}<%=uuid%>.setClick();
};
//禁用方法
searchCheckSelect<%=id%><%=uuid%>.disabled = function (id) {
    $("#"+id).attr("disabled", "disabled").addClass("uiframe-selectbox-text-disabled");
    $("#btn"+id+<%=uuid%>).off("mouseover");
    $("#btn"+id+<%=uuid%>).off("mouseout");
    $("#btn"+id+<%=uuid%>).off("click");
};
//取消禁用方法
searchCheckSelect<%=id%><%=uuid%>.enabled = function (id) {
    $("#"+id).removeAttr("disabled").removeClass("uiframe-selectbox-text-disabled");
    searchCheckSelect${id}<%=uuid%>.setClick();
};
//清空value方法
searchCheckSelect<%=id%><%=uuid%>.clearValue = function (id) {
    $("#"+id).val("");
    searchCheckSelect<%=id%><%=uuid%>.selectedValArray = [];
    $("#${id}").addClass("uiframe-emptyTextColor");
};
//修改url地址
searchCheckSelect<%=id%><%=uuid%>.setUrl = function (newurl) {
    searchCheckSelect<%=id%><%=uuid%>.changeUrl = newurl;
};
//下拉按钮绑定事件
searchCheckSelect${id}<%=uuid%>.setClick = function(){
    $("#btn<%=id%>"+<%=uuid%>).on("mouseover" , function () {
        $(this).prev("input").addClass("uiframe-selectbox-text-hover");
        $(this).addClass("uiframe-selBtn-hover");
    });
    $("#btn<%=id%>"+<%=uuid%>).on("mouseout" , function () {
        $(this).prev("input").removeClass("uiframe-selectbox-text-hover");
        $(this).removeClass("uiframe-selBtn-hover");
    });
    if("<%=readonly%>" !== "true"){
        $("#btn<%=id%>"+<%=uuid%>).bind("click",function(e){
            $(this).prev("input").focus();
            var table_s = $("#select_div<%=id%>"+<%=uuid%>).css('display');
            searchCheckSelect<%=id%><%=uuid%>.startPage = 1;
            searchCheckSelect<%=id%><%=uuid%>.start = 0;
            if(table_s=="none") {
                searchCheckSelect<%=id%><%=uuid%>.showY = e.pageY;
                $("#${id}").addClass("uiframe-selectbox-text-click");
                $("#btn<%=id%>"+<%=uuid%>).addClass("uiframe-selBtn-click");
                $("#select_div<%=id%>"+<%=uuid%>).css("z-index",sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $("#select_table_main${id}").find("tbody").empty();       //清空数据
                searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
            }else{
                $("#select_div<%=id%>"+<%=uuid%>).hide();
                $("#${id}").removeClass("uiframe-selectbox-text-click");
                $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            }
            return false;
        }) ;
    }
    if("<%=editFlagText%>" == "true"){
        $("#${id}").bind("click",function(e){
            $(this).focus();
            var table_s = $("#select_div<%=id%>"+<%=uuid%>).css('display');
            searchCheckSelect<%=id%><%=uuid%>.startPage = 1;
            searchCheckSelect<%=id%><%=uuid%>.start = 0;
            if(table_s=="none") {
                searchCheckSelect<%=id%><%=uuid%>.showY = e.pageY;
                $("#${id}").addClass("uiframe-selectbox-text-click");
                $("#btn<%=id%>"+<%=uuid%>).addClass("uiframe-selBtn-click");
                $("#select_div<%=id%>"+<%=uuid%>).css("z-index",sywFunction.selection_zindex);
                sywFunction.selection_zindex++;
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                $("#select_table_main${id}").find("tbody").empty();       //清空数据
                searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
            }else{
                $("#select_div<%=id%>"+<%=uuid%>).hide();
                $("#${id}").removeClass("uiframe-selectbox-text-click");
                $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            }
            return false;
        }) ;
    }
};
//获取选中数据数组，并缓存到“getDate”上
searchCheckSelect${id}<%=uuid%>.getDate = function () {
    var val = $("#${id}").val().split(";");
    var dataKey = [];
    var dataValue = [];
    for(var i = 0;i < val.length;i++){
        if(val[i]!=undefined && val[i] !=""){
            var keyArray = val[i].split("[");
            var key = keyArray[keyArray.length - 1].replace("]","");
            dataKey.push(key);
            dataValue.push(keyArray[0]);
        }
    }
    $("#${id}").removeData("getKeyData");
    $("#${id}").removeData("getValueData");
    $("#${id}").data("getKeyData", dataKey);
    $("#${id}").data("getValueData", dataValue);
};
(function(){
    var searchCombox=function(){

        //搜索下拉框划过样式脚本
        $('#select_table_main${id} tr').live("mouseover", function () {
            $(this).addClass('uiframe-hover');
            $(this).siblings("tr").removeClass("uiframe-hover");
        });
        $('#select_table_main${id} tr').live("mouseout", function () {
            $(this).removeClass('uiframe-hover');
        });
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
            searchCheckSelect${id}<%=uuid%>.setClick();
        }
        //文本框出现光标时执行脚本
        $("#${id}").bind("focus", function () {
            $(this).addClass("uiframe-selectbox-text-click");
            $(this).next("span").addClass("uiframe-selBtn-click");
            $(this).removeClass("uiframe-emptyTextColor");
            //搜索过滤
            if ($(this).attr("readonly") == "readonly" || $(this).attr("readonly") == "") {
            }else {
                //给文本框绑定键盘点击事件
                $(this).bind("keyup", function (e) {
                    if(e.keyCode === 40 || e.keyCode === 39 ||e.keyCode === 38 || e.keyCode === 37 || e.keyCode === 27 || e.keyCode === 13 ) return;
                    $("#select_div<%=id%>"+<%=uuid%>).css("z-index",sywFunction.selection_zindex);
                    sywFunction.selection_zindex++;
                    var valArray =  $(this).val().split(";");
                    searchCheckSelect<%=id%><%=uuid%>.searchName = valArray[valArray.length-1];
                    searchCheckSelect<%=id%><%=uuid%>.startPage = 1;
                    searchCheckSelect<%=id%><%=uuid%>.start = 0;
                    if(valArray[valArray.length-1] !== ""){
                        searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
                    }
                });
            }
        });
        //文本框光标消失时执行脚本
        $("#${id}").bind("blur", function () {
            $(this).removeClass("uiframe-selectbox-text-click");
            $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            //移除文本框绑定键盘点击事件
            $(this).unbind("keyup");
        });
        //键盘UP监听事件
        widget.hotKey.regist($("#search_select${id}"+<%=uuid%>),widget.hotKey.UP,function(){
            var showDiv = $("#select_div${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#select_table_mainDiv${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                if(listDiv.find("tr.uiframe-hover").length === 1){
                    var myTr = listDiv.find("tr.uiframe-hover");
                    myTr.removeClass("uiframe-hover");
                    if(myTr.prev("tr").length === 0) {
                        listDiv.find("tr:last").addClass("uiframe-hover");
                        listDiv.find("tr:last").focus();
                    } else {
                        myTr.prev("tr").addClass("uiframe-hover");
                        myTr.next("tr").focus();
                    }
                }
            }
        });
        //键盘DOWN监听事件
        widget.hotKey.regist($("#search_select${id}"+<%=uuid%>),widget.hotKey.DOWN,function(){
            var showDiv = $("#select_div${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#select_table_mainDiv${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                if(listDiv.find("tr.uiframe-hover").length === 0){
                    listDiv.find("tr:first").addClass("uiframe-hover");
                } else if(listDiv.find("tr.uiframe-hover").length === 1){
                    var myTr = listDiv.find("tr.uiframe-hover");
                    myTr.removeClass("uiframe-hover");
                    if(myTr.next("tr").length === 0) {
                        listDiv.find("tr:first").addClass("uiframe-hover");
                        listDiv.find("tr:first").focus();
                    } else {
                        myTr.next("tr").addClass("uiframe-hover");
                        myTr.next("tr").focus();
                    }
                }
            }
        });
        //键盘ENTER监听事件
        widget.hotKey.regist($("#search_select${id}"+<%=uuid%>),widget.hotKey.ENTER,function(){
            var showDiv = $("#select_div${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#select_table_mainDiv${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                var myTr = listDiv.find("tr.uiframe-hover");
                myTr.trigger("click");
                myTr.removeClass("uiframe-hover");
            }  else {
                showDiv.show();
            }
        });
        //键盘ESC监听事件
        widget.hotKey.regist($("#search_select${id}"+<%=uuid%>),widget.hotKey.ESC,function(){
            var showDiv = $("#select_div${id}"+<%=uuid%>);                    //下拉框中显示div的jQuery对象
            var listDiv = $("#select_table_mainDiv${id}"+<%=uuid%>);         //下拉框中显示div的jQuery对象
            if(showDiv.css('display') !== "none"){
                $("#select_div<%=id%>"+<%=uuid%>).hide();
                $("#${id}").removeClass("uiframe-selectbox-text-click");
                $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            }
        });
        //上一页按钮绑定事件
        $("#prev${id}").bind("click",function(){
            var nowPage = parseInt(searchCheckSelect<%=id%><%=uuid%>.startPage);
            var prevPage =nowPage-1;
            searchCheckSelect<%=id%><%=uuid%>.startPage=""+prevPage;
            searchCheckSelect<%=id%><%=uuid%>.start = (prevPage-1)*searchCheckSelect<%=id%><%=uuid%>.recordPage;
            searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
        });
        //下一页按钮绑定事件
        $("#next${id}").bind("click",function(){
            var nowPage = parseInt(searchCheckSelect<%=id%><%=uuid%>.startPage);
            var nextPage =nowPage+1;
            searchCheckSelect<%=id%><%=uuid%>.startPage=""+nextPage;
            searchCheckSelect<%=id%><%=uuid%>.start = (nextPage-1)*searchCheckSelect<%=id%><%=uuid%>.recordPage;
            searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
        });
        //第一页按钮绑定事件
        $("#first${id}").bind("click",function(){
            searchCheckSelect<%=id%><%=uuid%>.startPage = 1;
            searchCheckSelect<%=id%><%=uuid%>.start = 0;
            searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
        });
        //最后一页按钮绑定事件
        $("#last${id}").bind("click",function(){
            searchCheckSelect<%=id%><%=uuid%>.startPage = searchCheckSelect<%=id%><%=uuid%>.totalPage;
            searchCheckSelect<%=id%><%=uuid%>.start = (searchCheckSelect<%=id%><%=uuid%>.totalPage-1)*searchCheckSelect<%=id%><%=uuid%>.recordPage;
            searchCheckSelect<%=id%><%=uuid%>.loadajax_search();
        });
        //tr点击选中事件
        $("#search_select<%=id%>"+<%=uuid%>).find("tr.click-ajax-tr").live("click", function () {
            var val = $(this).children(".search<%=id%>"+<%=uuid%>).text()+";";
            $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
            $("#select_div${id}"+<%=uuid%>).hide();
            //为此组件id绑定change事件
            <%--$("#${id}").trigger("change",[searchCheckSelect<%=id%><%=uuid%>.selectedValArray]);--%>
            $("#${id}").focus();              //解决ie6下选中出现虚框问题
            var myVal = $("#${id}").val().split(";");
            myVal[myVal.length-1] = val;
            $("#${id}").val(myVal.join(";"));
            $("#${id}").removeClass("uiframe-selectbox-text-click");
            $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            $("#${id}").removeClass("uiframe-emptyTextColor").removeClass("error");
            $("#${id}").next("label.error").remove();
            searchCheckSelect${id}<%=uuid%>.getDate();
        });
        //清空按钮绑定事件
        $("#clearBtn<%=id%>"+<%=uuid%>).on("click", function () {
            <%--$("#${id}").trigger("change",[val]);--%>
            $("#${id}").focus();              //解决ie6下选中出现虚框问题
            $("#${id}").val("");
            $("#select_table_main${id}").find("tr").removeClass("uiframe-selected");
            $("#${id}").addClass("uiframe-emptyTextColor").removeClass("uiframe-selectbox-text-click");
            $("#select_div<%=id%>"+<%=uuid%>).hide();
            $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
            searchCheckSelect${id}<%=uuid%>.getDate();
        });
        //点击下拉框之外的元素，下拉列表隐藏
        $("body").on("click", function () {
            $("#search_select<%=id%>"+<%=uuid%>).find(".uiframe-selectbox-ajax").each(function () {
                if ($(this).css("display") === "block") {
                    $(this).hide();
                    $("#${id}").removeClass("uiframe-selectbox-text-click");
                    $("#btn<%=id%>"+<%=uuid%>).removeClass("uiframe-selBtn-click");
                }
            });
            searchCheckSelect<%=id%><%=uuid%>.searchName="";
            $("#first${id}").trigger("click");
        });
        $("#search_select<%=id%>"+<%=uuid%>).find(".uiframe-select-bbar").on("click", function (event) {
            event.stopPropagation();
        });
        //为此组件id绑定只读方法
        $("#${id}").on("readonly", function () {
            searchCheckSelect<%=id%><%=uuid%>.readonly("${id}");
        });
        //为此组件id绑定取消只读方法
        $("#${id}").on("unreadonly", function () {
            searchCheckSelect<%=id%><%=uuid%>.unreadonly("${id}");
        });
        //为此组件id绑定禁用方法
        $("#${id}").on("disabled", function () {
            searchCheckSelect<%=id%><%=uuid%>.disabled("${id}");
        });
        //为此组件id绑定取消禁用方法
        $("#${id}").on("enabled", function () {
            searchCheckSelect<%=id%><%=uuid%>.enabled("${id}");
        });
        //为此组件id绑定更换url方法
        $("#${id}").on("setUrl", function (event,url) {
            searchCheckSelect<%=id%><%=uuid%>.setUrl(url);
        });
        //为此组件id绑定清空value方法
        $("#${id}").on("clearValue", function (event,url) {
            searchCheckSelect<%=id%><%=uuid%>.clearValue("${id}");
        });
        //判断谷歌浏览器
        if(widget.browser.isChrome()){
            $("#search_select${id}"+<%=uuid%>).width($("#select_div${id}"+<%=uuid%>).width() + 6);
        }
    };
    searchCombox.orderNumber=43;
    executeQueue.push(searchCombox);
})();
</script>
<div class="uiframe-mainCon" id="search_select<%=id%><%=uuid%>">
    <input type="text" id="${id}" <%=valueText%> <%=nameText%> <%=searchableText%> <%=disableText%> <%=readonlyText%> class="uiframe-selectbox-text-ajax <%=disableInputClass%> <%=cls%> <%=editFalseCls%>" style="width:<%=(w-22)%>px;">
    <span id="btn<%=id%><%=uuid%>" class="uiframe-form-btnClick uiframe-selBtn-ajax"></span>
    <div id="select_div<%=id%><%=uuid%>" class="uiframe-selectbox-ajax uiframe-selectHide" style="width: <%=w+10%>px;*margin-left: -<%=w+12%>px">
        <div id="select_table_mainDiv${id}<%=uuid%>" style="overflow-y: auto;overflow-x: hidden;">
            <table class="uiframe-ajax-content" id="select_table_main${id}">
            </table>
        </div>
        <div class="uiframe-select-bbar" id="select_bbar${id}" <%=toolPageText%>>
            <div style="float: left;margin-top: 1px;">
                <table>
                    <tr>
                        <td class="uiframe-grid-span"></td>
                        <td><input type="button" class="uiframe-module-btn" id="clearBtn<%=id%><%=uuid%>" style="padding: 0;" value="清空"></td>
                        <td class="uiframe-grid-span"></td>
                    </tr>
                </table>
            </div>
            <div style="float: right;" id="toolBarRight${id}">
                <table>
                    <tr>
                        <td><span id="page${id}"></span></td>
                        <td style="line-height:18px;">/</td>
                        <td><span id="totalpage${id}"></span></td>
                        <td><div class="uiframe-grid-span"></div></td>
                        <td style="line-height:18px;"><div style="_padding-top: 4px;">页</div></td>
                        <td><div class="uiframe-grid-span"></div></td>
                        <td><input type="button" class="uiframe-module-btn" id="prev${id}" style="padding: 0;" value="上一页"><%--上一页--%></td>
                        <td><div class="uiframe-grid-span"></div></td>
                        <td><input type="button" class="uiframe-module-btn" id="next${id}" style="padding: 0;" value="下一页"><%--下一页--%></td>
                        <td class="uiframe-grid-span"></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="uiframe-select-bbar" id="dataNone${id}" style="display: none;padding-left: 8px;">无数据</div>
    </div>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <div class="mustWrite" style="float: left;margin: -20px 0 0 <%=w+16%>px;*-float:none;*-margin:0;">*</div>
    </c:when>
</c:choose>