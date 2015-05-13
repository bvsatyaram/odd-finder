---
---
Game =
  noCells: 81
  maxTimeForOdd: 4 #This is the max. no. of rotates before an odd appears
  scoreA: 0
  scoreB: 0
  oddCell: null
  randomEmoticon: (odd) ->
    rotatedClassNames = [
      "",
      "fa-rotate-90",
      "fa-rotate-180",
      "fa-rotate-270"
    ]
    className = (if odd then "fa fa-frown-o " else "fa fa-smile-o ")
    className += rotatedClassNames[Math.floor(Math.random() * rotatedClassNames.length)]
    return "<i class='#{className}'></i>"
  writeToCell: (i, odd = false) ->
    console.log(i) if odd
    $('#game-cell-'+i).html(Game.randomEmoticon(odd))
  rotateRandomCell: ->
    cellNo = Math.floor(Math.random()*Game.noCells) + 1
    if !Game.oddCell && Math.floor(Math.random()*Game.maxTimeForOdd) == Math.floor(Game.maxTimeForOdd/2)
      Game.setOddCell(cellNo)
    else
      if cellNo == Game.oddCell
        Game.removeOddCell(cellNo)
      else
        Game.writeToCell(cellNo)
  setOddCell: (i) ->
    Game.oddCell = i
    Game.writeToCell(i, true)
  removeOddCell: (i) ->
    Game.oddCell = null
    Game.writeToCell(i)
  startGame: ->
    for i in [1..(Game.noCells)]
      Game.writeToCell(i)
    Game.propagateGame()
  propagateGame: ->
    Game.propagator = window.setInterval((->
      Game.rotateRandomCell()
    ), 500)
$ ->
  Game.startGame()