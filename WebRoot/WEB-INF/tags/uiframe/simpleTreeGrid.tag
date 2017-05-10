<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-7-30上午10:33
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="url" rtexprvalue="true" required="false" description="刷新数据地址" %>
<%@attribute name="treeGridHeader" fragment="true"%>
<%@attribute name="treeGridMain" fragment="true"%>
<div id="<%=id%>" style="height:100%;">
    <div style="width:100%;" id="gridId" class="uiframe-treeGrid-panel">
        <div class="uiframe-grid">
            <div class="uiframe-grid-header" id="<%=id%>HeaderDiv">
                <table class="sywTreeGridHeader">
                    <tbody>
                    <%-- 表格表头 --%>
                    <jsp:invoke fragment="treeGridHeader"/>
                    </tbody>
                </table>
            </div>
            <div class="uiframe-treeGrid-main" id="<%=id%>MainDiv" style="width:100%;position:relative;">
                <table class="sywTreeGridMain" id="<%=id%>MainTable">
                    <tbody>
                    <%-- 表格数据 --%>
                    <jsp:invoke fragment="treeGridMain"/>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var simpleTreeGrid = {};

    // 获取选中数据方法
    simpleTreeGrid.getSelectData = function(){
        return $("#<%=id%>MainDiv").find("tr.gridTrSelect");
    };
    $(function(){

        // 表格数据的宽度
        $("#<%=id%>MainDiv").height($(window).height() - 26);

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
    })
</script>