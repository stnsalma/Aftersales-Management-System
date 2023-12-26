$(function () {
    
    function FianlRequisition(Id, IsUsed, IsStackFaulty, IsWastage) {

        // Add object properties like this
        this.Id = Id;
        this.IsUsed = IsUsed;
        this.IsStackFaulty = IsStackFaulty;
        this.IsWastage = IsWastage;
    }
    var finalRequisitions = [];
    var cnt = 0;
    var table = document.getElementById("grdvSpareForRecommendation");
    for (var i = 1; i < table.rows.length; i++) {
        var cell = table.rows[i].cells;
        var requisition = new FianlRequisition(cell[0].innerHTML, true, false, false);
        finalRequisitions.push(requisition);
    }
    console.log(finalRequisitions);
    $('input[type="checkbox"]').on('click', function (e) {
        e.preventDefault();
        var tableId = $(this).closest('table').prop('id');
        var deletedRowIndex = $(this).closest('tr').index()+1;
        var table = document.getElementById(tableId);
        var jobId = table.rows[deletedRowIndex].cells[3].innerHTML;
        if ($(this).prop('checked') == true) {
            //do something
            
            alert($(this).prop('id'));
        }
        console.log(jobId);
        
    });
})