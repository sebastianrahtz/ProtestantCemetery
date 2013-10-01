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
    $( "#tabs" ).tabs({ 
	    select: function(event, ui) { fnAdjustColumnSizing(); }
	});
    $( "span.numlink" ).click(function() {
	$("#stone").load($(this).text() + ".html #main");
	colourstone($(this).text());
    });

    $( "span.numlinkiframe" ).click(function() {
	$("#stonecontainer").attr('src',$(this).text() + ".html");
	colourstone($(this).text());
    });

    $('table.simplestones').dataTable( {
	"sPaginationType": "full_numbers",
	"bPaginate": true,
	"bLengthChange": true,
	"bFilter": true,
	"bSort": true,
	"bJQueryUI": true,
      	"aoColumnDefs": [
	    { "sWidth": "10%", "aTargets": [ 0 ] },
	    { "sWidth": "10%", "aTargets": [ 1 ] },
	    { "sWidth": "80%", "aTargets": [ 2 ] }
	]  
});

    $('table.stones').dataTable( {
	"sPaginationType": "full_numbers",
	"bPaginate": true,
	"bLengthChange": true,
	"bFilter": true,
	"bSort": true,
	"bInfo": true,
	"bScrollCollapse": true,
	"bJQueryUI": true,
	"sDom": 'flprtip',
	"aoColumnDefs": [
	    { "sWidth": "8%", "aTargets": [ 0 ] },
	    { "sWidth": "8%", "aTargets": [ 0 ] },
	    { "sWidth": "20%", "aTargets": [ 1 ] },
	    { "sWidth": "30%", "aTargets": [ 2 ] },
	    { "sWidth": "10%", "aTargets": [ 3 ] },
	    { "sWidth": "14%", "aTargets": [ 4 ] },
	    { "sWidth": "5%", "aTargets": [ 5 ] }
	]  
    } );    

    $('#ProtestantCemetery').load(function() {
	$( "g.stone" ).click(function() {
	    colourstone($(this).attr('id'));
	    $("#stone").load(CurrentStone + ".html #main");
	});
    });
});


var CurrentStone="S1";

function colourstone(one) {
    var g = $('#' + CurrentStone);
    var p = g.children('polygon');
    p.css('fill','#F5FCFF');
    CurrentStone = one ;
    g = $('#' + CurrentStone);
    p = g.children('polygon');
    var r= g.children('rect')[0];
    p.css('fill','red');	
    var c=$("#locatorcircle")[0];
    c.setAttribute("cx",r.getAttribute("x"));
    c.setAttribute("cy",r.getAttribute("y"));
    var pos=g.position();
    //console.log(pos);
    // var newx1 =r.getAttribute("x") - 500;
    // var newy1 =r.getAttribute("y") - 500;
    // var newx2 =r.getAttribute("x") + 500;
    // var newy2 =r.getAttribute("y") + 500;
    // var newVB = newx1 + " "+ newy1 + " " + newx2 + " "+ newy2;
    // var wherex = -pos.left + 700;
    // var wherey=-pos.top;
    // $("#ProtestantCemetery")[0].setAttribute('style','fill:none; -webkit-transform: matrix(4,0,0,4,'+wherex+','+wherey+')');
    
}


var fuzzyNum = function (x) {
    return +x.replace(/[^\d\.\-]/g, "");
}; 

jQuery.fn.dataTableExt.oSort['prettynumbers-asc'] = function(x, y) {
    return fuzzyNum(x) - fuzzyNum(y);
};   
jQuery.fn.dataTableExt.oSort['prettynumbers-desc'] = function(x, y) {
    return fuzzyNum(y) - fuzzyNum(x);
};

