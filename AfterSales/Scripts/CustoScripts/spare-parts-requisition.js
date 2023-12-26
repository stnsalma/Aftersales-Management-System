$(function () {
    function Parts(Id, Status) {

        // Add object properties like this
        this.Id = Id;
        this.Status = Status;
    }
    //var parts = {Id:"",Status:false};
    var requestedParts = [];
    var table = document.getElementById("grdvdetailsPendingLoan");
    for (var i = 1; i < table.rows.length; i++) {
        var cell = table.rows[i].cells;
        var part = new Parts(cell[1].innerHTML, "no");
        requestedParts.push(part);
    }
    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var btnId = $(this).attr('id');
        if (btnId !== "btnSubmitRequestedSpareParts" && btnId != "btnCacelRequestedSpareParts") {
            var tableId = $(this).closest('table').prop('id');
            var currentIndex = $(this).closest('tr').index();

            var requitionId = table.rows[currentIndex].cells[0].innerHTML;
            var id = table.rows[currentIndex].cells[1].innerHTML;
            var itemStatus = "";
            
            if (btnId == "btnSparePartsRequisitionSanction") {
                itemStatus = "sanc";
                $(this).closest('tr').css('background-color', '#CCFFCC');
            }
            else if (btnId == "btnSparePartsRequisitionUnavailable") {
                itemStatus = "unavail";
                $(this).closest('tr').css('background-color', '#99CCFF');
            }
            if (requestedParts.length > 0) {
                for (var i in requestedParts) {
                    if (requestedParts[i].Id == id) {
                        requestedParts[i].Status = itemStatus;
                    }
                }
            }
            console.log(requestedParts);
        }
    });


    $('#btnSubmitRequestedSpareParts').on('click', function () {
        if (requestedParts.length > 0) {
            var isNotSelected = false;
            for (var i in requestedParts) {
                if (requestedParts[i].Status == "no") {
                    isNotSelected = true;
                    break;
                } else {
                    continue;
                }
            }
            
            if (isNotSelected == false) {
                var requisition = JSON.stringify(requestedParts);
                //console.log(requisition);
                var a = "kjdkf";
                //ajax posting 
                $.ajax({
                    type: "POST",
                    url: "RequestedSpareParts.aspx/SaveRequisitionSpareParts",
                    contentType: "application/json; charset=utf-8",
                    traditional:true,
                    data: JSON.stringify({ partses: requestedParts }),
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "ok") {
                            alertify.success("Parts Sanctioned Succesfully");
                            window.location.href = "PendingLoan.aspx?status=ok";
                        } else if(result.d == "no") {
                            alertify.error("Error !!!");
                        }
                    },
                    error: function (result) {
                        alert('Oh no :(');
                        console.log(result.d);
                    }
                });
            } else {
                alertify.alert("Select Every Parts as Sanction Or Unavailable !!!");
            }
        }
    });

    $('#btnCacelRequestedSpareParts').on('click', function () {
        window.location.href = "PendingLoan.aspx";
    });

});