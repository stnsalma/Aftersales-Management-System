$(function () {
    function UnAvailableSpare(Id, SpareRequisitionId, Status) {

        // Add object properties like this
        this.Id = Id;
        this.SpareRequisitionId = SpareRequisitionId;
        this.Status = Status;
    };
    var currentRowId = 0;
    var prevRowId = 0;
    var requisitionId = 0;
    var cnt = 0;
    var spares = [];
    var unavailablePartsList = [];
    var detectedRow;
    var table = document.getElementById("grdvPartsUnavailable");
    for (var i = 1; i < table.rows.length; i++) {
        var cell = table.rows[i].cells;
        var part = new UnAvailableSpare(cell[1].innerHTML, cell[2 ].innerHTML, "no");
        unavailablePartsList.push(part);
    }
    console.log(unavailablePartsList);
    $('#ddlSpareParts').select2({
        //placeholder: "Select a State",
        //allowClear: true

    });
    
    $('input[type="submit"]').on('click', function (e) {
        e.preventDefault();
        var id = $(this).attr('id');
        if (id === "btnPartsUnavailableReplace" || id === "btnPartsUnavailableSanction") {
            //if ($("#sp").is(':visible')) {
            //   // alertify.alert("sohwn");
            //}
            //$("#sp").is(':hidden');
            table = document.getElementById('grdvPartsUnavailable');
            detectedRow = $(this).closest('tr').index();
            requisitionId = table.rows[detectedRow].cells[1].innerHTML;
            if (id == "btnPartsUnavailableReplace") {
                
                
                if (currentRowId == 0 && prevRowId == 0) {
                    currentRowId = detectedRow;
                    prevRowId = detectedRow;
                }
                prevRowId = currentRowId;
                currentRowId = detectedRow;
                var rowCount = $('#tblReplacedData tr').length;
                console.log(rowCount);
                $('#partsUnavailableReplaceModal').modal({
                    show: true,
                    backdrop: 'static'
                });
                $(this).closest('tr').css('background-color', '#99CCFF');
               //requisitionId = 0;
               //requisitionId = table.rows[detectedRow].cells[1].innerHTML;
                for (var i in unavailablePartsList) {
                    if (unavailablePartsList[i].Id == requisitionId) {
                        unavailablePartsList[i].Status = "0";
                    }
                }
               //$('#sp').toggle('slow');
            }
            if (id == "btnPartsUnavailableSanction") {
                $(this).closest('tr').css('background-color', '#CCFFCC');
                //requisitionId = 0;
                //requisitionId = table.rows[detectedRow].cells[1].innerHTML;
                for (var i in unavailablePartsList) {
                    if (unavailablePartsList[i].Id == requisitionId) {
                        unavailablePartsList[i].Status = "1";
                    }
                }
            }
       }
    });

    $('#btnReplaceSpareAdd').on('click', function () {
        var obj = {};
        var id = document.getElementById("ddlSpareParts");
        var itemName = id.options[ddlSpareParts.selectedIndex].innerHTML;
        var itemCode = id.value;
        obj.requisitionId = requisitionId;
        obj.itemName = itemName;
        obj.itemCode = itemCode;
        if (requisitionId > 0) {
            $.ajax({
                type: "POST",
                url: "PartsUnavailable.aspx/AddToReplacedList",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    
                },
                failure: function (responser) {
                    alert("i am in failure");
                }
            });
        }
        var row = '<tr><td><input type="text" class="form-control" value="' + itemName + '" disabled/></td><td><input type="text" class="form-control" value="' + itemCode + '" id="itemCodeId"disabled/></td><td><input type="text" class="form-control" value=1 disabled/></td><td><buttton class="btn btn-danger rmUnavailableItem">Remove</button></td></tr>';
        
        $('#tblReplacedData').find('#tbleReplaceBody').append(row);
    });

    $("#tblReplacedData").on('click', '.rmUnavailableItem', function () {
        // alert(val);
        removeObj = {};
        
        var itemCode = $(this).closest('tr').find('[id*="itemCodeId"]').val();
        removeObj.requisitionId = requisitionId;
        removeObj.itemCode = itemCode;
        console.log(itemCode);
        $(this).parent().parent().remove();
        $.ajax({
            type: "POST",
            url: "PartsUnavailable.aspx/RemoveFromList",
            data: JSON.stringify(removeObj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
               
            },
            failure: function (response) {
                alert(response.d);
            }
        });

    });


    $('#btnPartsReplaceCancel').on('click', function () {
        $(table.rows[detectedRow]).css('background-color', 'white');
        for (var i in unavailablePartsList) {
            if (unavailablePartsList[i].Id == requisitionId) {
                unavailablePartsList[i].Status = "no";
            }
        }
        $("#tbleReplaceBody > tr").remove();
        $.ajax({
            type: "POST",
            url: "PartsUnavailable.aspx/ClearSpareList",
            data: JSON.stringify({'requisitionId':requisitionId}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {

            },
            failure: function (response) {
                alert(response.d);
            }
        });
        
    });

    $('#btnPartsReplaceConfirm').on('click', function () {
        $("#tbleReplaceBody > tr").remove();
    });

    $('#btnSubmitUnavailablePart').on('click', function () {
        var noStatus = 0;
        for (var j = 0; j < unavailablePartsList.length; j++) {
            if (unavailablePartsList[j].Status == "no") {
                noStatus = 1;
                break;
            }
        }
        if (noStatus <= 0) {
            $.ajax({
                type: "POST",
                url: "PartsUnavailable.aspx/SaveUnavailableParts",
                data: JSON.stringify({ partses: unavailablePartsList }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "ok") {
                        window.location.href = "SpareUnavailable.aspx";
                    }
                    if (msg.d == "no") {
                        alertify.error("Data not saved successfully !!!! :( ");
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        } else {
            alertify.alert("All spares should be sanctioned or replace !!");
        }
        
        
        // unavailablePartsLIst will be empty after successful submit  unavailablePartsList = [];
    });

});