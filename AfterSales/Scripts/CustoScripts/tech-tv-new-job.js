$(document).ready(function () {


    //Applying DataTable to the Grid
    $("#grdvNewJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
   
    //Tab changing Js
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

   
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });


    //StartJob Button functionality 

    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var deletedRowIndex = $(this).closest('tr').index() + 1;
        var table = document.getElementById('grdvNewJob');
        var productServiceId = table.rows[deletedRowIndex].cells[10].innerHTML;



        $.ajax({
            type: "POST",
            url: "NewJob.aspx/StartJob",
            data: "{'productServiceId':" + productServiceId + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == "jobStart") {

                    alert("Job Started!");
                    window.location = "StartJob.aspx";
                } else if (result.d == "CantStartAJob") {

                    alert("You Can not start a job until completion of your current job");
                }
            }
           
        });


    });


});