$(function () {

    function Approval(ServiceId, TechnicianId, Code, TotalPending,Status) {

        // Add object properties like this
        this.ServiceId = ServiceId;
        this.TechnicianId = TechnicianId;
        this.Code = Code;
        this.TotalPending = TotalPending;
        this.Status = Status;
    }
    //var parts = {Id:"",Status:false};
    var approvalList = [];
    var grid = document.getElementById("grdvSparePartsApprovedDetails");
    for (var i = 1; i < grid.rows.length; i++) {
        var cell = grid.rows[i].cells;
        var part = new Approval(cell[0].innerHTML, cell[1].innerHTML,cell[3].innerHTML, 0, false);
        console.log(cell[10]);
        approvalList.push(part);
    }
    console.log(approvalList);
    $('input[type = "number"]').on('change', function (e) {
        e.preventDefault();
        var tableId = "grdvSparePartsApprovedDetails";
        var table = document.getElementById(tableId);
        var row = $(this).closest('tr').index()+1;
        var totalRequisition = table.rows[row].cells[6].innerHTML;
        var totalUsed = table.rows[row].cells[7].innerHTML;

        var getReturn = parseInt(totalRequisition) - parseInt(totalUsed);
        var totalReturn = $(this).val();
        var intReturn = parseInt(totalReturn);
        if (intReturn >= 0) {


            if (intReturn < getReturn) {
                alertify.alert("You have Pending return " + (getReturn - intReturn));
                $(this).closest('tr').find('[id*="txtSpareApprovalTotalPending"]').val(getReturn - intReturn);
            }
            else if (intReturn > getReturn) {
                alertify.alert("You will get return " + getReturn + " " + "not " + intReturn);
                $(this).val(getReturn);
                $(this).closest('tr').find('[id*="txtSpareApprovalTotalPending"]').val(0);
            }
            else if (intReturn == getReturn) {
                $(this).closest('tr').find('[id*="txtSpareApprovalTotalPending"]').val(0);
            }
        } else {
            alertify.alert("Return value can't be Nagetive");
            $(this).val(getReturn);
            $(this).closest('tr').find('[id*="txtSpareApprovalTotalPending"]').val(0);
        }

    });

    $('input[type = "submit"]').on('click', function (e) {
        e.preventDefault();
        var btnId = $(this).attr('id');
        if (btnId != "btnSpareApprovalSubmit" && btnId != "btnSpareApprovalCancel") {
            var tableId = "grdvSparePartsApprovedDetails";
            var table = document.getElementById(tableId);
            var row = $(this).closest('tr').index()+1;
            var oraCode = table.rows[row].cells[3].innerHTML;
            var totalReturn = $(this).closest('tr').find('[id*="txtSpareApprovalTotalReturn"]').val();
            var totalPending = $(this).closest('tr').find('[id*="txtSpareApprovalTotalPending"]').val();
            totalReturn = parseInt(totalReturn);
            totalPending = parseInt(totalPending);
            if (totalReturn >= 0 && totalPending >= 0) {
                if (approvalList.length > 0) {
                    for (var i in approvalList) {
                        if (approvalList[i].Code == oraCode) {
                            approvalList[i].Status = true;
                            approvalList[i].TotalPending = totalPending;
                            
                            break;
                        }
                    }
                    if (totalPending > 0) {
                        $(this).closest('tr').css('background-color', 'red');
                    }else{
                    $(this).closest('tr').css('background-color', '#0B691B');
                }
                }
            } else {
                alertify.alert("Please input Return quantity");
            }
        }
    });


    $('#btnSpareApprovalSubmit').on('click', function () {
        var flag = 0;
        if (approvalList.length > 0) {
            for (var i in approvalList) {
                if (approvalList[i].Status == false) {
                    ++flag;
                    break;
                }
            }
        }
        if (flag == 0) {
            $.ajax({
                type: "POST",
                url: "SparePartsApproveDetails.aspx/SaveApprovedSpares",
                contentType: "application/json; charset=utf-8",
                traditional: true,
                data: JSON.stringify({ spares: approvalList }),
                dataType: "json",
                success: function (result) {
                    if (result.d == "ok") {
                        alertify.success("Parts Sanctioned Succesfully");
                        window.location.href = "ApproveLoan.aspx?status=ok";
                    } else if (result.d == "no") {
                        alertify.error("Error !!!");
                    }
                },
                error: function (result) {
                    alert('Oh no :(');
                    console.log(result.d);
                }
            });
        } else {
            alertify.alert("You have to Approve Every Spare before Submit !!!");
        }
    });
    
    $('#btnSpareApprovalCancel').on('click', function () {
        window.location.href = "ApproveLoan.aspx";
    });
});