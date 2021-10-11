$(document).ready(function () {
    $.ajax({
        url: 'connected/check.php',
        type: 'POST',
        data: {
            propose: "initialize"
        },
        dataType: "json"
    }).done(function (json) {
        jQuery.each(json.c_name, function (_i, val) {
            $("#c-site-select").append('<option value=' + val + '>' + val + '</option>');
        });
        $("#c-site-select").append('<option value="所有工程">所有工程</option>');

        jQuery.each(json.c_charge, function (_i, val) {
            $("#c-site-charge").append('<option value=' + val + '>' + val + '</option>');
        });
    });

    $("#c-site-select").change(function () {
        $('#date-func option[value=1]').attr('selected', 'true');

        $.ajax({
            url: 'connected/check.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "change_c_site",
                c_site_name: $(this).val()
            },
        }).done(function (json) {

            update_data(json)

        });

        $('#date-func option[value=1]').removeAttr('selected');
    })

    $("#c-site-charge").change(function () {

        $.ajax({
            url: 'connected/check.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "change_c_site",
                c_site_name: $(this).val()
            },
        }).done(function (json) {

            update_data(json)

        });
    })

    $("#date-func").change(function () {
        if ($('#date-func').val() == '0') {
            $('#date-select').css("display", "block");
        }
        else {
            $('#date-select').css("display", "none");
        }
        $.ajax({
            url: 'connected/check.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "date-func",
                c_site_name: $('#c-site-select').val(),
                date_select: $('#date-func').val(),
                date_start: $('#date-start').val(),
                date_end: $('#date-end').val()
            },
        }).done(function (json) {

            update_data(json);

        });
    })

    $("#date-start").change(function () {
        $.ajax({
            url: 'connected/check.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "date-func",
                c_site_name: $('#c-site-select').val(),
                date_select: $('#date-func').val(),
                date_start: $('#date-start').val(),
                date_end: $('#date-end').val()
            },
        }).done(function (json) {

            update_data(json);

        });
    })

    $("#date-end").change(function () {
        $.ajax({
            url: 'connected/check.php',
            type: 'POST',
            dataType: "json",
            data: {
                propose: "date-func",
                c_site_name: $('#c-site-select').val(),
                date_select: $('#date-func').val(),
                date_start: $('#date-start').val(),
                date_end: $('#date-end').val()
            },
        }).done(function (json) {

            update_data(json);

        });
    })
});

function update_data(json) {
    // 將table清空後重新載入內容
    $('#c-site-tbody').empty();

    let date_tmp = "";
    let count = 0;
    let count_alter = 0;

    // 請款資料
    jQuery.each(json.data, function (_i, obj) {

        if (date_tmp != obj.日期) {
            $('#c-site-tbody').append("<tr class='data-entity'><td>" + obj.日期 + "</td><td></td><td></td>" +
                "<td></td><td></td><td></td><td></td></tr>");
            date_tmp = obj.日期;
            count = 0;
            count_alter = 0;
        }

        if (obj.補請款 == 1) {
            $('#c-site-tbody').append("<tr class='data-entity' style='background-color:#fff0f0' id=補" + ((+count_alter) + 1) + "><td>補" +
                ((+count_alter) + 1) + "</td><td>" + obj.負責人 + "</td><td>" +
                obj.工數 + "</td><td>" + obj.扣工方式 + "</td><td>" + obj.工作內容 +
                "</td><td>" + obj.扣工明細 + "</td><td>" + obj.總額 + "</td></tr>");
            count_alter++;
        } else {
            $('#c-site-tbody').append("<tr class='data-entity' id=" + ((+count) + 1) + "><td>" +
                ((+count) + 1) + "</td><td>" + obj.負責人 + "</td><td>" +
                obj.工數 + "</td><td>" + obj.扣工方式 + "</td><td>" + obj.工作內容 +
                "</td><td>" + obj.扣工明細 + "</td><td>" + obj.總額 + "</td></tr>");
            count++;
        }
    });
}

function make_file() {

    $.ajax({
        url: 'connected/check.php',
        type: 'POST',
        dataType: "json",
        data: {
            propose: "make_files",
            c_site_name: $('#c-site-select').val(),
            date_select: $('#date-func').val(),
            date_start: $('#date-start').val(),
            date_end: $('#date-end').val()
        },
    }).done(function (json) {

        let date_tmp = "";
        let count = 0;
        let count_alter = 0;
        var wb = XLSX.utils.book_new();

        // 請款資料
        jQuery.each(json.data, function (_i, obj) {

            if (date_tmp != obj.日期 && date_tmp != "") {
                // 取得日期
                var month = date_tmp.substr(5, 2);
                var day = date_tmp.substr(8, 2);

                var weekArray = new Array("日", "一", "二", "三", "四", "五", "六");
                var week = weekArray[new Date(date_tmp).getDay()];

                var ws = XLSX.utils.table_to_sheet(document.getElementById('save-table'));
                var sheetName = month + "-" + day + "(" + week + ")";

                XLSX.utils.book_append_sheet(wb, ws, sheetName);

                if (date_tmp != "") {
                    $('#save-tbody').empty();
                }
            }

            if (obj.補請款 == 1) {
                $('#save-tbody').append("<tr class='data-entity' style='background-color:#fff0f0' id=補" + ((+count_alter) + 1) + "><td>補" +
                    ((+count_alter) + 1) + "</td><td>" + obj.工程名稱 + "</td><td>" +
                    obj.負責人 + "</td><td>" + obj.請款人 + "</td><td>" + obj.工數 + "</td><td>" +
                    obj.扣工方式 + "</td><td>" + obj.工作內容 + "</td><td>" + obj.扣工明細 + "</td><td>" +
                    obj.工錢 + "</td><td>" + obj.總額 + "</td></tr>");
                count_alter++;
            } else {
                $('#save-tbody').append("<tr class='data-entity' id=" + ((+count) + 1) + "><td>" +
                    ((+count) + 1) + "</td><td>" + obj.工程名稱 + "</td><td>" +
                    obj.負責人 + "</td><td>" + obj.請款人 + "</td><td>" + obj.工數 + "</td><td>" +
                    obj.扣工方式 + "</td><td>" + obj.工作內容 + "</td><td>" + obj.扣工明細 + "</td><td>" +
                    obj.工錢 + "</td><td>" + obj.總額 + "</td></tr>");
                count++;
            }

            if (date_tmp != obj.日期) {
                date_tmp = obj.日期;
                count = 0;
                count_alter = 0;
            }
        });

        // 最後一天的資料
        var month = date_tmp.substr(5, 2);
        var day = date_tmp.substr(8, 2);

        var weekArray = new Array("日", "一", "二", "三", "四", "五", "六");
        var week = weekArray[new Date(date_tmp).getDay()];

        var ws = XLSX.utils.table_to_sheet(document.getElementById('save-table'));
        var sheetName = month + "-" + day + "(" + week + ")";

        XLSX.utils.book_append_sheet(wb, ws, sheetName);

        // 取得今天日期
        var d = new Date();
        var month = d.getMonth() + 1;
        var day = d.getDate();

        var output = d.getFullYear() + '-' +
            (month < 10 ? '0' : '') + month + '-' +
            (day < 10 ? '0' : '') + day;

        var xlsx_name = output + ".xlsx";
        XLSX.writeFile(wb, xlsx_name);
    });
}