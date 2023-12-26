$(document).ready(function () {
    var deletedRowIndex;
    var deletedRow;
    $("#grdvDeliveryJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();

    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var btnId = $(this).attr('id');


        deletedRowIndex = $(this).closest('tr').index() + 1;
        var table = document.getElementById('grdvDeliveryJob');
        var jobId = table.rows[deletedRowIndex].cells[1].innerHTML;

        var Id = table.rows[deletedRowIndex].cells[0].innerHTML;

        $('#DeliveryJobId').val(jobId);
        //   alert(jobId);

        if (btnId == "btnDelivery") {


            $('#DeliveryModal').modal({
                show: true,
                backdrop: 'static'
            });

        }
        else if (btnId == "btnDeny") {
            deletedRow = $(this).closest('tr');
            $('#txtDenyReason').val('');
            $('#DenyModal').modal({
                show: true,
                backdrop: 'static'
            });

        }


        $('#btnPrintChalan').on('click', function (e) {
            e.preventDefault();

            deletedRow = $(this).closest('tr');
            var billingAmount = $('#txtBillingAmount').val();
            if (billingAmount == 0) {
                alert('Plz confirm billing ammount');
                //  $('#DeliveryModal').modal('Hide');
                return false;
            }

            $.ajax({
                type: "POST",
                url: "Delivery.aspx/DeliveryJob",
                data: JSON.stringify({ 'id': Id, 'billingAmount': billingAmount }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d == "ok") {


                        deletedRow.remove();
                        $('#DeliveryModal').modal('hide');
                        window.location = "PrintChallan.aspx?id=" + Id;
                    }
                }
            });
        });

        $('#btnConfirmDeny').on('click', function (e) {
            e.preventDefault();

            var denyReason = $('#txtDenyReason').val();
            //alert(denyReason);

            $.ajax({
                type: "POST",
                url: "Delivery.aspx/DenyJob",
                data: JSON.stringify({ 'id': Id, 'denyReason': denyReason }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d == "ok") {

                        // alert("a");
                        $('#DenyModal').modal('hide');
                        deletedRow.remove();
                        //window.location = "printChalan.aspx?id=" + Id;
                    }
                }
            });
        });
    });
});