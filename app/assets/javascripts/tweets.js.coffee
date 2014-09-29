# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
        $('.unuseful-p').hide()
        $('.bayes-p').hide()
        $('.bayes').submit ->
                $('.bayes-p').show()
                $('.unuseful').hide()
        $('.unuseful').submit ->
                $('.unuseful-p').show()
                $('.bayes').hide()
