<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 13-11-09下午17:37
    * @team	    :
    * @author      : yangn
--%>
<%@ tag pageEncoding="utf-8"%>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe"%>
<%@ tag import="com.widget.utils.widgetUtil"%>
<%@ tag import="java.util.List"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="com.widget.system.UploadAction"%>
<%@ tag import="com.widget.fileserver.database.FileBean"%>
<%@ attribute name="id" required="true" description="定义上传控件ID。"%>
<%@ attribute name="name" required="true" description="定义上传控件名称，用于获取已上传文件ID。"%>
<%@ attribute name="fileNumLimit" description="定义允许上传文件数量，默认为不限制。"%>
<%@ attribute name="fileTypeLimit" description="定义允许上传的文件类型限制，多个文件类型以|隔开，默认为不限制。"%>
<%@ attribute name="disabled" description="定义是否禁用，true禁用false不禁用，默认为false。"%>
<%@ attribute name="downloadEnable" description="定义是否允许下载，true可下载false不可下载，默认为true。"%>
<%@ attribute name="deleteEnable" description="定义是否允许删除文件，true可删除false不可删除，默认为true。"%>
<%@ attribute name="value" description="定义已经上传的文件ID，多个文件ID以,隔开。"%>
<%@ attribute name="text" description="定义上传按钮的文字，默认为[选择文件]。"%>
<%@ attribute name="deleteText" description="定义上传文件后文件后的删除按钮的文字，默认为[删除]。"%>
<%@ attribute name="width" description="定义组件的宽度"%>
<%@ attribute name="must" description="是否是必填项"%>
<%@ attribute name="fileName" description="名称"%>
<%
    if (!widgetUtil.isEmpty(fileNumLimit) && !widgetUtil.isInteger(fileNumLimit)) {
        throw new JspTagException(
                "Upload_TAG : fileNumLimit只能定义为整数。");
    }
    // 对disabled进行合法验证
    if (!widgetUtil.isEmpty(disabled) && !"true".equals(disabled)
            && !"false".equals(disabled)) {
        throw new JspTagException(
                "Upload_TAG : disabled只能定义为true或false。");
    }
    // 对downloadEnable进行合法验证
    if (!widgetUtil.isEmpty(downloadEnable) && !"true".equals(downloadEnable)
            && !"false".equals(downloadEnable)) {
        throw new JspTagException(
                "Upload_TAG : downloadEnable只能定义为true或false。");
    }
    // 对deleteEnable进行合法验证
    if (!widgetUtil.isEmpty(deleteEnable) && !"true".equals(deleteEnable)
            && !"false".equals(deleteEnable)) {
        throw new JspTagException(
                "Upload_TAG : deleteEnable只能定义为true或false。");
    }
    int _fileNumLimit = widgetUtil.isEmpty(fileNumLimit) ? 0 : Integer.parseInt(fileNumLimit);
    fileTypeLimit = widgetUtil.isEmpty(fileTypeLimit) ? "" : fileTypeLimit;
    text = widgetUtil.isEmpty(text) ? "选择" : text;
    deleteText = widgetUtil.isEmpty(deleteText) ? "删除" : deleteText;
    boolean _disabled = widgetUtil.isEmpty(disabled) ? false : Boolean.parseBoolean(disabled);
    boolean _downloadEnable = widgetUtil.isEmpty(downloadEnable) ? true : Boolean.parseBoolean(downloadEnable);
    boolean _deleteEnable = widgetUtil.isEmpty(deleteEnable) ? true : Boolean.parseBoolean(deleteEnable);
    List<FileBean> list = new ArrayList<FileBean>();
    if(!widgetUtil.isEmpty(value)) {
        list = new UploadAction().getFileList(value.split(","));
    }
    if(fileName==null||fileName.equalsIgnoreCase("")){
        fileName="";
    }
    if(width==null||width.equalsIgnoreCase("")){
        width="580";
    }
    float w=580;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=580;
    }
