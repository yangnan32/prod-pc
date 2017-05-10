<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-5-8上午10:29
    * @team	    :
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="columns" rtexprvalue="true" required="true" description="控件列名,必填" %>
<%@attribute name="url" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="selectName" rtexprvalue="true" type="java.lang.String" required="true" description="选中数据的显示名称,必填" %>
<%@attribute name="dataId" rtexprvalue="true" type="java.lang.String" required="true" description="数据唯一标识,必填" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="每页显示条数" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="valueMap" rtexprvalue="true" required="false" type="java.util.Map" description="选中数据对应的的LinkedHashMap对象" %><%--键值对--%>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="leftTitle" rtexprvalue="true"  required="false" description="控件左侧div标题" %>
<%@attribute name="rightTitle" rtexprvalue="true"  required="false" description="控件右侧div标题" %>
<%
    long uuid=new Date().getTime();
    String leftTitleText="";
    String rightTitleText="";
    if(leftTitle==null||leftTitle.equalsIgnoreCase("")){
        leftTitleText= "用户列表";
    } else {
        leftTitleText= leftTitle;
    }
    if(rightTitle==null||rightTitle.equalsIgnoreCase("")){
        rightTitleText= "已选用户";
    } else {
        rightTitleText= rightTitle;
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="660";
    }
    float w=660;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=660;
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="240";
    }
    float h=240;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=240;
    }
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<script type="text/javascript">
var SimpleMultiSelect<%=id%><%=uuid%> = {};

// 数据去重方法
SimpleMultiSelect<%=id%><%=uuid%>.noRepeatArray = function(selectArray, dataArray){
    var noRepeatArray = [];
    var arrayObj = {};
    var moveDataString = "'" + dataArray.join("','") + "'";
    for (var i = 0; i < selectArray.length; i++) {
        var selectId = "'" + selectArray[i].<%=dataId%> + "'";
        if (moveDataString.indexOf(selectId) == "-1") {
            noRepeatArray.push(selectArray[i]);
        }
    }
    return noRepeatArray;
};

// 移动数据方法
SimpleMultiSelect<%=id%><%=uuid%>.moveData = function(selectData){
    var dataArray = SimpleMultiSelect<%=id%><%=uuid%>.getDataId();
    var noRepeatData = selectData;
    if(dataArray && dataArray.length != 0){
        noRepeatData = SimpleMultiSelect<%=id%><%=uuid%>.noRepeatArray(selectData, dataArray);
    }
    for(var i = 0; i < noRepeatData.length; i++){
        var tr = $("<tr dataId='"+noRepeatData[i].<%=dataId%>+"'>"
                + "<td>"+noRepeatData[i].<%=selectName%>+"</td>" +
                "</tr>");
        $("#${id}").append(tr);
    }
    $("#<%=id%>NoSelect tr").removeClass("jspGridTrSelect");
    $("#<%=id%>NoSelect td").removeClass("grid-check").addClass("grid-nocheck").attr("checkbox","false");
    SimpleMultiSelect<%=id%><%=uuid%>.disabled(["add${id}"]);
};

// 获取选中数据id值方法
SimpleMultiSelect<%=id%><%=uuid%>.getDataId = function(){
    var dataIdArray = [];
    $("#${id}").find("tr").each(function(){
        var dataId = $(this).attr("dataId");
        dataIdArray.push(dataId);
    });
    return dataIdArray;
};

//设置操作按钮启用方法
SimpleMultiSelect<%=id%><%=uuid%>.enabled = function (idArray) {
    for(var i = 0; i < idArray.length; i++) {
        $("#"+idArray[i]).removeAttr("disabled").removeClass("uiframe-emptyTextColor");
    }
};

