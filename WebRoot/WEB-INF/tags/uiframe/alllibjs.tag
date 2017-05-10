<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="widget" tagdir="/WEB-INF/tags/uiframe" %>

<%@ tag pageEncoding="UTF-8" %>
<%-- 模板html --%>
<%@ include file="/uiframe/js/uicomponent/sywTpl.html" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<script type="text/javascript">
var basePath="<%=basePath%>";/*设置js的basePath*/
var p2mBaseUrl = {
		toP2MDataPage:basePath+"/task/grid/view/taskDataGrid.lightmesh"
}
</script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.draggable.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.sortable.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/ui/jquery.ui.resizable.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-validation-1.9.0/jquery.validate.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-validation-1.9.0/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-validation-1.9.0/messages_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/pnotify-1.1.0/jquery.pnotify.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery-form/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/wdScrollTab/sywTab.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/shiftcheck/jquery.shiftcheck.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/contextmenu/AeroWindow-Contextmenu v0.2.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/ajaxFileUpload/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/resize/jquery.ba-resize.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jquery.hotkeys-0.7.9/jquery.hotkeys-0.7.9.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/backbone/underscore.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/backbone/mustache.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/backbone/backbone.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/zTree-3.5.14/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ext-all.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/ComboBoxTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/widget/ExtComboxTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/widget/ExtGridPanel.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/widget/ExtTreePanel.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/widget/ExtDatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treePage/PagingTreeLoader.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treePage/leftNavigationTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/widget/ExtPagingToolBar.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/ColumnHeaderGroup.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/src/locale/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/widget/uiFrame.js"></script>
<%-- 
<script type="text/javascript" src="<%=basePath%>/uiframe/js/core/widgetcore.js"></script>
 --%>

<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywMask.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywDialog.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywWindow.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywToolbarButton.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywToolbarMenu.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywToolbarOverflow.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywText.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywButton.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywBtnText.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywDate.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywTime.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywFile.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywCombox.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywComboxTree.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywSearchCombox.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywMultiSelect.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywDrag.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywGrid.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/uicomponent/sywTreeGrid.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/widget/I18nManager.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/jquery/plugin/jqwidgets/jqxsplitter.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/TreeGrid.packed.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/AbstractTreeStore.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/AdjacencyListStore.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/EditorGridPanel.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/sysEditTreeGridPanel.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/ExtOverride.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/GridPanel.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/GridView.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/NestedSetStore.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/NS.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/PagingToolbar.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/XType.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/showDiscussView.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext4.2/ext-all-sandbox.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext4.2/modified/NodeInterface.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext4.2/modified/Ext4Override.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext4.2/modified/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/ext4.2/modified/CheckColumn.js"></script>
<%--<widget:mergejs moduleName="uiframe/frame/widgetAll"/>--%>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/jquery-ui-1.8.17.custom/css/ui-lightness/jquery-ui-1.8.17.custom.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/pnotify-1.1.0/jquery.pnotify.default.icons.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/wdScrollTab/sywTab.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/zTree-3.5.14/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/contextmenu/AeroWindow-Contextmenu.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext3.4/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext3.4/ux/treegridlib/sysTreeGrid.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext4.2/resources/css/ext-sandbox.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext4.2/modified/uiframe-ext.css">
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/jquery/plugin/jqwidgets/jqx.base.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/js/widgetui/plugins/uploadify3.2.1/uploadify.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/uiframe/newPortal/js/selectBox.js"></script>
   <link rel="stylesheet" href="<%=basePath%>/uiframe/css/securityCombox.css" type="text/css"/>
<script type="text/javascript">
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

 //extjs ----



    //    表格加入tip提示
