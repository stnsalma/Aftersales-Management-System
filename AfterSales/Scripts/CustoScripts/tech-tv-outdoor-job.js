$(document).ready(function () {
    var btnRemoveId = 0; var NewProductServiceId="";
    //Applying DataTable to the Grid
  $("#grdvOutdoorJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
    //Append Spare Parts to the Table

    $("#btnAdd").on('click', function (e) {
        e.preventDefault();

        var id = document.getElementById("ddlSpareItems");
        var selectedText = id.options[ddlSpareItems.selectedIndex].innerHTML;
        var selectedValue = id.value;

        console.log(NewProductServiceId);
      

        $.ajax({
            type: "POST",
            url: "OutdoorJob.aspx/AddSparePartsToList",
            data: JSON.stringify({ 'itemCode': selectedValue, 'itemName': selectedText }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
            }
           });

        $("#tblData").append('<tr><td>' + selectedText +'</td><td>' + selectedValue + '</td><td>1</td><td><button class="btn btn-danger remCF" id="' + btnRemoveId + '">Remove</button></td></tr>');
        btnRemoveId = btnRemoveId + 1;


        //$("#tblData").on('click', '.remCF', function () {
        //    $(this).parent().parent().remove();

        //    $.ajax({
        //        type: "POST",
        //        url: "OutdoorJob.aspx/RemoveSparePartsFromList",
        //        data: JSON.stringify({ 'itemCode': selectedValue}),
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (msg) {
        //            alert(msg.d);
        //            //if (msg.d == "ok") {
        //            //    alertify.confirm("Added");
        //            //}
        //        }
        //    });


        //});


    });

    $("#tblData").on('click','.remCF', function (e) {
        e.preventDefault();
        var id = $(this).closest('tr');
        var table = document.getElementById('tblData');
        var itemCodeIndex = $(this).closest('tr').index() + 1;
        var itemCode = table.rows[itemCodeIndex].cells[1].innerHTML;
        //alert("Hello");
      //  console.log(itemCode);
       

        $.ajax({
            type: "POST",
            url: "OutdoorJob.aspx/RemoveSparePartsFromList",
            data: JSON.stringify({ 'itemCode': itemCode }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                alert(msg.d);
                //if (msg.d == "ok") {
                //    alertify.confirm("Added");
                //}
            }
        });
        $(this).closest('tr').remove();
        //$(this).parent().parent().remove();

    });
    //Outdoor Start Job Js
    
    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var id = $(this).attr('id');
        if (id != "btnOutdoorTvTechnicianSpareSubmit" && id != "btnAdd")
        {
            console.log(id);
            var obj = {};
            var deletedRowIndex = $(this).closest('tr').index() + 1;
            var table = document.getElementById('grdvOutdoorJob');
            $('#lblProductserviceId').text(table.rows[deletedRowIndex].cells[9].innerHTML);
            NewProductServiceId = $('#lblProductserviceId').text();
            obj.jobId = table.rows[deletedRowIndex].cells[1].innerHTML;

            var btnid = $(this).attr('id');


            if (btnid == "btnStartJob") {

            }
            else if (btnid == "btnSpareRequisition") {


                $('#requestSpareModal').modal({
                    show: true,
                    backdrop: 'static'
                });



            }
        }


    });

    

    //final Subbmission of a list of Spare Items
    
    $('#btnOutdoorTvTechnicianSpareSubmit').on('click', function () {

        //var deletedRowIndex = $(this).closest('tr').index()+2;
    
     //   var table = document.getElementById('grdvOutdoorJob');
        
       // var jobId = table.rows[deletedRowIndex].cells[1].innerHTML;

        console.log( '-------------' + NewProductServiceId);

        alertify.dialog('confirm')
          .set({
              'title': 'Alert',
              'transition': 'slide',
              'labels': { ok: 'Yes!', cancel: 'No!' },
              'message': 'are you sure?',
              'onok': function () {

                  $.ajax({
                      type: "POST",
                      url: "OutdoorJob.aspx/SaveSpareParts",
                      data: JSON.stringify({ 'ProductServiceId': NewProductServiceId }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (msg) {
                             if (msg.d == "ok") {
                              alertify.success("Data Save Successfully !");
                              window.location = "OutdoorRunningJob.aspx";
                          }
                          else if (msg.d == "no") {
                              alertify.error("Error");
                          }
                     }
                      
                  });
              },
              'oncancel': function () {
                  selectedItem = "";
                  alertify.error('You did not Submit !');
              }
          }).show();
        //alert('Alertify probelm');
    });

    //Select2 Js

    $('#ddlSpareItems').select2({
        
         });
});