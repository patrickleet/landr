Template.landerMain.rendered = () ->
  if $('#superContainer').length is 0
    $.fn.fullpage
      navigation: true
      css3: true
      controlArrowColor: '#eee'


