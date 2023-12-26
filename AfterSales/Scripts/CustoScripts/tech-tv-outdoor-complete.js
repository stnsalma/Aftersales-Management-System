$(document).ready(function () {
    
    $('#dvBounce').hide();
    
    $('#btnBounce').on('click', function (e) {
        e.preventDefault();
        $('#dvBounce').toggle("slow");


    });
    
    $("#grdvOutdoorSpareParts").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable({
        "bPaginate": false
    });

    function Parts(Id, Status) {
        this.Id = Id;
        this.Status = Status;
    }
    var requestedParts = [];
    var table = document.getElementById("grdvOutdoorSpareParts");
    if (table != null) {
        for (var i = 1; i < table.rows.length; i++) {
            var cell = table.rows[i].cells;
            var part = new Parts(cell[4].innerHTML, "no");
            requestedParts.push(part);
        }
    }

    console.log(requestedParts);

    $('input[type="submit"]').click(function (e) {
        e.preventDefault();
        var btnid = $(this).attr('id');
        
        
        if (btnid != "btnTvTechnicianOutdoorJobCancel" && btnid != "btnTvTechnicianOutdoorJobSubmit" && btnid != "btnBounce") {
            var deletedRowIndex = $(this).closest('tr').index() + 1;
            var outdoorspareTable = document.getElementById("grdvOutdoorSpareParts");
            var itemStatus = "";
            var requisitionId = outdoorspareTable.rows[deletedRowIndex].cells[4].innerHTML;
            if (btnid == "btnUse") {
                itemStatus = "U";
                $(this).closest('tr').css('background-color', '#CCFFCC');
            }
            else if (btnid == "btnReturn") {
                itemStatus = "R";
                $(this).closest('tr').css('background-color', '#99CCFF');
            }
            
            if (requestedParts.length > 0) {
                for (var i in requestedParts) {
                    if (requestedParts[i].Id == requisitionId) {
                        requestedParts[i].Status = itemStatus;
                    }
                }
            }

            console.log(requestedParts);
        }


    });

    $('#btnTvTechnicianOutdoorJobSubmit').on('click', function () {
        var isNotSelected = false;
        if (requestedParts.length > 0) {
            
            for (var i in requestedParts) {
                if (requestedParts[i].Status == "no") {
                    isNotSelected = true;
                    break;
                } else {
                    continue;
                }
            }
        }
        if (isNotSelected == false) {

            var checkedCheckboxes = $("[id*=cblBounceList] input:checked");
            var bounceReason = "";

            checkedCheckboxes.each(function () {
                var value = $(this).val();
                var text = $(this).closest("td").find("label").html();
                bounceReason += text + ",";
            });
            var serviceId = "";
            serviceId = $('#lblProcuctServiceId').text();
            var data = JSON.stringify({ partses: requestedParts, bounceReason: bounceReason, serviceId: serviceId });
            console.log(serviceId + "-------" + data);
            $.ajax({
                type: "POST",
                url: "CompleteOutdoorJob.aspx/SpareSubmission",
                contentType: "application/json; charset=utf-8",
                traditional: true,
                data: data,
                dataType: "json",
                success: function (result) {
                    if (result.d == "ok") {
                        alertify.success("Submitted Succesfully");
                        window.location = "OutdoorRunningJob.aspx?status=ok";
                    } else if (result.d == "no") {
                        alertify.error("Error !!!");
                    }
                    else if (result.d == "check") {
                        alertify.error("Error !!! Must Return Every parts");
                    }

                },
                error: function (result) {
                    alert('Oh no :(');
                    console.log(result.d);
                }
            });
        } else {
            alertify.alert("Select Every Parts as Use Or Return !!!");
        }
    });

    $('#btnTvTechnicianOutdoorJobCancel').on('click', function () {
        window.location = "OutdoorRunningJob.aspx";
        
    });
});