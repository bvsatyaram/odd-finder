---
---
Game =
  noCells: 81
  maxTimeWithoutOdd: 10 # This is the max. no. of rotates before an odd appears
  scoreA: 0
  scoreB: 0
  oddCell: null
  cyclesLeftForOdd: 0
  maxCyclesForOdd: 20 # This is the max number of cycles for which the odd icon is shown
  penaltyForWrongAnswer: 10
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
    if odd
      console.log(i)
      Game.cyclesLeftForOdd = Game.maxCyclesForOdd
    $('#game-cell-'+i).html(Game.randomEmoticon(odd))
  rotateRandomCell: ->
    if Game.cyclesLeftForOdd == 1
      removeOddCell(Game.oddCell)
      Game.oddCell = null
    else
      cellNo = Math.floor(Math.random()*Game.noCells) + 1
      if !Game.oddCell && Math.floor(Math.random()*Game.maxTimeWithoutOdd) == Math.floor(Game.maxTimeWithoutOdd/2)
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
    Game.cyclesLeftForOdd = 0
    Game.oddCell = null
    Game.writeToCell(i)
  pulseScore: (player, score) ->
    scoreEle = $("#score#{if player == 1 then 'A' else 'B'}")
    if score > 0
      scoreEle.fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
    else
      scoreEle.fadeOut(300).fadeIn(300).fadeOut(200).fadeIn(200);
  updateScores: ->
    $('#scoreA .score').html(Game.scoreA)
    $('#scoreB .score').html(Game.scoreB)
  addScore: (player, score) ->
    if player == 1
      Game.scoreA += score
    else
      Game.scoreB += score
    Game.updateScores()
    Game.pulseScore(player, score)
  handlePlayerResponse: (player) ->
    if Game.oddCell
      Game.addScore(player, Game.cyclesLeftForOdd)
      Game.removeOddCell(Game.oddCell)
    else
      Game.addScore(player, -Game.penaltyForWrongAnswer)
  watchHotKeys: ->
    console.log 'Watching Keys'
    $(document).bind 'keyup', 'ctrl', ->
      Game.handlePlayerResponse(1)
    $(document).bind 'keyup', 'right', ->
      Game.handlePlayerResponse(2)
  startGame: ->
    for i in [1..(Game.noCells)]
      Game.writeToCell(i)
    Game.updateScores()
    Game.propagateGame()
    Game.watchHotKeys()
  propagateGame: ->
    Game.propagator = window.setInterval((->
      Game.rotateRandomCell()
    ), 500)
$ ->
  Game.startGame()