Vue.component "hoge",
  template: require "./views/hoge.html"

onDeviceReady = ->
  app = new Vue
    el: "#app"
    data:
      currentView: "hoge"

$(document).bind "deviceready", onDeviceReady
