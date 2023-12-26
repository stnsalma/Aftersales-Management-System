$(document).ready(function () {

    //Applying DataTable to the Grid

    $("#grdvQcJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();


    //Tab Changing Js

    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

    
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });


    //QcPassed and QcFailed Button Ajax Request Js

    $('input[type="submit"]').on('click', function (e) {
        e.preventDefault();

      
        var deletedRowIndex = $(this).closest('tr').index() + 1;

        var table = document.getElementById('grdvQcJob');

        var productServiceId = table.rows[deletedRowIndex].cells[0].innerHTML;
     

        var btnid = $(this).attr('id');

       

        if (btnid == "btnQcPassed") {

            
            $.ajax({
                type: "POST",
                url: "QcJob.aspx/QcPassStatus",
                data: JSON.stringify({ 'productServiceId': productServiceId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "success") {

                        alertify.success("QC Passed");

                    } else {

                        alertify.error("QC Failed");
                    }
                }
            });


        }
        else if (btnid == "btnQcFailed") {

            $.ajax({
                type: "POST",
                url: "QcJob.aspx/QcFailedStatus",
                data: JSON.stringify({ 'productServiceId': productServiceId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    alertify.success("QC Failed");


                }

            });

        }


    });







});