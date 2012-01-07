function show_add_round() {
  $("tr.score-entry").toggleClass('score-entry-hidden');
  $("td.delete-round-column").toggleClass('delete-round-hidden');
  $("td.round-date").toggleClass('delete-round-hidden');
  if ($("tr.score-entry").hasClass('score-entry-hidden')) {
    $("#add-a-game-link").text("Add/Edit a Game");
  } else {
    $("#add-a-game-link").text("Hide Add/Edit a Game");
  }
}

function hide_add_round() {
  $("tr.score-entry").addClass('score-entry-hidden');
  $("td.delete-round-column").addClass('delete-round-hidden');
}

function open_player_autocomplete(i) {
  input = $( "#player" + i + "_name" );
  console.log("fired");
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