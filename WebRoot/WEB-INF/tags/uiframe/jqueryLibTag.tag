<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    List<String> jsList=new ArrayList<String>(20);
    //js集合
    jsList.add("/uiframe/js/jquery/jquery-1.7.2.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.core.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.widget.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.mouse.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.draggable.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.sortable.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.resizable.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-validation-1.9.0/jquery.validate.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-validation-1.9.0/jquery.metadata.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-validation-1.9.0/messages_cn.js");
    jsList.add("/uiframe/js/jquery/plugin/pnotify-1.1.0/jquery.pnotify.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery-form/jquery.form.js");
    jsList.add("/uiframe/js/jquery/plugin/wdScrollTab/sywTab.js");
    jsList.add("/uiframe/js/jquery/plugin/shiftcheck/jquery.shiftcheck.js");
    jsList.add("/uiframe/js/jquery/plugin/contextmenu/AeroWindow-Contextmenu v0.2.js");
    jsList.add("/uiframe/js/jquery/plugin/ajaxFileUpload/ajaxfileupload.js");
    jsList.add("/uiframe/js/jquery/plugin/resize/jquery.ba-resize.js");
    jsList.add("/uiframe/js/jquery/plugin/jquery.hotkeys-0.7.9/jquery.hotkeys-0.7.9.js");
    jsList.add("/uiframe/js/backbone/underscore.js");
    jsList.add("/uiframe/js/backbone/mustache.js");
    jsList.add("/uiframe/js/backbone/backbone.js");
    jsList.add("/uiframe/js/jquery/plugin/jqwidgets/jqxcore.js");
    //合并js
    String jsName=UiframeUtil.mergeJs(jsList, "jqueryLibAll.js");
%>
<script type="text/javascript" src="<%=basePath%><%=jsName%>"></script>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/css/ui-lightness/jquery-ui-1.8.17.custom.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/pnotify-1.1.0/jquery.pnotify.default.icons.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/wdScrollTab/sywTab.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/contextmenu/AeroWindow-Contextmenu.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/jqwidgets/jqx.base.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    //重写jquery的load方法，主要是在加载完html及js内容后，触发widget.onready事件，用于控制事件处理先后顺序
    $.prototype.load=function( url, params, callback, errorCallBack) {
        if(typeof url!=="string")return;
        if ( typeof url !== "string" ) {
            return _load.apply( this, arguments );
        } else if ( !this.length ) {
            return this;
        }
        var off = url.indexOf( " " );
        if ( off >= 0 ) {
            var selector = url.slice( off, url.length );
            url = url.slice( 0, off );
        }
        var type = "GET";
        if ( params ) {
            if ( jQuery.isFunction( params ) ) {
                callback = params;
                params = undefined;
            } else if ( typeof params === "object" ) {
                params = jQuery.param( params, jQuery.ajaxSettings.traditional );
                type = "POST";
            }
        }
        var self = this;
        jQuery.ajax({
            url: url,
            type: type,
            dataType: "html",
            data: params,
            complete: function( jqXHR, status, responseText ) {
                $("#body").find("div.uiframe-selectHide").each(function(){
                    $(this).hide();//隐藏所有下拉框显示框
                });
                responseText = jqXHR.responseText;
                if ( jqXHR.isResolved() ) {
                    jqXHR.done(function( r ) {
                        responseText = r;
                    });
                    self.html( selector ?
                            jQuery("<div>").append(responseText.replace(rscript, ""))
                                    .find(selector) :responseText );
                    $(document).trigger("allReady");
                    $(document).trigger("widgetOnReady");
                    if ( callback ) {
                        self.each( callback, [ responseText, status, jqXHR ] );
                    }
                }else{
                    if(errorCallBack){
                        errorCallBack(jqXHR.status);
                    }
                }

            }
        });
        return this;
    };


    //jquery全局ajax事件
    $.ajaxSetup({
        dataType:'text',
        beforeSend:function(){
            $("#loadingMsg").show();//显示frame.jsp中的数据加载提示语
            $("#body").find("div.uiframe-selectHide").each(function(){
                $(this).hide();//隐藏所有下拉框显示框
            });
        },
        dataFilter :function(data){
            $("#loadingMsg").hide();//隐藏frame.jsp中的数据加载提示语
            return data;
        },
        error :function(){
            $("#loadingMsg").hide();//隐藏frame.jsp中的数据加载提示语
        },statusCode:{401:function(){
            //session过期，重登录
            if($("#loginPopUpWindow")[0]==undefined){
                $.sywWindow.show({
                    width:400,
                    height:250,
                    closable:false,
                    id:'loginPopUpWindow',
                    maskOpacity:1,
                    title:'登录',
                    url:'<%=basePath%>/uiframe/loginPortal/againLogin/winLogin.jsp?refresh=false'
                })
            }
        }}
    });

</script>


