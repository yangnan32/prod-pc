<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%@attribute name="pidKey" rtexprvalue="true"  required="false" description="树父节点id" %>
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


    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }
    if(value==null||value.equalsIgnoreCase("")){
        value="";
    }
    if(nodeName==null||nodeName.equalsIgnoreCase("")){
        nodeName="text";
    }
    if(idKey==null||idKey.equalsIgnoreCase("")){
        idKey="id";
    }
    if(pidKey==null||pidKey.equalsIgnoreCase("")){
        pidKey="pId";
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
        height="300";
    }
    float h=300;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=300;
    }
%>
<script type="text/javascript">
var comboxSelect${id}<%=uuid%> = {};

// 显示下拉内容方法
comboxSelect${id}<%=uuid%>.toggleMenu = function(e){
    if($("#<%=id%>TreeDiv").css("display") === "none") {
        $("#<%=id%>TreeDiv").css("z-index", sywFunction.selection_zindex);
        sywFunction.selection_zindex++;
        $("#body").find("div.uiframe-selectHide").each(function(){
            $(this).hide();//隐藏所有下拉框显示框
        });
        $("#<%=id%>TreeDiv").css("top", $(e.target).offset().top +32);
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

// 隐藏下拉内容方法
comboxSelect${id}<%=uuid%>.setSystem = function(){
    var widgetKeSpaceMains =  $("[name=widgetKeSpaceMain]");
    var text = "";
    var isAll = 0;
    //是否显示分类选择：1=隐藏0=不隐藏
    
    var isShow100 = "1";
    for(var i=0;i<widgetKeSpaceMains.length;i++){
        if(widgetKeSpaceMains[i].checked){
            text += $("#label"+widgetKeSpaceMains[i].id).text()+",";
        }else{
            isAll=1;
        }
        if(widgetKeSpaceMains[i].value=="100"&&widgetKeSpaceMains[i].checked){isShow100 = "0"}
    }
    if(isAll==0)text="全部范围";
    $("#<%=id%>Text").text(text.substring(0,text.length-1));
    //处理分类隐藏/显示
    if(isShow100=="1"){
        $("#divCategoryMain<%=id%>Text").hide();
        $("#<%=showId%>").hide();
        $("#select_bbar<%=id%>").hide();
    }else{
        $("#divCategoryMain<%=id%>Text").show();
        $("#<%=showId%>").show();
        $("#select_bbar<%=id%>").show();
    }
};

(function(){
    var combox=function(){
        // 树的配置
        var setting = {
            check: {
                enable: true,
                chkboxType: { "Y": "", "N": "" }
            },
            view: {
                showIcon: false
            },
            data: {
                key: {
                    name: "<%=nodeName%>"
                },
                simpleData: {
                    enable: true,
                    idKey: "<%=idKey%>",
                    pIdKey: "<%=pidKey%>",
                    rootPId: 0
                }
            },
            async: {
                enable: true,
                autoParam:["id", "name", "level"],
                url: "<%=url%>"
            },
            callback: {
                onCheck:onCheck
                //onClick: onClick
            }
        };

        // 树节点复选框事件
        function onCheck(e, treeId, treeNode) {
            var selectNode = $.fn.zTree.getZTreeObj("<%=id%>TreeDemo").getCheckedNodes(true);
            var i, max, idArray=[], textArray=[];
            for (i = 0, max = selectNode.length; i < max; i +=1) {
                idArray.push(selectNode[i]["<%=idKey%>"]);
                textArray.push(selectNode[i]["<%=nodeName%>"]);
            }
            $("#<%=id%>").val(idArray.join(","));
            $("#divCategoryMain<%=id%>Text").text(textArray.join(",") == "" ? "全部类别" : textArray.join(","));
            $("#<%=id%>").trigger("change", [$("#<%=id%>").val(), $("#divCategoryMain<%=id%>Text").text()]);
        }

        /***
        *树的点击事件
        */
        /*
        function onClick(e, treeId, treeNode) {
            alert("onClick");
            $("#<%=id%>").val(treeNode.id);
            $("#<%=id%>Text").text(treeNode.text);
            comboxSelect${id}<%=uuid%>.hideMenu();
            $("#<%=id%>").trigger("change", [treeNode.id, treeNode.text]);
        }
        */

        // 初始化树
        $.fn.zTree.init($("#<%=id%>TreeDemo"), setting);

        // 输入框及按钮点击事件
        $("#<%=id%>Text").on("click", comboxSelect${id}<%=uuid%>.toggleMenu);

        // 清空按钮点击事件
        $("#clearBtn${id}").on("click", function(){
            $("#<%=id%>").val("");
            $("#divCategoryMain<%=id%>Text").text("全部类别");
            $.fn.zTree.getZTreeObj("<%=id%>TreeDemo").cancelSelectedNode();
            $.fn.zTree.getZTreeObj("<%=id%>TreeDemo").checkAllNodes(false);
            $("#<%=id%>").trigger("change", ["", ""]);
        });

        // 输入框及按钮点击事件
        $("[name=widgetKeSpaceMain]").on("click", comboxSelect${id}<%=uuid%>.setSystem);
    };
    combox.orderNumber=44;
    executeQueue.push(combox);
})();
</script>
<div id="selectTree${id}<%=uuid%>" class="uiframe-mainCon ${outCls}" style="${outStyle}">
    <input type="hidden" class="${group}" id="<%=id%>" value="<%=value%>" <%=name%> />
    <div id="<%=id%>Text" style="width:<%=w%>px;<%=style%>" class="selectTypeTree uiframe-text-overflow <%=cls%>">全部范围</div>
    <div id="<%=id%>TreeDiv" class="uiframe-selectTree-wrapper uiframe-selectHide comboxCheckboxDiv" style="border:1px solid #e4e4e4;margin-top:0;background:#fafafa;width: <%=w%>px;">
        <div id="system<%=showId%>" style="width:160px;overflow:auto;border-bottom: 1px solid #ebebeb;background:#fafafa;margin-left:auto;margin-right:auto;padding-bottom:10px;padding-top:5px;">
            <div id="system<%=showId%>left" style="width:80px;overflow:auto;background:#fafafa;float:left;">
                <input type="checkbox" checked id="widgetKeSpaceMain01" value="100" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain01" for="widgetKeSpaceMain01" class="uiframe-checkbox-label">知识中心</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain02" value="200" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain02" for="widgetKeSpaceMain03" class="uiframe-checkbox-label">问答社区</label>
                <!-- <br>
                <input type="checkbox" checked id="widgetKeSpaceMain03" value="300" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain03" for="widgetKeSpaceMain05" class="uiframe-checkbox-label">任务中心</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain04" value="400" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain04" for="widgetKeSpaceMain05" class="uiframe-checkbox-label">材料库</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain05" value="500" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain05" for="widgetKeSpaceMain05" class="uiframe-checkbox-label">数字档案</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain06" value="600" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain06" for="widgetKeSpaceMain05" class="uiframe-checkbox-label">PDM</label> -->
            </div>
            <div id="system<%=showId%>right" style="width:80px;overflow:auto;background:#fafafa;float:left">
                <input type="checkbox" checked id="widgetKeSpaceMain07" value="101" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain07" for="widgetKeSpaceMain02" class="uiframe-checkbox-label">我的知识</label><br>
                <!-- 
                <input type="checkbox" checked id="widgetKeSpaceMain08" value="800" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain08" for="widgetKeSpaceMain04" class="uiframe-checkbox-label">工程模板</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain09" value="900" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain09" for="widgetKeSpaceMain06" class="uiframe-checkbox-label">数据中心</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain10" value="110" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain10" for="widgetKeSpaceMain06" class="uiframe-checkbox-label">培训资料</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain11" value="120" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain11" for="widgetKeSpaceMain06" class="uiframe-checkbox-label">数字图书</label><br>
                <input type="checkbox" checked id="widgetKeSpaceMain12" value="130" name="widgetKeSpaceMain" class="uiframe-checkbox"><label id="labelwidgetKeSpaceMain12" for="widgetKeSpaceMain06" class="uiframe-checkbox-label">标准网</label> -->
            </div>
        </div>
        <div id="divCategoryMain<%=id%>Text" style="width:160px;overflow:auto;background:#fafafa;margin-left:auto;margin-right:auto;padding-bottom:3px;padding-top:2px;border-bottom: 1px solid #ebebeb;line-height:20px">全部类别</div>
        <div id="<%=showId%>" style="width: <%=w%>px;height:<%=h%>px;overflow:auto;background:#fafafa;">
            <ul id="<%=id%>TreeDemo" class="ztree"></ul>
        </div>
        <%
           if(hasClear==null || hasClear.equalsIgnoreCase("true")){
        %>
        <div class="uiframe-select-bbar" id="select_bbar<%=id%>" style="width: <%=w%>px;border-top: 1px solid #ebebeb;background:#fafafa;">
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
