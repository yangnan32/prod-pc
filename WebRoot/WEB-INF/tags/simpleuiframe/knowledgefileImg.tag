<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-16下午2:24
    * @team	    : 
    * @author      : yangn
    * @ps      : 定制功能，不做升级，单独维护
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>

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

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
    long uuid=new Date().getTime();
    String nameText="";
    String idText="";
    String fileIdValueText="";
    Boolean fileIdValueFlag=false;
    String fileNameValueText="";
    Boolean fileNameValueFlag=false;

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
%>
<div id="<%=id%>" style="height:180px;width:220px;overflow:hidden;">
    <input type="hidden" id="${fileId}" <%=fileIdValueText%> <%=idText%> />
    <input type="hidden" id="${fileValueId}" <%=fileNameValueText%> <%=nameText%> />
    <img id="${id}Img" style="height:150px;width:200px;margin-left:10px;" src="${basePath}/ke/product/professional/item/img/knowledgeFileBg.png" />
</div>

<script type="text/javascript">
    (function(){
        var fileImg = function(){
            new AjaxUpload('${id}', {
                action: basePath + '/upload/doAjaxFileUpload.action',
                name : 'fileToUpload',
                data : {},
                autoSubmit: true,
                onComplete: function(file, response) {
                    var obj = eval("("+response+")");
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
                            $('#${fileId}').val('');
                            $('#${fileValueId}').val('');
                            return false;
                        }
                    }
                    $("#${id}Img").attr("src",basePath +'/download/?ID=' + obj.fileMsg.fileId + '&&DIS=true&ORIGINALNAME=' + encodeURI(encodeURI(obj.fileMsg.fileName))).show();
                }
            });
            if (<%=fileNameValueFlag%> && <%=fileIdValueFlag%>) {
                $('#${fileId}').val("<%=fileIdValue%>");
                $('#${fileValueId}').val("<%=fileNameValue%>");
                $("#${id}Img").attr("src",basePath +'/download/?ID=' + "<%=fileIdValue%>" + '&&DIS=true&ORIGINALNAME=' + encodeURI(encodeURI("<%=fileNameValue%>"))).show();
            }
        };
        fileImg.orderNumber = 34;
        executeQueue.push(fileImg);
    })();
</script>
