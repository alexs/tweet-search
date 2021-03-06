# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#search_button').click ->
    word = $('input#search').val()
    $('input#active_word').val(word);
    $('#results').empty()
    callback = (data) -> $.each(data.statuses, (key, val) ->
    	$('#results').append(
    		"<div class='tweet'><div class='user_image large-2 columns small-3'><img src='" + val["user"]["profile_image_url"] + "'></div> <div class='large-10 columns'><strong> " + val["user"]["name"] + "</strong> <small>@"+val["user"]["screen_name"]+"</small>" +
    			"<div class='tweet_text'>" + 
    			val["text"] + "" +
    		"<ul class='inline-list'><li><a onclick=reply_tweet_show('"+val["id_str"]+"');> Reply </a></li> <li><a onclick=save_tweet('"+val["id_str"]+"')>Save</a></li></ul></div><div class='reply_tweet_input' id="+val["id_str"]+"><textarea class='reply_textarea' id="+val["id_str"]+">@"+val["user"]["screen_name"]+"</textarea><button class='reply_button' type='submit' onclick=send_reply('"+val["id_str"]+"');>Responder</button></div></div>" 
    	)
    	)

    $.get '/search_tweet',{word}, callback, 'json'
    get_saved_tweets_for(word);


  $('#search_save_button').click ->
    word = $('input#search').val()
    $('#words_saved').empty()
    $.get '/search_tweet/save', {word}, 'json'

