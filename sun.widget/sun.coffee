{
  settings: {
    latitude: 1
    longitude: 1
    timezone: 'Europe/London'
  }

  y_percent: 80
  ray_percent: 100

  command: "PYTHONPATH=. python sun_elevation.py #{settings.latitude} #{settings.longitude} #{settings.timezone}"

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
    bottomPercent = Math.cos(rad) * @y_percent

    sun = $(domEl).find("#sun")
    sun.css("left", "#{leftPercent}%").css("bottom", "#{bottomPercent}%")

  style: """
    body
      background:#2EB5E5

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
      height:#{170 * @ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(180deg)
      top:-175px
      left: 15px

    .ray2
      height:#{100 * @ray_percent / 100}px
      width:8px
      -webkit-transform: rotate(220deg)
      top:-90px
      left: 75px

    .ray3
      height:#{170 * @ray_percent / 100}px
      width:50px
      -webkit-transform: rotate(250deg)
      top:-80px
      left: 100px

    .ray4
      height:#{120 * @ray_percent / 100}px
      width:14px
      -webkit-transform: rotate(305deg)
      top:30px
      left: 100px

    .ray5
      height:#{140 * @ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(-15deg)
      top:60px
      left: 40px

    .ray6
      height:#{90 * @ray_percent / 100}px
      width:50px
      -webkit-transform: rotate(30deg)
      top:60px
      left: -40px

    .ray7
      height:#{180 * @ray_percent / 100}px
      width:10px
      -webkit-transform: rotate(70deg)
      top:-35px
      left: -40px

    .ray8
      height:#{120 * @ray_percent / 100}px
      width:30px
      -webkit-transform: rotate(100deg)
      top:-45px
      left:-90px

    .ray9
      height:#{80 * @ray_percent / 100}px
      width:10px
      -webkit-transform: rotate(120deg)
      top:-65px
      left:-60px

    .ray10
      height:#{190 * @ray_percent / 100}px
      width:23px
      -webkit-transform: rotate(150deg)
      top:-185px
      left: -60px

    @-webkit-keyframes ray_anim {
      0% { -webkit-transform: rotate(0deg) transform: rotate(0deg)}
      100% { -webkit-transform: rotate(360deg) transform: rotate(360deg)}
    }
  """
}
