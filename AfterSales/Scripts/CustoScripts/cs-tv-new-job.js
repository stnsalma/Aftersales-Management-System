$(function () {


    var url = document.location.toString();
    var deletedRow;
    var selectedItem;
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

    // Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });

    //For Data Table
  
    //$('#grdvInchargeAssign, #grdvOutdoorReceive').prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
    //$('#grdvInchargeAssign, #grdvOutdoorReceive').dataTable();
    $('.tablehead').prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable({
        "bPaginate": false
    });
   
    
    //Function for terminate job
    function terminateJob(jobId) {
        var obj = {};
        obj.jobId = jobId;
        deletedRow = $('#btnApply').closest('tr');
        $.ajax({
            type: "POST",
            url: "TvIndoorReceive.aspx/TvJobTerminate",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "ok") {
                    deletedRow.remove();
                    alertify.success('Job is Terminated. ID: ' + jobId);
                }
            },
            failure: function (responser) {
                alert("i am in failure");
            }
        });

    }

    $('.decision').change(function () {
        selectedItem = $(this).val();
    });

    //Load Modals
    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var tableId = $(this).closest('table').prop('id');
        var id = $(this).attr('id');
        var deletedRowIndex = $(this).closest('tr').index() + 1;
        var table = document.getElementById(tableId);
        var jobId = table.rows[deletedRowIndex].cells[1].innerHTML;
        var receiveId = table.rows[deletedRowIndex].cells[0].innerHTML;
        var modelNo = table.rows[deletedRowIndex].cells[4].innerHTML;
        var serialNo = table.rows[deletedRowIndex].cells[5].innerHTML;
        var selectedValue = $(this).closest('tr').find('[id*="ddlDecisions"]').val();
        console.log(selectedValue);
        $('#txtJobID').val(jobId);
        $('#txtNewJobIdModal').val(jobId);
        $('#lblID').text(receiveId);
        //
        $('#lblIDWarrantyVoid').text(receiveId);
        $('#lblTvTransfer').text(receiveId);
        $('#lblTvTerminate').text(receiveId);
        
        //
        $('#txtSerialNo').val(serialNo);
        var model = table.rows[deletedRowIndex].cells[4].innerHTML;

        if (selectedValue == "*") {
            //alertify.alert("Please Select an Action from Dropdown Menu");
            alertify.dialog('alert')
              .set({
                  'title': 'Alert',
                  'transition': 'slide',
                  'message': "Please Select an Action from Dropdown Menu",
              }).show();

        }
        if (selectedValue == "Assign") {
            $('#txtModel').val(model);
            
            $('#inchargeNewJobAssignModal').modal({
                
                show: true,
                backdrop: 'static'
            });
            deletedRow = $(this).closest('tr');
        }
        else if (selectedValue == "Warrenty Void") {

            $('#inchargeNewJobWarrentyVoidModal').modal({
                show: true,
                backdrop: 'static'
            });
            deletedRow = $(this).closest('tr');
        }
        else if (selectedValue == "Transfer") {
            $('#txtJobIdTransferModal').val(jobId);
            $('#txtModelTransferModal').val(modelNo);
            $('#inchargeNewJobTransferedModal').modal({
                show: true,
                backdrop: 'static'
            });
            deletedRow = $(this).closest('tr');
        }
        else if (selectedValue == "Terminate") {
            

            //alertify.dialog('confirm')
            //  .set({
            //      'title': 'Alert',
            //      'transition': 'slide',
            //      'labels': { ok: 'Yup!', cancel: 'Nop!' },
            //      'message': 'Are you sure to Terminate this Job ? Job ID is ' + jobId,
            //      'onok': function () {
            //          terminateJob(jobId);
            //          selectedItem = "";
            //      },
            //      'oncancel': function () {
            //          selectedItem = "";
            //           alertify.error('You did not Terminate the job !');
            //      }
            //  }).show();
            $('#txtJobIdTerminateModal').val(jobId);
            $('#txtModelTerminateModal').val(modelNo);
            $('#txtSerialNoTerminateModal').val(serialNo);
            $('#inchargeNewJobTerminateModal').modal({
                show: true,
                backdrop: 'static'
            });
            deletedRow = $(this).closest('tr');

        }
    });



    //Data Posting using ajax for Job Assign
    $('#btnAssignConfirm, #btnTvOutdoorJobAssignConfirm').click(function (e) {
        e.preventDefault();
        var btnId = $(this).attr('id');
        var codeBehind = "";
        if (btnId == "btnTvOutdoorJobAssignConfirm") {
            codeBehind = "TvOutDoorReceive.aspx";
        }
        else if (btnId == "btnAssignConfirm") {
            codeBehind = "TvIndoorReceive.aspx";
        }
        var obj = {};
        obj.Id = $('#lblID').text();
        obj.jobId = $("#txtJobID").val();
        obj.modelName = $("#txtModel").val();
        obj.technicianName = $("#ddlSelectTechnician").val();
        obj.comment = $('#txtTvJobAssignComment').val();
        var destination = codeBehind + "/TvJobAssign";
        $.ajax({
            type: "POST",
            url: destination,
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                //alert("i am in success");
                if (result.d == "ok") {
                    //alert("Data Saved Successfully !");
                    alertify.success("Data saved successfully !");
                    deletedRow.remove();
                }

            },
            failure: function (response) {
                console.log("I am in failure");
            }
        });
        
    });


    //For Warrenty Void
    $('#btnWarrentyVoidConfirm').click(function (e) {
        e.preventDefault();
        var warrentVoidObj = {};
        warrentVoidObj.Id = $('#lblIDWarrantyVoid').text();
        warrentVoidObj.jobId = $('#txtNewJobIdModal').val();
        warrentVoidObj.voidComment = $('#txtCommentModal').val();
        warrentVoidObj.voidReason = $('#ddlReasonModal :selected').val();
        if (warrentVoidObj.voidReason != "" || warrentVoidObj.voidReason != "Select" || warrentVoidObj.voidReason != undefined) {
            $.ajax({
                type: "POST",
                url: "TvIndoorReceive.aspx/TvJobWarrentyVoid",
                data: JSON.stringify(warrentVoidObj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d == "ok") {
                        //alert("Data Saved Successfully !");
                        alertify.success("Data saved successfully !");
                        deletedRow.remove();
                    }
                },
                failure: function (responser) {
                    alert("i am in failure");
                }
            });
        } else {
            alert("Select a reason");
        }
        
    });


    //For Job Transfer

    $('#btnTransferConfirm').click(function (e) {
        e.preventDefault();
        var jobTransferObj = {};
        jobTransferObj.jobId = $('#txtJobIdTransferModal').val();
        jobTransferObj.servicePointId = $('#ddlToServiceCenterTransferModal').val();
        jobTransferObj.transferComment = $('#txtCommentTransferModal').val();
        jobTransferObj.Id = $('#lblTvTransfer').text();
        $.ajax({
            type: "POST",
            url: "TvIndoorReceive.aspx/TvJobTransfer",
            data: JSON.stringify(jobTransferObj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "ok") {
                    //alert("Data Saved Successfully !");
                    alertify.success("Data saved successfully !");
                    deletedRow.remove();
                }
                if (result.d == "same") {
                    //alertify.alert("To & From Service Point Can't be Same !!!");
                    alertify.alert("সার্ভিস পয়েন্ট এক হতে পারবে না !!!");
                    alertify.error("Can't Transfer");
                }
            },
            failure: function (responser) {
                alert("i am in failure");
            }
        });
    });

    //For Terminate a Job

    $('#btnTerminateConfirm, #btnTvOutdoorJobTerminateConfirm').click(function (e) {
        e.preventDefault();
        var btnId = $(this).attr('id');
        var codeBehind = "";
        if (btnId == "btnTvOutdoorJobTerminateConfirm") {
            codeBehind = "TvOutDoorReceive.aspx";
        }
        else if (btnId == "btnTerminateConfirm") {
            codeBehind = "TvIndoorReceive.aspx";
        }
        var destination = codeBehind + "/TvJobTerminate";
        var jobTerminateObj = {};
        jobTerminateObj.jobId = $('#txtJobIdTerminateModal').val();
        jobTerminateObj.terminateComment = $('#txtCommentTerminateModal').val();
        jobTerminateObj.Id = $('#lblTvTerminate').text();
        $.ajax({
            type: "POST",
            url: destination,
            data: JSON.stringify(jobTerminateObj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "ok") {
                    alertify.success("Data saved successfully !");
                    deletedRow.remove();
                }
            },
            failure: function (response) {
                alert("i am in failure");
            }
        });
    });

});