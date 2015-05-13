---
---
Game =
  noCells: 81
  scoreA: 0
  scoreB: 0
  randomEmoticon: ->
    rotatedClassNames = [
      "",
      "fa-rotate-90",
      "fa-rotate-180",
      "fa-rotate-270"
    ]
    className = "fa fa-smile-o "
    className += rotatedClassNames[Math.floor(Math.random() * rotatedClassNames.length)]
    '<i class="' + className + '"></i>'
  writeToCell: (i) ->
    $('#game-cell-'+i).html(Game.randomEmoticon())
  rotateRandomCell: ->
    cellNo = Math.floor(Math.random()*Game.noCells) + 1
    Game.writeToCell(cellNo)
    console.log cellNo
  startGame: ->
    Game.propagator = window.setInterval(
      (() -> Game.rotateRandomCell()), 500
    )
    Game.propagator = window.setInterval((->
      Game.rotateRandomCell()
    ), 500)
$ ->
  for i in [1..(Game.noCells)]
    Game.writeToCell(i)
  Game.startGame()