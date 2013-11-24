/* Custom filtering function which will filter data in column four between two values */
$.fn.dataTableExt.afnFiltering.push(
    function( oSettings, aData, iDataIndex ) {
	var minYear = document.getElementById('min').value * 1;
	var maxYear = document.getElementById('max').value * 1;
	var deathDate = aData[4];
	var deathYear= deathDate.substring(0,4);
	if ( minYear == "" && maxYear == "" )
	{
	    return true;
	}
	else if ( minYear == "" && deathYear <= maxYear )
	{
	    return true;
	}
	else if ( minYear <= deathYear && "" == maxYear )
	{
	    return true;
	}
	else if ( minYear <= deathYear && deathYear <= maxYear )
	{
	    return true;
	}
	return false;
	}
);


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

    $(document).on("click","span.numlink",function(e){
	colourstone($(this).text());
	$("#stone").load($(this).text() + ".html #main");
    });

    $( "span.numlinkiframe" ).click(function() {
	$("#stonecontainer").attr('src',$(this).text() + ".html");
	colourstone($(this).text());
    });

    $(document).on("click","g.stone",function(e){
	    colourstone($(this).attr('id'));
	    $("#stone").load(CurrentStone + ".html #main");
    });

//    $('#ProtestantCemetery').load(function() {
//	$( "g.stone" ).click(function() {
//	    colourstone($(this).attr('id'));
//	    $("#stone").load(CurrentStone + ".html #main");
//	});
//    });
});


var CurrentStone="S1";
var CurrentStroke="black";

function colourstone(one) {
    var g = $('#' + CurrentStone);
    var p = g.children('polygon');
    p.css('stroke',CurrentStroke);
    CurrentStone = one ;
    g = $('#' + CurrentStone);
    p = g.children('polygon');
    CurrentStroke = p.css('stroke');
    var r= g.children('text')[0];
    p.css('stroke','red');	
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

