var test = {
    mask:undefined
};

// 新建、编辑弹出窗口
test.showTestWindow = function(id){
    var title="新增";
    var url=basePath + "/test/viewTest.action";
    var saveUrl = basePath + "/test/addTest.action";
    if(id && id != ""){
        title="编辑";
        url+="?id="+id;
        saveUrl=basePath + "/test/updateTest.action";
    }
    var buttons=[];
    var saveButton=$('<button class="uiframe-button">保存</button>');
    saveButton.on("click",function(){
        $.ajax({
            type: "POST",
            url: saveUrl,
            data:$("#testForm").serialize(),
            success:function(){
                $.sywDialog.msg("提示","操作成功");
				addIconSortWindow.close();
				$("#testGrid").trigger("reload");
            }
        });
    });
    var cancelButton=$('<button class="uiframe-button uiframe-cancel-btn">取消</button>');
    cancelButton.on("click",function(){
        addIconSortWindow.close();
    });
    buttons.push(saveButton);
    buttons.push(cancelButton);
    var addIconSortWindow = $.sywWindow.show({
        "title":title,
        "width":600,
        "height":176,
        "url":url,
        "useMask":true,
        bottomContent:buttons
    });
};

// 删除图标分类节点方法
test.delete = function(id) {
    $.sywDialog.confirm("删除操作","请确认所选分类是否删除?",function(){
        $.ajax({
            type: "POST",
            url: basePath + "/test/deleteTest.action",
            data:"id="+id,
            success:function(){
                $.sywDialog.msg("提示","删除成功");
				$("#testGrid").trigger("reload");
            }
        });
    });
};


$(function(){

    //grid新增方法
    $("#addTest").on("click",function(){
		test.showTestWindow();
    });
    //grid删除方法
    // $("#deleteIcon").on("click",function(){
    //     var records = $("#iconGridMainDiv").find(".jspGridTrSelect");
    //     var idArray=[];
    //     for(var i=0;i<records.length;i++){
    //         idArray.push($(records[i]).attr("dataId"));
    //     }
    //     test.delete(idArray.join(","), "请确认所选图标是否删除?");
    // });

    // grid点击事件
    $("#testGrid").on("selectChange", function(e, selectData){
        if (selectData.length > 1) {
            $("#deleteIcon").show();
            $("#downloadIcon").show();
        } else {
            $("#deleteIcon").hide();
            $("#downloadIcon").hide();
        }
    });

    // 表格列划过事件
    $(document).on("mouseover","#testGridMainTable tr",function(){
        $(this).find("div.grid_iconTools").show();
    }).on("mouseout","#testGridMainTable tr",function(){
        $(this).find("div.grid_iconTools").hide();
    });

    // 表格列上编辑、删除事件
    $(document).on("click","#testGridMainTable .iconEdit",function(){
        test.showTestWindow($(this).attr("dataId"));
    }).on("click","#testGridMainTable .iconDelete",function(){
        test.delete($(this).attr("dataId"));
    });

});