<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0
    * @created     : 15-01-19下午12:30
    * @team        :
    * @author      : liuyk
--%>
<%@ tag pageEncoding="utf-8"%>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe"%>
<%@ tag import="com.widget.utils.widgetUtil"%>
<%@ tag import="java.util.List"%>
<%@ tag import="java.util.ArrayList"%>
<%@ tag import="com.widget.system.UploadAction"%>
<%@ tag import="com.widget.fileserver.database.FileBean"%>
<%@ attribute name="id" required="true" description="定义上传控件ID。"%>
<%@ attribute name="fileListId" description="定义上传控文件展示dom元素id。"%>
<%@ attribute name="name" required="true" description="定义上传控件名称，用于获取已上传文件ID。"%>
<%@ attribute name="fileNumLimit" description="定义允许上传文件数量，默认为不限制。"%>
<%@ attribute name="fileTypeLimit" description="定义允许上传的文件类型限制，多个文件类型以;隔开，默认为不限制。"%>
<%@ attribute name="disabled" description="定义是否禁用，true禁用false不禁用，默认为false。"%>
<%@ attribute name="downloadEnable" description="定义是否允许下载，true可下载false不可下载，默认为true。"%>
<%@ attribute name="deleteEnable" description="定义是否允许删除文件，true可删除false不可删除，默认为true。"%>
<%@ attribute name="value" description="定义已经上传的文件ID，多个文件ID以,隔开。"%>
<%@ attribute name="text" description="定义上传按钮的文字，默认为[选择文件]。"%>
<%@ attribute name="deleteText" description="定义上传文件后文件后的删除按钮的文字，默认为[删除]。"%>
<%@ attribute name="width" description="定义组件的宽度"%>
<%@ attribute name="must" description="是否是必填项"%>
<%@ attribute name="fileName" description="名称"%>
<%@ attribute name="fileSize" description="定义文件上传大小，默认不限制。"%>
<%@ attribute name="isNeedSecurity" description="定义是否需要密级,默认不需要"%>
<%@ attribute name="auto" description="定义是否自动上传，默认为true"%>
<%@ attribute name="multi" description="定义是否支持多选，默认为true"%>
<%
    //对isNeedSecurity进行校验
    if(!widgetUtil.isEmpty(isNeedSecurity) && !"true".equals(isNeedSecurity)&& !"false".equals(isNeedSecurity)){
        throw new JspTagException(
             "Upload_TAG : isNeedSecurity只能定义为true或false。");
    }
    //对multi进行校验
    if(!widgetUtil.isEmpty(multi) && !"true".equals(multi)&& !"false".equals(multi)){
        throw new JspTagException(
             "Upload_TAG : multi只能定义为true或false。");
    }
    // 对auto进行校验
    if(!widgetUtil.isEmpty(auto) && !"true".equals(auto)&& !"false".equals(auto)){
        throw new JspTagException(
                "Upload_TAG : auto只能定义为true或false。");
    }
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
    boolean _isNeedSecurity = (!widgetUtil.isEmpty(isNeedSecurity)&& "true".equals(isNeedSecurity))? true : false;
    boolean _auto = (!widgetUtil.isEmpty(auto)&& "true".equals(auto))? true : false;
    boolean _multi = (!widgetUtil.isEmpty(multi)&& "false".equals(multi))? false : true;
    int _fileNumLimit = widgetUtil.isEmpty(fileNumLimit) ? 999 : Integer.parseInt(fileNumLimit);
    fileSize = widgetUtil.isEmpty(fileSize) ? "0" : fileSize;
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
    //当用户配置为不多选、将队列限制为1.
    if(!_multi){
        _fileNumLimit = 1;
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
        fileNum : 0,
        swfuploadify : "" //flashupload对象。
    };
 	// 清除文件上传队列  用于当文件发布完成后、文件队列不清除的问题
    upload<%=id%>.clearUploadQueue = function(){
    	var swfuploadify = upload<%=id%>.swfuploadify = window["uploadify_<%=id%>"];
    	swfuploadify.queueData.files = 0;
    };
    upload<%=id%>.getSecurityDegree = function(fileId) {
      var addSecu=$('<div class ="fileSecurity" style="clear:both;margin-right:20px;width:60px;float:left;z-index:1200"></div>');
      //给附件设置密级
      $.ajax({
          url : basePath+'/system/securityDegree/getSecurityDegreeListByType.json',
          type : 'POST',
          dataType: 'JSON',
          async : false,
          data : {securityDegreeType : 'user'},
          success : function(msg){
              if(msg.success){
                  var degreeId = upload<%=id%>.getSecurityDegreeIdByFileId(fileId);
                  var options = '<select id="'+fileId+'" >'
                  var data = msg.root.datas;
                  for(var i=0;i<data.length;i++){
                      if(data[i].securityId == degreeId){
                          options += '<option selected="true" value='+data[i].securityId+'>'+data[i].securityName+'</option>';
                      }else{
                          options += '<option value='+data[i].securityId+'>'+data[i].securityName+'</option>';
                      }
                  }
                  options += '</select>';
                  upload<%=id%>.securityDegree = $(options);
                  addSecu.append($(options));
              }
          }
      });
      return addSecu;
    };
    // 通过文件id获取密级id
    upload<%=id%>.getSecurityDegreeIdByFileId = function(fileId) {
         var degreeId = ""; 
         $.ajax({
             url : basePath + '/fileserver/getSecurityLevelByFileId.action',
             type : 'POST',
             dataType: 'JSON',
             async : false,
             data : {pid : fileId},
             success : function(msg){
                 degreeId =  msg.root.datas[0].id;
             }
         });
         return degreeId;
    }
    upload<%=id%>.getFileNum = function() {
        return upload<%=id%>.fileNum;
    };
    // num 为正..表示增加  为负 表示减少。
    upload<%=id%>.changeFileQueue = function(num) {
        var swfuploadify = upload<%=id%>.swfuploadify = window["uploadify_<%=id%>"];
        $('#<%=id%>').uploadify('settings','uploadLimit',swfuploadify.settings.uploadLimit+num);
    };
    upload<%=id%>.clearAllFile = function() {
        <%if(!widgetUtil.isEmpty(fileListId)){%>
            $('#<%=fileListId%>').html("");
        <%}else{%>
             $('#uploadifyFileListId<%=id%>').html("");
        <%}%>
        upload<%=id%>.fileNum =0;
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
    // 获取tokenid
    upload<%=id%>.getTokenId = function() {
        var reg1 = new RegExp("(^|)tokenId=([^;]*)(;|$)");
        var arr;
        if(arr = document.cookie.match(reg1)){
             return unescape(arr[2]);
        }
        return "";
    }
    // 取消上传文件的方法
    upload<%=id%>.cancelUpload = function(upload,fileNum,file,obj) {
        // 取消length减1.
         upload.cancelUpload(file.id);
         $(obj).parent().parent().remove();
         if(fileNum > 0) {
             upload<%=id%>.fileNum = fileNum-1;
         }
         $('#<%=id%>').attr("myTitle",'最多还能上传'+(<%=_fileNumLimit%>-upload<%=id%>.fileNum)+'个文件');
         upload<%=id%>.cleanButton();
    }
    upload<%=id%>.deleteFile = function(upload,fileNum,file,obj) {
         for ( var g in upload.queueData.files) {
                var f = upload.queueData.files[g];
                if(f.name == file.name){
                    upload.queueData.files[g]={};
                }
         }
         //解决删除的时候不删除队列的问题。
         upload<%=id%>.changeFileQueue(1);
         $(obj).parent().parent().remove();
         if(fileNum > 0) {
             upload<%=id%>.fileNum = fileNum-1;
         }
         $('#<%=id%>').attr("myTitle",'最多还能上传'+(<%=_fileNumLimit%>-upload<%=id%>.fileNum)+'个文件');
         upload<%=id%>.cleanButton();
    }
    $(function(){
        // 获取tokenId、解决cookie中tokenId丢失的我问题。
        var tokenId =upload<%=id%>.getTokenId();
        var id = "<%=id%>";
        <%if(widgetUtil.isEmpty(fileListId)){%>
        $("#<%=id%>").parent().css('overflow','auto');
        $("#<%=id%>").parent().append($("<ul id='uploadifyFileListId<%=id%>'></ul>"));
    	<%}%>
        <%if(!_disabled){%>
        $('#<%=id%>').uploadify({
            'swf' : basePath+"/uiframe/js/widgetui/plugins/uploadify3.2.1/uploadify.swf",
            'buttonImage' : basePath+'/uiframe/images/blue/newPortal/file.png',
            'uploader' : basePath + '/upload/system/fileUpload.action',
            'fileSizeLimit' : '<%=fileSize%>', //文件的极限大小.0为不限制
            'auto' : true, //自动上传
            'width' : 16,
            'fileTypeExts' : "<%=fileTypeLimit%>", //可以上传文件的类型
            'formData' : {'UUIDTOKEN':tokenId}, //自定义参数.
            'height' : 16,
            'multi' : true, //支持多选
            'uploadLimit' : "<%=_fileNumLimit%>", //能同时上传的文件数.
            'queueID': 'shareFileListQueueID',
            'itemTemplate' : true, 
            'queueSizeLimit' : "<%=_fileNumLimit%>", //队列中允许的最大文件数目。
            'removeCompleted' : false, //完成不移除进度条。
            'onUploadStart' : function(file){
                $("#"+file.id+" .uploadify-progress-bar").css("background","#7d9fd7");
            },
            'onUploadSuccess' : function(file,data,response){
                //显示删除按钮
                 $("#"+file.id+" .delete").css("display",'block');
                 $("#"+file.id+" .cancel").css("display",'none');
                //移除滚动条
                $("#"+file.id+" .uploadify-progress-bar").parent().remove();
                $("#"+file.id+" .data").remove();
                var obj = eval("("+data+")");
                 <%if(_isNeedSecurity){%>
                    securityDegreeCombox.fielIdData[file.id+securityDegreeCombox.DEGREE]=obj.fileMsg.fileId;
                 <%}%>
                //增加密级的设定
                var start = obj.fileMsg.fileName.lastIndexOf(".");
                var end = obj.fileMsg.fileName.length;
                var extension = obj.fileMsg.fileName.substring(start + 1, end);
                addFileList<%=id%>(file.id,obj.fileMsg.fileId, obj.fileMsg.fileName, obj.fileMsg.fileSize);
                // 当上传的文件数等于设置的文件数。禁用按钮
                if(upload<%=id%>.fileNum >= <%=_fileNumLimit%>){
                    $('#<%=id%>').uploadify('disable',true);
                    $('#<%=id%>').attr("myTitle",'文件上传数量已经达到最大值<%=_fileNumLimit%>');
                    return;
                }
                $('#<%=id%>').attr("myTitle",'最多还能上传'+(<%=_fileNumLimit%>-upload<%=id%>.fileNum)+'个文件');
            },
            'onSWFReady':function(){
            	<%if(_disabled){%>
            	$('#<%=id%>').uploadify('disable',true);
            	$('#<%=id%>').attr("myTitle",'上传文件功能已被禁用。');
        		<%}%>
            },
            'onSelect' : function(file){
            	var uploadNum = <%=_fileNumLimit%>-upload<%=id%>.fileNum;
            	if(uploadNum<=0){
            		$.sywDialog.msg("提示信息", "还能上传的文件数量为0,请删除文件后在上传.");
            		return;
            	}
                setFileList<%=id%>(this,file);
            },
            'onInit' : function(){
                // 当上传文件有限制的时候才提示。
                if(<%=_fileNumLimit%> <999 || <%=_multi%> ==false){
                    $('#<%=id%>').addClass("tooltip");
                    $('#<%=id%>').attr("myTitle",'最多能上传<%=_fileNumLimit%>个文件');
                }
                //设置图标的样式和当浏览器flash版本较低的时候。
                $("#<%=id%>-button").removeClass("uploadify-button").addClass("uploadify-button-my");
                $("#<%=id%>").on("click",function(){
                    var v = securityDegreeCombox.flashVersion();
                    if(!v){
                        $.sywDialog.confirm("提示信息","您的flash版本过低,请先下载flash并重新打开浏览器,您想立即下载安装吗？",function(){
                            window.location = basePath+"/fileserver/downloadFlash.action";
                        });
                    }
                });
            }
        });
        <%}%>
        var addFileList<%=id%> = function(id,fileId, fileName, fileSize) {
            var inputSpan=$('<input type="hidden" name="<%=name%>" value="' + fileId + '"/><input type="hidden" name="<%=name%>Name" value="' + fileName + '"/><input type="hidden" name="<%=name%>Size" value="' + fileSize + '"/>');
            $("#"+id+" .fileName").html(getDownloadFile<%=id%>(fileId,fileName,fileSize));
            var num = 0;
            //设置背景颜色
            <%if(!widgetUtil.isEmpty(fileListId)){%>
                $('#'+id).append(inputSpan);
                // 获取li的数量
                num = $('#<%=fileListId%>').children('li').length;
            <%}else{%>
                $('#'+id).append(inputSpan)
                num = $('#uploadifyFileListId<%=id%>').children('li').length;
           <% }%>
            upload<%=id%>.fileNum = num;
            upload<%=id%>.cleanButton();
        };
        var addEditFileLst<%=id%> = function(fileId, fileName, fileSize){
            var delSpan=$('<span style="text-decoration:underline; color:#4677c0;margin-right:10px;cursor:pointer;float:right" fileid="'+ fileId +'" filename="'+ fileName +'"><%=deleteText%></span>');
            var addSpan=$('<span style="color:#3d3d3d;float:left">' + getDownloadFile<%=id%>(fileId, fileName, fileSize) + '</span>');
            var inputSpan=$('<input type="hidden" name="<%=name%>" value="' + fileId + '"/><input type="hidden" name="<%=name%>Name" value="' + fileName + '"/><input type="hidden" name="<%=name%>Size" value="' + fileSize + '"/>');
            delSpan.bind("click",function(){
                $('#<%=id%>').uploadify('disable',false);
                upload<%=id%>.changeFileQueue(1);
                $(this).parent().remove();
                upload<%=id%>.fileNum --;
                $('#<%=id%>').attr("myTitle",'最多还能上传'+(<%=_fileNumLimit%>-upload<%=id%>.fileNum)+'个文件');
                upload<%=id%>.cleanButton();
            });
            var addDiv=$("<li style='margin-top:2px;'></li>");
            <%if(_isNeedSecurity){%>
                 var addSecu = upload<%=id%>.getSecurityDegree(fileId); 
                 addDiv.append(addSecu);
              <%}%>
            addDiv.append(addSpan);
            addDiv.append(inputSpan);
            <%if(!_disabled && _deleteEnable){%>
            addDiv.append(delSpan);
            <%}%>
            <%if(!widgetUtil.isEmpty(fileListId)){%>
                $('#<%=fileListId%>').append(addDiv);
            <%}else{%>
                 $('#uploadifyFileListId<%=id%>').append(addDiv);
            <%}%>
            <%if(_isNeedSecurity){%>
                securityDegreeCombox.init(fileId);
            <%}%>
            upload<%=id%>.fileNum ++;
            var uploadNum = (<%=_fileNumLimit%>-upload<%=id%>.fileNum);
            $('#<%=id%>').attr("myTitle",'最多还能上传'+uploadNum+'个文件');
            upload<%=id%>.cleanButton();
        };
        var getDownloadFile<%=id%> = function(fileId, fileName, fileSize) {
            <%
            if(_downloadEnable){
            %>
            return '<div style="width:<%=w-185%>px;"><a style="display:inline-block;" href="javascript:widget.downloadFile(\'' + fileId + '\')">' + fileName + '(' + getFileSize<%=id%>(fileSize) + ')</a></div>';
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
        
        var setFileList<%=id%> = function(obj,file) {
             var uploadify = obj;
             //开始的时候创建进度条！
              var itemTemplate = $('<div id='+file.id+' style="height:22px;width:100%;line-height:23px;">'); 
              var fileNameSpan = $('<span class="fileName" style="float:left;height:20px;">'+file.name+' ('+getFileSize<%=id%>(file.size)+')'+'</span>');
              var dataSpan = $('<span class="data" style="float:left;height:20px;width:100px;"></span>');
              var cancelDiv = $('<div class="cancel" style="color:#4677c0;margin-left:5px;width:5px;float:left;cursor:pointer;font-weight:bold">X</div>');
              var parentDiv = $('<div style="width:100px;float:left;border:1px solid #7d9fd7;margin-top:5px;"></div>'); 
              var progressDiv= $('<div class="uploadify-progress-bar" style="height:10px;float:left;margin:1px;"></div>');
              var delSpan=$('<span class="delete" style="text-decoration:underline; display:none;color:#4677c0;margin-right:10px;width:25px;float:right;cursor:pointer;" >删除</span>');
              cancelDiv.bind("click",function(){
                        $('#<%=id%>').uploadify('disable',false);
                      upload<%=id%>.cancelUpload(uploadify,upload<%=id%>.fileNum,file,this);
                });
              delSpan.bind("click",function(){
                      $('#<%=id%>').uploadify('disable',false);
                      upload<%=id%>.deleteFile(uploadify,upload<%=id%>.fileNum,file,this);
             });
              var fileId = file.id+securityDegreeCombox.DEGREE;
              <%if(_isNeedSecurity){%>
                  var addSecu = upload<%=id%>.getSecurityDegree(fileId); 
                  itemTemplate.append(addSecu);
              <%}%>
              parentDiv.append(progressDiv);
              itemTemplate.append(fileNameSpan);
              itemTemplate.append(dataSpan);
              itemTemplate.append(parentDiv);
              itemTemplate.append(cancelDiv);
              <%if(!_disabled && _deleteEnable){%>
                  itemTemplate.append(delSpan);
              <%}%>
              var addDiv=$("<li style='margin-top:2px;width:99%;'></li>");
              addDiv.append(itemTemplate);
              <%if(!widgetUtil.isEmpty(fileListId)){%>
                  $('#<%=fileListId%>').append(addDiv);
             <% }else{%>
                  $('#uploadifyFileListId<%=id%>').append(addDiv);
             <% }%>
              <%if(_isNeedSecurity){%>
                  securityDegreeCombox.init(fileId);
              <%}%>
              $("#"+file.id+" .uploadify-progress-bar").css("background","white");
              $("#"+file.id+" .uploadify-progress-bar").css("width","99%");
        };
        <%
        if(!widgetUtil.isEmpty(list)) {%>
           <% for(FileBean file : list) {
        %>
        addEditFileLst<%=id%>("<%=file.getPid()%>", "<%=file.getFilename()%>", <%=file.getFilesize()%>);
        <%
            }
        } else if(!widgetUtil.isEmpty(value)){
        %>
        <%if(!widgetUtil.isEmpty(fileListId)){%>
            $('#<%=fileListId%>').html("上传文件不存在或已经被移除！");
        <%}%>
        <%
        }
        %>
    });
</script>
<div id="<%=id%>" class="shareFile"><%=fileName%></div>
<script>
</script>
<!-- 上传文件控件结束 -->