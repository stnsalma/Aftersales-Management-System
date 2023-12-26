$(function () {
    var deletedRow;
    $("#grdvInchargeTvBillingPending").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable({
        "bPaginate": false
    });
    //$('#grdvInchargeTvBillingPending').dataTable({
    //    "bPaginate": false
    //});


    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

    // Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });



    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var id = $(this).attr('id');
        var deletedRowIndex = $(this).closest('tr').index() + 1;
        var table = document.getElementById('grdvInchargeTvBillingPending');
        var receiveId = table.rows[deletedRowIndex].cells[0].innerHTML;
        $('#txtPendingJobIdModal').val(receiveId);
        //var model = table.rows[deletedRowIndex].cells[1].innerHTML;

        console.log(name);
        if (id == "btnSetBill") {
            $('#setBillModal').modal({
                show: true,
                backdrop: 'static'
            });
            deletedRow = $(this).closest('tr');
        }
    });


    $('#btnPendingJobModalSetBillConfirm').on('click', function (e) {
        e.preventDefault();
        var obj = {};
        obj.jobId = $("#txtPendingJobIdModal").val();
        obj.amount = $("#txtPendingBillAmountModal").val();
        obj.billComment = $("#txtPendingCommentModal").val();
        
        
        $.ajax({
            type: "POST",
            url: "TvBillPending.aspx/TvSetBillForAJob",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "ok") {
                    deletedRow.remove();
                    alertify.success('Data Saved Successfully !');
                } else if(result.d == "no") {
                    alertify.error("Error !!! Could not Saved");
                }
            },
            failure: function (responser) {
                alert("i am in failure");
            }
        });
    });

});