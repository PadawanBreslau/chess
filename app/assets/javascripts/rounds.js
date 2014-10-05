function prepareList() {
	$('#round_games').find('li:has(ul)').unbind('click').click(function(event) {
		if(this == event.target) {
			if($(this).attr('class') != 'one_round collapsed expanded'){
				$('#round_games li.one_round.collapsed.expanded').removeClass('expanded').children('ul').hide();
			}
			$(this).toggleClass('expanded');
			$(this).children('ul').toggle('medium');

		}
		return false;
	}).addClass('collapsed').removeClass('expanded').children('ul').hide();

		$('#round_games a').unbind('click').click(function() {
		window.location.href = $(this).attr('href');
		return false;
	});
};

$(document).ready( function() {
    prepareList()
});
