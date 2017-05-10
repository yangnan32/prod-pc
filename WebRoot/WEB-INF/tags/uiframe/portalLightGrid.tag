<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="java.util.Date" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="width" rtexprvalue="true" required="false" description="表格宽度" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="gridHeader" fragment="true"%>
<%
    if(width==null||width.equalsIgnoreCase("")) {
        width="760";
    }
    float w=760;
    try{
        w=Float.parseFloat(width);
    } catch (NumberFormatException ex){
        w=760;
    }
%>
<div style="width:100%;" id="<%=id%>" class="uiframe-portalLightGrid-panel">
    <div class="uiframe-portalLightGrid">
        <div style="width:100%;">
            <table style="width:100%;">
                <thead id="<%=id%>HeaderDiv" class="uiframe-portalLightGrid-header">
                <%-- 表格表头 --%>
                    <jsp:invoke fragment="gridHeader"/>
                </thead>
                <tbody id="<%=id%>MainDiv" class="uiframe-portalLightGrid-main">
                <%-- 表格数据 --%>
                </tbody>
                <tfoot>
                    <tr><td style="height:1px;border:none;"></td></tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    var portalGrid = {
        url : "<%=url%>", // 加载url
        baseParams:{} // 固定参数
    };

    // 刷新数据方法
    portalGrid.load = function(url, param){
        portalGrid.url = url;
        var myUrl = url;
        if (param && param != "") {
            // 定义baseParam参数
            portalGrid.baseParams = param;
        }
        if(myUrl.indexOf("?")!=-1){
            myUrl+="&_time="+new Date().getTime()
        }else{
            myUrl+="?_time="+new Date().getTime()
        }
        $("#<%=id%>MainDiv").load(myUrl, portalGrid.baseParams, function(){
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
            if (loadCallBack) {
                loadCallBack()
            }
        });
    };


    $(function(){
        portalGrid.load(portalGrid.url, portalGrid.baseParams);

        // 隐藏、显示列按钮
        $("#<%=id%>MainDiv").find("td.uiframe-portalLightGrid-btnColumn").live("click", function(){
            if($(this).attr("showFlag") === "false"){
                $(this).addClass("uiframe-portalLightGrid-showColumnBtn").attr("showFlag","true");
                $(this).parent("tr.uiframe-portalLightGrid-dataColumn").addClass("uiframe-portalLightGrid-showColumn");
                $(this).parent("tr.uiframe-portalLightGrid-dataColumn").next("tr.uiframe-portalLightGrid-hideColumn").show();
            } else {
                $(this).removeClass("uiframe-portalLightGrid-showColumnBtn").attr("showFlag","false");
                $(this).parent("tr.uiframe-portalLightGrid-dataColumn").removeClass("uiframe-portalLightGrid-showColumn");
                $(this).parent("tr.uiframe-portalLightGrid-dataColumn").next("tr.uiframe-portalLightGrid-hideColumn").hide();
            }
        });
        
        // 表格悬停事件
        $("#<%=id%>MainDiv").find("tr").live("mouseover", function(){
            $(this).addClass("uiframe-portalLightGrid-trHover");
            if ($(this).next("tr").hasClass("uiframe-portalLightGrid-hideColumn")) {
                $(this).next("tr").addClass("uiframe-portalLightGrid-trHover");
            }
        });
        $("#<%=id%>MainDiv").find("tr").live("mouseout", function(){
            $(this).removeClass("uiframe-portalLightGrid-trHover");
            if ($(this).next("tr").hasClass("uiframe-portalLightGrid-hideColumn")) {
                $(this).next("tr").removeClass("uiframe-portalLightGrid-trHover");
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