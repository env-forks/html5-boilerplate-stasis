#1 DEFINE CONSTANTS
splash_is_visible = true
allowed_pages = new Array('home', 'bio', 'media', 'tour', 'merch', 'contact')
$loading = $('<img></img>').attr('src', '/img/layout/loading.gif').css('margin-left', '300px')

#2 HELPER FUNCTIONS
enter_site = ->
        
        $('#splash').animate {
                left: '-1000px',
                height: '0'
        }, 200, ->  
                $('#splash').css({
                        height: '1px'
                })
                splash_is_visible = false
                $('header').animate({
                        height: '400px',
                }, 500, ->
                        $('#nav, #player').fadeIn()
                ) 

get_content = (name)->
        #$('#content').hide()
        if $.inArray(name, allowed_pages) == -1
                name = 'home'
        $('#drop_target').html($loading)
        $('#nav a').removeClass('active')
        $('#nav_'+name).addClass('active')
        
        html_file = '/' + name + '.html'
        $.get html_file, (data)->
                $('#drop_target').html(data) 
                $('#content').show()
                switch name
                        when 'home' then
                                init_tweet() 
                                init_cycle() 
                        when 'media' then
                                init_pp()

#3 INITALIZER FUNCTIONS
init_content = ->
        $.history.init ((hash) ->
          if hash == ""
            $("#content, #nav, #player").hide()
          else
            enter_site() if splash_is_visible
            name = hash.replace /\//, ''
            get_content(name)
            
        ), unescape: ",/"


init_pp = ->
        $('a.modal').prettyPhoto({
                deeplinking: false
        })
        #$('a.modal').live "click", ->
                #$.prettyPhoto.open($(this).attr("href"), "", "")
                #false
        #$('a.modal').pretty_phtoo
init_masthead = ->
        $('#masthead').click ->
                if location.href.indexOf('http://0.0.0.0:81') > -1
                        current_url = 'http://0.0.0.0:81'
                else if location.href.indexOf('http://yd.squiid.net') > -1
                        current_url = 'http://yd.squiid.net'
                location.href = current_url

init_tweet = ->
        $lt = $('#latest_tweet');
        if $lt.size() > 0
                $.get('/lib/get_tweets.php', (data) ->
                        $lt.html(data)
                )

init_player = ->
        media_path = '/media/'
        $("#jquery_jplayer_1").jPlayer 
                ready: (event) ->
                        $(this).jPlayer "setMedia", 
                        mp3: media_path + '/mp3/04-Oh-Darling.mp3',
                        oga: media_path + '/ogg/04-Oh-Darling.ogg'
                swfPath: "/lib/jplayer/",
                supplied: "m4a, oga",
                wmode: "window"


init_cycle = ->
        $('#slideshow').cycle({
                next: 'a.arrow.left',
                prev: 'a.arrow.right'
                
        })

#4 BRING IT ALL TOGETHER ON DOCREADY
$ ->
        init_pp()
        init_content()
        init_masthead()
        init_tweet()
        init_player()
        