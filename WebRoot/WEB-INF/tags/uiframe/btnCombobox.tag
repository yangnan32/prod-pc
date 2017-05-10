<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-8-11上午9:44
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
<%@attribute name="iconCls" rtexprvalue="true"  required="false" description="图标样式代码" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="name" rtexprvalue="true"  required="true" description="控件下拉框name,后台根据name获取选择的值，必填" %>
<%@attribute name="btnTitle" rtexprvalue="true" required="true" description="按钮名称" %>
<%@attribute name="url" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="param" rtexprvalue="true"  required="false" description="加载数据的参数" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件样式class名称" %>

<%

    long uuid=new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    String fontText="";
    String nameText="";
    String paramText="";
    String btnText="";

    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        btnText = "uiframe-toolbarBtn-disabled";
    } else {
        disableText="";
        btnText = "uiframe-toolbarHover";
    }
    if(StringUtils.isNotEmpty(param)){
    	paramText= param;
    } else {
    	paramText="";
    }
    if(StringUtils.isNotBlank(name)){
        nameText="name='"+name+"'";
    }else {
        nameText="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="100";
    }
    float w=100;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=100;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="260";
    }
    float h=260;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=260;
    }

%>
<script type="text/javascript">
var btnSelect<%=id%><%=uuid%> = {
    selectName: {<%=paramText%>},                //load条件
    selectData: "",                //加载的数据
    changeUrl:"<%=url%>",   //修改时传的url
    textval : "",                  //text显示值
    selectval : ""                 //value真实值
};
//加载数据方法
btnSelect<%=id%><%=uuid%>.loadajax = function(){
    $.ajax({
        type: "POST",
        url: btnSelect<%=id%><%=uuid%>.changeUrl,
        dataType: "json",
        data:btnSelect<%=id%><%=uuid%>.selectName,
        success:function(data_name){
            if(data_name){
                var data=data_name.<%=dataRoot%>;
                if(data==undefined){return;}
                btnSelect<%=id%><%=uuid%>.selectData = data.resultSet||[];
            }
            var ulDiv=$("#btnSelect_div_${id}"+<%=uuid%>);
            ulDiv.empty();       //清空数据
            var ul=$('<ul></ul>');
            if(<%=height%>){
                var maxHeight = <%=height%>;
                var trueHeight = 26 * btnSelect<%=id%><%=uuid%>.selectData.length;
                if(trueHeight > maxHeight){
                    $("#btnSelect_div_${id}"+<%=uuid%>).height(maxHeight)
                }
            }
            for(var i=0;i<btnSelect<%=id%><%=uuid%>.selectData.length;i++){
                var record=btnSelect<%=id%><%=uuid%>.selectData[i];
                if(record){
                    var key=record["key"]||"";
                    var value=record["value"]||"";
                    ul.append('<li class="click-option" val="' + key + '">'+value+'</li>');
                }
            ulDiv.append(ul);
            }
            if(btnSelect<%=id%><%=uuid%>.selectData && btnSelect<%=id%><%=uuid%>.selectData.length != 0){
                $("#btnCombox${id}"+<%=uuid%>).off("click");
                $("#btnComboxIcon${id}"+<%=uuid%>).off("click");
                btnSelect<%=id%><%=uuid%>.setClick();
                if($("#menu${id}").hasClass("uiframe-toolbarBtn-disabled")){
                    $("#menu${id}").removeClass("uiframe-toolbarBtn-disabled").addClass("uiframe-toolbarHover");
                }
            } else {
                $("#btnCombox${id}"+<%=uuid%>).off("click");
                $("#btnComboxIcon${id}"+<%=uuid%>).off("click");
                if(!$("#menu${id}").hasClass("uiframe-toolbarBtn-disabled")){
                    $("#menu${id}").addClass("uiframe-toolbarBtn-disabled").removeClass("uiframe-toolbarHover");
                }
            }
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){

        }
    });
};
//修改url地址
btnSelect<%=id%><%=uuid%>.setUrl = function (newurl) {
    btnSelect<%=id%><%=uuid%>.changeUrl = newurl;
    btnSelect<%=id%><%=uuid%>.loadajax();
};
//修改url加载条件
btnSelect<%=id%><%=uuid%>.setUrlParams = function (newparams) {
    btnSelect<%=id%><%=uuid%>.selectName = newparams;
    btnSelect<%=id%><%=uuid%>.loadajax();
};
//下拉按钮绑定事件
btnSelect<%=id%><%=uuid%>.setClick = function(){
    $("#btnCombox<%=id%>"+<%=uuid%>).on("click",function(){
        var table_s = $("#btnCombox_div<%=id%>"+<%=uuid%>).css('display');
        if(table_s=="none") {
            $("#btnCombox_div<%=id%>"+<%=uuid%>).css("z-index",sywFunction.selection_zindex);
            sywFunction.selection_zindex++;
            $("#body").find("div.uiframe-selectHide").each(function(){
                $(this).hide();//隐藏所有下拉框显示框
            });
            $("#btnCombox_div<%=id%>"+<%=uuid%>).show();
        }else{
            $("#btnCombox_div<%=id%>"+<%=uuid%>).hide();
        }
        return false;
    }) ;
    $("#btnComboxIcon<%=id%>"+<%=uuid%>).on("click",function(){
        var table_s = $("#btnCombox_div<%=id%>"+<%=uuid%>).css('display');
        if(table_s=="none") {
            $("#btnCombox_div<%=id%>"+<%=uuid%>).css("z-index",sywFunction.selection_zindex);
            sywFunction.selection_zindex++;
            $("#btnCombox_div<%=id%>"+<%=uuid%>).show();
        }else{
            $("#btnCombox_div<%=id%>"+<%=uuid%>).hide();
        }
        return false;
    }) ;
};
(function(){
    var btnCombox=function(){
        btnSelect<%=id%><%=uuid%>.loadajax();
        //下拉列表赋值操作
            $("#btnSelect_div_${id}"+<%=uuid%>).find(".click-option").live("click", function () {
                $(this).addClass('uiframe-selected').siblings().removeClass('uiframe-selected');
                var text = $(this).text();
                var val = $(this).attr("val");
                $("#${id}").val(val);
                $("#${id}").attr("text", text);
                //为此组件id绑定点击tr时的方法
                $("#${id}").trigger("change",[val,text]);
            });
        //清空按钮绑定事件
        $("#clearBtn<%=id%>"+<%=uuid%>).on("click", function () {
            var text = "";
            var val = "";
            $("#{id}").val("");
            $("#${id}").attr("text", "");
            $("#btnCombox_div<%=id%>"+<%=uuid%>).hide();
            $("#${id}").trigger("change",[val,text]);
        });
        //点击下拉框之外的元素，下拉列表隐藏
        $("body").on("click", function () {
            $("#btnCombox_div<%=id%>"+<%=uuid%>).each(function () {
                if ($(this).css("display") === "block") {
                    $(this).hide();
                }
            });
        });
        //禁用
        $("#${id}").on("disabled",function(){
            $("#btnCombox${id}"+<%=uuid%>).attr("disabled", "disabled").addClass("uiframe-emptyTextColor");
            $("#btnComboxIcon${id}"+<%=uuid%>).attr("disabled", "disabled").addClass("uiframe-emptyTextColor");
            $("#menu${id}").removeClass("uiframe-toolbarHover").addClass("uiframe-toolbarBtn-disabled");
        });
        //取消禁用
        $("#${id}").on("enable",function(){
            $("#btnCombox${id}"+<%=uuid%>).removeAttr("disabled").removeClass("uiframe-emptyTextColor");
            $("#btnComboxIcon${id}"+<%=uuid%>).next("button").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
            $("#menu${id}").removeClass("uiframe-toolbarBtn-disabled").addClass("uiframe-toolbarHover");
        });
        if("<%=disabled%>" == "true"){   
        	//本页刷新时判断是否禁用
            $("#btnCombox${id}"+<%=uuid%>).attr("disabled", "disabled").addClass("uiframe-emptyTextColor");
            $("#btnComboxIcon${id}"+<%=uuid%>).attr("disabled", "disabled").addClass("uiframe-emptyTextColor");
            $("#menu${id}").removeClass("uiframe-toolbarHover").addClass("uiframe-toolbarBtn-disabled");
        }
        //清空
        $("#${id}").on("clearValue",function(){
            $("#${id}").val("");
            $("#${id}").attr("text","");
        });
        //为此组件id绑定更换url方法
        $("#${id}").on("setUrl", function (event,url) {
            btnSelect<%=id%><%=uuid%>.setUrl(url);
        });
        //为此组件id绑定更换urlParams方法
        $("#${id}").on("setUrlParams", function (event,newParams) {
            btnSelect<%=id%><%=uuid%>.setUrlParams(newParams);
        });
        $("#btnCombobox_${id}").live("keydown",function(e){
            var key= e.keyCode;
            /*switch (key){
                case 38:console.log(key);break;//up
                case 39:console.log(key);break;//right
                case 40:console.log(key);break;//down
                case 37:console.log(key);break;//left
            }*/
        });
        if($.browser.msie && $.browser.version==6){
            $("#btnCombox_div${id}"+<%=uuid%>).css("margin-left",-($("#menu${id}").width()));
        }
    };
    btnCombox.orderNumber=33;
    executeQueue.push(btnCombox);
})();
</script>
<span id="btnCombobox_${id}" class="uiframe-btnComboDiv">
    <input type="hidden" class="${group}" id="${id}" value="" text="" <%=nameText%> <%=disableText%> />
    <span class="<%=btnText%>" id="menu${id}">
        <div class="toolbar-left"></div>
        <div class="toolbar-center">
            <button id="btnCombox<%=id%><%=uuid%>" type="button" class="tool-button" style="text-align: left;" <%=disableText%> ><span class="uiframe-toolbarBtnIcon <%=iconCls%>">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=btnTitle%></button>
            <button type="button" class="uiframe-menu-overflow" id="btnComboxIcon<%=id%><%=uuid%>" <%=disableText%>> </button>
        </div>
        <div class="toolbar-right"></div>
    </span>
    <input type="hidden" class="${group}" id="${id}" value="" text="" <%=nameText%> <%=disableText%> />
    <div id="btnCombox_div<%=id%><%=uuid%>" class="uiframe-selectbox-wrapper uiframe-selectHide" style="width: <%=w%>px;*width:<%=w-12%>px;margin-top: 23px;border: 1px solid #c4c4c4;">
        <div id="btnSelect_div_${id}<%=uuid%>" style="overflow-y: auto;">
            <ul>
            </ul>
        </div>
    </div>
</span>