//    Ext.override(Ext.grid.Column,{
//        renderer:function(value){
//            var titleVal= Ext.util.Format.htmlEncode(value);
//            return "<div class='tooltip tree-grid-cell-item' myTitle=\""+titleVal+"\">"+titleVal+"</div>";
//        }
//    });
    Ext.grid.GridPanel.prototype.stateful=false;
    Ext.grid.GridPanel.prototype.columnLines=true;

    //表格状态触发事件
    Ext.grid.GridPanel.prototype.stateEvents=['hiddenchange','columnresize'];//,'columnmove', 'columnresize'
    Ext.grid.GridView.prototype.handleHdDown = function(e, target) {
        if (Ext.fly(target).hasClass('x-grid3-hd-btn')) {
            e.stopEvent();

            var colModel  = this.cm,
                    header    = this.findHeaderCell(target),
                    index     = this.getCellIndex(header),
                    sortable  = colModel.isSortable(index),
                    menu      = this.hmenu,
                    menuItems = menu.items,
                    menuCls   = this.headerMenuOpenCls;

            this.hdCtxIndex = index;

            Ext.fly(header).addClass(menuCls);
//            menuItems.get('asc').setDisabled(!sortable);
//            menuItems.get('desc').setDisabled(!sortable);

            menu.on('hide', function() {
                Ext.fly(header).removeClass(menuCls);
            }, this, {single:true});

            menu.show(target, 'tl-bl?');
        }
    };

    Ext.grid.GridPanel.prototype.bodyStyle="width:100%";
    Ext.grid.GridView.prototype.handleHdMenuClickDefault = function(item) {
        var colModel = this.cm,
                itemId   = item.getItemId(),
                index    = colModel.getIndexById(itemId.substr(4));

        if (index != -1) {
            if (item.checked && colModel.getColumnsBy(this.isHideableColumn, this).length <= 1) {
                this.onDenyColumnHide();
                return;
            }
            var  j=0;
            for(var i=0;i<colModel.getColumnCount();i++){

                if(colModel.getDataIndex(i)!="" &&  (colModel.isHidden(i)==false)){
                    j++;
                }
            }
            if(j==1){
                item.checked = false;
                colModel.setHidden(index,false);
            }else{

                colModel.setHidden(index, item.checked);
            }
        }
    };
    Ext.grid.GridView.prototype.afterRenderUI = function(){
        var grid = this.grid;

        this.initElements();


        Ext.fly(this.innerHd).on('click', this.handleHdDown, this);

        this.mainHd.on({
            scope    : this,
            mouseover: this.handleHdOver,
            mouseout : this.handleHdOut,
            mousemove: this.handleHdMove
        });

        this.scroller.on('scroll', this.syncScroll,  this);

        if (grid.enableColumnResize !== false) {
            this.splitZone = new Ext.grid.GridView.SplitDragZone(grid, this.mainHd.dom);
        }

        if (grid.enableColumnMove) {
            this.columnDrag = new Ext.grid.GridView.ColumnDragZone(grid, this.innerHd);
            this.columnDrop = new Ext.grid.HeaderDropZone(grid, this.mainHd.dom);
        }

        if (grid.enableHdMenu !== false) {
            this.hmenu = new Ext.menu.Menu({id: grid.id + '-hctx'});
//             this.hmenu.add(
//                 {itemId:'asc',  text: this.sortAscText,  cls: 'xg-hmenu-sort-asc'},
//                 {itemId:'desc', text: this.sortDescText, cls: 'xg-hmenu-sort-desc'}
//             );

            if (grid.enableColumnHide !== false) {
                this.colMenu = new Ext.menu.Menu({id:grid.id + '-hcols-menu'});
                this.colMenu.on({
                    scope     : this,
                    beforeshow: this.beforeColMenuShow,
                    itemclick : this.handleHdMenuClick
                });
                this.hmenu.add({
                    itemId:'columns',
                    hideOnClick: false,
                    text: this.columnsText,
                    menu: this.colMenu,
                    iconCls: 'x-cols-icon'
                });
            }

            this.hmenu.on('itemclick', this.handleHdMenuClick, this);
        }

        if (grid.trackMouseOver) {
            this.mainBody.on({
                scope    : this,
                mouseover: this.onRowOver,
                mouseout : this.onRowOut
            });
        }

        if (grid.enableDragDrop || grid.enableDrag) {
            this.dragZone = new Ext.grid.GridDragZone(grid, {
                ddGroup : grid.ddGroup || 'GridDD'
            });
        }

        this.updateHeaderSortState();
    };


    //获取表格状态，存储到后台，存储调用在frame.jsp的全局函数中
    Ext.grid.GridPanel.prototype.getState=function(){
        var cm = this.getColumnModel();
        var columnCount=cm.getColumnCount();
        var obj={"saveColumns":{columns:[]}};
        for(var i=0;i<columnCount;i++){
            var id=cm.getColumnId(i);
            var column=cm.getColumnById(id);
            obj.saveColumns.columns.push({id:id,hideable:column.hidden ,width:column.width});
        }
        return obj;
    };
    /**
     * 保存grid的状态
     * saveColumns是约定的属性
     */
    var stateProvider=new Ext.state.Provider();
    stateProvider.on("statechange",function(provider,key,value){
        if(value.saveColumns){
            $.ajax({
                type: "POST",
                url: basePath+"/uiframe/componentstate/save.json",
                data: {"componentId":key,"state":Ext.util.JSON.encode(value.saveColumns)},
                success: function(msg){
                }
            });
        }
    })
    Ext.state.Manager.setProvider(stateProvider);
    //Ext.grid.GridPanel.prototype.columnLines=true;
    //应用状态改变表头显示隐藏
    Ext.grid.GridPanel.prototype.applyState=function(state){
        var cm = this.getColumnModel();
        if(state==undefined||state.columns==undefined){return;}
        for(var k=0;k<state.columns.length;k++){
            try{
                var col = cm.getIndexById(state.columns[k].id);
                if(state.columns[k].hideable == true){

                    cm.setHidden(col,true);

                }
                cm.setColumnWidth(col,state.columns[k].width);
            }catch(e){}
        }
    };
    Ext.Ajax.on("beforerequest",function(conn,response,options){
        $("#loadingMsg").show();
    });
    Ext.Ajax.on("requestcomplete",function(conn,response,options){
        $("#loadingMsg").hide();
    });
    Ext.Ajax.on("requestexception",function(conn,response,options){
        if(response.statusText=='Unauthorized'&& $("#loginPopUpWindow")[0]==undefined){
            $.sywWindow.show({
                width:400,
                height:250,
                id:'loginPopUpWindow',
                maskOpacity:1,
                closable:false,
                title:'登录',
                url:'<%=basePath%>/uiframe/loginPortal/againLogin/winLogin.jsp?refresh=false',
                bottomContent:"none"
            });
        }
    });

    Ext.QuickTips.init();
    Ext.BLANK_IMAGE_URL = basePath+'/uiframe/js/ext3.4/resources/images/default/s.gif';

</script>
<script type="text/javascript" src="<%=basePath%>/uiframe/js/widget/urlMapping.jsp"></script>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/theme/blue.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/loginPortal/css/frame.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/reset.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/uiframe.css" type="text/css"/>
<link rel="stylesheet" href="<%=basePath%>/uiframe/css/toolbar.css" type="text/css"/>
<%--<link rel="stylesheet" href="<%=basePath%>/uiframe/css/defaultSkin.css" type="text/css" id="cssFile"/>--%>
