// 負責記錄現在頁面、先前頁數、總頁數
var now_page = 1;
var page_num = 1;

var choose = "";
var edit_name = "";
var edit_date_start = "";
var edit_date_end = "";
var delete_obj = "";

// 網頁載入時的初始化
// 載入表格內資訊
$(document).ready(function () {
    $.ajax({
        url: 'connected/edit_ajax.php',
        type: 'POST',
        data: {
            propose: "initialization",
            now_page: "1"
        },
        dataType: "json"
    }).done(function (json) {
        page_num = json.page_num;
        
        $('#username').text(json.name);
        $('#userpower').text(json.power); 

        update_table(json);
        page_set();

        // 新增工程
        $('#btn-add-confirm').click(function () {
            $.ajax({
                url: 'connected/edit_ajax.php',
                type: 'POST',
                dataType: "json",
                data: {
                    propose: "add",
                    c_site_name: $('#c_site_name').val(),
                    c_site_date_start: $('#c_site_date_start').val(),
                    c_site_date_end: $('#c_site_date_end').val()
                },
            }).done(function (json) {
                now_page = 1;
                page_num = json.page_num;

                $("#add_modal").modal('hide');

                handler_alert('新增', json.status)
                update_table(json);
                page_set();
            });
        })

        // 確定刪除工程
        $('#btn-delete-confirm').click(function () {
            $.ajax({
                url: 'connected/edit_ajax.php',
                type: 'POST',
                dataType: "json",
                data: {
                    propose: "delete",
                    c_site_name: delete_obj
                },
            }).done(function (json) {
                now_page = 1;
                page_num = json.page_num;

                $("#delete_modal").modal('hide');

                handler_alert('刪除', json.status)
                update_table(json);
                page_set();
            });
        })
    });
})

function page_set() {
    // 更新頁數按鈕
    $('#new-page-buttons').empty();
    for (let i = 1; i <= page_num; i++) {
        let pageBtn;
        if (i == now_page) {
            pageBtn = $('<button class="btn btn-outline-primary page-btn" id="btn-' + i + '">' + i + '</button>');
        } else {
            pageBtn = $('<button class="btn page-btn" id="btn-' + i + '">' + i + '</button>');
        }

        $('#new-page-buttons').append(pageBtn);
    }

    // 新增按鈕的換頁功能
    $('.page-btn').click(function () {

        // 選擇下一個頁面 && 更新頁籤css
        let next_page = 1;

        if ($(this).text() == '前一頁') {
            next_page = parseInt(now_page, 10) - 1;
        } else if ($(this).text() == '後一頁') {
            next_page = parseInt(now_page, 10) + 1;
        } else {
            next_page = $(this).text();
        }

        $('#btn-' + now_page).removeClass('btn-outline-primary');
        $('#btn-' + next_page).addClass('btn-outline-primary');

        $.ajax({
            url: 'connected/edit_ajax.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "change_page",
                now_page: next_page
            },
        }).done(function (json) {
            now_page = json.now_page;
            page_num = json.page_num;

            page_format(now_page, page_num);

            update_table(json);
        });
    })
}

function page_format(now_tmp, page_tmp) {
    // 當在第一頁disabled"前一頁"功能
    if (now_tmp == 1) {
        $('#front-page').attr('disabled', true);
    } else {
        $('#front-page').attr('disabled', false);
    }

    // 當在最後一頁disabled"後一頁"功能
    if (now_tmp == page_tmp) {
        $('#next-page').attr('disabled', true);
    } else {
        $('#next-page').attr('disabled', false);
    }
}

