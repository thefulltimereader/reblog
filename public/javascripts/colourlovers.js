var backgrounds = new Array(), count = 0, maxCount = 40;

$.getJSON(  'http://www.colourlovers.com/api/palettes/top?numResults='+maxCount+'&showPaletteWidths=1&jsonCallback=?',
  function(data){
// make color objects and store them in colors 
      $.each(data, function(i, palette){
	var bkground = {
	    title: palette.title,
	    url: palette.url,
	    numColors: palette.colors.length,
	    colors: palette.colors,
	    colorWidth: palette.colorWidths
	};

	backgrounds[count++] = bkground;
	var lastcolor = bkground.colors[bkground.numColors-1];
 var contents = "<div class='background "+ i + "' style='background-color:#"+lastcolor+"'>";
    $.each(bkground.colors, function(i, color){
	contents += "<div class='color' style='background-color:#"+color+"; height:100%;width:"+bkground.colorWidth[i]*100+"%'></div>";
    });
      contents +="</div>";
      $('#window').append(contents)

      });//end for each
     

      count=0; //reset the count
      changeBackground();
  },
 function(data,status, jqHXR){
    console.log("rest call successful: " + jqHXR);
    }
  );

function changeBackground(){
    bkground = backgrounds[count++% backgrounds.length];
    count= count % backgrounds.length;
    $('.footer').html('via colourlovers: <a href="'+ bkground.url+'" target="_blank">'+bkground.title+'</a>');
   
    console.log(count);
}

/*
function addBackground(id, curr){
    bkground = backgrounds[id % (backgrounds.length)];
    var contents = "";

    $.each(bkground.colors, function(i, color){
	contents += "<div class='color' style='background-color:#"+color+"; height:100%; width:"+bkground.colorWidth[i]*100+"%'></div>";
    });
    if(curr == 1){
	$('.background.curr').html(contents);
    }
    else{
	var next = "<div class='background next'>" +
	contents +"</div>"; 
	$(next).insertAfter(".background.curr");
    }
};
*/

function resizeView(){
 $(".background").height($(window).height());

 $(".backgrounds").width($(window).width());
}

function autoChange(){
    count == 0 ? speed = 0: speed = 700;

    $("#window").scrollTo($(".background."+count), speed)
    changeBackground(); // just the footer
};

function rotate(){
    
}

