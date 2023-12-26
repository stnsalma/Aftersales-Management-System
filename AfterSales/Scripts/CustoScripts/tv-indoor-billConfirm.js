/// <reference path="E:\Walton Projects\CRM_TV\CRM_TV\WSMS_TV\CustomerCare/TvIndoorConfirmationList.aspx" />
/// <reference path="E:\Walton Projects\CRM_TV\CRM_TV\WSMS_TV\CustomerCare/TvIndoorConfirmationList.aspx" />
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
    $('.tablehead').prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
    $('.tablehead').dataTable();

    //Function for terminate job
    function billConfirmationFunc(jobId, buttonValue, deleteRow) {
        var obj = {};
        obj.jobId = jobId;
        obj.buttonValue = buttonValue;
        deletedRow = deleteRow;
        $.ajax({
            type: "POST",
            url: "TvIndoorConfirmationList.aspx/SetBillOrCancellJob",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "ok") {
                    alertify.success('Successs');
                    window.location.href = "../CustomerCare/TvIndoorConfirmationList.aspx";
                }
                if (result.d == "no") {
                    alertify.success('Cenceled');
                    window.location.href = "../CustomerCare/TvIndoorConfirmationList.aspx";
                }
                if (result.d == "refresh") {
                    alertify.dialog('confirm')
                      .set({
                          'title': 'Alert',
                          'transition': 'slide',
                          'labels': { ok: 'Yes', cancel: 'No' },
                          'message': "This bill already has been confirmed. Page Refresh required",
                          'onok': function () {
                              window.location.href = "../CustomerCare/TvIndoorConfirmationList.aspx";
                          }
                      }).show();
                }
            }
        });

    }

    $('.decision').change(function () {
        selectedItem = $(this).val();
    });

    //Load Modals
    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var buttonValue = 0;
        var id = $(this).attr('id');
        deletedRow = $(this).closest('tr');
        var deletedRowIndex = $(this).closest('tr').index() + 1;
        var table = document.getElementById('grdvTvIndoorBillConfirmation');
        var jobId = table.rows[deletedRowIndex].cells[0].innerHTML;
        console.log("jobid : " + jobId + " - " + "id :" + id);
        if (id == "btnTvIndoorConfirmationConfirmed") {
            buttonValue = 1;
            billConfirmationFunc(jobId, buttonValue, deletedRow);
        } else if (id == "btnTvIndoorConfirmationFaild") {
            buttonValue = -1;
            billConfirmationFunc(jobId, buttonValue);
        }

        //if (selectedValue == "Terminate") {


        //    //alertify.dialog('confirm')
        //    //  .set({
        //    //      'title': 'Alert',
        //    //      'transition': 'slide',
        //    //      'labels': { ok: 'Yup!', cancel: 'Nop!' },
        //    //      'message': 'Are you sure to Terminate this Job ? Job ID is ' + jobId,
        //    //      'onok': function () {
        //    //          terminateJob(jobId);
        //    //          selectedItem = "";
        //    //      },
        //    //      'oncancel': function () {
        //    //          selectedItem = "";
        //    //           alertify.error('You did not Terminate the job !');
        //    //      }
        //    //  }).show();

        //    deletedRow = $(this).closest('tr');

        //}
    });

});