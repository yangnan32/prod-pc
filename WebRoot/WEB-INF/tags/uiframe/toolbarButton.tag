<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @team	       :
    * @author      : yangn
    *description   :工具栏按钮
--%>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="按钮ID" %>
<%@attribute name="btnCls" rtexprvalue="true" required="false" description="按钮class样式名" %>
<%@attribute name="iconCls" rtexprvalue="true" required="false" description="图标class样式名" %>
<%@attribute name="title" rtexprvalue="true" required="false" description="提示的标题" %>
<%@attribute name="style" rtexprvalue="true" required="false" description="style行内样式" %>
<%@attribute name="text" rtexprvalue="true" required="false" description="按钮是否有文字，true和false，默认是true" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="hidden" rtexprvalue="true"  required="false" description="是否隐藏,值为true或者false" %>
<%@attribute name="attr" rtexprvalue="true"  required="false" description="标签属的性值" %>
<%
    String noTextClass = "";
    String titleText = "";
    String titleClass = "";
    String btnText = "";
    String disableText = "";
    String hiddenText = "";

    if(id==null){
        id=String.valueOf(new Date().getTime());
    }

    if(StringUtils.isNotBlank(title)){
        titleText="myTitle='"+title+"'";
        titleClass="tooltip";
    }else {
        titleText="";
        titleClass="";
    }
    if(StringUtils.isBlank(btnCls))btnCls="";
    if(StringUtils.isBlank(style))style="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equals("true")){
        disableText="disabled='disabled'";
        btnText = "uiframe-toolbarBtn-disabled";
    } else {
        disableText="";
        btnText = "uiframe-toolbarHover";
    }
    if(StringUtils.isBlank(iconCls))iconCls="";
    if(StringUtils.isNotEmpty(text) && text.equalsIgnoreCase("false")){
        noTextClass="tool-button-noText";
    } else {
        noTextClass = "";
    }
    if(StringUtils.isNotEmpty(hidden) && hidden.equalsIgnoreCase("true")){
        hiddenText="uiframe-hide";
    } else {
        hiddenText = "";
    }
%>
<script type="text/javascript">
    (function(){
        var toolbarButton=function(){
            $("#${id}").on("disabled",function(e){
                $(this).attr("disabled","disabled");
                if($("#btnParent${id}").parent().is("div.uiframe-sub-toolbarOverflow") || $("#btnParent${id}").parent().is("div.uiframe-submenu")){
                    $("#btnParent${id}").addClass("uiframe-menu-disabled");
                    $("#btnParent${id}").removeClass("uiframe-toolbarBtn-click");
                    $("#btnParent${id}").removeClass("uiframe-toolbarBtn-hover");
                    if ($("#tooltip")) {
                        $("#tooltip").remove();
                    }
                } else {
                    $("#btnParent${id}").removeClass("uiframe-toolbarHover");
                    $("#btnParent${id}").addClass("uiframe-toolbarBtn-disabled");
                    $("#btnParent${id}").removeClass("uiframe-toolbarBtn-hover");
                    if ($("#tooltip")) {
                        $("#tooltip").remove();
                    }
                }
                e.preventDefault();

            });
            $("#${id}").on("enable",function(e){
                $(this).removeAttr("disabled");
                if($("#btnParent${id}").parent().is("div.uiframe-sub-toolbarOverflow") || $("#btnParent${id}").parent().is("div.uiframe-submenu")){
                    $("#btnParent${id}").removeClass("uiframe-menu-disabled");
                } else {
                    $("#btnParent${id}").addClass("uiframe-toolbarHover");
                    $("#btnParent${id}").removeClass("uiframe-toolbarBtn-disabled");
                }
                e.preventDefault();
            });
            if("${disabled}" === "true") {
                if($("#btnParent${id}").parent().is("div.uiframe-sub-toolbarOverflow")  || $("#btnParent${id}").parent().is("div.uiframe-submenu")){
                    $("#btnParent${id}").removeClass("uiframe-toolbarBtn-disabled");
                    $("#btnParent${id}").addClass("uiframe-menu-disabled");
                }
            }
            if("<%=disabled%>" == "true"){
            	$("#${id}").trigger("disabled");	//本页刷新时判断是否禁用
            }
        };
        toolbarButton.orderNumber=15;
        executeQueue.push(toolbarButton);
    })();
</script>
<span id="btnParent${id}" <%=titleText%> class="<%=btnText%> <%=titleClass%> <%=hiddenText%>">
    <div class="toolbar-left"></div>
    <div class="toolbar-center">
        <button type="button" <%=attr%> id="${id}" class="tool-button <%=btnCls%> <%=noTextClass%>" style="<%=style%>" <%=disableText%>><span class="uiframe-toolbarBtnIcon <%=iconCls%>">&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="toolbarText"><jsp:doBody/></span></button>
    </div>
    <div class="toolbar-right"></div>
</span>