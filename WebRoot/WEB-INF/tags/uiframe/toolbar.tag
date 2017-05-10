<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @team	       :
    * @author      : hemq
    *description   :工具栏
--%>
<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@attribute name="id" rtexprvalue="true" required="false" description="工具栏唯一标识" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="工具栏style" %>
<%@attribute name="enableOverflow" rtexprvalue="true" required="false" description="是否允许按钮自动换行" %>
<%
    long uuid=new Date().getTime();
    if(id==null||id.equalsIgnoreCase("")){
        id=String.valueOf(new Date().getTime());
    }
    if(StringUtils.isNotEmpty(enableOverflow) && enableOverflow.equalsIgnoreCase("true")){
        enableOverflow="true";
    } else {
        enableOverflow="false";
    }
%>

<script type="text/javascript">
    var toolbarDiv${id}<%=uuid%> = {};

    // 监听工具栏显示宽度不够时，换行显示方法
    toolbarDiv${id}<%=uuid%>.resizeToolBarWidth = function(id) {
        var trueWidth = null;   //工具栏实际宽度
        var toolbarArray = $("#"+id).children("span");      //按钮数组集合
        var parentId = $("#"+id).parent("div").attr("id");    //工具栏的父级div的id值
        var once = 1;
        var two = 2;
        var myToolbar = $("<div id='"+id+"Two' class='uiframe-toolbar'></div>");
        for (var i = 0; i < toolbarArray.length;i++) {
            trueWidth += $(toolbarArray[i]).width();
            if(trueWidth > $("#"+id).width()) {
                //确保只执行一次的操作
                if(once == 1) {
                    $("#"+id).after(myToolbar);
                    sywFunction.initFit(parentId);
                    once++;
                }
                myToolbar.append($(toolbarArray[i]));
            }
        }
        //确保只执行一次的操作
        if(trueWidth < $("#"+id).width() && two == 2) {
            $("#"+id).append($("#"+id+"Two").html());
            $("#"+id+"Two").remove();
            sywFunction.initFit(parentId);
            two++;
        }
    };
    (function(){
        var toolbarDiv=function(){
            if ("<%=enableOverflow%>" === "true") {
                if (!widget.browser.isIE6()) {
                    toolbarDiv${id}<%=uuid%>.resizeToolBarWidth("<%=id%>");
                    $("#<%=id%>").on("resize", function(){
                        toolbarDiv${id}<%=uuid%>.resizeToolBarWidth("<%=id%>");
                    });
                }
            }
        };
        toolbarDiv.orderNumber=14;
        executeQueue.push(toolbarDiv);
    })();
</script>
<div id="<%=id%>" class="uiframe-toolbar" style="${style};">
    <jsp:doBody/>
</div>
<%--<div class="clearFloat"></div>--%>
