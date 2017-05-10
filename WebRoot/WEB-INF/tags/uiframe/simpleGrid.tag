<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-7-30上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="limit" rtexprvalue="true" required="false" description="分页条数" %>
<%@attribute name="startPage" rtexprvalue="true" required="false" description="起始页" %>
<%@attribute name="total" rtexprvalue="true" required="true" description="总条数" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="gridHeader" fragment="true"%>
<%@attribute name="gridMain" fragment="true"%>
<%
    if(limit==null||limit.equalsIgnoreCase("")){
        limit="10";
    }
	if(startPage==null||startPage.equalsIgnoreCase("")){
		startPage="1";
	}
%>
<div id="<%=id%>" style="height:100%;">
    <div style="width:100%;" id="gridId" class="uiframe-grid-panel">
        <div class="uiframe-grid">
            <div class="uiframe-grid-header" id="<%=id%>HeaderDiv">
                <table class="sywGridHeader">
                    <tbody>
                    <%-- 表格表头 --%>
                    <jsp:invoke fragment="gridHeader"/>
                    </tbody>
                </table>
            </div>
            <div class="uiframe-grid-main" id="<%=id%>MainDiv" style="width:100%;">
                <table class="sywGridMain">
                    <tbody>
                    <%-- 表格数据 --%>
                    <jsp:invoke fragment="gridMain"/>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="uiframe-grid-footer" id="<%=id%>Footer">
            <table style="width:100%;">
                <tbody>
                <tr>
                    <td align="left" class="uiframe-grid-footer-l">
                        <table>
                            <tbody>
                            <tr>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td><button type="button" class="uiframe-grid-first-page" id="<%=id%>FirstBtn">&nbsp;</button></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td><button type="button" class="uiframe-grid-prev-page" id="<%=id%>PrevBtn">&nbsp;</button></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td class="uiframe-grid-split"></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td style="line-height:18px;"><div style="_padding-top: 3px;">第</div></td>
                                <td><div style="_padding-top: 1px;"><input type="text" value="<%=startPage%>" class="uiframe-grid-footer-pages" id="<%=id%>Page"></div></td>
                                <td><div style="_padding-top: 3px;">页,共<span class="uiframe-totalpage" id="<%=id%>TotalPage"></span>页</div></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td class="uiframe-grid-split"></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td><button type="button" class="uiframe-grid-next-page" id="<%=id%>NextBtn">&nbsp;</button></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td><button type="button" class="uiframe-grid-last-page" id="<%=id%>LastBtn" >&nbsp;</button></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td class="uiframe-grid-split"></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td><button type="button" class="uiframe-grid-refresh" id="<%=id%>RefreshBtn">&nbsp;</button></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td class="uiframe-grid-split"></td>
                                <td class="uiframe-grid-toolSpan"></td>
                                <td style="line-height:18px;"><div style="_padding-top: 3px;">每页</div></td>
                                <td><div style="_padding-top: 1px;"><input type="text" value="<%=limit%>" class="uiframe-grid-footer-pages" id="<%=id%>Limit"></div></td>
                                <td><div style="_padding-top: 3px;">条</div></td>
                                <td class="uiframe-grid-toolSpan"></td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                    <td align="left" class="uiframe-grid-footer-l"></td>
                    <td align="right" class="uiframe-grid-footer-r"><div class="toolPageRight" id="<%=id%>ToolPageRight">显示<span class="startData" id="<%=id%>Start"></span>-<span class="endData" id="<%=id%>End"></span>条,共<span class="dataTotal"><%=total%></span>条</div></td>
                    <td class="uiframe-grid-toolSpan"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    var simpleGrid = {
        startPage : parseInt("<%=startPage%>"),                 // 起始页
        startData : (parseInt("<%=startPage%>") - 1) * parseInt("<%=limit%>"),                 // 起始条数
        total : parseInt("<%=total%>"),                 // 总条数
        totalPage : Math.ceil(parseInt("<%=total%>")/parseInt("<%=limit%>")),                 // 总页数
        limit:parseInt("<%=limit%>")  //每页条数
    };

    //初始化翻页工具栏
    simpleGrid.initialToolPage = function(){
        $("#<%=id%>TotalPage").text(simpleGrid.totalPage);
        $("#<%=id%>Start").text(simpleGrid.startData + 1);
        $("#<%=id%>End").text(simpleGrid.startPage * simpleGrid.limit);
        if(simpleGrid.total == 0){
            simpleGrid.pageBtnDisabled;
            $("#<%=id%>ToolPageRight").empty();
            $("#<%=id%>ToolPageRight").text("无数据");
        }  else {
            if(simpleGrid.startPage == simpleGrid.totalPage){
                $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("uiframe-grid-next-page-disabled");
                $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("uiframe-grid-last-page-disabled");
            }else{
                $("#<%=id%>NextBtn").removeAttr("disabled").removeClass("uiframe-grid-next-page-disabled");
                $("#<%=id%>LastBtn").removeAttr("disabled").removeClass("uiframe-grid-last-page-disabled");
            }
        }
        if(simpleGrid.startPage == 1){
            $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("uiframe-grid-prev-page-disabled");
            $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("uiframe-grid-first-page-disabled");
        }else{
            $("#<%=id%>PrevBtn").removeAttr("disabled").removeClass("uiframe-grid-prev-page-disabled");
            $("#<%=id%>FirstBtn").removeAttr("disabled").removeClass("uiframe-grid-first-page-disabled");
        }
    };

    // 按钮应用方法
    simpleGrid.pageBtnDisabled = function(){
        $("#<%=id%>FirstBtn").attr("disabled","disabled").addClass("uiframe-grid-first-page-disabled");
        $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("uiframe-grid-prev-page-disabled");
        $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("uiframe-grid-next-page-disabled");
        $("#<%=id%>LastBtn").attr("disabled","disabled").addClass("uiframe-grid-last-page-disabled");
    };

    // 获取选中数据方法
    simpleGrid.getSelectData = function(){
        return $("#<%=id%>MainDiv").find("tr.gridTrSelect");
    };

    // 刷新数据方法
    simpleGrid.reload = function(){
        document.location.reload();
    };

    $(function(){
        $("#<%=id%>MainDiv").height($(window).height() - 54 - 24);    // 表格数据的宽度
        simpleGrid.initialToolPage();     //初始化翻页工具栏

        // 表头随着表格数据横向滚动的方法
        $("#<%=id%>MainDiv").scroll(function(){
            $("#<%=id%>HeaderDiv").css("margin-left",-($(this).scrollLeft()));
        });

        // 表头复选框点击事件
        $("#<%=id%>HeaderDiv").find("td.uiframe-grid-checkbox").live("click", function(){
            if($(this).attr("checkbox") === "false"){
                $(this).removeClass("grid-nocheck").addClass("grid-check").attr("checkbox","true");
                $("#<%=id%>MainDiv").find("td.checkboxes").removeClass("grid-nocheck").addClass("grid-check").attr("checkbox","true");
                $("#<%=id%>MainDiv").find("tr").addClass("gridTrSelect");
            } else {
                $(this).removeClass("grid-check").addClass("grid-nocheck").attr("checkbox","false");
                $("#<%=id%>MainDiv").find("td.checkboxes").removeClass("grid-check").addClass("grid-nocheck").attr("checkbox",false);
                $("#<%=id%>MainDiv").find("tr").removeClass("gridTrSelect");
            }
        });

        // 表格数据复选框点击事件
        $("#<%=id%>MainDiv").find("td.uiframe-grid-checkbox").live("click", function(){
            if($(this).attr("checkbox") === "false"){
                $(this).removeClass("grid-nocheck").addClass("grid-check").attr("checkbox","true");
                $(this).parent("tr").addClass("gridTrSelect");
            } else {
                $(this).removeClass("grid-check").addClass("grid-nocheck").attr("checkbox","false");
                $(this).parent("tr").removeClass("gridTrSelect");
            }
        });

        // 第一页按钮绑定事件
        $("#<%=id%>FirstBtn").on("click", function(){
            simpleGrid.startPage = 1;
            simpleGrid.startData = 0;
            <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
            document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
        });

        // 上一页按钮绑定事件
        $("#<%=id%>PrevBtn").on("click", function(){
            simpleGrid.startPage = parseInt(simpleGrid.startPage) - 1;
            simpleGrid.startData = (simpleGrid.startPage - 1) * simpleGrid.limit;
            <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
            document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
        });

        // 下一页按钮绑定事件
        $("#<%=id%>NextBtn").on("click", function(){
            simpleGrid.startPage = parseInt(simpleGrid.startPage) + 1;
            simpleGrid.startData = (simpleGrid.startPage - 1) * simpleGrid.limit;
            <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
            document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
        });

        // 最后一页按钮绑定事件
        $("#<%=id%>LastBtn").on("click", function(){
            simpleGrid.startPage = simpleGrid.totalPage;
            simpleGrid.startData = (simpleGrid.startPage - 1) * simpleGrid.limit;
            <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
            document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
        });

        // 刷新按钮绑定事件
        $("#<%=id%>RefreshBtn").on("click", function(){
            simpleGrid.reload();
        });

        // 输入页数，回车执行方法
        $("#<%=id%>Page").on("keydown", function(event){
            if (event.keyCode == 13) {
                simpleGrid.startPage = parseInt($(this).val());
                simpleGrid.startData = (simpleGrid.startPage - 1) * simpleGrid.limit;
                <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
                document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
            }
        });

        // 输入每页条数，回车执行方法
        $("#<%=id%>Limit").on("keydown", function(event){
            if (event.keyCode == 13) {
                simpleGrid.limit = parseInt($(this).val());
                <%--parent.iframeLoad("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData);--%>
                document.location.replace("<%=url%>&startPage="+simpleGrid.startPage+"&start="+simpleGrid.startData+"&limit="+simpleGrid.limit);
            }
        });
    })
</script>