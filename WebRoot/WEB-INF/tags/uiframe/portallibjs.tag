<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>

<%@ tag pageEncoding="UTF-8" %>
<%-- 模板html --%>
<%@ include file="/uiframe/js/uicomponent/sywTpl.html" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/css/ui-lightness/jquery-ui-1.8.17.custom.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/pnotify-1.1.0/jquery.pnotify.default.icons.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/wdScrollTab/sywTab.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/zTree-3.5.14/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/reset.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/theme/blue.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/uiframe.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/toolbar.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/loginPortal/css/newPortal.css" type="text/css" />
<script type="text/javascript" src="<%=basePath%>/uiframe/js/My97DatePicker/WdatePicker.js"></script>
<widget:mergejs moduleName="uiframe/portal/newPortalAll"/>
<script type="text/javascript">
    var basePath="<%=basePath%>";/*设置js的basePath*/
    //重写jquery的load方法，主要是在加载完html及js内容后，触发widget.onready事件，用于控制事件处理先后顺序
    $.prototype.load=function( url, params, callback, errorCallBack ) {
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
                    url:'<%=basePath%>/uiframe/loginPortal/againLogin/winLogin.jsp?refresh=false',
                    bottomContent:"none"
                })
            }
        }}
    });
    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    // 例子：
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

</script>

<%--<link rel="stylesheet" href="<%=basePath%>/uiframe/css/defaultSkin.css" type="text/css" id="cssFile"/>--%>
