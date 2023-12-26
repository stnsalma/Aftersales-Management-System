$(document).ready(function () {
    var hashes1 = window.location.href.slice(window.location.href.indexOf('?') + 1);
    console.log(hashes1);
    if (hashes1 == "status=ok") {
        alertify.success("Success");
        //window.location.hash = "OutdoorRunningJob.aspx";
    }
    
    //Data Table Added to Grid Js
 $("#grdvOutdoorCompletedJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();

    //Tab Changing Js
 var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

   
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });
    
 
    


});