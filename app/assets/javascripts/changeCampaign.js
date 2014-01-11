$(document).ready(function() {

	buttonText = ["Call Domino Factory",
								"Call the Department of Transportation"
								];

	var randombuttonText = Math.floor(Math.random() * buttonText.length);
	$('button#change-campaign').append(buttonText[randombuttonText]);

	$('body').on("click", "#change-link", function() {
		var randombuttonText = Math.floor(Math.random() * buttonText.length);
		$('button#change-campaign').replaceWith("<button id='change-campaign' class='btn btn-theme btn-lg'>" + buttonText[randombuttonText] + "</button>");
		console.log(randomReason);
	});
});