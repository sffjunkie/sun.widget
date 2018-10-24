settings = {
  latitude: 1
  longitude: 1
  timezone: 'Europe/London'

  y_factor: 80
  ray_percent: 100
  sky_color: ["#041245", "#12487D", "#2A7CB1", "#6EABD0", "#A2C7DE", "#8FC2DF", "#CBECFA"]
  sun_color: ["#FFC404", "#FFFAC8", "#FFFCF0"]
}

{
  command: "PYTHONPATH=. python sun_elevation.py " +
    "#{settings.latitude} #{settings.longitude} #{settings.timezone}"

  refreshFrequency: 30000

  style: """
    body
      background-color: #CBECFA

    #sun
      position : absolute
      top: 0
      left: 0
      right: 0
      bottom: 0
      margin: auto
      width: 70px
      height: 70px
      border-radius: 50%
      background: white
      opacity: 0.9
      box-shadow: 0px 0px 40px 15px white

    .ray_box
      position: absolute
      margin: auto
      top: 0
      left: 0
      right: 0
      bottom: 0
      width: 70px
      -webkit-animation: ray_anim 120s linear infinite
      animation: ray_anim 120s linear infinite

    .ray
      background: -webkit-linear-gradient(top, rgba(255,255,255,0) 0%, rgba(255,255,255,0.8) 50%, rgba(255,255,255,0) 100%)
      background: linear-gradient(top, rgba(255,255,255,0) 0%, rgba(255,255,255,0.8) 50%, rgba(255,255,255,0) 100%)
      margin-left: 10px
      border-radius: 80% 80% 0 0
      position:absolute
      opacity:0.1

    .ray1
      height:#{170 * settings.ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(180deg)
      top:-175px
      left: 15px

    .ray2
      height:#{100 * settings.ray_percent / 100}px
      width:8px
      -webkit-transform: rotate(220deg)
      top:-90px
      left: 75px

    .ray3
      height:#{170 * settings.ray_percent / 100}px
      width:50px
      -webkit-transform: rotate(250deg)
      top:-80px
      left: 100px

    .ray4
      height:#{120 * settings.ray_percent / 100}px
      width:14px
      -webkit-transform: rotate(305deg)
      top:30px
      left: 100px

    .ray5
      height:#{140 * settings.ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(-15deg)
      top:60px
      left: 40px

    .ray6
      height:#{90 * settings.ray_percent / 100}px
      width:50px
      -webkit-transform: rotate(30deg)
      top:60px
      left: -40px

    .ray7
      height:#{180 * settings.ray_percent / 100}px
      width:10px
      -webkit-transform: rotate(70deg)
      top:-35px
      left: -40px

    .ray8
      height:#{120 * settings.ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(100deg)
      top:-45px
      left:-90px

    .ray9
      height:#{80 * settings.ray_percent / 100}px
      width:10px
      -webkit-transform: rotate(120deg)
      top:-65px
      left:-60px

    .ray10
      height:#{190 * settings.ray_percent / 100}px
      width:23px
      -webkit-transform: rotate(150deg)
      top:-185px
      left: -60px

    @-webkit-keyframes ray_anim {
      0% { -webkit-transform: rotate(0deg) transform: rotate(0deg)}
      100% { -webkit-transform: rotate(360deg) transform: rotate(360deg)}
    }
  """

  render: -> """
    <div id="sun">
      <div class="ray_box">
        <div class="ray ray1"></div>
        <div class="ray ray2"></div>
        <div class="ray ray3"></div>
        <div class="ray ray4"></div>
        <div class="ray ray5"></div>
        <div class="ray ray6"></div>
        <div class="ray ray7"></div>
        <div class="ray ray8"></div>
        <div class="ray ray9"></div>
        <div class="ray ray10"></div>
      </div>
    </div>
    """

  update: (output, domEl) ->
    angle = parseFloat(output)
    rad = (270 + angle) * Math.PI / 180
    leftPercent = (Math.sin(rad) + 1) * 100 / 2
    bottomPercent = Math.cos(rad) * @y_factor

    sun = $(domEl).find("#sun")
    sun.css("left", "#{leftPercent}%").css("bottom", "#{bottomPercent}%")

    body = $(domEl).find('body')
    if angle > 90
      angle = 180 - angle
    degPerSkyColor = 90 / @sky_color.length
    index = Math.floor(90 / degPerSkyColor)
    body['background-color'] = @sky_color[index]

    degPerSunColor = 90 / @sun_color.length
    index = Math.floor(90 / degPerSunColor)
    sun['background-color'] = @sun_color[index]
}
