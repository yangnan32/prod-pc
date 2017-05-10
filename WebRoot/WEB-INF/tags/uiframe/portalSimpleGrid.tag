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
<%@attribute name="gridHeader" fragment="true"%>
<%
    if(limit==null||limit.equalsIgnoreCase("")){
        limit="10";
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
<div style="width:100%;" id="<%=id%>" class="uiframe-portalSimpleGrid-panel">
    <div class="uiframe-portalSimpleGrid-cutLine" style="width:90%;"></div>
    <div class="uiframe-portalSimpleGrid">
        <div style="width:100%;">
            <table style="width:100%;">
                <tbody id="<%=id%>MainDiv" class="uiframe-portalSimpleGrid-main">
                <%-- 表格数据 --%>
                </tbody>
                <tfoot>
                    <tr><td style="height:1px;border:none;"></td></tr>
                </tfoot>
            </table>
        </div>
    </div>
    <!-- <div class="uiframe-portalSimpleGrid-cutLine"style="width:900%;"></div>  -->
    <div class="uiframe-portalGrid-footer" style="width:92%" id="<%=id%>Footer">
        <table style="width:100%;">
            <tbody>
            <tr>
                <td align="left" class="uiframe-portalGrid-footer-l"></td>
                <td align="right" class="uiframe-portalGrid-footer-r">
                    <table>
                        <tbody>
                        <tr>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-first-page" id="<%=id%>FirstBtn">&nbsp;</button></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-prev-page" id="<%=id%>PrevBtn">&nbsp;</button></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td style="line-height:18px;"><div style="_padding-top: 3px;">第</div></td>
                            <td><div style="_padding-top: 1px;"><input type="text" value="1" class="uiframe-portalGrid-footer-pages" id="<%=id%>Page"></div></td>
                            <td><div style="_padding-top: 3px;">页,共<span class="uiframe-totalpage" id="<%=id%>TotalPage"></span>页</div></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-next-page" id="<%=id%>NextBtn">&nbsp;</button></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                            <td><button type="button" class="uiframe-portalGrid-last-page" id="<%=id%>LastBtn" >&nbsp;</button></td>
                            <td class="uiframe-portalGrid-toolSpan"></td>
                        </tr>
                        </tbody>
                    </table>
                <td class="uiframe-portalGrid-toolSpan"></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    var portalSimpleGrid = {
        url : "<%=url%>",                 // 加载url
        startPage : 1,                 // 起始页
        startData : 0,                 // 起始条数
        total : 0,                 // 总条数
        totalPage : 1,                 // 总页数
        limit:parseInt("<%=limit%>")  //每页条数
    };

    //初始化翻页工具栏
    portalSimpleGrid.initialToolPage = function(){
        $("#<%=id%>TotalPage").text(portalSimpleGrid.totalPage);
        $("#<%=id%>Page").val(portalSimpleGrid.startPage);
        if(portalSimpleGrid.total == 0){
            portalSimpleGrid.pageBtnDisabled;
            $("#<%=id%>ToolPageRight").empty();
            $("#<%=id%>ToolPageRight").text("无数据");
        }  else {
            $("#<%=id%>DataTotal").text(portalSimpleGrid.total);
            if(portalSimpleGrid.startPage == portalSimpleGrid.totalPage){
                $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("btnDisabled");
                $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("btnDisabled");
            }else{
                $("#<%=id%>NextBtn").removeAttr("disabled").removeClass("btnDisabled");
                $("#<%=id%>LastBtn").removeAttr("disabled").removeClass("btnDisabled");
            }
        }
        if(portalSimpleGrid.startPage == 1){
            $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("btnDisabled");
            $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("btnDisabled");
        }else{
            $("#<%=id%>PrevBtn").removeAttr("disabled").removeClass("btnDisabled");
            $("#<%=id%>FirstBtn").removeAttr("disabled").removeClass("btnDisabled");
        }
    };

    // 按钮应用方法
    portalSimpleGrid.pageBtnDisabled = function(){
        $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("btnDisabled");
        $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("btnDisabled");
    };

    // 刷新数据方法
    portalSimpleGrid.load = function(url, param){
        portalSimpleGrid.url = url;
        var myUrl = url;
        param.limit=portalSimpleGrid.limit;
        param.start=portalSimpleGrid.startData;
        if(myUrl.indexOf("?")!=-1){
            myUrl+="&_time="+new Date().getTime()
        }else{
            myUrl+="?_time="+new Date().getTime()
        }
        $("#<%=id%>MainDiv").load(myUrl, param, function(){
            portalSimpleGrid.initialToolPage();     //初始化翻页工具栏
            if (loadCallBack) {
                loadCallBack()
            }
        });
    };

    // 刷新数据方法
    portalSimpleGrid.reload = function(){
        var myUrl = portalSimpleGrid.url;
        var param = {
            limit:portalSimpleGrid.limit,
            start:portalSimpleGrid.startData
        }
        if(myUrl.indexOf("?")!=-1){
            myUrl+="&_time="+new Date().getTime()
        }else{
            myUrl+="?_time="+new Date().getTime()
        }
        $("#<%=id%>MainDiv").load(myUrl, param, function(){
            portalSimpleGrid.total = parseInt($("#<%=id%>MainDiv").find("input.dataTotal").val());                 // 总条数
            portalSimpleGrid.totalPage = Math.ceil(parseInt(portalSimpleGrid.total)/parseInt("<%=limit%>"));
            portalSimpleGrid.initialToolPage();     //初始化翻页工具栏
            if (loadCallBack) {
                loadCallBack()
            }
        });
    };

    $(function(){

        portalSimpleGrid.reload();

        // 第一页按钮绑定事件
        $("#<%=id%>FirstBtn").on("click", function(){
            portalSimpleGrid.startPage = 1;
            portalSimpleGrid.startData = 0;
            portalSimpleGrid.reload();
            <%--parent.iframeLoad("<%=url%>&startPage="+portalSimpleGrid.startPage+"&start="+param.start);--%>
        });

        // 上一页按钮绑定事件
        $("#<%=id%>PrevBtn").on("click", function(){
            portalSimpleGrid.startPage = parseInt(portalSimpleGrid.startPage) - 1;
            portalSimpleGrid.startData = (portalSimpleGrid.startPage - 1) * portalSimpleGrid.limit;
            portalSimpleGrid.reload();
        });

        // 下一页按钮绑定事件
        $("#<%=id%>NextBtn").on("click", function(){
            portalSimpleGrid.startPage = parseInt(portalSimpleGrid.startPage) + 1;
            portalSimpleGrid.startData = (portalSimpleGrid.startPage - 1) * portalSimpleGrid.limit;
            portalSimpleGrid.reload();
        });

        // 最后一页按钮绑定事件
        $("#<%=id%>LastBtn").on("click", function(){
            portalSimpleGrid.startPage = portalSimpleGrid.totalPage;
            portalSimpleGrid.startData = (portalSimpleGrid.startPage - 1) * portalSimpleGrid.limit;
            portalSimpleGrid.reload();
        });


        // 输入页数，回车执行方法
        $("#<%=id%>Page").on("keydown", function(event){
            if (event.keyCode == 13) {
                portalSimpleGrid.startPage = parseInt($(this).val());
                if (portalSimpleGrid.startPage > portalSimpleGrid.totalPage) {
                    portalSimpleGrid.startPage = portalSimpleGrid.totalPage;
                    portalSimpleGrid.startData = (portalSimpleGrid.startPage - 1) * portalSimpleGrid.limit;
                } else {
                    portalSimpleGrid.startData = (portalSimpleGrid.startPage - 1) * portalSimpleGrid.limit;
                }
                portalSimpleGrid.reload();
            }
        });

        // 刷新表格数据
        $("#${id}").on("reload", function () {
            portalSimpleGrid.reload();
        });

        //为此组件id绑定更换url方法
        $("#${id}").on("load", function (event, url, params) {
            portalSimpleGrid.load(url, params);
        });

    })
</script>