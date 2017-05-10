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
<%@attribute name="fileIdValue" rtexprvalue="true"  required="false" description="附件id的回显值" %>
<%@attribute name="fileNameValue" rtexprvalue="true"  required="false" description="附件name的回显值" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="resetbtn" rtexprvalue="true"  required="false" description="是否可用,值为true或者false" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="imageDiv" rtexprvalue="true"  required="false" description="显示图片的位置" %>
<%@attribute name="emptyImg" rtexprvalue="true"  required="false" description="默认显示图片" %>

<%
    long uuid=new Date().getTime();
    String disableText="";
    String disableClass="";
    String fontText="";
    String nameText="";
    String idText="";
    String fileIdValueText="";
    Boolean fileIdValueFlag=false;
    String fileNameValueText="";
    Boolean fileNameValueFlag=false;
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
        fontText="color:#b3b3b3";
        disableClass="uiframe-textinput-disabled";
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

    if(StringUtils.isNotBlank(fileNameValue)){
        fileNameValueText="fileNameValue='"+fileNameValue+"'";
        fileNameValueFlag = true;
    }else {
        fileNameValueText="";
    }

    if(StringUtils.isNotBlank(fileIdValue)){
        fileIdValueText="fileIdValue='"+fileIdValue+"'";
        fileIdValueFlag = true;
    }else {
        fileIdValueText="";
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

    if(height==null||height.equalsIgnoreCase("")){
        height="150";
    }
    float h=150;
    try{
        h=Float.parseFloat(height);
    }catch (NumberFormatException ex){
        h=150;
    }
%>
<script type="text/javascript">
    (function(){
        var file=function(){
            new AjaxUpload('filebtn${id}', {
                action: basePath + '/upload/doAjaxFileUpload.action',
                name : 'fileToUpload',
                data : {},
                autoSubmit: true,
                onComplete: function(file, response) {
                    var obj = eval("(" + response + ")");
                    $('#${id}').val(obj.fileMsg.fileName);
                    $('#${fileId}').val(obj.fileMsg.fileId);
                    $('#${fileValueId}').val(obj.fileMsg.fileName);
                    var name = obj.fileMsg.fileName;
                    if (name != "" && name.length > 0) {
                        //图片类型验证操作
                        var pos = name.lastIndexOf("\\");
                        name = name.substring(pos + 1, name.length);
                        var pos1 = name.lastIndexOf("\.");
                        var suffix = name.substring(pos1 + 1, name.length);
                        if (!(suffix == "jpg" || suffix == "JPG" || suffix == "bmp" || suffix == "BMP" || suffix == "png" || suffix == 'PNG'|| suffix == "gif" || suffix == 'GIF')) {
                            $.sywDialog.notice("提示","请选择图片格式文件","140px","80px","fileWinId");
                            $('#${id}').val("支持输JPG、PNG、GIF、BMP格式的图片文件");
                            $('#${id}').addClass("uiframe-emptyTextColor");
                            $('#${fileId}').val('');
                            $('#${fileValueId}').val('');
                            $("#<%=imageDiv %>").hide();
                            return false;
                        }
                    }
                    if(obj.fileMsg.fileName != "" && $("#${id}").hasClass("error")){
                        $("#${id}").removeClass("error");
                    }
                    $('#${id}').focus();
                    $('#${id}').removeClass("uiframe-emptyTextColor");
                    $("#<%=imageDiv %>").attr("src",basePath +'/download/?ID=' + obj.fileMsg.fileId + '&&DIS=true&ORIGINALNAME=' + encodeURI(encodeURI(obj.fileMsg.fileName)));
                    $("#<%=imageDiv %>").show();
                }
            });
            if("<%=disableClass%>" !== "uiframe-textinput-disabled"){
                <%--$("#filebtn${id}")[0].click();--%>
            }
            if (<%=fileNameValueFlag%> && <%=fileIdValueFlag%>) {
                $('#${id}').removeClass("uiframe-emptyTextColor");
                $('#${id}').val("<%=fileNameValue%>");
                $('#${fileId}').val("<%=fileIdValue%>");
                $('#${fileValueId}').val("<%=fileNameValue%>");
                $("#<%=imageDiv %>").attr("src",basePath +'/download/?ID=' + "<%=fileIdValue%>" + '&&DIS=true&ORIGINALNAME=' + encodeURI(encodeURI("<%=fileNameValue%>")));
            } else {
                $('#${id}').val("支持输JPG、PNG、GIF、BMP格式的图片文件");
                $('#${id}').addClass("uiframe-emptyTextColor");
            }
            //清空按钮操作
            $("#file${id}"+<%=uuid%>).find(".file-reset").each(function () {
                $(this).bind("click", function () {
                    $('#${id}').val("支持输JPG、PNG、GIF、BMP格式的图片文件");
                    $('#${id}').addClass("uiframe-emptyTextColor");
                    $('#${fileId}').val('');
                    $('#${fileValueId}').val('');
                    $("#<%=imageDiv %>").attr("src", "${emptyImg}");
                });
            });
        };
        file.orderNumber=38;
        executeQueue.push(file);
    })();
</script>
<div class="uiframe-file-container" id="file<%=id%><%=uuid%>">
    <input type="hidden" id="${fileId}" <%=fileIdValueText%> <%=idText%> />
    <input type="hidden" id="${fileValueId}" <%=fileNameValueText%> <%=nameText%> />
    <input type="text" id="${id}" name="txt_${fileId}" readonly="readonly" class="uiframe-fileinput ${cls} ${group} <%=disableClass%>" style="float: left;width:<%=w%>px;<%=fontText%>" <%=disableText%> >
    <span id="filebtn${id}" class="uiframe-module-btn uiframe-button-file" style="<%=fontText%>" >浏览</span>
    <c:choose>
        <c:when test="${not empty must and must=='true'}">
            <span class="mustWrite" style="margin-left: 4px;">*</span>
        </c:when>
    </c:choose>
    <span class="file-reset" <%=resetbtn%> >清空</span>
</div>