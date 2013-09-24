$(document).ready(function() {
    var $section = $('.buttons');
    var $panzoom = $('#ProtestantCemetery').panzoom({
        $zoomIn: $section.find(".zoom-in"),
        $zoomOut: $section.find(".zoom-out"),
        $zoomRange: $section.find(".zoom-range"),
        $reset: $section.find(".reset")});
    $panzoom.panzoom("option", {
	increment: 0.4,
	minScale: 1,
	maxScale: 19,
    });
    $( "#tabs" ).tabs();
    $( "span.numlink" ).click(function() {
	$("#stonebycat").load($(this).text() + ".html #main");
    });
    $( "span.numlink2" ).click(function() {
	$("#stonebynat").load($(this).text() + ".html #main");
    });
    $( "span.numlink3" ).click(function() {
	$("#stonebyyr").load($(this).text() + ".html #main");
    });
    $('table.simplestones').dataTable( {
	"bPaginate": true,
	"bLengthChange": true,
	"bFilter": true,
	"bSort": true});

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
	    { "sWidth": "5%", "aTargets": [ 0 ] },
	    { "sWidth": "8%", "aTargets": [ 1 ] },
	    { "sWidth": "15%", "aTargets": [ 2 ] },
	    { "sWidth": "8%", "aTargets": [ 3 ] },
	    { "sWidth": "12%", "aTargets": [ 4 ] }
	]  
    } );    
});
var CurrentStone="S1";

$(document).on("click", "span.maplink", function(){
    var p = $('#' + CurrentStone).children('polygon');
    p.css('fill','F5FCFF');
    CurrentStone = $(this).text();
    var g = $('#' + CurrentStone);
    //    $('#locatorcircle').cx=g.cx
    var p = g.children('polygon');
    p.css('fill','red');
});

//showstone () {
//    $("#thisstone").load("b.html"); 
//}); 

//    $('.mydiv').click(function(){
//    window.open(' /chatwindow/?user='+$(this).attr('id').replace('mydiv-',''), '_blank', 'width=300,height=400');
//    return false;
//    });

var fuzzyNum = function (x) {
    return +x.replace(/[^\d\.\-]/g, "");
}; 

jQuery.fn.dataTableExt.oSort['prettynumbers-asc'] = function(x, y) {
    return fuzzyNum(x) - fuzzyNum(y);
};   
jQuery.fn.dataTableExt.oSort['prettynumbers-desc'] = function(x, y) {
    return fuzzyNum(y) - fuzzyNum(x);
};

