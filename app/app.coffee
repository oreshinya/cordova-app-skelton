fs = require 'fs'

Vue.component "hoge",
  template: fs.readFileSync "#{__dirname}/views/hoge.html", "utf8"

onDeviceReady = ->
  app = new Vue
    el: "#app"
    data:
      currentView: "hoge"

$(document).bind "deviceready", onDeviceReady
