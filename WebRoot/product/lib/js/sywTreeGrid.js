(function($){
    //表格模型数据
    $.SywTreeGridModel = Backbone.Model.extend({
        initialize:function(){
            this.render();
        },
        defaults:{
            dataRoot: "data",             //获取数据集合，默认取值
            dataRecordTotal: "total",   //获取数据集合总数，默认取值
            cid:undefined,                       //隐藏域ID,必填
            renderTo:undefined,                 //渲染到指定id上
            forceFit:false,                     //自动平分列宽
            useCheckbox:true,                   //是否显示复选框
            useToolPage:false,                   //是否显示分页
            treeColumn: undefined,             //以树形展示的列
            idField: undefined,                //当前数据id值的名称
            parentIdField: undefined,          //当前数据父级的数据id值的名称
            rootValue:undefined,                //根节点的值
            expandLevel:0,                      //初始化时展开几级节点
            columns: [],                         //数据列{title:'',dataIndex:'',sortable: true,align:'center',width:'',render:function(record){}}
            minColumnWidth: "100px",           //宽度值
            width: "500px",                     //宽度值
            height: undefined,                  //高度值
            resizable:false,                    //列是否和拖拽
            editable:true,                      // 树表是否可编辑
            plugins:undefined,                  // 多表头(Array)
            url: undefined,                     //加载地址 url
            urlParms: undefined,               //提交到服务器的参数
            autoLoad:false,                     //是否自动加载，默认false
            singleSelect:false,                //只选中一行，默认是true
            selectNodeId:undefined,             // 加载数据默认选中行，暂时只能选中一个
            stripeRows:true,                    // 斑马线效果
            limit: 10,                           //每页默认的结果数
            showName:"显示",                    //显示名称
            itemName:"条",                      //条数名称
            totalName:"共",                     //共名称
            diName:"第",                        //第名称
            pageName:"页",                      //页名称
            nodeIconShow:true,                 //是否展示树节点上的图片
            nodeIconHide:false,                 //是否展示树节点上的所有图片
            autoChangeColumn:false,             // 是否显示控制隐藏列按钮
            isTag:false                         //是否是tag，内部使用
        },
        render:function(){
            //宽度、高度解析成纯数字+px
            var myWidth = parseInt(this.get("width")) + "px";
            if (this.get("width") == "auto") {
                this.set({width:"100%"});                           //重新赋值宽度
            } else {
                this.set({width:myWidth});                           //重新赋值宽度
            }
        },
        //删除模型数据的方法
        clear: function() {
            this.destroy();
        }
    });
    $.SywTreeGridView = Backbone.View.extend({
        dataMap:{},                      //key-value结构的键值对对象
        treeData:{},                     //树结构的数据对象
        className:"uiframe-layoutDiv", //视图的class样式
        level:0,                          //树表级别
        startData:0,
        trCls:"",
        columnWidth:100,                 //默认列宽
        changeColumnWidth: false,       //记录表格列宽度是否被改变
        columnMenu:undefined,           //控制列显示菜单对象
        store: "",                       //加载的数据对象
        initialize:function(){
            //当模型中url属性变化时触发此方法
            this.model.bind("change:url",function(){
                this.storeLoad(this.model.get("urlParms"), this.model.get("selectNodeId"));
            },this);
            this.render();//视图渲染方法
        },
        //渲染
        render:function(){
            this.judgeBasicAttr();                                //判断表格的一些基本属性操作
            this.createHeader();                                  //渲染表头
            if(this.model.get("autoLoad")){
                this.storeLoad(this.model.get("urlParms"), this.model.get("selectNodeId"));     //加载treeGrid数据
            }
            this.gridScroll();                                    //滚动grid数据时，表头随之滚动方法方法
            this.resizeHeaderColumn();                            //拖拽表头列改变列宽度方法
            return this;
        },
        //判断表格的一些基本属性操作
        judgeBasicAttr:function(){
            //判断是否执行tag标签
            if(!this.model.get("isTag")){
                this.$el.empty();
                this.$el.append(Mustache.render($("#sywTreeGridTpl").html(),this.model.toJSON()));//初始化模板并append到该视图对象中
                var myId = this.model.get("renderTo");
                if(myId){
                    $("#"+myId).append(this.$el);
                }
            }
            //判断是否显示分页工具栏
            if(!this.model.get("useToolPage")){
                this.$(".sywTreeGridFooter").remove();
            }
            //判断是否自适应宽度
            if(this.model.get("forceFit")){
                var columns = this.model.get("columns");
                var fixWidth = 0;
                var fixTd = 0;
                for(var i = 0;i < columns.length;i++){
                    if (columns[i].fixColumn == true) {
                        fixWidth+= parseInt(columns[i].width) + 6;
                        fixTd++;
                    }
                    if (columns[i].hidden && columns[i].hidden == "true") {
                        fixTd++;
                    }
                }
                var columnWw = this.model.get("width");
                if (columnWw == "100%") {
                	columnWw = this.$el.width();
                }
                if(this.model.get("useCheckbox")){
                    this.columnWidth = (parseInt(columnWw) - fixWidth - 38) / (this.model.get("columns").length - fixTd) - 6;
                }else{
                    this.columnWidth = (parseInt(columnWw) - fixWidth - 18) / (this.model.get("columns").length - fixTd) - 6;
                }
            }
            //判断表格数据div的高度
            if(!this.model.get("height")){
                this.$(".sywTreeGridMainDiv").addClass("gridMain");
            } else {
                this.$(".sywTreeGridMainDiv").height(parseInt(this.model.get("height")) - 28);
            }
        },
        //创建表头
        createHeader:function(){
            var columns = this.model.get("columns");
            var headTable = this.$(".sywTreeGridHeader");
            headTable.empty();
            if (this.model.get("plugins")) {
                var pluginsHeader = this.model.get("plugins");
                for (var x = 0;x < pluginsHeader.length;x++) {
                    var pluginsHeaderTr = $("<tr></tr>");
                    var pluginsHeaderTd = pluginsHeader[x];
                    for (var y = 0;y < pluginsHeaderTd.length;y++) {
                        var tdAlign = pluginsHeaderTd[y].align || "left";
                        pluginsHeaderTr.append($('<td colspan="'+pluginsHeaderTd[y].colspan+'"><div style="text-align:'+tdAlign+'">'+pluginsHeaderTd[y].title+'</div></td>'));
                    }
                    pluginsHeaderTr.append($('<td></td>'));
                    headTable.append(pluginsHeaderTr);
                }
            }
            var tr = $("<tr></tr>");
            this.headerCheckboxEvent(tr);           //复选框判断及绑定事件
            for(var i = 0;i < columns.length;i++){
                var w = this.columnWidth;
                var align = columns[i].align || "left";
                if(!this.model.get("forceFit") && columns[i].width){
                    w = columns[i].width;
                }
                if(columns[i].fixColumn == true && (!columns[i].hidden || columns[i].hidden != "true")){
                    tr.append($('<td class="column-'+columns[i].dataIndex+'"><div id="'+columns[i].id+'" style="width: '+columns[i].width+'px;text-align:'+align+'" dataIndex="'+columns[i].dataIndex+'" fixColumn="'+columns[i].fixColumn+'" hideColumn="false" class="uiframe-resizecolumn">'+columns[i].title+'</div></td>'));
                } else if (columns[i].hidden == "true") {
                    tr.append($('<td style="display:none;" class="column-'+columns[i].dataIndex+'"><div id="'+columns[i].id+'" style="width: '+w+'px;text-align:'+align+'" dataIndex="'+columns[i].dataIndex+'" fixColumn="'+columns[i].fixColumn+'" hideColumn="true" class="uiframe-resizecolumn">'+columns[i].title+'</div></td>'));
                } else {
                    tr.append($('<td class="column-'+columns[i].dataIndex+'"><div id="'+columns[i].id+'" style="width: '+w+'px;text-align:'+align+'" dataIndex="'+columns[i].dataIndex+'" fixColumn="'+columns[i].fixColumn+'" hideColumn="false" class="uiframe-resizecolumn">'+columns[i].title+'</div></td>'));
                }
            }
            tr.append($('<td class="grid-headerBtnTd"><div class="grid-headerBtn"></div></td>'));
            headTable.append(tr);
            if (this.model.get("autoChangeColumn")) {
            	this.controlColumn();                  //编辑列显示按钮的换过方法、点击方法
            }
        },
        //复选框判断及绑定事件
        headerCheckboxEvent:function(checkbox){
            var that = this;
            var myId = this.model.get("cid");
            var checkboxTd =$('<td class="uiframe-jspGrid-checkbox jspGrid-nocheck jspGridSortTd" checkbox="false"><div class="uiframe-jspGrid-checkBg"></div></td>');
            if(this.model.get("useCheckbox")){
                checkbox.append(checkboxTd);
                //判断表格是单选还是多选
                if(that.model.get("singleSelect")){
                    checkboxTd.removeClass("jspGrid-nocheck");
                } else {
                    //表头复选框绑定事件
                    checkboxTd.on("click",function(){
                        if($(this).attr("checkbox") === "false"){
                            $(this).removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                            that.$(".checkboxes").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                            that.$(".sywTreeGridMainDiv tr").addClass("gridTrSelect");
                        }else{
                            $(this).removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                            that.$(".checkboxes").addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                            that.$(".sywTreeGridMainDiv tr").removeClass("gridTrSelect");
                        }
                        $("#"+myId).trigger("rowClick");                      //触发树表的rowClick绑定事件
                    });
                }
            }
        },
        //控制列显示按钮划过事件及控制列显示方法
        controlColumn:function(){
            var that = this;
            var columns = this.model.get("columns");
            //控制列显示按钮划过事件
            this.$(".grid-headerBtnTd").hover(function(){
                $(this).addClass("grid-headerBtnTd-hover");
            },function(){
                $(this).removeClass("grid-headerBtnTd-hover");
            });
            //控制列显示按钮绑定方法
            this.$(".grid-headerBtnTd").on("click", function(e){
                $(this).addClass("grid-headerBtnTd-click");
                if($("#gridColumnMenu")){
                    $("#gridColumnMenu").remove();
                }
                var ul = $("<ul></ul>");
                ul.empty();
                for(var i = 0; i < columns.length; i++){
                    var liCheckbox;
                    if(that.$(".column-"+columns[i].dataIndex).css("display") == "none"){
                        liCheckbox = $("<li class='clickColumn' val='"+columns[i].dataIndex+"' tabindex=0 checkbox='false'><span class='columnMenuSpan'>"+columns[i].title+"</span></li>");
                    } else {
                        liCheckbox = $("<li class='clickColumn selectColumn' val='"+columns[i].dataIndex+"' tabindex=0 checkbox='true'><span class='columnMenuSpan'>"+columns[i].title+"</span></li>");
                    }
                    ul.append(liCheckbox);
                }
                var columnMenu = $("<div id='gridColumnMenu'></div>"); //创建 div 元素
                columnMenu.append(ul);
                $("body").append(columnMenu);	//把它追加到文档中
                $("#gridColumnMenu")
                    .css({
                        "top": ( (e.pageY+$("#gridColumnMenu").height()+20)>$(window).height()? e.pageY -$("#gridColumnMenu").height()- sywFunction.tooltip_y:e.pageY+sywFunction.tooltip_y) + "px",
                        "left": ( (e.pageX+$("#gridColumnMenu").width()+20)>$(window).width()? e.pageX -$("#gridColumnMenu").width()- sywFunction.tooltip_x:e.pageX+sywFunction.tooltip_x) + "px"
                    }).show();	  //设置x坐标和y坐标，并且显示
                $(".clickColumn").each(function(){
                    $(this).on("click", function(){
                        var dataIndex = $(this).attr("val");
                        if($(this).attr("checkbox") == "true"){
                            if($(".selectColumn").length == 1) return false;
                            $(this).attr("checkbox","false").removeClass("selectColumn");
                            that.$("td.column-"+dataIndex).hide();
                            that.$("td.column-"+dataIndex).children("div").attr("hideColumn", "true");
                        } else {
                            $(this).attr("checkbox","true").addClass("selectColumn");
                            that.$("td.column-"+dataIndex).show();
                            that.$("td.column-"+dataIndex).children("div").attr("hideColumn", "false");
                        }
                        that.setHeaderColumn(that.$(".uiframe-TreeGrid-panel").width());
                        return false;
                    });
                });
                return false;
            });
            $("body").on("click", function () {
                if($("#gridColumnMenu").css("display") == "block") {
                    $("#gridColumnMenu").remove();
                    that.$(".grid-headerBtnTd").removeClass("grid-headerBtnTd-click");
                }
            });
        },
        //加载表格数据
        storeLoad:function(urlParams, selectId){
            var selectDataId = "";
            if (selectId && selectId != "") {
                selectDataId = selectId;
            }
            var that = this;
            var url = this.model.get("url");
            var dataRoot = this.model.get("dataRoot");
            var dataRecordTotal = this.model.get("dataRecordTotal");
            var parentId = this.model.get("parentIdField");
            this.recordPage = parseInt(this.model.get("limit"));
            //定义url的条件参数
            var params;
            if(urlParams){
                params = urlParams+'&start='+that.startData+'&limit='+that.recordPage;
            } else {
                params = 'start='+that.startData+'&limit='+that.recordPage
            }
            $.ajax({
                type: "POST",
                url: url,
                dataType: "json",
                data:params,
                success:function(data_name){
                    if(data_name){
                        that.store = eval("data_name." +dataRoot) || [];
                        that.totalCount = eval("data_name." +dataRecordTotal) || 0;
                        if(that.store==undefined){return;}
                        that.level = 0;
                        that.treeData = {
                            "id": "ad",
                            "level":that.level
                        };
                        that.getDataMap(that.store,parentId);                //dataMap构建成key-value键值对对象
                        if(that.model.get("rootValue")){                       //是否自定义根节点值
                            that.treeData.children = that.dataMap[that.model.get("rootValue")];            //构建treeData的children中数据
                            that.createTreeNode(that.dataMap[that.model.get("rootValue")], that.level);     //循环构建treeData下的每一个节点数据
                        } else {
                            that.treeData.children = that.dataMap["-1"];                                      //构建treeData的children中数据
                            that.createTreeNode(that.dataMap["-1"], that.level);                               //循环构建treeData下的每一个节点数据
                        }
                        that.fillTreeGridData(that.treeData, selectDataId);                    //填充数据，生成并渲染视图
                        that.$(".sywTreeGridMainDiv").children("div").css({width :"100%"});    //解决ie6下滚动条变化问题
                        that.judgeUnnecessaryTdShow();         //判断内容中多余的td是否需要显示
                        if(that.changeColumnWidth){         //判断表格列宽是否发生改变
                            that.resizeDataColumnWidth();     //根据表头列宽重新计算数据列宽度值
                        }
                        that.clickTr();                       //每行数据的划过和点击事件

                        $("#"+that.model.get("cid")).trigger("setBind");
                        $("#"+that.model.get("cid")).trigger("loadAfter");
                    }
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                }
            });
        },
        //根据加载的数据构建key-value结构的键值对对象
        getDataMap:function(data, parentId){
            this.dataMap ={};
            for(var i = 0; i < data.length; i++){
                var dataKey = data[i][parentId];//eval("data[i]." +parentId);
                if(!this.model.get("rootValue")){
                    if(!dataKey || dataKey =="" || dataKey == "null" || dataKey == "0"){
                        dataKey = "-1";
                    }
                }
                if(this.dataMap[dataKey]){
                    this.dataMap[dataKey].push(data[i]);
                }else{
                    this.dataMap[dataKey]=[];
                    this.dataMap[dataKey].push(data[i]);
                }
            }
        },
        //循环构建树结构的数据对象
        createTreeNode:function(array, level){
            if(!array) return;
            var that = this;
            var idField = this.model.get("idField");
            level++;
            for(var m = 0;m < array.length;m++){
                var myId = array[m][idField];
                if(that.dataMap[myId]){
                    if(!(array[m].children)){
                        array[m].children = that.dataMap[myId];
                        array[m].leaf = false;                   //是否是叶子节点
                        array[m].level = level;                  //是第几级节点数据，从0开始
                        that.createTreeNode(that.dataMap[myId], level);      //继续构建树的节点数据
                    }
                } else {
                    array[m].leaf = true;
                    array[m].level = level;
                }
            }
            if(that.level < level){
                that.level = level;      //计算树表最大层级结构
            }
        },
        //填充treeGrid中的数据
        fillTreeGridData:function(treeData, selectDataId){
            if(!treeData) return;
            var dataTable = this.$(".sywTreeGridMainDiv");
            dataTable.empty();
            var showLevel;         //定义当前需要展开几级数据的变量
            if(this.model.get("expandLevel") == "true"){
                showLevel = this.level;
            } else{
                showLevel = parseInt(this.model.get("expandLevel"));
            }
            this.createTreeNodeData(treeData.children, dataTable, showLevel, selectDataId);     //循环构建并渲染视图(此节点下的children数据，需要append的对象，需要构建几级)
        },
        //构建视图中的节点数据
        createTreeNodeData:function(data, $jquery, level, selectDataId){
            if(!data) return;
            var that = this;
            var columns = this.model.get("columns");                                 //数据列的数组
            var treeColumn = this.model.get("treeColumn");                          //需要以树的形式显示的列
            var parentIdField = this.model.get("parentIdField");                   //父级节点的id名称
            var idField = this.model.get("idField");                                //此节点本身的id名称
            var parentId = data[0][parentIdField];                                   //此组节点的共同父级id的值
            var order = 0;                                                           //定义当前数据在父节点下是第几条的变量
            var $parents = $("<div id='syw-treeGridNode"+parentId+"'></div>");   //此组节点共同append的div对象
            //循环加载grid数据
            for(var i = 0;i <  data.length;i++){                                     //循环此组节点数据
                order++;                                                              //循环为数据赋顺序值
                var record = data[i];
                var myId = data[i][idField];
                var $this = $("<div id='syw-treeGrid"+myId+"'></div>");
                var myTable=$("<table id='"+myId+"Table'></table>");
                myTable.data("getData", record);                         //缓存树表的每一条数据到此数据的table上
                myTable.data("getParentData", data);                    //缓存树表的当前数据的父节点数据到此数据的table上
                myTable.data("getOrder", order);                         //缓存树表的每一条数据的顺序值到此数据的table上
                if(record){                                               //当前数据对象
                    var row;
                    if(this.model.get("stripeRows")){                   //执行斑马线效果
                        if(i %2 != 0){
                            row = $('<tr class="treeGridTr uiframe-grid-tr-even '+that.trCls+' "></tr>');
                        }else{
                            row = $('<tr class="treeGridTr uiframe-grid-tr-odd '+that.trCls+' "></tr>');
                        }
                    }
                    if(this.model.get("useCheckbox")){                  //是否需要显示复选框
                        if (selectDataId && selectDataId != "" && selectDataId == myId) {
                            row.append($('<td class="uiframe-grid-checkbox jspGrid-nocheck checkboxes" checkbox="true"><div class="uiframe-jspGrid-checkBg"></div></td>'));
                            row.addClass("gridTrSelect");
                        } else {
                            row.append($('<td class="uiframe-grid-checkbox jspGrid-nocheck checkboxes" checkbox="false"><div class="uiframe-jspGrid-checkBg"></div></td>'));
                        }
                    }
                    for(var j = 0;j < columns.length;j++){                //循环列数组
                        var w = this.columnWidth + 1;                   //每一列的宽度值
                        if(!this.model.get("forceFit") && columns[j].width){
                            w = parseInt(columns[j].width) + 1;
                        }
                        if(this.model.get("forceFit") && columns[j].fixColumn == true){
                            w = parseInt(columns[j].width) + 1;
                        }
                        var align = columns[j].align || "left";          //文字显示文字
                        var dataIndex = columns[j].dataIndex;            //列的dataIndex值
                        if (record[dataIndex] == "0") {
                            dataName ="0";
                        }
                        var dataName = record[dataIndex] || "";           //数据中对应列的dataIndex值的数据名称
                        if (record[dataIndex] == "0") {
                        	dataName = 0;
                        }
                        var myLevel = record.level;                       //当前数据的的级别
                        var myParentId = "syw-treeGrid"+myId;            //当前数据父级的id值
                        if(treeColumn == dataIndex){                       //判断哪一列需要显示成树的形式
                            var paddingLeft = parseInt(record.level-1) * 16;     //定义paddingLeft距离
                            var myTdClass;
                            var iconCls = record["iconCls"] || "";
                            //判断是否是根节点，添加显示样式
                            if(record.leaf){
                                myTdClass = "uiframe-treeNode-leaf";
                            } else {
                                if(record.level-1 == level){       //判断当前节点是否是加载的最后一级，添加显示样式
                                    myTdClass = "uiframe-treeNode-collapse";
                                } else {
                                    myTdClass = "uiframe-treeNode-collapse uiframe-treeNode-expand";
                                }
                            }
                            var treeTd;                   //当前td对象
                            if (columns[j].hidden && columns[j].hidden == "true") {
                                treeTd = $("<td style='display:none;' class='uiframe-columnTree column-"+dataIndex+"'></td>");
                            } else {
                                treeTd = $("<td class='uiframe-columnTree column-"+dataIndex+"'></td>");
                            }
                            treeTd.addClass(myTdClass);
                            var treeTdData = dataName;                     //定义需要加载到td中的数据名称
                            if(columns[j].renderer && $.isFunction(columns[j].renderer)){               //执行column中的renderer方法
                                var treeColIndex;                               //当前列数
                                var treeRowIndex = i + 1;                       //当前行数
                                if(this.model.get("useCheckbox")){
                                    treeColIndex = j + 2;
                                } else {
                                    treeColIndex = j + 1;
                                }
                                treeTdData = columns[j].renderer(dataName, treeTd, record, row, treeRowIndex, treeColIndex, this.store)
                            }
                            if(that.model.get("nodeIconHide")) {
                                treeTd.append('<div class="resize-'+dataIndex+'" style="width:'+(w-6)+'px;padding-left:6px;height:18px;">'+treeTdData+'</div>');
                            } else {
                                if(that.model.get("nodeIconShow")){
                                    treeTd.append('<div class="resize-'+dataIndex+'" style="width:'+w+'px;position:relative;">' +
                                        '<div class="uiframe-treeLevel uiframe-treeLevelIcon" level='+myLevel+' parentId='+myParentId+' style="left:'+paddingLeft+'px;"></div>' +
                                        '<div class="uiframe-treeFolder uiframe-treeFolderIcon '+iconCls+'" style="left:'+(paddingLeft+16)+'px;"></div>' +
                                        '<div style="display:inline-block;margin-top:4px;padding:1px;margin-left:'+(paddingLeft+36)+'px">'+treeTdData+'</div>' +
                                        '</div>');
                                }else {
                                    treeTd.append('<div class="resize-'+dataIndex+'" style="width:'+w+'px;position:relative;">' +
                                        '<div class="uiframe-treeLevel uiframe-treeLevelIcon" level='+myLevel+' parentId='+myParentId+' style="left:'+paddingLeft+'px;"></div>' +
                                        '<div style="display:inline-block;margin-top:4px;padding:1px;margin-left:'+(paddingLeft+20)+'px">'+treeTdData+'</div>' +
                                        '</div>');
                                }
                            }
                            row.append(treeTd);
                        } else{
                            var td = $("<td class='column-"+dataIndex+"'></td>");                   //当前td对象
                            if (columns[j].hidden && columns[j].hidden == "true") {
                                td = $("<td style='display:none;' class='column-"+dataIndex+"'></td>");
                            } else {
                                td = $("<td class='column-"+dataIndex+"'></td>");
                            }
                            var tdData = dataName;
                            if(columns[j].renderer && $.isFunction(columns[j].renderer)){               //执行column中的renderer方法
                                var colIndex;                               //当前列数
                                var rowIndex = i + 1;                       //当前行数
                                if(this.model.get("useCheckbox")){
                                    colIndex = j + 2;
                                } else {
                                    colIndex = j + 1;
                                }
                                tdData = columns[j].renderer(dataName, td, record, row, rowIndex, colIndex, this.store);
                            }
                            td.append('<div class="resize-'+dataIndex+'" style="width:'+w+'px;text-align:'+align+';" >'+tdData+'</div>');
                            row.append(td);
                        }
                    }
                    row.append($('<td class="grid-mainBtnTd"><div class="grid-mainBtn"></div></td>'));  //UnnecessaryTd,数据无滚动条时需要显示
                }
                myTable.append(row);             //一条数据渲染到table中
                $this.append(myTable);           //一个table渲染到div中
                $parents.append($this);          //多个含有table的div渲染到它的父级div中
                $jquery.append($parents);        //父级div渲染到它父级table的后面
                if(!record.leaf && record.children){                //判断当前数据不是叶子节点且含有children属性
                    if(record.level <= level) {
                        that.createTreeNodeData(record.children, $this, level, selectDataId);    //继续构建视图中的节点数据
                    }
                    myTable.find("tr").each(function(){                           //在myTable循环找到所有的tr标签
                        that.setParentNodeClick($(this).find("td.uiframe-columnTree"), record.children, $this, level+1, selectDataId);
                    });
                }
            }
        },
        //父节点绑定的点击事件
        setParentNodeClick:function($this, record, $parents, level, selectDataId){
            var that = this;
            var myId = this.model.get("cid");
            if(!$this.hasClass("uiframe-treeNode-leaf")){          //判断是否是叶子节点，执行绑定方法
                $this.find("div.uiframe-treeLevel").on("click", function(){
                    if($this.hasClass("uiframe-treeNode-expand")){            //判断是否节点是否是展开的
                        $($parents).children("div").hide();
                        $this.removeClass("uiframe-treeNode-expand");
                    } else {
                        if($($parents).children("div") && $($parents).children("div").css("display") == "none"){   //判断此节点的子节点视图已构建，没有则执行构建
                            $($parents).children("div").show();
                        } else {
                            that.createTreeNodeData(record, $parents, level, selectDataId);                      //构建节点视图
                            if(that.changeColumnWidth){         //判断表格列宽是否发生改变
                                that.resizeDataColumnWidth();     //根据表头列宽重新计算数据列宽度值
                            }
                        }
                        $this.addClass("uiframe-treeNode-expand");
                    }
                    that.judgeUnnecessaryTdShow();                //判断内容中多余的td是否需要显示
//                    if(!$this.parents("tr").hasClass("gridTrSelect")){                   //判断此条数据复选框是否已加勾选样式
//                        $this.parents("tr").addClass("gridTrSelect");
//                        $this.parents("tr").find("td:first").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
//                    }
                    //$("#"+myId).trigger("rowClick");         //触发树表的rowClick绑定事件
                    return false;
                });
            }
        },
        //根据树表中的内容是否出现滚动条，执行数据生成时多加的td是否需要显示
        judgeUnnecessaryTdShow:function(){
            var $this = this.$(".sywTreeGridMainDiv");
            var trueHeight = $this.height();
            var dataHeight = $this.children("div").height();
            if(trueHeight >= dataHeight){
                $this.find("td.grid-mainBtnTd").show();
                //this.$(".sywTreeGridMainDiv").children("div").width($this.width());
            } else {
                $this.find("td.grid-mainBtnTd").hide();
                //this.$(".sywTreeGridMainDiv").children("div").width($this.width() - 17);
            }
        },
        //根据表头列宽重新计算数据列宽度值
        resizeDataColumnWidth:function(){
            var that = this;
            this.$(".uiframe-resizecolumn").each(function(){
                var dataIndex = $(this).attr("dataIndex");
                that.$el.find(".resize-"+dataIndex).css("width",$(this).width()+1);
            });
        },
        //每行数据的划过和点击事件
        clickTr:function(){
            var that = this;
            var myId = this.model.get("cid");
            //表格内容tr鼠标划过事件及点击事件
            that.$(".sywTreeGridMainDiv tr").on("mouseover",function(){
                $(this).addClass("gridTrHover");
            });
            that.$(".sywTreeGridMainDiv tr").on("mouseout", function(){
                $(this).removeClass("gridTrHover");
            });
            //判断表格是单选还是多选
            if(that.model.get("singleSelect")){
                if (!that.model.get("editable")) {
                    //tr绑定事件
                    that.$(".sywTreeGridMainDiv tr").off("click");
                    that.$(".sywTreeGridMainDiv tr").on("click", function(){
                        that.$(".sywTreeGridMainDiv").find("tr").removeClass("gridTrSelect");
                        $(this).addClass("gridTrSelect");
                        that.$(".checkboxes").removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                        $(this).find("td.checkboxes").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        $("#"+myId).trigger("rowClick");                      //触发树表的rowClick绑定事件
                        return false;
                    });
                }
                //checkbox绑定事件
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").off("click");
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").on("click", function(){
                    that.$(".sywTreeGridMainDiv").find("tr").removeClass("gridTrSelect");
                    $(this).parents("tr").addClass("gridTrSelect");
                    that.$(".checkboxes").removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                    $(this).removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                    $("#"+myId).trigger("rowClick");                      //触发树表的rowClick绑定事件
                    return false;
                });
            } else {
                // if (!that.model.get("editable")) {
                    //tr绑定事件
					$(document).off(".trclick");
					$(document).on("click.trclick", "#"+myId+" tr", function(){
                        var checkbox = $(this).find("td.checkboxes");
						$("#"+myId).find("tr").removeClass("gridTrSelect");
						$("#"+myId).find("td.checkboxes").addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                        if(checkbox.attr("checkbox") == "false"){
                            checkbox.removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                            $(this).addClass("gridTrSelect");
                        } else {
                            checkbox.addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                            $(this).removeClass("gridTrSelect");
                        }
						$("#"+myId).trigger("rowClick");                      //触发树表的rowClick绑定事件
						return false;
                    });
                // }
                //checkbox绑定事件
                $("#"+myId).off(".tdCheckboxes");
                $("#"+myId).on("click.tdCheckboxes", "td.checkboxes", function(){
                    var checkbox = $(this);
                    if(checkbox.attr("checkbox") == "true"){
                            checkbox.addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                        $(this).parents("tr").removeClass("gridTrSelect");
                    } else {
                        checkbox.removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        $(this).parents("tr").addClass("gridTrSelect");
                    }
                    $("#"+myId).trigger("rowClick");                      //触发树表的rowClick绑定事件
                    return false;
                });
            }
        },
        //滚动grid数据时，表头随之滚动方法方法
        gridScroll:function(){
            var that = this;
            this.$(".sywTreeGridMainDiv").scroll(function(){
                that.$(".sywTreeGridHeaderDiv").css("margin-left",-($(this).scrollLeft()));
            });
        },
        //拖拽列改变列宽度方法
        resizeHeaderColumn:function(){
            var that = this;
            this.$(".uiframe-resizecolumn").each(function(){
                var myThis = this;
                var min_width;
                var myTitle = $(this).text();
                var myId = $(this).attr("id");
                var parentId = $(this).parents("div.uiframe-TreeGrid-panel").attr("id");
                if($(this).width() > parseInt(that.model.get("minColumnWidth"))){
                    min_width = parseInt(that.model.get("minColumnWidth"));
                } else {
                    min_width=$(this).width();
                }
                if(that.model.get("resizable")){
//                    var dragSampleView= Sysware.grid.createDragView({
//                        id:myId,
//                        parentId:parentId,
//                        resize:function(){
//                            var dataIndex = $(myThis).attr("dataIndex");
//                            that.$el.find(".resize-"+dataIndex).css("width",$(myThis).width()+1);
//                            that.changeColumnWidth = true;
//                            that.$(".sywTreeGridMainDiv").trigger("scroll");
//                        },
//                        stop:function(){
//                        }
//
//                    });
                    $(this).resizable({
                        minWidth:min_width,
                        handles: "e",
                        ghost: false,
                        stop:function(event,ui){
                        },
                        resize: function(event, ui) {
                            var dataIndex = $(this).attr("dataIndex");
                            that.$el.find(".resize-"+dataIndex).css("width",$(this).width()+1);
                            that.changeColumnWidth = true;
                            that.$(".sywTreeGridMainDiv").trigger("scroll");
                            //todo   保存column数据
                        }
                    });
                }
            });
        },
        setHeaderColumn:function(width){
            var that = this;
            //判断是否自适应宽度
            if(this.model.get("forceFit")){
                var columns = this.model.get("columns");
                var columnLength = this.model.get("columns").length;
                var fixColumn = 0;                             //固定列宽的个数
                var fixColumnWidth = 20;                       //所有固定列宽的宽度和
                var columnWidth;                               //剩余列平均宽度
                if(this.model.get("useCheckbox")){
                    fixColumnWidth += 18;
                }
                for(var i = 0;i < columnLength; i ++){
                    var trId = columns[i].id;
                    if(that.$el.find("#"+trId).attr("fixcolumn") && that.$el.find("#"+trId).attr("fixcolumn") == "true"){
                        fixColumnWidth += that.$("#"+trId).width() + 6;
                        fixColumn++;
                        if(that.$el.find("#"+trId).attr("hidecolumn") && that.$el.find("#"+trId).attr("hidecolumn") == "true"){
                            fixColumnWidth -= that.$("#"+trId).width() + 6;
                        }
                    } else {
                        if(that.$el.find("#"+trId).attr("hidecolumn") && that.$el.find("#"+trId).attr("hidecolumn") == "true"){
                            fixColumn++;
                        }
                    }
                }
                if((columnLength - fixColumn) !== 0 && (columnLength - fixColumn) != ""){
                    columnWidth = (width - fixColumnWidth) / (columnLength - fixColumn);
                    for(var j = 0;j < columnLength; j ++){
                        var trIds = columns[j].id;
                        if(that.$el.find("#"+trIds).attr("fixColumn") == undefined || that.$el.find("#"+trIds).attr("fixColumn") == "false"){
                            that.$el.find("#"+trIds).width(columnWidth - 6);
                        }
                    }
                }
            }
            this.resizeDataColumnWidth();           //grid数据列重新赋值宽度
        },
        //获取树表的选中数据
        getSelectData:function(){
            var selectDataArray = [];        //定义选中的数据对象数组
            this.$("tr.gridTrSelect").each(function(){
                selectDataArray.push($(this).parents("table").data("getData"));
            });
            return selectDataArray;
        },
        //获取树表的选中数据的父节点数据
        getSelectParentData:function(){
            var selectParentDataArray = [];        //定义选中的数据对象数组
            this.$("tr.gridTrSelect").each(function(){
                selectParentDataArray.push($(this).parents("table").data("getParentData"));
            });
            return selectParentDataArray;
        },
        //获取树表的选中数据的顺序值
        getSelectOrder:function(){
            var selectOrderArray = [];        //定义选中的数据对象数组
            this.$("tr.gridTrSelect").each(function(){
                selectOrderArray.push($(this).parents("table").data("getOrder"));
            });
            return selectOrderArray;
        },
        //设置表格数据背景色
        setBackground:function(cls){
        	this.trCls = cls;
            this.$el.find("tr.treeGridTr").addClass(cls);
        },
        //刷新按钮绑定事件
        refreshBtn:function(){
            this.storeLoad(this.model.get("urlParms"));
        },
        clear:function(){
            this.remove();
            this.model.destroy();
            this.model=null;
        }
    });

    Sysware.grid.createTreeGridView = function(params){
        if(params&&params.id){
            params.cid = params.id;
            params.id = undefined;
        }
        var model = new $.SywTreeGridModel(params);
        var view = new $.SywTreeGridView({model:model});
        return view;

    };

    //MustacheGrid
    $.SywMustacheTreeGridModel = Backbone.Model.extend({
        defaults:{
            treeGridId:undefined,                 //表格的id值
            singleSelect:false,                   //是否单选，默认是false
            useCheckbox:true,                     //是否使用多选框，默认是true
            forceFit:true,                        //是否自适应宽度，默认是true
            columns:[],                            //表头数据模型
            records:[],                           //表格每页数据
            recordMaps:{},                        //表格Map数据,key为每条数据的id值
//            dataRoot: "root.datas[0]",          //默认值root.datas[0]
            treeColumn: undefined,             //以树形展示的列
            idField: undefined,                //当前数据id值的名称
            parentIdField: undefined,          //当前数据父级的数据id值的名称
            rootValue:undefined,                //根节点的值
            expandLevel:0,                      //初始化时展开几级节点
            minColumnWidth: "100px",           //宽度值
            resizable:false,                    //列是否和拖拽
            url: undefined,                     //加载地址 url
            urlParms: undefined,               //提交到服务器的参数
            autoLoad:false,                     //是否自动加载，默认false
            stripeRows:true
        }
    });

    $.SywMustacheTreeGridView = Backbone.View.extend({
        dataMap:{},                      //key-value结构的键值对对象
        treeData:{},                     //树结构的数据对象
        level:0,                          //树表级别
        columnWidth:100,                 //默认列宽
        changeColumnWidth: false,       //记录表格列宽度是否被改变
        columnMenu:undefined,           //控制列显示菜单对象
        store: "",                       //加载的数据对象
        //初始化
        initialize:function(){
            this.headerCheckboxEvent();             //表头复选框绑定事件
            this.controlColumn();                   //控制列显示按钮划过事件及控制列显示方法
            this.judgeUnnecessaryTdShow();          //判断内容中多余的td是否需要显示
            this.clickTr();                         //每行数据的划过和点击事件
            this.gridScroll();                      //滚动grid数据时，表头随之滚动方法方法
            this.resizeHeaderColumn();              //拖拽表头列改变列宽度方法
            this.setParentNodeClick();              //父级节点绑定点击事件
        },
        //复选框判断及绑定事件
        headerCheckboxEvent:function(checkbox){
            var that=this;
            //判断表格是单选还是多选
            if(that.model.get("singleSelect")){
                that.$(".sywTreeGridHeader").find(".uiframe-grid-checkbox").removeClass("jspGrid-nocheck");
            } else {
                this.$(".sywTreeGridHeader").find(".uiframe-grid-checkbox").on("click",function(){
                    if($(this).attr("checkbox") === "false"){
                        $(this).removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        that.$(".checkboxes").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        that.$(".sywTreeGridMainDiv tr").addClass("gridTrSelect");
                    }else{
                        $(this).removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                        that.$(".checkboxes").addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                        that.$(".sywTreeGridMainDiv tr").removeClass("gridTrSelect");
                    }
                    that.$el.trigger("rowClick");                      //触发树表的rowClick绑定事件
                });
            }
        },
        //控制列显示按钮划过事件及控制列显示方法
        controlColumn:function(){
            var that = this;
            var columns = this.model.get("columns");
            //控制列显示按钮划过事件
            this.$(".grid-headerBtnTd").hover(function(){
                $(this).addClass("grid-headerBtnTd-hover");
            },function(){
                $(this).removeClass("grid-headerBtnTd-hover");
            });
            //控制列显示按钮绑定方法
            this.$(".grid-headerBtnTd").on("click", function(e){
                $(this).addClass("grid-headerBtnTd-click");
                if($("#gridColumnMenu")){
                    $("#gridColumnMenu").remove();
                }
                var ul = $("<ul></ul>");
                ul.empty();
                for(var i = 0; i < columns.length; i++){
                    var liCheckbox;
                    if(that.$(".column-"+columns[i].dataIndex).css("display") == "none"){
                        liCheckbox = $("<li class='clickColumn' val='"+columns[i].dataIndex+"' tabindex=0 checkbox='false'><span class='columnMenuSpan'>"+columns[i].header+"</span></li>");
                    } else {
                        liCheckbox = $("<li class='clickColumn selectColumn' val='"+columns[i].dataIndex+"' tabindex=0 checkbox='true'><span class='columnMenuSpan'>"+columns[i].header+"</span></li>");
                    }
                    ul.append(liCheckbox);
                }
                var columnMenu = $("<div id='gridColumnMenu'></div>"); //创建 div 元素
                columnMenu.append(ul);
                $("body").append(columnMenu);	//把它追加到文档中
                $("#gridColumnMenu")
                    .css({
                        "top": ( (e.pageY+$("#gridColumnMenu").height()+20)>$(window).height()? e.pageY -$("#gridColumnMenu").height()- sywFunction.tooltip_y:e.pageY+sywFunction.tooltip_y) + "px",
                        "left": ( (e.pageX+$("#gridColumnMenu").width()+20)>$(window).width()? e.pageX -$("#gridColumnMenu").width()- sywFunction.tooltip_x:e.pageX+sywFunction.tooltip_x) + "px"
                    }).show();	  //设置x坐标和y坐标，并且显示
                $(".clickColumn").each(function(){
                    $(this).on("click", function(){
                        var dataIndex = $(this).attr("val");
                        if($(this).attr("checkbox") == "true"){
                            if($(".selectColumn").length == 1) return false;
                            $(this).attr("checkbox","false").removeClass("selectColumn");
                            that.$("td.column-"+dataIndex).hide();
                            that.$("td.column-"+dataIndex).children("div").attr("hideColumn", "true");
                        } else {
                            $(this).attr("checkbox","true").addClass("selectColumn");
                            that.$("td.column-"+dataIndex).show();
                            that.$("td.column-"+dataIndex).children("div").attr("hideColumn", "false");
                        }
                        that.setHeaderColumn(that.$(".uiframe-TreeGrid-panel").width());
                        return false;
                    });
                });
                return false;
            });
            $("body").on("click", function () {
                if($("#gridColumnMenu").css("display") == "block") {
                    $("#gridColumnMenu").remove();
                    that.$(".grid-headerBtnTd").removeClass("grid-headerBtnTd-click");
                }
            });
        },
        //每行数据的划过和点击事件
        clickTr:function(){
            var that = this;
            //表格内容tr鼠标划过事件及点击事件
            that.$(".sywTreeGridMainDiv tr").on("mouseover",function(){
                $(this).addClass("gridTrHover");
            });
            that.$(".sywTreeGridMainDiv tr").on("mouseout", function(){
                $(this).removeClass("gridTrHover");
            });
            //判断表格是单选还是多选
            if(that.model.get("singleSelect")){
                //tr绑定事件
                that.$(".sywTreeGridMainDiv tr").off("click");
                that.$(".sywTreeGridMainDiv tr").on("click", function(){
                    that.$(".sywTreeGridMainDiv").find("tr").removeClass("gridTrSelect");
                    $(this).addClass("gridTrSelect");
                    that.$(".checkboxes").removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                    $(this).find("td.checkboxes").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                    return false;
                });
                //checkbox绑定事件
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").off("click");
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").on("click", function(){
                    that.$(".sywTreeGridMainDiv").find("tr").removeClass("gridTrSelect");
                    $(this).parents("tr").addClass("gridTrSelect");
                    that.$(".checkboxes").removeClass("jspGrid-check").addClass("jspGrid-nocheck").attr("checkbox","false");
                    $(this).removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                    that.$el.trigger("rowClick");                      //触发树表的rowClick绑定事件
                    return false;
                });
            } else {
                //tr绑定事件
                that.$(".sywTreeGridMainDiv tr").off("click");
                that.$(".sywTreeGridMainDiv tr").on("click", function(){
                    var checkbox = $(this).find("td.checkboxes");
                    if(checkbox.attr("checkbox") == "false"){
                        checkbox.removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        $(this).addClass("gridTrSelect");
                        return false;
                    }
                });
                //checkbox绑定事件
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").off("click");
                that.$(".sywTreeGridMainDiv tr").find("td.checkboxes").on("click", function(){
                    var checkbox = $(this);
                    if(checkbox.attr("checkbox") == "true"){
                        checkbox.addClass("jspGrid-nocheck").removeClass("jspGrid-check").attr("checkbox","false");
                        $(this).parents("tr").removeClass("gridTrSelect");
                    } else {
                        checkbox.removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                        $(this).parents("tr").addClass("gridTrSelect");
                    }
                    that.$el.trigger("rowClick");                      //触发树表的rowClick绑定事件
                    return false;
                });
            }
        },
        //滚动grid数据时，表头随之滚动方法方法
        gridScroll:function(){
            var that = this;
            this.$(".sywTreeGridMainDiv").scroll(function(){
                that.$(".sywTreeGridHeaderDiv").css("margin-left",-($(this).scrollLeft()));
            });
        },
        //拖拽列改变列宽度方法
        resizeHeaderColumn:function(){
            var that = this;
            this.$(".uiframe-resizecolumn").each(function(){
                var myThis = this;
                var min_width;
                var myTitle = $(this).text();
                var myId = $(this).attr("id");
                var parentId = $(this).parents("div.uiframe-TreeGrid-panel").attr("id");
                if($(this).width() > parseInt(that.model.get("minColumnWidth"))){
                    min_width = parseInt(that.model.get("minColumnWidth"));
                } else {
                    min_width=$(this).width();
                }
                if(that.model.get("resizable")){
//                    var dragSampleView= Sysware.grid.createDragView({
//                        id:myId,
//                        parentId:parentId,
//                        resize:function(){
//                            var dataIndex = $(myThis).attr("dataIndex");
//                            that.$el.find(".resize-"+dataIndex).css("width",$(myThis).width()+1);
//                            that.changeColumnWidth = true;
//                            that.$(".sywTreeGridMainDiv").trigger("scroll");
//                        },
//                        stop:function(){
//                        }
//                    });
                    $(this).resizable({
                        minWidth:min_width,
                        handles: "e",
                        ghost: false,
                        stop:function(event,ui){
                        },
                        resize: function(event, ui) {
                            var dataIndex = $(this).attr("dataIndex");
                            that.$el.find(".resize-"+dataIndex).css("width",$(this).width()+1);
                            that.changeColumnWidth = true;
                            that.$(".sywTreeGridMainDiv").trigger("scroll");
                            //todo   保存column数据
                        }
                    });
                }
            });
        },
        //加载表格数据
        storeLoad:function(url){
            var that = this;
            url = basePath + "/control/treeGridTest.action";
            that.$(".sywTreeGridMainDiv").empty();
            that.$(".sywTreeGridMainDiv").load(url,     //load加载方法
                {treeGridId:that.model.get("treeGridId")},
                function(treeGridHtml){
                    that.resizeDataColumnWidth();          //根据表头列宽重新计算数据列宽度值
                    that.judgeUnnecessaryTdShow();         //判断内容中多余的td是否需要显示
                    //判断如果表头有隐藏列则数据列也隐藏
                    that.$(".uiframe-clickColumn").each(function(){
                        if($(this).parent("td").css("display") == "none"){
                            var dataIndex = $(this).attr("dataindex");
                            that.$("td.column-"+dataIndex).hide();
                        }
                    });
                    that.clickTr();                         //每行数据的划过和点击事件
                    that.setParentNodeClick();              //父级节点绑定点击事件
                });
        },
        //父节点绑定的点击事件
        setParentNodeClick:function(){
            var that = this;
            this.$(".sywTreeGridMainDiv").find("div.uiframe-treeLevel").each(function(){
                var $parents = $(this).parents("td");
                if(!$parents.hasClass("uiframe-treeNode-leaf")){          //判断是否是叶子节点，执行绑定方法
                    $(this).on("click", function(){
                        var myId = $(this).parents("table").attr("id");
                        if($parents.hasClass("uiframe-treeNode-expand")){            //判断是否节点是否是展开的
                            $parents.removeClass("uiframe-treeNode-expand");
                            that.getChildrenNode(myId);
                        } else {
                            $parents.addClass("uiframe-treeNode-expand");
                            $(".syw-treeGrid"+myId).show();
                        }
                        that.judgeUnnecessaryTdShow();                //判断内容中多余的td是否需要显示
                        if(!$(this).parents("tr").hasClass("gridTrSelect")){                   //判断此条数据复选框是否已加勾选样式
                            $(this).parents("tr").addClass("gridTrSelect");
                            $(this).parents("tr").find("td:first").removeClass("jspGrid-nocheck").addClass("jspGrid-check").attr("checkbox","true");
                            that.$el.trigger("rowClick");         //触发树表的rowClick绑定事件
                        }
                        return false;
                    });
                }
            });
        },
        getChildrenNode:function(myId){
            var that = this;
            $(".syw-treeGrid"+myId).each(function(){
                $(this).hide();
                var childrenId = $(this).children("table").attr("id");
                if($(this).children("table").find("td.uiframe-columnTree").hasClass("uiframe-treeNode-expand")){            //判断是否节点是否是展开的
                    $(this).children("table").find("td.uiframe-columnTree").removeClass("uiframe-treeNode-expand");
                }
                that.getChildrenNode(childrenId);
            });
        },
        //根据树表中的内容是否出现滚动条，执行数据生成时多加的td是否需要显示
        judgeUnnecessaryTdShow:function(){
            var $this = this.$(".sywTreeGridMainDiv");
            var trueHeight = $this.height();
            var dataHeight = $this.children("div").height();
            if(trueHeight >= dataHeight){
                $this.find("td.grid-mainBtnTd").show();
                this.$(".sywTreeGridMainDiv").children("div").width($this.width());
            } else {
                $this.find("td.grid-mainBtnTd").hide();
                this.$(".sywTreeGridMainDiv").children("div").width($this.width() - 17);
            }
        },
        //根据表头列宽重新计算数据列宽度值
        resizeDataColumnWidth:function(){
            var that = this;
            this.$(".uiframe-resizecolumn").each(function(){
                var dataIndex = $(this).attr("dataIndex");
                that.$el.find(".resize-"+dataIndex).css("width",$(this).width()+1);
            });
        },
        setHeaderColumn:function(width){
            var that = this;
            //判断是否自适应宽度
            if(this.model.get("forceFit")){
                var columns = this.model.get("columns");
                var columnLength = this.model.get("columns").length;
                var fixColumn = 0;                             //固定列宽的个数
                var fixColumnWidth = 20;                       //所有固定列宽的宽度和
                var columnWidth;                               //剩余列平均宽度
                if(this.model.get("useCheckbox")){
                    fixColumnWidth += 18;
                }
                for(var i = 0;i < columnLength; i ++){
                    var trId = columns[i].id;
                    if(that.$el.find("#"+trId).attr("fixcolumn") && that.$el.find("#"+trId).attr("fixcolumn") == "true"){
                        fixColumnWidth += that.$("#"+trId).width() + 6;
                        fixColumn++;
                        if(that.$el.find("#"+trId).attr("hidecolumn") && that.$el.find("#"+trId).attr("hidecolumn") == "true"){
                            fixColumnWidth -= that.$("#"+trId).width() + 6;
                        }
                    } else {
                        if(that.$el.find("#"+trId).attr("hidecolumn") && that.$el.find("#"+trId).attr("hidecolumn") == "true"){
                            fixColumn++;
                        }
                    }
                }
                if((columnLength - fixColumn) !== 0 && (columnLength - fixColumn) != ""){
                    columnWidth = (width - fixColumnWidth) / (columnLength - fixColumn);
                    for(var j = 0;j < columnLength; j ++){
                        var trIds = columns[j].id;
                        if(that.$el.find("#"+trIds).attr("fixcolumn") == undefined || that.$el.find("#"+trIds).attr("fixcolumn") == "false"){
                            that.$el.find("#"+trIds).width(columnWidth - 6);
                        }
                    }
                }
            }
            this.resizeDataColumnWidth();           //grid数据列重新赋值宽度
        },
        //赋值宽度方法
        setWidth:function(width){
            this.$el.width(width);
            this.setHeaderColumn(width);            //表头列重新赋值宽度
        },
        //赋值高度方法
        setHeight:function(height){
            this.$el.height(height);
            this.$(".sywTreeGridMainDiv").height(height - 28);
        },
        //获取树表的选中数据
        getSelectData:function(){
            var that = this;
            var selectDataArray = [];        //定义选中的数据对象数组
            this.$("tr.gridTrSelect").each(function(){
                var key = $(this).attr("dataKey");
                selectDataArray.push(that.model.get("recordMaps")[key]);
            });
            return selectDataArray;
        },
        clear:function(){
            this.remove();
            this.model.destroy();
            this.model=null;
        }

    });

})(jQuery);


