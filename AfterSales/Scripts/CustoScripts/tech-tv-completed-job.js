$(document).ready(function () {

  
    //Applying DataTable to the Grid
    $("#grdvCompletedJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();

    //Tab Changing Functionality
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href=#' + url.split('#')[1] + ']').tab('show');
    }

    // Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });


});