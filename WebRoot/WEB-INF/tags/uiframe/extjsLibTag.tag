<%@ tag import="com.widget.framework.mergejs.UiframeUtil" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ tag pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    List<String> jsList=new ArrayList<String>(20);
    //js集合
    jsList.add("/uiframe/js/ext3.4/adapter/ext/ext-base.js");
    jsList.add("/uiframe/js/ext3.4/ext-all.js");
    jsList.add("/uiframe/js/ext3.4/ux/ComboBoxTree.js");
    jsList.add("/uiframe/js/ext3.4/ux/widget/ExtComboxTree.js");
    jsList.add("/uiframe/js/ext3.4/ux/widget/ExtGridPanel.js");
    jsList.add("/uiframe/js/ext3.4/ux/widget/ExtTreePanel.js");
    jsList.add("/uiframe/js/ext3.4/ux/widget/ExtDatePicker.js");
    jsList.add("/uiframe/js/ext3.4/ux/treePage/PagingTreeLoader.js");
    jsList.add("/uiframe/js/ext3.4/ux/treePage/leftNavigationTree.js");
    jsList.add("/uiframe/js/ext3.4/ux/widget/ExtPagingToolBar.js");
    jsList.add("/uiframe/js/ext3.4/src/locale/ext-lang-zh_CN.js");
    String jsName=UiframeUtil.mergeJs(jsList, "extjsLibAll.js");
%>
    <script type="text/javascript" src="<%=basePath%><%=jsName%>"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/uiframe/js/ext3.4/resources/css/ext-all.css" />

<script type="text/javascript">
//    表格加入tip提示
    Ext.override(Ext.grid.Column,{
        renderer:function(value){
            var titleVal= Ext.util.Format.htmlEncode(value);
            return "<div class='tooltip tree-grid-cell-item' myTitle=\""+titleVal+"\">"+titleVal+"</div>";
        }
    })
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
}

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
}
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
}


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
    }

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
}
Ext.Ajax.on("beforerequest",function(conn,response,options){
    $("#loadingMsg").show();
})
Ext.Ajax.on("requestcomplete",function(conn,response,options){
    $("#loadingMsg").hide();
})
 Ext.Ajax.on("requestexception",function(conn,response,options){
     if(response.statusText=='Unauthorized'&& $("#loginPopUpWindow")[0]==undefined){
         $.sywWindow.show({
             width:400,
             height:250,
             id:'loginPopUpWindow',
             maskOpacity:1,
             closable:false,
             title:'登录',
             url:'<%=basePath%>/uiframe/loginPortal/againLogin/winLogin.jsp?refresh=false'
         });
     }
 })
</script>


<%--<!-- extjs itemselector -->--%>
<%--<script type="text/javascript" src="<%=basePath %>/uiframe/js/ext3.4/ux/MultiSelect.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath %>/uiframe/js/ext3.4/ux/ItemSelector.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath %>/uiframe/js/ExtItemSelector.js"></script>--%>

<!-- ueditor -->
<%--<script type="text/javascript" src="<%=basePath%>/ueditor/editor_config.js"></script>
<script type="text/javascript" src="<%=basePath%>/ueditor/editor_all.js"></script>
<link rel="stylesheet" href="<%=basePath%>/ueditor/themes/default/ueditor.css"></link>--%>