

initFeed = ->
    $.ajax
        url: document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=10&callback=?&q=' + encodeURIComponent('http://arnthak.com/?q=rss.xml')
        dataType: 'json'
        complete: ->
            displayContent()
        success: (data) ->
            if (data.responseData.feed && data.responseData.feed.entries)
                $.each data.responseData.feed.entries, (i, e) ->
                    articleDate = moment(e.publishedDate).format('MMMM Do YYYY')
                    title = '<h1 class="article-title">' + e.title + '</h1>'
                    dateLine = '<h2 class="article-date">' + articleDate + '</h2>'
                    $('#content-div').append title
                    $('#content-div').append dateLine
                    $('#content-div').append e.content

doResize = ->
    if $(window).width() > 1220
        winHeight = $(window).height() * 0.7
        $('body').css 'left', winHeight + 'px'
    else
        $('body').css 'left', ''

displayContent = ->
    $('body').fadeIn 3000

$(window).load ->
    initFeed()
    doResize()

    $(window).on "resize orientationchange", ->
        doResize()