//设置操作按钮禁用方法
SimpleMultiSelect<%=id%><%=uuid%>.disabled = function (idArray) {
    for(var i = 0; i < idArray.length; i++) {
        $("#"+idArray[i]).attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
    }
    $("#tooltip").remove();
};
(function(){
        var simpleMultiGrid= widget.form.createGridView({
            id:"<%=id%>Grid",
            renderTo:"<%=id%>NoSelect",
            forceFit:true,
            autoLoad:true,
            limit:<%=limit%>,
            width: $("#<%=id%>NoSelect").width(),
            height: $("#<%=id%>NoSelect").height(),
            url: '<%=url%>',  //加载地址 url
            isShowText:false,
            columns: <%=columns%>
        });

        // 表格load后监听事件
        $(simpleMultiGrid).on("afterLoad", function(){
            if(simpleMultiGrid.store.length == 0) {
                SimpleMultiSelect<%=id%><%=uuid%>.disabled(["addAll${id}","add${id}","remove${id}","removeAll${id}"]);
            } else {
                SimpleMultiSelect<%=id%><%=uuid%>.disabled(["add${id}","remove${id}","removeAll${id}"]);
                SimpleMultiSelect<%=id%><%=uuid%>.enabled(["addAll${id}"]);
            }
            if("<%=valueMap%>" !== "null") {
                SimpleMultiSelect<%=id%><%=uuid%>.enabled(["removeAll${id}"]);
            }
        });

        // 点击表格列的监听事件
        $(simpleMultiGrid).on("rowClick", function(){
            if (simpleMultiGrid.getSelectData().length == 0) {
                SimpleMultiSelect<%=id%><%=uuid%>.disabled(["add${id}"]);
            } else {
                SimpleMultiSelect<%=id%><%=uuid%>.enabled(["add${id}"]);
            }
        });

        // 双击表格列的监听事件
        $(simpleMultiGrid).on("rowDblclick", function(event,dataArray){
            SimpleMultiSelect<%=id%><%=uuid%>.moveData(dataArray);
        });

        //右侧数据点击事件事件
        $("#${id}").off(".rightClick");
        $("#${id}").on("click.rightClick", "tr", function(){
            var get_class = $(this).attr("class");
            if (get_class == "uiframe-table-tr-click") {
                $(this).removeClass("uiframe-table-tr-click");
            } else {
                $(this).addClass("uiframe-table-tr-click");
            }
            if ($("#${id}").find("tr.uiframe-table-tr-click").length == 0) {
                SimpleMultiSelect<%=id%><%=uuid%>.disabled(["remove${id}"]);
            } else {
                SimpleMultiSelect<%=id%><%=uuid%>.enabled(["remove${id}"]);
            }
        });

        // 移动按钮单击事件
        $("#add${id}").on("click", function(){
            SimpleMultiSelect<%=id%><%=uuid%>.moveData(simpleMultiGrid.getSelectData());
        });

        // 删除按钮点击事件
        $("#remove${id}").on("click", function(){
            $('#${id}').find("tr.uiframe-table-tr-click").each( function () {
                $(this).remove();
            });
            SimpleMultiSelect<%=id%><%=uuid%>.disabled(["remove${id}"]);
            if ($("#${id}").find("tr").length == 0) {
                SimpleMultiSelect<%=id%><%=uuid%>.disabled(["removeAll${id}"]);
            }
        });

        // 全部移动按钮点击事件
        $("#addAll${id}").on("click", function(){
            SimpleMultiSelect<%=id%><%=uuid%>.moveData(simpleMultiGrid.store);
            SimpleMultiSelect<%=id%><%=uuid%>.enabled(["removeAll${id}"]);
        });

        // 删除全部按钮点击事件
        $("#removeAll${id}").on("click", function(){
            $('#${id}').empty();
            SimpleMultiSelect<%=id%><%=uuid%>.disabled(["remove${id}"]);
            SimpleMultiSelect<%=id%><%=uuid%>.disabled(["removeAll${id}"]);
        });

        //右侧选中数据双击事件
        $("#${id}").off(".right_dblclick");
        $("#${id}").on("dblclick.right_dblclick", "tr", function(){
            $(this).remove();
        });

        // 根据条件重新加载左侧表格数据事件
        $("#${id}").on("reLoad", function(event, params, flag){
            simpleMultiGrid.storeLoad(params, flag);
        });

        // 加载新url
        $("#${id}").on("changeUrl", function(event,url){
            simpleMultiGrid.model.set("url", url);
        });

        // 按钮取消禁用
        $("#add${id}").removeAttr("disabled");
        $("#addAll${id}").removeAttr("disabled");
})();

</script>
<div id="multiLayout${id}" class="uiframe-multilayout" tabindex=0 style="width: <%=w%>px;height:<%=h%>px">
    <div class="uiframe-multifieldset" style="width: <%=(w-203)%>px;height:<%=h%>px">
        <span class="uiframe-multi-title"><%=leftTitleText%></span>
        <div class="uiframe-multidiv-noselectParent" id="<%=id%>NoSelect" style="width: <%=(w-205)%>px;height:<%=h-25%>px">
        </div>
    </div>
    <div class="uiframe-multibuttondiv" style="height:<%=h%>px; ">
        <div class="uiframe-multibutton" style="margin-top:<%=(h-120)/2+20%>px;_margin-top:<%=(h-120)/2+10%>px; ">
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip " style="padding: 0;" id="addAll${id}" myTitle="选择全部"><span class="icon-multi-selAll">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip uiframe-emptyTextColor" style="padding: 0;" id="add${id}" myTitle="选择"><span class="icon-multi-sel uiframe-emptyTextColor">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip uiframe-emptyTextColor" style="padding: 0;" id="remove${id}" myTitle="删除"><span class="icon-multi-del uiframe-emptyTextColor">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip uiframe-emptyTextColor" style="padding: 0;" id="removeAll${id}" myTitle="删除全部"><span class="icon-multi-delAll uiframe-emptyTextColor">&nbsp;</span></button></div>
        </div>
    </div>
    <div class="uiframe-multifieldset" style="width: 137px;height:<%=h%>px">
        <span class="uiframe-multi-title"><%=rightTitleText%></span>
        <div class="uiframe-multidiv-select" style="width: 135px;height:<%=h-25%>px">
            <table id="${id}">
                <c:forEach var="item" items="<%=valueMap%>" varStatus="s">
                    <tr dataId="${item.key}"><td>${item.value}</td></tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
