$(document).ready(function () {
    $.ajax({
        url: 'connected/punch_in.php',
        type: 'POST',
        data: {
            propose: "initialize"
        },
        dataType: "json"
    }).done(function (json) {
        jQuery.each(json.name, function (_i, val) {
            $("#c_site_name").append('<option value=' + val + '>' + val + '</option>');
        });
    });

    // 扣工方式:營造請
    $('#deduction_method').change(function(){
        if($('#deduction_method').val() == '營造請'){
            $('#deduction_remark').removeClass('d-none');
        }
        else{
            $('#deduction_remark').addClass('d-none');
        }
    })

    // 取得今天日期
    var d = new Date();
    var month = d.getMonth() + 1;
    var day = d.getDate();

    var output = d.getFullYear() + '-' +
        (month < 10 ? '0' : '') + month + '-' +
        (day < 10 ? '0' : '') + day;

    $('#date').val(output);

    // 送出表單
    $("#c_site_form").submit(function (e) {

        var form = $(this);
        var url = form.attr('action');

        $.ajax({
            type: "POST",
            url: url,
            data: form.serialize(),
            dataType: "json",
            success: function (json) {
                console.log(json.status); // show response from the php script.
                alert('新增成功');
                location.reload();
            }
        });

        e.preventDefault(); // avoid to execute the actual submit of the form.
    });

});
