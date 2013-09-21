$(document).ready(function() {
    var $section = $('.buttons');
    var $panzoom = $('#ProtestantCemetery').panzoom({
        $zoomIn: $section.find(".zoom-in"),
        $zoomOut: $section.find(".zoom-out"),
        $zoomRange: $section.find(".zoom-range"),
        $reset: $section.find(".reset")});
    $('table.stones').dataTable( {
	"sPaginationType": "full_numbers",
	"bPaginate": true,
	"bLengthChange": true,
	"bFilter": true,
	"bSort": true,
	"bInfo": true,
	"aoColumns": [ { "sType": [ "prettynumbers" ] }, null,null,null,null ],
	"bScrollCollapse": true,
	"bAutoWidth": false,
	"bJQueryUI": true,
	"sDom": 'flprtip',
	"aoColumnDefs": [
	    { "sWidth": "10%", "aTargets": [ 0 ] },
	    { "sWidth": "15%", "aTargets": [ 1 ] },
	    { "sWidth": "30%", "aTargets": [ 2 ] },
	    { "sWidth": "15%", "aTargets": [ 3 ] },
	    { "sWidth": "25%", "aTargets": [ 4 ] }
	]  
    } );    
});
var fuzzyNum = function (x) {
    return +x.replace(/[^\d\.\-]/g, "");
}; 

jQuery.fn.dataTableExt.oSort['prettynumbers-asc'] = function(x, y) {
    return fuzzyNum(x) - fuzzyNum(y);
};   
jQuery.fn.dataTableExt.oSort['prettynumbers-desc'] = function(x, y) {
    return fuzzyNum(y) - fuzzyNum(x);
};

