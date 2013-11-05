Template.landerMain.rendered = () ->

  if $('#superContainer').length is 0
    anchors = []
    i = 0
    $(".section").each(() ->
      i = i + 1
      anchors.insert("#{i}")
    ).promise().done(() ->
      $.fn.fullpage
        navigation: true
        css3: true
        anchors: anchors
        controlArrowColor: '#eee'
    )

