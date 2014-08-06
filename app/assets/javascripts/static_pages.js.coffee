# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).on 'page:change', ->
#	$(".tweets").marquee({direction: "down", duration: 15000, pauseOnHover: true})

$(document).on 'page:change', ->
        $('.tweets').newsTicker({
                row_height: 80,
                max_rows: 3,
                duration: 4000})
