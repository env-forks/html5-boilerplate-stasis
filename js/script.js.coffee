# Author: Shaun Robinson

init_nav = ->
        domain = 'http://yd.squiid.net/'
        url = location.href

        url = url.replace(domain, '')
        url = url.replace('http://localhost:81/', '');
        url = url.replace('http://0.0.0.0:81/', '');
        
        url = url.replace('.html', '')

        url = 'home' if url == ''
                
        $('#' + url).addClass('active')


init_tweet = ->
        $lt = $('#latest_tweet');
        if $lt.size() > 0
                $.get('/lib/get_tweets.php', (data) ->
                        $lt.html(data)
                )
                

init_pp = ->
        $('a.modal').prettyPhoto()
        
init_anim = ->
        #$('#nav').hide();
        #$('header').animate({
        #        height: '800px'
        #}, 300)

$ ->
        init_nav()
        init_pp()
        init_tweet()
        #init_anim()














