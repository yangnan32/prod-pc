<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 12-5-18上午11:29
    * @team	    :
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>

<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="columns" rtexprvalue="true" required="true" description="控件列名,必填" %>
<%@attribute name="url" rtexprvalue="true" type="java.lang.String" required="true" description="ajax url地址,必填" %>
<%@attribute name="editUrl" rtexprvalue="true" type="java.lang.String" required="true" description="回显时数据地址" %>
<%@attribute name="emptyUrl" rtexprvalue="true" type="java.lang.String" required="false" description="默认显示数据地址" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="dataId" rtexprvalue="true" type="java.lang.String" required="true" description="数据唯一标识,必填" %>
<%@attribute name="toolPage" rtexprvalue="true" required="false" description="翻页工具栏" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="每页显示条数" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="leftTitle" rtexprvalue="true"  required="false" description="控件左侧div标题" %>
<%@attribute name="rightTitle" rtexprvalue="true"  required="false" description="控件右侧div标题" %>
<%
    long uuid=new Date().getTime();
    String toolPageText="";
    boolean toolPageFlag = true;
    String emptyUrlText="";
    String leftTitleText="";
    String rightTitleText="";
    if(StringUtils.isNotEmpty(toolPage) && toolPage.equalsIgnoreCase("false")){
        toolPageText = "display:none;";
        toolPageFlag = false;
    }
    if(leftTitle==null||leftTitle.equalsIgnoreCase("")){
        leftTitleText= "未选择";
    } else {
        leftTitleText= leftTitle;
    }
    if(rightTitle==null||rightTitle.equalsIgnoreCase("")){
        rightTitleText= "已选择";
    } else {
        rightTitleText= rightTitle;
    }
    if(emptyUrl==null||emptyUrl.equalsIgnoreCase("")){
        emptyUrlText= "";
    } else {
        emptyUrlText= emptyUrl;
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="500";
    }
    float w=500;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=500;
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
var multiSelect<%=id%><%=uuid%> = {
    conditionName : "",                     //加载数据时的条件
    recordPage: 0,                          //每页显示数据条数
    totalPage: "",                          //总页数
    leftData: [],                           //未选中div里的数据
    rightData: [],                          //以选中div里的数据
    editData: [],                            //回显时以id为数据组成的新数组
    imptyData: [],                           //修改时回显的数组
    totalCount: "",                         //数据总条数
    start: 0,                                //数据起始条数
    startPage: 1,                           //起始页数
    columns: "",                            //数据显示列
    url:"",                                 // 加载数据url地址
    leftlength:0,                           //加载数据的长度
    columnlength: 0,                        //列数
    changeUrl:"<%=basePath%><%=url%>",      //修改时加载的url地址
    defaultUrl:"<%=emptyUrl%>",				//默认加载的url
    tdW :0,                                   //表格中td的宽度
    tdWIE :0                                  //表格中td在ie6下的宽度
};

//数据对应显示列
multiSelect<%=id%><%=uuid%>.columns= <%=columns%>;
//数据对应显示列个数
multiSelect<%=id%><%=uuid%>.columnlength = <%=columns%>.length;

multiSelect<%=id%><%=uuid%>.tdW = parseInt("<%=(w-66)/2-24%>")/multiSelect<%=id%><%=uuid%>.columnlength;
multiSelect<%=id%><%=uuid%>.tdWIE = parseInt("<%=(w-66)/2-28%>")/multiSelect<%=id%><%=uuid%>.columnlength;
//每页显示数据
if(!<%=limit%>) {
    multiSelect<%=id%><%=uuid%>.recordPage=5;
}else{
    multiSelect<%=id%><%=uuid%>.recordPage = "<%=limit%>";
}

