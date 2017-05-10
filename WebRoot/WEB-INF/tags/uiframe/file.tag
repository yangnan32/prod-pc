<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-16下午2:24
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>

<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="fileId" rtexprvalue="true" required="true" description="控件id隐藏域ID,必填" %>
<%@attribute name="fileValueId" rtexprvalue="true" required="true" description="控件value隐藏域ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>
<%@attribute name="idName" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="valueName" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="resetbtn" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableClass="";
    String disableBtnClass="";
    String fontText="";
    String nameText="";
    String idText="";
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        disableClass="uiframe-textinput-disabled";
        disableBtnClass="uiframe-emptyTextColor";
    }

    if(StringUtils.isNotEmpty(resetbtn) && resetbtn.equalsIgnoreCase("true")){
        resetbtn="style='display:none'";
    }

    if(StringUtils.isNotBlank(valueName)){
        nameText="name='"+valueName+"'";
    }else {
        nameText="";
    }

    if(StringUtils.isNotBlank(idName)){
        idText="name='"+idName+"'";
    }else {
        idText="";
    }

    if(width==null||width.equalsIgnoreCase("")){
        width="334";
    }
    float w=334;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=334;
    }
%>
<script type="text/javascript">
var file<%=id%><%=uuid%> = {
    AjaxUpload:null
};
file<%=id%><%=uuid%>.initFile = function(){
    this.AjaxUpload = new AjaxUpload('filebtn${id}', {
        action: basePath + '/upload/doAjaxFileUpload.action',
        name : 'fileToUpload',
        data : {},
        autoSubmit: true,
        onComplete: function(file, response) {
            var obj = Ext.util.JSON.decode(response);
            $('#${id}').val(obj.fileMsg.fileName);
            $('#${fileId}').val(obj.fileMsg.fileId);
            $('#${fileValueId}').val(obj.fileMsg.fileName);
            $("#${id}").trigger("getFileName",[obj.fileMsg.fileName]);
            if(obj.fileMsg.fileName != "" && $("#${id}").hasClass("error")){
                $("#${id}").removeClass("error");
            }
            $('#${id}').focus();
        }
    });
    return this.AjaxUpload;
};
(function(){
    var file=function(){
        if("<%=disableClass%>" !== "uiframe-textinput-disabled"){
            file<%=id%><%=uuid%>.initFile();
        }
        //清空按钮操作
        $("#file${id}"+<%=uuid%>).find(".file-reset").each(function () {
            $(this).bind("click", function () {
                $('#${id}').val('');
                $('#${fileId}').val('');
                $('#${fileValueId}').val('');
            });
        });

        // 禁用
        $("#${id}").on("disable",function(){
            $("#filebtn${id}").addClass("uiframe-emptyTextColor");
            $("#${id}").attr("disabled","disabled").addClass("uiframe-textinput-disabled");
            file<%=id%><%=uuid%>.AjaxUpload.destroy();
        });
        // 启用
        $("#${id}").on("enable",function(){
            $("#filebtn${id}").removeClass("uiframe-emptyTextColor");
            $("#${id}").removeAttr("disabled").removeClass("uiframe-textinput-disabled");
            file<%=id%><%=uuid%>.initFile();
        });
    };
    file.orderNumber=36;
    executeQueue.push(file);
})();
</script>
<div class="uiframe-file-container" id="file<%=id%><%=uuid%>">
    <input type="hidden" id="${fileId}" <%=idText%> />
    <input type="hidden" id="${fileValueId}" <%=nameText%> />
    <input type="text" id="${id}" name="txt_${fileId}" readonly="readonly" class="uiframe-fileinput ${cls} ${group} <%=disableClass%>" style="float: left;width:<%=w%>px;<%=fontText%>" <%=disableText%> >
    <span id="filebtn${id}" class="uiframe-module-btn uiframe-button-file <%=disableBtnClass%>" style="<%=fontText%>" >浏览</span>
    <c:choose>
        <c:when test="${not empty must and must=='true'}">
            <span class="mustWrite" style="margin-left: 4px;">*</span>
        </c:when>
    </c:choose>
    <span class="file-reset" <%=resetbtn%> >清空</span>
</div>