function update_table(json) {
    // 清空table
    $('#c_site_tbody').empty();
    // 將資料新增至table中
    json.data.map(function (obj) {
        $('#c_site_tbody').append("<tr class='data-entity' id=" + obj.工程名稱 + "><td class='edit-text'>" +
            obj.工程名稱 + "</td><td class='edit-text'>" + obj.開始日期 + " ~ " + obj.預計結束日期 +
            "</td><td class='edit-text'><button class='btn btn-outline-success btn-edit' type='button'>修改</button>" +
            "<button type='button' class='btn btn-outline-danger btn-delete' data-bs-toggle='modal' " +
            "data-bs-target='#delete_modal'>刪除</button></td><td class='edit-input'>" +
            "<input type='text' class='form-control c_site_name' placeholder='請輸入工程名稱' required></td><td class='edit-input'><div class='input-group has-validation'>" +
            "<input type='date' class='form-control c_site_date_start' required> <span class='input-group-text'>~</span>" +
            "<input type='date' class='form-control c_site_date_end' required></div>" +
            "</td><td class='edit-input'><button class='btn btn-success btn-edit-confirm' type='button'>確定</button>" +
            "<button type='button' class='btn btn-danger btn-cancel'" +
            ">取消</button></td></tr>");
    });

    $('.edit-input').hide();

    // 設定頁數按鈕css
    page_format(now_page, page_num);


    // 修改工程input <-> text切換
    $('.btn-edit').click(function () {

        choose = $(this).parent().parent().attr('id');

        edit_name = $('#' + choose + ' td:nth-child(1)').text();
        edit_date_start = $('#' + choose + ' td:nth-child(2)').text().substring(0, 10);
        edit_date_end = $('#' + choose + ' td:nth-child(2)').text().substring(13);

        $('#' + choose).siblings().find('td.edit-text').show();
        $('#' + choose).siblings().find('td.edit-input').hide();
        $('#' + choose + ' .edit-input').show();
        $('#' + choose + ' .edit-text').hide();

        $('#' + choose + ' .c_site_name').val(edit_name);
        $('#' + choose + ' .c_site_date_start').val(edit_date_start);
        $('#' + choose + ' .c_site_date_end').val(edit_date_end);
    })

    // 確認修改
    $('.btn-edit-confirm').click(function () {
        $.ajax({
            url: 'connected/edit_ajax.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "update",
                now_page: now_page,
                c_site_name_before: edit_name,
                c_site_name: $('#' + choose + ' .c_site_name').val(),
                c_site_date_start: $('#' + choose + ' .c_site_date_start').val(),
                c_site_date_end: $('#' + choose + ' .c_site_date_end').val()
            },
        }).done(function (json) {

            handler_alert('更新', json.status);
            console.log(json.sql1);
            update_table(json);
            page_set();
        });
    })

    // 取消修改
    $('.btn-cancel').click(function () {

        choose = "";

        $('#' + $(this).parent().parent().attr('id') + ' .edit-text').show();
        $('#' + $(this).parent().parent().attr('id') + ' .edit-input').hide();

    })

    // 刪除工程
    $('.btn-delete').click(function () {
        delete_obj = $(this).parent().parent().attr('id');
        $('#modal-body').html("確定要刪除 <b>" + delete_obj + "</b> 嗎?");
    })
}

function handler_alert(func, status) {
    $('#alert-outer-div').append(`<div class="alert d-flex alert-dismissible alert-fade" role="alert" id="alert-inner-div">
    <svg class="bi flex-shrink-0 me-2" id="svg-success" width="24" height="24" role="img"><use xlink:href="#check-circle-fill" /></svg>
    <svg class="bi flex-shrink-0 me-2" id="svg-danger" width="24" height="24" role="img"><use xlink:href="#exclamation-triangle-fill" /></svg>
    <div id="alert-text"></div><button type="button" class="btn-close" data-bs-dismiss="alert" aria-lbel="Close"></button></div>`);
    
    if(status == '成功'){
        $('#svg-danger').css('display', 'none');
        $('#alert-inner-div').addClass('alert-success');
    }
    else if(status == '失敗'){
        $('#svg-success').css('display', 'none');
        $('#alert-inner-div').addClass('alert-danger');
    }
    $('#alert-text').text(func + status);

    $(".alert-fade").fadeOut(2000);
    setTimeout(function () { $("#alert-inner-div").remove() }, 2000);
}