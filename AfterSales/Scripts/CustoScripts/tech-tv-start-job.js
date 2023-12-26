
$(document).ready(function () {

    $("#grdvStartJob").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();



    $("#btnAdd").on('click', function (e) {
        e.preventDefault();
        var id = document.getElementById("ddlSpareItems");
        var selectedText = id.options[ddlSpareItems.selectedIndex].innerHTML;
        var selectedValue = id.value;
        var btnRemoveId = 0;
        //var splitted = selectedText.split(",", 0);
        //alert(selectedText + "->" + selectedValue);
        //alert(splitted);

        $.ajax({
            type: "POST",
            url: "StartJob.aspx/AddSparePartsToList",
            data: JSON.stringify({ 'itemCode': selectedValue, 'itemName': selectedText }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                // Replace the div's content with the page method's return.
                //debugger;
                //alert(msg.d);
                //alert('ok');


            },
            //failure: function (response) {
            //    alert(response.d);
            //}
        });

        $("#tblData").append('<tr><td><input type="text" class="form-control" value="' + selectedText + '" disabled/></td><td><input type="text" class="form-control" value="' + selectedValue + '" id="itemCodeId"disabled/></td><td><input type="text" class="form-control" value=1 disabled/></td><td><buttton class="btn btn-danger remCF" id="' + btnRemoveId + '">Remove</button></td></tr>');

        //btnRemoveId++;

        $("#tblData").on('click', '.remCF', function () {
            // alert(val);
            var itemCode = $(this).closest('tr').find('[id*="itemCodeId"]').val();
            $(this).parent().parent().remove();
            $.ajax({
                type: "POST",
                url: "StartJob.aspx/RemoveSparePartsFromList",
                data: JSON.stringify({ 'itemCode': itemCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    // Replace the div's content with the page method's return.
                    //debugger;
                    //alert(msg.d);
                    //alert('ok');
                    if (msg.d == "ok") {
                        alertify.success("Data remove successfully !");
                    } else if (msg.d == "no") {
                        alertify.error("Nothing to save !!!");
                    }

                },
                //failure: function (response) {
                //    alert(response.d);
                //}
            });

        });


    });

    $('#btnTvTechnicianSpareSubmit').on('click', function () {


        var table = document.getElementById('grdvStartJob');
        var ProductServiceId = table.rows[1].cells[0].innerHTML;
        //alert(ProductServiceId);

        alertify.dialog('confirm')
          .set({
              'title': 'Alert',
              'transition': 'slide',
              'labels': { ok: 'Yup!', cancel: 'Nop!' },
              'message': 'are you sure?',
              'onok': function () {

                  $.ajax({
                      type: "POST",
                      url: "StartJob.aspx/SaveSpareParts",
                      data: JSON.stringify({ 'ProductServiceId': ProductServiceId }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (msg) {
                       
                          if (msg.d == "ok") {
                              alertify.success("Data Save Successfully !");
                              window.location = "StartJob.aspx";
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
    });

    $('input[type="submit"]').click(function (e) {
        e.preventDefault();

        var obj = {};
       
        var tableId = $(this).closest('table').prop('id');
       // console.log(tableId);
        

        if (tableId === "grdvStartJob") {
            var table = document.getElementById(tableId);
          

            var deletedRowIndex = $(this).closest('tr').index() + 1;
            obj.jobId = table.rows[deletedRowIndex].cells[1].innerHTML;
            var  ProductServiceId = table.rows[1].cells[0].innerHTML;
            
            var selectedValue = $(this).closest('tr').find('[id*="ddlDecisions"]').val();


            if (selectedValue == "Pause") {


                $.ajax({
                    type: "POST",
                    url: "StartJob.aspx/PauseJob",
                    data: JSON.stringify({ 'productServiceId': ProductServiceId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "success") {
                            alertify.alert("Job Paused !");
                            window.location = "NewJob.aspx";
                        }
                        else if (result.d == "failure") {
                           alertify.alert("You have to must use or return spare parts !!!");
                        }
                    }
                });


            } else if (selectedValue == "Send2Qc") {


                $.ajax({
                    type: "POST",
                    url: "StartJob.aspx/SendToQc",
                    data: JSON.stringify({ 'productServiceId': ProductServiceId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "success") {
                            alertify.alert("Sent to QC !");
                            window.location = "QcJob.aspx";
                        }
                        else if (result.d == "failure") {
                            alertify.alert("You have to must use or return spare parts !!!");
                        }
                    }
                });


            } else if (selectedValue == "Failed") {


                $.ajax({
                    type: "POST",
                    url: "StartJob.aspx/ServiceFailed",
                    data: JSON.stringify({ 'productServiceId': ProductServiceId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "success") {
                            alertify.alert("Service Failed!");
                        }
                        else if (result.d == "failure") {
                            alertify.alert("You have to must use or return spare parts !!!");
                        }
                    }
                });


            }
        } else if (tableId === "grdvRequestedSpareParts") {

           

            
              var table = document.getElementById(tableId);
              var RowIndex = $(this).closest('tr').index();
             // alert(RowIndex);
              var itemCode = table.rows[RowIndex].cells[0].innerHTML;
              var RowId = table.rows[RowIndex].cells[4].innerHTML;
             // alert(RowId);
              var startJobTable = document.getElementById("grdvStartJob");
              var jobId = startJobTable.rows[1].cells[1].innerHTML;
              var productServiceId = startJobTable.rows[1].cells[8].innerHTML;
              
           
              var partsStatus = table.rows[RowIndex].cells[2].innerHTML;
              
              
            //var productServiceId = 1;
              var btnid = $(this).attr('id');

              if (btnid === "btnUse") {

                 
           
                  // alert(productServiceId);
                  if (partsStatus == "Sanctioned") {
                      $.ajax({
                          type: "POST",
                          url: "StartJob.aspx/UsedSparePartsStatusChanged",
                          data: JSON.stringify({ 'itemCode': itemCode, 'jobId': jobId, 'productServiceId': productServiceId, 'id': RowId }),
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function(msg) {
                              if (msg.d == "Added") {
                                  alertify.success("Spare Parts Added !");

                              }

                          }
                      });
                      $(this).closest('tr').css('background-color', '#CCFFCC');
                  } else if (partsStatus == "PartsUnavailable") {

                      alert("You can not Return or Use This Parts!!Contact to Store");

                  } else {

                      alert("Please Contact With Store");
                  }
              }
              else if (btnid === "btnReturn") {


                  if (partsStatus == "Sanctioned") {

                      $.ajax({
                          type: "POST",
                          url: "StartJob.aspx/ReturnSparePartsStatusChanged",
                          data: JSON.stringify({ 'itemCode': itemCode, 'jobId': jobId, 'productServiceId': productServiceId, 'id': RowId }),
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function(msg) {
                              if (msg.d == "Returned") {
                                  alertify.error("Spare Parts Returned !");

                              }

                          }
                      });
                      $(this).closest('tr').css('background-color', '#99CCFF');
                  } else if (partsStatus == "PartsUnavailable") {

                      alert("You can not Return or Use This Parts!!Contact to Store");


                  } else {

                      alert("Please Contact With Store");

                  }

              }
        }
    });




    $('#ddlSpareItems').select2({
        //placeholder: "Select a State",
        //allowClear: true

    });
    // $("#grdvRequestedSpareParts").prepend($("<thead></thead>").append($(this).find("tr:selected"))).dataTable();
});