%>
<script type="text/javascript">
    var upload<%=id%> = {
        fileNum : 0
    };
    upload<%=id%>.getFileNum = function() {
        return upload<%=id%>.fileNum;
    };
    upload<%=id%>.clearAllFile = function() {
        $('#<%=id%>').parent("div").next("div.fileList").html("");
        fileNum<%=id%> = 0;
        upload<%=id%>.fileNum = fileNum<%=id%>;
        upload<%=id%>.cleanButton();
    }
    upload<%=id%>.cleanButton = function() {
        <%if(_fileNumLimit > 0 && !_disabled){%>
        if(upload<%=id%>.fileNum >= <%=_fileNumLimit%>) {
            $("#communication_upload_button_<%=id%>").css("display", "none");
        } else {
            $("#communication_upload_button_<%=id%>").css("display", "inline-block");
        }
        <%}%>
    };
    $(function(){
        var fileNum<%=id%> = 0;
        new AjaxUpload('#<%=id%>', {
            action: basePath + '/upload/system/fileUpload.action',
            name : 'fileToUpload',
            data : {},
            autoSubmit: true,
            onComplete: function(file, response) {
                var obj = eval("("+response+")");
                var start = obj.fileMsg.fileName.lastIndexOf(".");
                var end = obj.fileMsg.fileName.length;
                var extension = obj.fileMsg.fileName.substring(start + 1, end);
                if("<%=fileTypeLimit%>"!=""){
                    if(extension<%if(!widgetUtil.isEmpty(fileTypeLimit)){%> && /^(<%=fileTypeLimit%>)$/.test(extension)<%}%>){
                        addFileList<%=id%>(obj.fileMsg.fileId, obj.fileMsg.fileName, obj.fileMsg.fileSize);
                    }else{
                        $.sywDialog.warn("提示","非法文件，请重新上传！");
                        return false;
                    }
                }else{
                    addFileList<%=id%>(obj.fileMsg.fileId, obj.fileMsg.fileName, obj.fileMsg.fileSize);
                }
            }
        });
        var addFileList<%=id%> = function(fileId, fileName, fileSize) {
            var delSpan=$('<span style="text-decoration:underline; color:#4677c0;margin-left:10px;cursor:pointer;" fileid="'+ fileId +'" filename="'+ fileName +'"><%=deleteText%></span>');
            var addSpan=$('<span style="color:#3d3d3d;">' + getDownloadFile<%=id%>(fileId, fileName, fileSize) + '</span>');
            var inputSpan=$('<input type="hidden" name="<%=name%>" value="' + fileId + '"/><input type="hidden" name="<%=name%>Name" value="' + fileName + '"/><input type="hidden" name="<%=name%>Size" value="' + fileSize + '"/>');
            delSpan.bind("click",function(){
                $(this).parent().remove();
                if(fileNum<%=id%> > 0) {
                    fileNum<%=id%> --;
                    upload<%=id%>.fileNum = fileNum<%=id%>;
                }
                upload<%=id%>.cleanButton();
            });
            var addDiv=$('<li />');
            addDiv.append(addSpan);
            addDiv.append(inputSpan);
            <%if(!_disabled && _deleteEnable){%>
            addDiv.append(delSpan);
            <%}%>
            $('#<%=id%>').parent("div").next("div.fileList").append(addDiv);
            fileNum<%=id%> ++;
            upload<%=id%>.fileNum = fileNum<%=id%>;
            upload<%=id%>.cleanButton();
        };
        var getDownloadFile<%=id%> = function(fileId, fileName, fileSize) {
            <%
            if(_downloadEnable){
            %>
            return '<a class="tipHeader" style="width:<%=w-60%>px;display:inline-block;" href="javascript:widget.downloadFile(\'' + fileId + '\')">' + fileName + '(' + getFileSize<%=id%>(fileSize) + ')</a>';
            <%
            } else {
            %>
            return fileName + '(' + getFileSize<%=id%>(fileSize) + ')';
            <%
            }
            %>
        }
        var getFileSize<%=id%> = function(size) {
            var dw = ["B", "KB", "MB", "GB"];
            var i = 0;
            while(size > 1024 && i < dw.length) {
                size = size / 1024;
                i ++;
            }
            return (i > 0 ? size.toFixed(2) : size) + dw[i];
        };

        <%
        if(!widgetUtil.isEmpty(list)) {
            for(FileBean file : list) {
        %>
        addFileList<%=id%>("<%=file.getPid()%>", "<%=file.getFilename()%>", <%=file.getFilesize()%>);
        <%
            }
        } else if(!widgetUtil.isEmpty(value)){
        %>
        $('#<%=id%>').parent("div").next("div.fileList").html("上传文件不存在或已经被移除！");
        <%
        }
        %>
    });
</script>
<div id="<%=id%>" class="shareFile"><%=fileName%></div>
<!-- 上传文件控件结束 -->