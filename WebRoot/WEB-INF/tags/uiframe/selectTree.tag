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
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载树数据的地址" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="nodeName" rtexprvalue="true"  required="false" description="树节点显示字段名称" %>
<%@attribute name="idKey" rtexprvalue="true"  required="false" description="树节点id" %>
<%@attribute name="pIdKey" rtexprvalue="true"  required="false" description="树父节点id" %>
<%@attribute name="text" rtexprvalue="true"  required="false" description="控件显示值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="是否只读,值为true或者false" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    long uuid = new Date().getTime();
    String disableText="";
    String disableBtnClass="";
    String disableInputClass="";
    String emptyTextk="";
    String heightText="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        disableBtnClass="uiframe-selBtn-disabled";
        disableInputClass="uiframe-textinput-disabled";
    }
    if(StringUtils.isNotBlank(emptyText)){
        emptyTextk="emptyText='"+emptyText+"'";
    }else {
        emptyTextk="";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(text==null||text.equalsIgnoreCase("")){
        text="";
    }
    if(nodeName==null||nodeName.equalsIgnoreCase("")){
        nodeName="text";
    }
    if(idKey==null||idKey.equalsIgnoreCase("")){
        idKey="id";
    }
    if(pIdKey==null||pIdKey.equalsIgnoreCase("")){
        pIdKey="id";
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
    if(height==null||height.equalsIgnoreCase("")){
        height="190";
    }
    float h=250;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=250;
    }
%>
<script type="text/javascript">
var comboxSelect${id}<%=uuid%> = {};

// 显示下拉内容方法
comboxSelect${id}<%=uuid%>.toggleMenu = function(e){
    if($("#<%=id%>TreeDiv").css("display") === "none") {
        var showH = $("#<%=id%>TreeDiv").height();
        var win = $("#<%=id%>Text").parents("div.uiframe-win");
        var winH = win.height() - 77;
        var winTop = parseInt(win.css("top"));
        if(widget.browser.isChrome() || widget.browser.iswidgetBrowser()){
            var topSelect = $("#<%=id%>Text").position().top;
            if(win.attr("winwin") === "window" && showH < winH) { //todo if(win.attr("winw") === "window")
                if(e.pageY + showH - 16 - winTop > winH){
                    $("#<%=id%>TreeDiv").css("top", topSelect - showH - 22);
                } else {
                    $("#<%=id%>TreeDiv").css("top", topSelect);
                }
            } else {
                if(e.pageY + showH + 30 > $(window).height()){
                    $("#<%=id%>TreeDiv").css("top", topSelect - showH -22);
                } else {
                    $("#<%=id%>TreeDiv").css("top", topSelect);
                }
            }
        } else {
            if(win.attr("winwin") === "window" && showH < winH) {//todo-hemq 这块代码跟上面todo中的功能重复 需重构
                if(e.pageY + showH - 16 - winTop > winH){
                    $("#<%=id%>TreeDiv").css("margin-top", -(showH + 1));
                } else {
                    $("#<%=id%>TreeDiv").css("margin-top", "22px");
                }
            } else {
                if(e.pageY + showH + 30 > $(window).height()){
                    $("#<%=id%>TreeDiv").css("margin-top", -(showH + 1));
                } else {
                    $("#<%=id%>TreeDiv").css("margin-top", "22px");
                }
            }
        }
        $("#<%=id%>Text").addClass("uiframe-selectbox-text-click");
        $("#<%=id%>Btn").addClass("uiframe-selBtn-click");
        $("#<%=id%>TreeDiv").css("z-index", sywFunction.selection_zindex);
        sywFunction.selection_zindex++;
        $("#body").find("div.uiframe-selectHide").each(function(){
            $(this).hide();//隐藏所有下拉框显示框
        });
        $("#<%=id%>TreeDiv").show();
        $("body").bind("mousedown", function(event){
            if (!(event.target.id == "<%=id%>Text" ||event.target.id == "<%=id%>Btn" || event.target.id == "<%=id%>TreeDiv" || $(event.target).parents("#<%=id%>TreeDiv").length>0)) {
                $("#<%=id%>TreeDiv").hide();
                $("body").unbind("mousedown");
            }
        });
    } else {
        comboxSelect${id}<%=uuid%>.hideMenu();
    }
    return false;
};

// 隐藏下拉内容方法
comboxSelect${id}<%=uuid%>.hideMenu = function(){
    $("#<%=id%>TreeDiv").hide();
    $("body").unbind("mousedown");
};

// 鼠标划上事件
comboxSelect${id}<%=uuid%>.onHover = function(){
    $("#<%=id%>Text").addClass("uiframe-selectbox-text-hover");
    $("#<%=id%>Btn").addClass("uiframe-selBtn-hover");
};
// 鼠标移走事件
comboxSelect${id}<%=uuid%>.outHover = function(){
    $("#<%=id%>Text").removeClass("uiframe-selectbox-text-hover");
    $("#<%=id%>Btn").removeClass("uiframe-selBtn-hover");
};

(function(){
    var combox=function(){

        // 水印文字脚本
        if ($("#<%=id%>Text").attr("emptyText") !== undefined && $("#<%=id%>Text").val() == "") {
            $("#<%=id%>Text").val($("#<%=id%>Text").attr("emptyText")).addClass("uiframe-emptyTextColor");
        }

        // 下拉框划过样式脚本
        $("#<%=id%>Text").hover(comboxSelect${id}<%=uuid%>.onHover, comboxSelect${id}<%=uuid%>.outHover);
        $("#<%=id%>Btn").hover(comboxSelect${id}<%=uuid%>.onHover, comboxSelect${id}<%=uuid%>.outHover);

        // 树的配置
        var setting = {
            data: {
                key: {
                    name: "<%=nodeName%>"
                },
                simpleData: {
                    enable: true,
                    idKey: "<%=idKey%>",
                    pIdKey: "<%=pIdKey%>",
                    rootPId: 0
                }
            },
            async: {
                enable: true,
                autoParam:["id", "name", "level"],
                url: "<%=url%>"
            },
            callback: {
                onClick: onClick
            }
        };

        // 树的点击事件
        function onClick(e, treeId, treeNode) {
            $("#<%=id%>").val(treeNode.id);
            $("#<%=id%>Text").val(treeNode.text).removeClass("uiframe-selectbox-text-click").removeClass("uiframe-emptyTextColor");
            $("#<%=id%>Btn").removeClass("uiframe-selBtn-click");
            comboxSelect${id}<%=uuid%>.hideMenu();
            $("#<%=id%>").trigger("change", [treeNode.id, treeNode.text]);
        }

        // 初始化树
        $.fn.zTree.init($("#<%=id%>TreeDemo"), setting);

        // 输入框及按钮点击事件
        $("#<%=id%>Btn").on("click", comboxSelect${id}<%=uuid%>.toggleMenu);
        $("#<%=id%>Text").on("click", comboxSelect${id}<%=uuid%>.toggleMenu);

        // 清空按钮点击事件
        $("#clearBtn${id}").on("click", function(){
            $("#<%=id%>").val("");
            if ($("#<%=id%>Text").attr("emptyText")  !== undefined) {
                $("#<%=id%>Text").val($("#<%=id%>Text").attr("emptyText"));
                $("#<%=id%>Text").addClass("uiframe-emptyTextColor");
            } else {
                $("#<%=id%>Text").val("");
            }
            $("#<%=id%>").trigger("change", ["", ""]);
            comboxSelect${id}<%=uuid%>.hideMenu();
        });

        //判断谷歌浏览器
        if(widget.browser.isChrome()){
            $("#combo_select${id}"+<%=uuid%>).width($("#select_div_${id}"+<%=uuid%>).width() + 6);
        }
    };
    combox.orderNumber=44;
    executeQueue.push(combox);
})();
</script>
<div id="selectTree${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="hidden" class="${group}" id="<%=id%>" value="<%=value%>" <%=name%> />
    <input type="text" id="<%=id%>Text" readonly="readonly" name="<%=id%><%=uuid%>" style="width: <%=w-22%>px;<%=style%>" <%=emptyTextk%> <%=disableText%> value="<%=text%>" class="uiframe-selectbox-text  <%=disableInputClass%> <%=cls%>">
    <span id="<%=id%>Btn" class="uiframe-form-btnClick uiframe-selBtn"></span>
    <div id="<%=id%>TreeDiv" class="uiframe-selectTree-wrapper uiframe-selectHide" style="*margin-left: -<%=w+12%>px;">
        <div id="<%=showId%>" style="width: <%=(w+10)%>px;height:<%=h%>px;overflow:auto;">
            <ul id="<%=id%>TreeDemo" class="ztree" style="width:100%;height:99.5%;"></ul>
        </div>
        <%
           if(hasClear==null || hasClear.equalsIgnoreCase("true")){
        %>

        <div class="uiframe-select-bbar" id="select_bbar<%=id%>" style="width: <%=(w+10)%>px;border-top: 1px solid #ebebeb;">
            <div style="float: left;margin-top: 1px;">
                <table>
                    <tr>
                        <td class="uiframe-grid-span"></td>
                        <td>
                            <input type="button" class="uiframe-module-btn" id="clearBtn${id}" style="padding: 0 4px;*-padding:0 2px;" value="清空">
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