//加载数据的方法
multiSelect<%=id%><%=uuid%>.load = function () {
    if (multiSelect<%=id%><%=uuid%>.defaultUrl !== "" && multiSelect<%=id%><%=uuid%>.defaultUrl !== "null") {
        //有默认显示数据的url地址时执行 else
        multiSelect<%=id%><%=uuid%>.url = "<%=basePath%><%=emptyUrlText%>";
    } else {
    	multiSelect<%=id%><%=uuid%>.url = "<%=basePath%><%=url%>";
    }
    var urlParams;
    if(<%=toolPageFlag%>){
    	urlParams = multiSelect<%=id%><%=uuid%>.conditionName +'start='+multiSelect<%=id%><%=uuid%>.start+'&limit='+multiSelect<%=id%><%=uuid%>.recordPage;
    } else {
    	urlParams = multiSelect<%=id%><%=uuid%>.conditionName;
    }
    $.ajax({
        type: "POST",
        url: multiSelect<%=id%><%=uuid%>.url,
        dataType: "json",
        data:urlParams,
        success:function(data_name){
            if(data_name){
                var data=eval("data_name.<%=dataRoot%>");
                if(data==undefined){return;}
                multiSelect<%=id%><%=uuid%>.totalCount = data.recordtotal||0;
                multiSelect<%=id%><%=uuid%>.leftData = data.resultSet||[];
            }
            if (multiSelect<%=id%><%=uuid%>.leftData.length === 0) {
                $("#page${id}").text("");
                $("#totalpage${id}").text("");
                $("#noselect-${id}").find("tbody").empty();
                $("#addAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                $("#removeAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                $("#addAll${id}").children("span").addClass("icon-multi-selAll-disabled");
                $("#removeAll${id}").children("span").addClass("icon-multi-delAll-disabled");
                multiSelect<%=id%><%=uuid%>.disabled();
                return false;
            } else {
                $("#addAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                $("#removeAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                $("#addAll${id}").children("span").removeClass("icon-multi-selAll-disabled");
                $("#removeAll${id}").children("span").removeClass("icon-multi-delAll-disabled");
                $("#add${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                $("#remove${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                $("#add${id}").children("span").addClass("icon-multi-sel-disabled");
                $("#remove${id}").children("span").addClass("icon-multi-del-disabled");
                if (multiSelect<%=id%><%=uuid%>.rightData.length ===0) {
                    multiSelect<%=id%><%=uuid%>.leftlength = multiSelect<%=id%><%=uuid%>.leftData.length;
                } else {
                    for(var j=0;j<multiSelect<%=id%><%=uuid%>.rightData.length;j++){
                        var rightrecord = multiSelect<%=id%><%=uuid%>.rightData[j];
                        if(rightid!=undefined){
                            var rightid = rightrecord["<%=dataId%>"];
                        }
                        if(rightid!=undefined){
                            for(var k=0;k<multiSelect<%=id%><%=uuid%>.leftData.length;k++){
                                var leftrecord = multiSelect<%=id%><%=uuid%>.leftData[k];
                                var leftid = leftrecord["<%=dataId%>"];
                                if (leftid === rightid) {
                                    for(var m=0;m<multiSelect<%=id%><%=uuid%>.columnlength;m++){
                                        var column=multiSelect<%=id%><%=uuid%>.columns[m];
                                        var dataIndex=column.dataIndex;
                                        leftrecord[dataIndex] = "";
                                        leftrecord["<%=dataId%>"] = "";
                                    }
                                }
                            }
                        }
                    }
                    multiSelect<%=id%><%=uuid%>.leftlength = multiSelect<%=id%><%=uuid%>.leftData.length;
                }
                var table=$("#noselect-${id}");
                table.find("tbody").empty();       //清空数据
                if (multiSelect<%=id%><%=uuid%>.editData.length !== 0) {
                    for(var j = 0; j < multiSelect<%=id%><%=uuid%>.editData.length; j++){
                        var myId = multiSelect<%=id%><%=uuid%>.editData[j];
                        for(var i = 0; i< multiSelect<%=id%><%=uuid%>.leftlength;i++){
                            var leftrecord = multiSelect<%=id%><%=uuid%>.leftData[i];
                            var leftid = leftrecord["<%=dataId%>"]; //left数据id
                            if(leftid!=undefined){
                                var tr=$('<tr id="'+leftid+'" tabindex=0 value="'+i+'" type="checkbox"></tr>');
                                for(var k=0;k<multiSelect<%=id%><%=uuid%>.columnlength;k++){
                                    var column=multiSelect<%=id%><%=uuid%>.columns[k];
                                    var dataIndex=column.dataIndex;
                                    var data=leftrecord[dataIndex]||"";
                                    tr.append('<td><div class="uiframe-multidiv-td-div" style="width:'+multiSelect<%=id%><%=uuid%>.tdW+'px;*-width:'+multiSelect<%=id%><%=uuid%>.tdWIE+'px">'+data+'</div></td>');
                                }
                                if($("#noselect-${id} tr").length < multiSelect<%=id%><%=uuid%>.leftlength){
                                    table.append(tr);
                                }
                                if(myId === leftid){
                                    var trId = "r"+leftid;
                                    var number_l = $('#'+leftid).attr("value");
                                    var number_r = multiSelect<%=id%><%=uuid%>.rightData.length;
                                    $('#'+leftid).text("");
                                    $('#'+leftid).removeAttr("value");
                                    $('#'+trId).attr("value",number_l);
                                }
                            }
                        }
                    }
                } else {
                    for(var i=0;i<multiSelect<%=id%><%=uuid%>.leftlength;i++){
                        var leftrecord = multiSelect<%=id%><%=uuid%>.leftData[i];
                        var leftid = leftrecord["<%=dataId%>"]; //left数据id
                        if(leftid!=undefined){
                            var tr=$('<tr id="'+leftid+'" tabindex=0 value="'+i+'" type="checkbox"></tr>');
                            for(var k=0;k<multiSelect<%=id%><%=uuid%>.columnlength;k++){
                                var column=multiSelect<%=id%><%=uuid%>.columns[k];
                                var dataIndex=column.dataIndex;
                                var data=leftrecord[dataIndex]||"";
                                tr.append('<td><div class="uiframe-multidiv-td-div" style="width:'+multiSelect<%=id%><%=uuid%>.tdW+'px;*-width:'+multiSelect<%=id%><%=uuid%>.tdWIE+'px">'+data+'</div></td>');
                            }
                            table.append(tr);
                        }
                    }
                }
                $("table").shiftCheck();  //键盘shift，多选脚本
                multiSelect<%=id%><%=uuid%>.totalPage = Math.ceil(multiSelect<%=id%><%=uuid%>.totalCount/multiSelect<%=id%><%=uuid%>.recordPage);
                $("#page${id}").text(multiSelect<%=id%><%=uuid%>.startPage);
                $("#totalpage${id}").text(multiSelect<%=id%><%=uuid%>.totalPage);
                if(multiSelect<%=id%><%=uuid%>.startPage==1){
                    $("#prev${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                }else{
                    $("#prev${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                }
                if(multiSelect<%=id%><%=uuid%>.startPage==multiSelect<%=id%><%=uuid%>.totalPage){
                    $("#next${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                }else{
                    $("#next${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                }
                if($('#${id}').find("tr").length == 0){
                    $("#removeAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                    $("#removeAll${id}").children("span").addClass("icon-multi-delAll-disabled");
                } else {
                    $("#removeAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                    $("#removeAll${id}").children("span").removeClass("icon-multi-delAll-disabled");
                }
                if($('#noselect-${id}').find("tr").length == 0){
                    $("#addAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
                    $("#addAll${id}").children("span").addClass("icon-multi-selAll-disabled");
                } else {
                    $("#addAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
                    $("#addAll${id}").children("span").removeClass("icon-multi-selAll-disabled");
                }
                multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            }
            //每次数据加载成功之后根据选中的值隐藏对应未选中的内容
            $('#${id}').find("tr").each( function () {
                var myId = $(this).attr("myid");
                $("#"+myId).text("");
                $('#'+myId).removeAttr("value");
            });
            multiSelect<%=id%><%=uuid%>.getDate();
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
        }
    });
};
//加载修改数据方法
multiSelect<%=id%><%=uuid%>.editLoad = function () {
    $.ajax({
        type: "POST",
        url: "<%=basePath%><%=editUrl%>",
        dataType: "json",
        data:"",
        success:function(data_name){
            if(data_name){
                var data=eval("data_name.<%=dataRoot%>");
                if(data==undefined){return;}
                multiSelect<%=id%><%=uuid%>.imptyData = data.resultSet||[];
            }
            var myTable=$("#${id}");
            myTable.find("tbody").empty();       //清空数据
            for(var i = 0;i< multiSelect<%=id%><%=uuid%>.imptyData.length;i++){
                var leftrecord = multiSelect<%=id%><%=uuid%>.imptyData[i];
                var leftid = leftrecord["<%=dataId%>"]; //left数据id
                if(leftid!=undefined){
                    var rightid = "r" + leftid;
                    multiSelect<%=id%><%=uuid%>.editData[i] = leftid;
                    var tr=$('<tr id="'+rightid+'" tabindex=0 value="'+i+'" myid="'+leftid+'" number="'+i+'" type="checkbox"></tr>');
                    for(var k=0;k<multiSelect<%=id%><%=uuid%>.columnlength;k++){
                        var column=multiSelect<%=id%><%=uuid%>.columns[k];
                        var dataIndex=column.dataIndex;
                        var data=leftrecord[dataIndex]||"";
                        tr.append('<td><div class="uiframe-multidiv-td-div" style="width:'+multiSelect<%=id%><%=uuid%>.tdW+'px;*-width:'+multiSelect<%=id%><%=uuid%>.tdWIE+'px">'+data+'</div></td>');
                    }
                    myTable.append(tr);
                }
            }
            //加载左侧数据的方法
            multiSelect<%=id%><%=uuid%>.rightData = multiSelect<%=id%><%=uuid%>.imptyData;
            multiSelect<%=id%><%=uuid%>.load();
            $("#${id}").trigger("getValue",[multiSelect<%=id%><%=uuid%>.rightData]);  //记录编辑时回显的数据值
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){

        }
    });
};
//根据条件回显重新加载数据方法
multiSelect<%=id%><%=uuid%>.reload = function (name) {
	multiSelect<%=id%><%=uuid%>.defaultUrl = "";
    if (name) {
        multiSelect<%=id%><%=uuid%>.conditionName  = name +'&';
    }
    multiSelect<%=id%><%=uuid%>.url = "<%=basePath%><%=url%>";
    multiSelect<%=id%><%=uuid%>.start = 0;
    multiSelect<%=id%><%=uuid%>.startPage = 1;
    multiSelect<%=id%><%=uuid%>.load();
};
//设置操作按钮禁用方法
multiSelect<%=id%><%=uuid%>.disabled = function () {
    $("#prev${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
    $("#next${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
    $("#add${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
    $("#remove${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
    $("#add${id}").children("span").addClass("icon-multi-sel-disabled");
    $("#remove${id}").children("span").addClass("icon-multi-del-disabled");
};
//取消操作按钮禁用方法
multiSelect<%=id%><%=uuid%>.enabled = function () {
    $("#add${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
    $("#remove${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
    $("#add${id}").children("span").removeClass("icon-multi-sel-disabled");
    $("#remove${id}").children("span").removeClass("icon-multi-del-disabled");
    $("#removeAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
    $("#removeAll${id}").children("span").removeClass("icon-multi-delAll-disabled");
};
//改变按钮启用禁用方法
multiSelect<%=id%><%=uuid%>.changeBtnDisabled = function () {
    if($("#noselect-${id}").find("tr.uiframe-table-tr-click").length == 0){
        $("#add${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#add${id}").children("span").addClass("icon-multi-sel-disabled");
    } else {
        $("#add${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#add${id}").children("span").removeClass("icon-multi-sel-disabled");
    }
    if($("#${id}").find("tr.uiframe-table-tr-click").length == 0){
        $("#remove${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#remove${id}").children("span").addClass("icon-multi-del-disabled");
    } else {
        $("#remove${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#remove${id}").children("span").removeClass("icon-multi-del-disabled");
    }
    if($("#noselect-${id}").find("td").length == 0){
        $("#addAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#addAll${id}").children("span").addClass("icon-multi-selAll-disabled");
    } else {
        $("#addAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#addAll${id}").children("span").removeClass("icon-multi-selAll-disabled");
    }
    if($("#${id}").find("td").length == 0){
        $("#removeAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#removeAll${id}").children("span").addClass("icon-multi-delAll-disabled");
    } else {
        $("#removeAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
        $("#removeAll${id}").children("span").removeClass("icon-multi-delAll-disabled");
    }
};
//获取选中数据数组，并缓存到“getDate”上
multiSelect<%=id%><%=uuid%>.getDate = function () {
    var dataArray = [];
    var m = 0;
    for (var i=0;i<multiSelect<%=id%><%=uuid%>.rightData.length;i++) {
        if(multiSelect<%=id%><%=uuid%>.rightData[i]!=undefined){
            dataArray[m] = multiSelect<%=id%><%=uuid%>.rightData[i];
            m++;
        }
    }
    $("#${id}").removeData("getData");
    $("#${id}").data("getData", dataArray);
    $("table").shiftCheck();
};
(function(){
    var multi=function(){
        //初始化时清空live的绑定事件
        $("#noselect-${id} tr,#${id} tr").die("click");
        //有修改操作的url地址时执行
        if ("<%=editUrl%>" !== "") {
            multiSelect<%=id%><%=uuid%>.editLoad();
        } else {
            multiSelect<%=id%><%=uuid%>.load();
        }
        <%--//监听left/right/up/down多选  有冲突，暂时去掉--%>

        <%--widget.hotKey.regist($("#multiLayout${id}"),37,function(){--%>
            <%--$('#remove${id}').trigger("click");--%>
            <%--return false;--%>
        <%--});--%>
        <%--widget.hotKey.regist($("#multiLayout${id}"),39,function(){--%>
            <%--$('#add${id}').trigger("click");--%>
            <%--return false;--%>
        <%--});--%>
        <%--widget.hotKey.regist($("#multiLayout${id}"),38,function(){--%>
            <%--if($("#noselect-${id}").find("tr.uiframe-table-tr-click").length === 1 || $("#${id}").find("tr.uiframe-table-tr-click").length === 1){--%>
                <%--var m = $("#noselect-${id}").find("tr.uiframe-table-tr-click");--%>
                <%--if(m.prev("tr").text() === "" || $("#noselect-${id}").find("tr:first").attr("class") == "uiframe-table-tr-click"){--%>
                <%--} else {--%>
                    <%--m.removeClass("uiframe-table-tr-click");--%>
                    <%--m.prev("tr").addClass("uiframe-table-tr-click");--%>
                    <%--m.prev("tr").focus();--%>
                <%--}--%>
                <%--var n = $("#${id}").find("tr.uiframe-table-tr-click");--%>
                <%--if(n.prev("tr").text() === "" || $("#${id}").find("tr:first").attr("class") == "uiframe-table-tr-click"){--%>
                <%--} else {--%>
                    <%--n.removeClass("uiframe-table-tr-click");--%>
                    <%--n.prev("tr").addClass("uiframe-table-tr-click");--%>
                    <%--m.prev("tr").focus();--%>
                <%--}--%>
                <%--return false;--%>
            <%--}--%>
        <%--});--%>
        <%--widget.hotKey.regist($("#multiLayout${id}"),40,function(){--%>
            <%--if($("#noselect-${id}").find("tr.uiframe-table-tr-click").length === 1 || $("#${id}").find("tr.uiframe-table-tr-click").length === 1){--%>
                <%--var m = $("#noselect-${id}").find("tr.uiframe-table-tr-click");--%>
                <%--if(m.next("tr").text() === "" || $("#noselect-${id}").find("tr:last").attr("class") == "uiframe-table-tr-click"){--%>
                <%--} else {--%>
                    <%--m.removeClass("uiframe-table-tr-click");--%>
                    <%--m.next("tr").addClass("uiframe-table-tr-click");--%>
                    <%--m.next("tr").focus();--%>
                <%--}--%>
                <%--var n = $("#${id}").find("tr.uiframe-table-tr-click");--%>
                <%--if(n.next("tr").text() === "" || $("#${id}").find("tr:last").attr("class") == "uiframe-table-tr-click"){--%>
                <%--} else {--%>
                    <%--n.removeClass("uiframe-table-tr-click");--%>
                    <%--n.next("tr").addClass("uiframe-table-tr-click");--%>
                    <%--m.next("tr").focus();--%>
                <%--}--%>
                <%--return false;--%>
            <%--}--%>
        <%--});--%>

        //为此组件id绑定回显重新加载方法
        $("#${id}").on("reLoad", function (event,name) {
            multiSelect<%=id%><%=uuid%>.reload(name);
        });
        //为此组件id绑定动态改变加载url地址方法
        $("#${id}").on("changeUrl", function (event,url) {
            //默认数据
            multiSelect<%=id%><%=uuid%>.load();
        });
        //默认初始化没load按钮禁用
        multiSelect<%=id%><%=uuid%>.disabled();
        //为此组件里所有的tr绑定单击事件
        $("#noselect-${id} tr,#${id} tr").live("click", function(){
            var get_class = $(this).attr("class");
            if (get_class=="uiframe-table-tr-click") {
                $(this).removeClass("uiframe-table-tr-click");
            } else {
                $(this).addClass("uiframe-table-tr-click");
            }
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
        });
        //移到右边事件
        $('#add${id}').bind("click", function() {
            if($("#tooltip")){
                $("#tooltip").remove();   //移除划过提示
            }
            //获取选中的选项，删除并追加给对方
            $('#${id}').find("tr").removeClass("uiframe-table-tr-click");
            $('#noselect-${id} tr.uiframe-table-tr-click').appendTo('#${id}');
            $('#${id}').find("tr.uiframe-table-tr-click").each( function () {
                var number_l = $(this).attr("value");
                var number_r = multiSelect<%=id%><%=uuid%>.rightData.length;
                $(this).attr("number",number_r);
                var myId = $(this).attr("id");
                $(this).attr("id","r"+myId);
                $(this).attr("myid",myId);
                multiSelect<%=id%><%=uuid%>.rightData[number_r] = multiSelect<%=id%><%=uuid%>.leftData[number_l];
            });
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            multiSelect<%=id%><%=uuid%>.getDate();
        });
        //移到左边事件
        $('#remove${id}').bind("click", function() {
            $('#noselect-${id}').find("tr").removeClass("uiframe-table-tr-click");
            $('#${id} tr.uiframe-table-tr-click').appendTo('#noselect-${id}');
            $('#noselect-${id}').find("tr.uiframe-table-tr-click").each( function () {
                var myId = $(this).attr("myid");
                $(this).attr("id",myId);
//                var right_number = $(this).attr("number");
                var right_value = $(this).attr("number");
                $(this).removeAttr("number");
                <%--multiSelect<%=id%><%=uuid%>.leftData[right_value] =  multiSelect<%=id%><%=uuid%>.rightData[right_number];--%>
                delete multiSelect<%=id%><%=uuid%>.rightData[right_value];
                delete multiSelect<%=id%><%=uuid%>.editData[right_value];
                <%--multiSelect<%=id%><%=uuid%>.rightData.splice(right_number,1);--%>
            });
            multiSelect<%=id%><%=uuid%>.load();
            multiSelect<%=id%><%=uuid%>.getDate();
        });
        //全部移到右边事件
        $('#addAll${id}').bind("click", function() {
            if($("#tooltip")){
                $("#tooltip").remove();   //移除划过提示
            }
            $("#removeAll${id}").removeAttr("disabled").removeClass("uiframe-emptyTextColor");
            $("#removeAll${id}").children("span").removeClass("icon-multi-delAll-disabled");
            $("#addAll${id}").attr("disabled","disabled").addClass("uiframe-emptyTextColor").removeClass("uiframe-module-btn-hover");
            $("#addAll${id}").children("span").addClass("icon-multi-selAll-disabled");
            //获取全部的选项,删除并追加给对方
            $('#${id}').find("tr").removeClass("uiframe-table-tr-click");
            if($('#noselect-${id} tr td').text() !== ""){
                $('#noselect-${id} tr').addClass("uiframe-table-tr-remove").appendTo('#${id}');
                $('#${id}').find("tr.uiframe-table-tr-remove").each( function () {
                    var number_l = $(this).attr("value");
                    var number_r = multiSelect<%=id%><%=uuid%>.rightData.length;
                    var myId = $(this).attr("id");
                    $(this).attr("id","r"+myId);
                    $(this).attr("myid",myId);
                    $(this).attr("number",number_r);
                    multiSelect<%=id%><%=uuid%>.rightData[number_r] = multiSelect<%=id%><%=uuid%>.leftData[number_l];
                });
                multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
                multiSelect<%=id%><%=uuid%>.getDate();
            }
        });
        //全部移到左边事件
        $('#removeAll${id}').bind("click", function() {
            multiSelect<%=id%><%=uuid%>.editData.length = 0;
            $('#${id} tr').appendTo('#noselect-${id}');
            multiSelect<%=id%><%=uuid%>.rightData.length = 0;
            multiSelect<%=id%><%=uuid%>.load();
            multiSelect<%=id%><%=uuid%>.getDate();
        });
        //双击选项右移事件
        $('#noselect-${id} tr').die().live("dblclick", function(){ //绑定双击事件
            var get_class = $(this).attr("class");
            if (get_class=="uiframe-table-tr-click") {
                $(this).removeClass("uiframe-table-tr-click");
            } else {
                $(this).addClass("uiframe-table-tr-click");
            }
            $(this).appendTo('#${id}').addClass("uiframe-table-tr-click").siblings("tr").removeClass("uiframe-table-tr-click");
            $('#${id}').find("tr.uiframe-table-tr-click").each( function () {
                var number_l = $(this).attr("value");
                var number_r = multiSelect<%=id%><%=uuid%>.rightData.length;
                var myId = $(this).attr("id");
                $(this).attr("id","r"+myId);
                $(this).attr("myid",myId);
                $(this).attr("number",number_r);
                multiSelect<%=id%><%=uuid%>.rightData[number_r] = multiSelect<%=id%><%=uuid%>.leftData[number_l];
            });
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            multiSelect<%=id%><%=uuid%>.getDate();
        });
        //双击选项左移事件
        $('#${id} tr').die().live("dblclick", function(){
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            var get_class = $(this).attr("class");
            if (get_class=="uiframe-table-tr-click") {
                $(this).removeClass("uiframe-table-tr-click");
            } else {
                $(this).addClass("uiframe-table-tr-click");
            }
            $(this).appendTo('#noselect-${id}').addClass("uiframe-table-tr-click").siblings("tr").removeClass("uiframe-table-tr-click");
            $('#noselect-${id}').find("tr.uiframe-table-tr-click").each( function () {
//                var right_number = $(this).attr("number");
                var myId = $(this).attr("myid");
                $(this).attr("id",myId);
                var right_value = $(this).attr("number");
                $(this).removeAttr("number");
                <%--multiSelect<%=id%><%=uuid%>.leftData[right_value] =  multiSelect<%=id%><%=uuid%>.rightData[right_number];--%>
                <%--multiSelect<%=id%><%=uuid%>.rightData.splice(right_number,1);--%>
                delete multiSelect<%=id%><%=uuid%>.rightData[right_value];
                delete multiSelect<%=id%><%=uuid%>.editData[right_value];
            });
            multiSelect<%=id%><%=uuid%>.load();
            multiSelect<%=id%><%=uuid%>.getDate();
        });
        //上一页按钮绑定事件
        $("#prev${id}").bind("click",function(){
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            var nowPage = parseInt(multiSelect<%=id%><%=uuid%>.startPage);
            var prevPage =nowPage-1;
            multiSelect<%=id%><%=uuid%>.startPage=""+prevPage;
            multiSelect<%=id%><%=uuid%>.start = (prevPage-1)*multiSelect<%=id%><%=uuid%>.recordPage;
            multiSelect<%=id%><%=uuid%>.load();
        });
        //下一页按钮绑定事件
        $("#next${id}").bind("click",function(){
            multiSelect<%=id%><%=uuid%>.changeBtnDisabled();
            var nowPage = parseInt(multiSelect<%=id%><%=uuid%>.startPage);
            var nextPage =nowPage+1;
            multiSelect<%=id%><%=uuid%>.startPage=""+nextPage;
            multiSelect<%=id%><%=uuid%>.start = (nextPage-1)*multiSelect<%=id%><%=uuid%>.recordPage;
            multiSelect<%=id%><%=uuid%>.load();
        });
        //第一页按钮绑定事件
        $("#first${id}").bind("click",function(){
            multiSelect<%=id%><%=uuid%>.startPage = 1;
            multiSelect<%=id%><%=uuid%>.start = 0;
            multiSelect<%=id%><%=uuid%>.load();
        });
        //最后一页按钮绑定事件
        $("#last${id}").bind("click",function(){
            multiSelect<%=id%><%=uuid%>.startPage = multiSelect<%=id%><%=uuid%>.totalPage;
            multiSelect<%=id%><%=uuid%>.start = (multiSelect<%=id%><%=uuid%>.totalPage-1)*multiSelect<%=id%><%=uuid%>.recordPage;
            multiSelect<%=id%><%=uuid%>.load();
        });
        //获取选中数据数组方法
        multiSelect<%=id%><%=uuid%>.getDate();
    };
    multi.orderNumber=47;
    executeQueue.push(multi);
})();

</script>
<div id="multiLayout${id}" class="uiframe-multilayout" tabindex=0 style="width: <%=w%>px;*-width: <%=w+30%>px;height:<%=h%>px">
    <div class="uiframe-multifieldset" style="width: <%=(w-66)/2%>px;height:<%=h%>px">
        <span class="uiframe-multi-title"><%=leftTitleText%></span>
        <div class="uiframe-multidiv-noselectParent" style="width: <%=(w-66)/2-2%>px;*-width: <%=(w-66)/2+7%>px;height:<%=h-25%>px">
        <%
         if(StringUtils.isNotEmpty(toolPage) && toolPage.equalsIgnoreCase("false")){
        %>
        	<div class="uiframe-multidiv-noselect" style="width: <%=(w-66)/2-2%>px;*-width: <%=(w-66)/2+7%>px;height:<%=h-25%>px">
        <%
          }else{
        %>
         	<div class="uiframe-multidiv-noselect" style="width: <%=(w-66)/2-2%>px;*-width: <%=(w-66)/2+7%>px;height:<%=h-57%>px">
        <%
       	 }
        %>
                <table id="noselect-${id}">
                </table>
            </div>
            <div class="uiframe-multiselect-tbardiv" style="width: <%=(w-66)/2-2%>px;*-width: <%=(w-66)/2+7%>px;<%=toolPageText%>">
                <div id="multi_bbar" class="uiframe-multiselect-tbar">
                    <table>
                        <tr>
                            <td class="uiframe-grid-span"></td>
                            <td style="line-height:18px;"><div style="_padding-top: 4px;">第</div></td>
                            <td><span id="page${id}"></span></td>
                            <td style="line-height:18px;">/</td>
                            <td><span id="totalpage${id}"></span></td>
                            <td class="uiframe-grid-span"></td>
                            <td style="line-height:18px;"><div style="_padding-top: 4px;">页</div></td>
                            <td class="uiframe-grid-span"></td>
                            <td><input type="button" class="uiframe-module-btn" id="prev${id}" style="padding: 0 2px;*-padding:0" value="上一页" /></td>
                            <td class="uiframe-grid-span"></td>
                            <td><input type="button" class="uiframe-module-btn" id="next${id}" style="padding: 0 2px;*-padding:0" value="下一页" /></td>
                            <td class="uiframe-grid-span"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="uiframe-multibuttondiv" style="height:<%=h%>px; ">
        <div class="uiframe-multibutton" style="margin-top:<%=(h-120)/2+20%>px;_margin-top:<%=(h-120)/2+10%>px; ">
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip" style="padding: 0;" id="addAll${id}" myTitle="选择全部"><span class="icon-multi-selAll">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip" style="padding: 0;" id="add${id}" myTitle="选择"><span class="icon-multi-sel">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip" style="padding: 0;" id="remove${id}" myTitle="删除"><span class="icon-multi-del">&nbsp;</span></button></div>
            <div class="uiframe-multibtn"><button type="button" class="uiframe-mutiButton tooltip" style="padding: 0;" id="removeAll${id}" myTitle="删除全部"><span class="icon-multi-delAll">&nbsp;</span></button></div>
            <%--<div class="uiframe-multibtn"><button type="button" class="uiframe-button two" id="remove_all${id}"><span class="icon-save">清空</span></button></div>--%>
        </div>
    </div>
    <div class="uiframe-multifieldset" style="width: <%=(w-66)/2%>px;*-width: <%=(w-66)/2+7%>px;height:<%=h%>px">
        <span class="uiframe-multi-title"><%=rightTitleText%></span>
        <div class="uiframe-multidiv-select" style="width: <%=(w-66)/2-2%>px;*-width: <%=(w-66)/2+7%>px;height:<%=h-25%>px">
            <table id="${id}">
            </table>
        </div>
    </div>
</div>
