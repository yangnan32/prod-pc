<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-11-6下午3:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="分页条数" %>
<%@attribute name="width" rtexprvalue="true" required="false" description="表格宽度" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="start" rtexprvalue="true" required="false" description="加载条数" %>
<%@attribute name="simpleBbar" rtexprvalue="true" required="false" description="是否应用简单翻页" %>
<%@attribute name="gridHeader" fragment="true"%>
<%
    if(limit==null||limit.equalsIgnoreCase("")){
        limit="10";
    }
    if(start==null||start.equalsIgnoreCase("")){
        start="0";
    }
    if(StringUtils.isNotEmpty(simpleBbar) && simpleBbar.equalsIgnoreCase("true")){
        simpleBbar = "style='display:none'";
    } else {
        simpleBbar = "";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="760";
    }
    float w=760;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=760;
    }
%>
<div style="width:100%;" id="<%=id%>" class="uiframe-portalGrid-panel">
    <div class="uiframe-portalGrid">
        <div style="width:100%;">
            <table style="width:100%;">
                <thead id="<%=id%>HeaderDiv" class="uiframe-portalGrid-header">
                <%-- 表格表头 --%>
                    <jsp:invoke fragment="gridHeader"/>
                </thead>
                <tbody id="<%=id%>MainDiv" class="uiframe-portalGrid-main">
                <%-- 表格数据 --%>
                </tbody>
                <tfoot>
                    <tr><td style="height:1px;border:none;"></td></tr>
                </tfoot>
            </table>
        </div>
    </div>
    <div class="uiframe-portalGrid-footer" id="<%=id%>Footer">
        <table style="width:100%;">
            <tbody>
            <tr>
                <td align="left" class="uiframe-portalGrid-footer-l">
                    <div <%=simpleBbar%> id="<%=id%>ToolPageRight"></div>
                </td>
                <td align="left" class="uiframe-portalGrid-footer-l"></td>
                <td align="right" class="uiframe-portalGrid-footer-r">
                    <table>
                        <tbody>
                        <tr>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td <%=simpleBbar%>><button type="button" class="uiframe-portalGrid-first-page" id="<%=id%>FirstBtn">&nbsp;</button></td>
                            <td <%=simpleBbar%> class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-prev-page" id="<%=id%>PrevBtn">&nbsp;</button></td>
                            <td <%=simpleBbar%> class="uiframe-portalGrid-toolSpan"></td>
                            <td <%=simpleBbar%> style="line-height:18px;"><div style="_padding-top: 3px;">第</div></td>
                            <td <%=simpleBbar%>><div style="_padding-top: 1px;"><input type="text" value="1" class="uiframe-portalGrid-footer-pages" id="<%=id%>Page"></div></td>
                            <td <%=simpleBbar%>><div style="_padding-top: 3px;">页,共<span class="uiframe-totalpage" id="<%=id%>TotalPage">1</span>页</div></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-next-page" id="<%=id%>NextBtn">&nbsp;</button></td>
                            <td <%=simpleBbar%> class="uiframe-portalGrid-toolSpan"></td>
                            <td <%=simpleBbar%>><button type="button" class="uiframe-portalGrid-last-page" id="<%=id%>LastBtn" >&nbsp;</button></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    var portalGrid = {
        url : "<%=url%>",                 // 加载url
        startPage : Math.ceil(parseInt("<%=start%>")/parseInt("<%=limit%>")) + 1,                  // 起始页
        total : 0,                      // 总条数
        startData:parseInt("<%=start%>"),  // 起始条数
        totalPage : 1,                  // 总页数
        baseParams:{},                  // 固定参数
        limit:parseInt("<%=limit%>")  //每页条数
    };

    //初始化翻页工具栏
    portalGrid.initialToolPage = function(){
        $("#<%=id%>TotalPage").text(portalGrid.totalPage);
        $("#<%=id%>Page").val(portalGrid.startPage);
        if(portalGrid.total == 0){
            portalGrid.pageBtnDisabled;
            $("#<%=id%>ToolPageRight").hide();
            $("#<%=id%>ToolPageRight").text("无数据");
        }  else {
            $("#<%=id%>ToolPageRight").show();
            $("#<%=id%>ToolPageRight").text("共"+portalGrid.total+"条结果");
            if(portalGrid.startPage == portalGrid.totalPage){
                $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("btnDisabled");
                $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("btnDisabled");
            }else{
                $("#<%=id%>NextBtn").removeAttr("disabled").removeClass("btnDisabled");
                $("#<%=id%>LastBtn").removeAttr("disabled").removeClass("btnDisabled");
            }
        }
        if(portalGrid.startPage == 1){
            $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("btnDisabled");
            $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("btnDisabled");
        }else{
            $("#<%=id%>PrevBtn").removeAttr("disabled").removeClass("btnDisabled");
            $("#<%=id%>FirstBtn").removeAttr("disabled").removeClass("btnDisabled");
        }
    };

    // 按钮应用方法
    portalGrid.pageBtnDisabled = function(){
        $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("btnDisabled");
    };

    // 刷新数据方法
    portalGrid.load = function(url, param){
        portalGrid.url = url;
        var myUrl = url;
        if (param && param != "") {
            // 定义baseParam参数
            portalGrid.baseParams = param;
            portalGrid.baseParams.limit = portalGrid.limit;
            portalGrid.baseParams.start = portalGrid.startData;
        }
        if(myUrl.indexOf("?")!=-1){
            myUrl+="&_time="+new Date().getTime()
        }else{
            myUrl+="?_time="+new Date().getTime()
        }
        $("#<%=id%>MainDiv").load(myUrl, portalGrid.baseParams, function(){
            portalGrid.total = parseInt($("#<%=id%>MainDiv").find("input.dataTotal").val());                 // 总条数
            portalGrid.totalPage = Math.ceil(parseInt(portalGrid.total)/parseInt("<%=limit%>"));
            portalGrid.startPage = Math.ceil(portalGrid.startData/parseInt("<%=limit%>")) + 1;
            $("#<%=id%>").trigger("getStart", [portalGrid.startData]);
            portalGrid.initialToolPage();     //初始化翻页工具栏
            if (loadCallBack) {
                loadCallBack()
            }
        });
    };

    // 刷新数据方法
    portalGrid.reload = function(params){
        if (params && params !="") {
            for (var param in params) {
                if (params.hasOwnProperty(param)){
                    portalGrid.baseParams[param] = params[param];
                }
            }
        }
        var myUrl = portalGrid.url;
        if(myUrl.indexOf("?")!=-1){
            myUrl+="&_time="+new Date().getTime()
        }else{
            myUrl+="?_time="+new Date().getTime()
        }
        $("#<%=id%>MainDiv").load(myUrl, portalGrid.baseParams, function(){
            portalGrid.total = parseInt($("#<%=id%>MainDiv").find("input.dataTotal").val());                 // 总条数
            portalGrid.totalPage = Math.ceil(parseInt(portalGrid.total)/parseInt("<%=limit%>"));
            portalGrid.startPage = Math.ceil(portalGrid.baseParams.start/parseInt("<%=limit%>")) + 1;
            $("#<%=id%>").trigger("getStart", [portalGrid.startData]);
            portalGrid.initialToolPage();     //初始化翻页工具栏
            if (loadCallBack) {
                loadCallBack()
            }
        });
    };


    $(function(){
        portalGrid.load(portalGrid.url, portalGrid.baseParams);
        // 表头复选框点击事件
        $("#<%=id%>HeaderDiv").find("td.uiframe-portalGrid-checkbox").die("click");
        $("#<%=id%>HeaderDiv").find("td.uiframe-portalGrid-checkbox").live("click", function(){
            if($(this).attr("checkbox") === "false"){
                $(this).removeClass("portalGrid-nocheck").addClass("portalGrid-check").attr("checkbox","true");
                $("#<%=id%>MainDiv").find("td.checkboxes").removeClass("portalGrid-nocheck").addClass("portalGrid-check").attr("checkbox","true");
                $("#<%=id%>MainDiv").find("tr.dataColumn").addClass("portalGridTrSelect");
                $("#<%=id%>MainDiv").find("tr").addClass("portalGridTrClick");
            } else {
                $(this).removeClass("portalGrid-check").addClass("portalGrid-nocheck").attr("checkbox","false");
                $("#<%=id%>MainDiv").find("td.checkboxes").removeClass("portalGrid-check").addClass("portalGrid-nocheck").attr("checkbox",false);
                $("#<%=id%>MainDiv").find("tr.dataColumn").removeClass("portalGridTrSelect");
                $("#<%=id%>MainDiv").find("tr").removeClass("portalGridTrClick");
            }
            $("#<%=id%>").trigger("getSelectData",[$("#<%=id%>MainDiv").find("tr.portalGridTrSelect")]);        // 选中数据时触发事件
        });

        // 表格数据复选框点击事件
        $("#<%=id%>MainDiv").find("td.uiframe-portalGrid-checkbox").die("click");
        $("#<%=id%>MainDiv").find("td.uiframe-portalGrid-checkbox").live("click", function(){
            if($(this).attr("checkbox") === "false"){
                $(this).removeClass("portalGrid-nocheck").addClass("portalGrid-check").attr("checkbox","true");
                $(this).parent("tr.dataColumn").addClass("portalGridTrSelect").addClass("portalGridTrClick");
                if ($(this).parent("tr.dataColumn").next("tr").hasClass("hideColumn")) {
                    $(this).parent("tr.dataColumn").next("tr").addClass("portalGridTrClick");
                }
            } else {
                $(this).removeClass("portalGrid-check").addClass("portalGrid-nocheck").attr("checkbox","false");
                $(this).parent("tr.dataColumn").removeClass("portalGridTrSelect").removeClass("portalGridTrClick");
                if ($(this).parent("tr.dataColumn").next("tr").hasClass("hideColumn")) {
                    $(this).parent("tr.dataColumn").next("tr").removeClass("portalGridTrClick");
                }
            }
            $("#<%=id%>").trigger("getSelectData",[$("#<%=id%>MainDiv").find("tr.portalGridTrSelect")]);       // 选中数据时触发事件
        });

        // 隐藏、显示列按钮
        $("#<%=id%>MainDiv").find("td.uiframe-portalGrid-btnColumn").live("click", function(){
            if($(this).attr("showFlag") === "false"){
                $(this).addClass("showColumnBtn").attr("showFlag","true");
                $(this).parent("tr.dataColumn").addClass("showColumn");
                $(this).parent("tr.dataColumn").next("tr.hideColumn").show();
            } else {
                $(this).removeClass("showColumnBtn").attr("showFlag","false");
                $(this).parent("tr.dataColumn").removeClass("showColumn");
                $(this).parent("tr.dataColumn").next("tr.hideColumn").hide();
            }
        });

        // 表格悬停事件
        $("#<%=id%>MainDiv").find("tr").live("mouseover", function(){
            $(this).addClass("portalGridTrHover");
            if ($(this).next("tr").hasClass("hideColumn")) {
                $(this).next("tr").addClass("portalGridTrHover");
            }
        });
        $("#<%=id%>MainDiv").find("tr").live("mouseout", function(){
            $(this).removeClass("portalGridTrHover");
            if ($(this).next("tr").hasClass("hideColumn")) {
                $(this).next("tr").removeClass("portalGridTrHover");
            }
        });


        // 第一页按钮绑定事件
        $("#<%=id%>FirstBtn").on("click", function(){
            portalGrid.startPage = 1;
            portalGrid.startData = 0;
            portalGrid.load(portalGrid.url, portalGrid.baseParams);
            <%--parent.iframeLoad("<%=url%>&startPage="+portalGrid.startPage+"&start="+param.start);--%>
        });

        // 上一页按钮绑定事件
        $("#<%=id%>PrevBtn").on("click", function(){
            portalGrid.startPage = parseInt(portalGrid.startPage) - 1;
            portalGrid.startData = (portalGrid.startPage - 1) * portalGrid.limit;
            portalGrid.load(portalGrid.url, portalGrid.baseParams);
        });

        // 下一页按钮绑定事件
        $("#<%=id%>NextBtn").on("click", function(){
            portalGrid.startPage = parseInt(portalGrid.startPage) + 1;
            portalGrid.startData = (portalGrid.startPage - 1) * portalGrid.limit;
            portalGrid.load(portalGrid.url, portalGrid.baseParams);
        });

        // 最后一页按钮绑定事件
        $("#<%=id%>LastBtn").on("click", function(){
            portalGrid.startPage = portalGrid.totalPage;
            portalGrid.startData = (portalGrid.startPage - 1) * portalGrid.limit;
            portalGrid.load(portalGrid.url, portalGrid.baseParams);
        });


        // 输入页数，回车执行方法
        $("#<%=id%>Page").on("keydown", function(event){
            if (event.keyCode == 13) {
                portalGrid.startPage = parseInt($(this).val());
                if (portalGrid.startPage > portalGrid.totalPage) {
                    portalGrid.startPage = portalGrid.totalPage;
                    portalGrid.startData = (portalGrid.startPage - 1) * portalGrid.limit;
                } else {
                    portalGrid.startData = (portalGrid.startPage - 1) * portalGrid.limit;
                }
                portalGrid.load(portalGrid.url, portalGrid.baseParams);
            }
        });

        // 刷新表格数据
        $("#${id}").on("reload", function (event, params) {
            portalGrid.reload(params);
        });

        //为此组件id绑定更换url方法
        $("#${id}").on("load", function (event, url, params) {
            portalGrid.load(url, params);
        });
    })
</script>