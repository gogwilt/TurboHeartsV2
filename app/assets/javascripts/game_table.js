function show_add_round() {
  $("tr.score-entry").toggleClass('score-entry-hidden');
  if ($("tr.score-entry").hasClass('score-entry-hidden')) {
    $("td.delete-round-column").addClass('delete-round-hidden');
    $("td.round-date").removeClass('delete-round-hidden');
    $("#add-a-game-link").text("Add/Edit a Game");
  } else {
    $("td.delete-round-column").removeClass('delete-round-hidden');
    $("td.round-date").addClass('delete-round-hidden');
    $("#add-a-game-link").text("Hide Add/Edit a Game");
  }
}

function hide_add_round() {
  $("td.round-date").removeClass('delete-round-hidden');
  $("tr.score-entry").addClass('score-entry-hidden');
  $("td.delete-round-column").addClass('delete-round-hidden');
  $("#add-a-game-link").text("Add/Edit a Game");
}

function clear_point_fields() {
  for(var i = 1; i <= 4; i++) {
    $("#player" + i + "_score").value = "";
  }
}

function open_player_autocomplete(i) {
  input = $( "#player" + i + "_name" );
  // close if already visible
	if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
			input.autocomplete( "close" );
			return;
	}
	
  // work around a bug (likely same cause as #5265)
	$( "#player"+i+"_dropdown" ).blur();

	// pass empty string as value to search for, displaying all results
  input.autocomplete("option", {minLength:0});
	input.autocomplete( "search", "" );
	input.focus();
  input.autocomplete("option", {minLength:1});
}

$("document").ready(function () {
  hide_add_round();
  open_player_autocomplete(1);
})