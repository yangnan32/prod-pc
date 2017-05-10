<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-28上午10:37
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils"%>
<%@ tag import="java.util.Date" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="面板的id" %>
<%@attribute name="title" rtexprvalue="true" required="true" description="面板的标题" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="面板宽度" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="面板高度" %>
<%@attribute name="collapse" rtexprvalue="true" required="false" description="折叠按钮是否显示，ture和false" %>
<%@attribute name="panel" fragment="true"%>
<%
    long uuid=new Date().getTime();
    String collapseText = "";
    if(StringUtils.isNotEmpty(collapse) && collapse.equalsIgnoreCase("false")){
        collapseText="style='display:none'";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="100%";
    }
    if(height==null||height.equalsIgnoreCase("")){
        height="100%";
    }
%>
<script type="text/javascript">
$(document).ready(function(){
    //标签生成时计算面板高
    $("#panel${id}"+<%=uuid%>).height($("#${id}").height()-28);
    //重新设置面板宽度事件
    $("#${id}").on("setWidth", function (event,width) {
       $("#${id}").width(width);
    });
    //重新设置面板高度事件
    $("#${id}").on("setHeight", function (event,height) {
        $("#${id}").height(height);
        $("#panel${id}"+<%=uuid%>).height(height-28);
    });
    //重新设置面板title名称事件
    $("#${id}").on("setTitle", function (event,title) {
        $("#title${id}"+<%=uuid%>).text(title);
    });
    //巨鹿面板初始化高度
    var panelHeight${id}${uuid} = $("#${id}").height();
    //收缩按钮绑定事件（面板的显示隐藏操作）
    $("#${id}").find(".uiframe-panel-collapse-hide").on("click",function () {
        if ($(this).parents("table.uiframe-panel-table").find("tr.uiframe-panel-content").css("display") !== "none") {
            $(this).parents("div.uiframe-panel").height(28);
            $(this).parents("table.uiframe-panel-table").find("tr.uiframe-panel-content").hide();
            $(this).addClass("uiframe-panel-collapse-show");
        } else {
            $(this).parents("div.uiframe-panel").height(panelHeight${id}${uuid});
            $(this).parents("table.uiframe-panel-table").find("tr.uiframe-panel-content").show();
            $(this).removeClass("uiframe-panel-collapse-show");
        }
    });
});
</script>
<div class="uiframe-panel" id="${id}" style="width:<%=width%>;height:<%=height%>;">
    <table class="uiframe-panel-table" style="width: 100%;height: 100%;">
        <thead>
            <td class="uiframe-panel-top-l"></td>
            <td class="uiframe-panel-top-c" id="panelTitle${id}<%=uuid%>">
                <p class="uiframe-panel-title" id="title${id}<%=uuid%>"><%=title%></p>
                <p class="uiframe-panel-collapse-hide" <%=collapseText%>>&nbsp;</p>
            </td>
            <td class="uiframe-panel-top-r"></td>
        </thead>
        <tr class="uiframe-panel-content">
            <td class="uiframe-panel-main-l"></td>
            <td class="uiframe-panel-main-c">
                <div id="panel${id}<%=uuid%>" class="${cls}" style="width:100%">
                    <jsp:doBody/>
                </div>
            </td>
            <td class="uiframe-panel-main-r"></td>
        </tr>
        <tr>
            <td class="uiframe-panel-bottom-l"></td>
            <td class="uiframe-panel-bottom-c"></td>
            <td class="uiframe-panel-bottom-r"></td>
        </tr>
    </table>
</div>