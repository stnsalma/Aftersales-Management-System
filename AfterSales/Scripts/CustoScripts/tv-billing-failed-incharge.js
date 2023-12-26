
$(function () {

    $('input[type="submit"]').on('click', function (e) {
        e.preventDefault();
        var tableId = $(this).closest('table').prop('id');
        var id = $(this).attr('id');
        var deletedRowIndex = $(this).closest('tr').index()+1;
        var table = document.getElementById(tableId);
        var rowId = table.rows[deletedRowIndex].cells[0].innerHTML;
        console.log(deletedRowIndex + " ---- " + rowId);
        alertify.dialog('confirm').set({
            'labels': { ok: 'Yes!', cancel: 'No!' },
            'message': 'Are you sure ???',
            'onok': function () {
                
                
                    $.ajax({
                    type: "POST",
                    url: "TvBillingFailed.aspx/TerminateJob",
                    data: "{'rowId':"+rowId+"}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        //alert("i am in success");
                        if (result.d == "ok") {
                            //alert("Data Saved Successfully !");
                            alertify.success("Data saved successfully !");
                        }

                    },
                    failure: function (response) {
                        console.log("I am in failure");
                    }
                });
                console.log("yes");
            },
            'oncancel': function () {
                console.log("no");
            }
        }).show();
    });
    $('#grdvInchargeBillingFailed').prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
    $('#grdvInchargeBillingFailed').dataTable();
});