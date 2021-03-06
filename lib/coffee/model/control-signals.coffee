'use strict'

{random} = Math
require '../helpers'
settings = require '../settings'

class ControlSignals
  constructor: (@intersection) ->
    @flipMultiplier = random()
    @phaseOffset = 100 * random()
    @time = @phaseOffset
    @stateNum = 0
    @emergency = false
    @emergencySituation = [-1,-1]

  @copy: (controlSignals, intersection) ->
    if !controlSignals?
      return new ControlSignals intersection
    result = Object.create ControlSignals::
    result.flipMultiplier = controlSignals.flipMultiplier
    result.time = result.phaseOffset = controlSignals.phaseOffset
    result.stateNum = 0
    result.intersection = intersection
    result

  toJSON: ->
    obj =
      flipMultiplier: @flipMultiplier
      phaseOffset: @phaseOffset

  states: [
    ['L', '', 'L', ''],
    ['FR', '', 'FR', ''],
    ['', 'L', '', 'L'],
    ['', 'FR', '', 'FR']
  ]

  @STATE = [RED: 0, GREEN: 1]

  @property 'flipInterval',
    get: -> (0.1 + 0.05 * @flipMultiplier) * settings.lightsFlipInterval

  _decode: (str) ->
    state = [0, 0, 0]
    state[0] = 1 if 'L' in str
    state[1] = 1 if 'F' in str
    state[2] = 1 if 'R' in str
    state

  @property 'state',
    get: ->
      if @emergency is true
        emergencyState = [[0,0,0], [0,0,0], [0,0,0], [0,0,0]]
        eside = @emergencySituation[0]
        eturn = @emergencySituation[1]
        emergencyState[eside] = [1,1,1]
        return emergencyState
      stringState = @states[@stateNum % @states.length]
      if @intersection.roads.length <= 2
        stringState = ['LFR', 'LFR', 'LFR', 'LFR']
      (@_decode x for x in stringState)

  flip: ->
    @stateNum += 1
    @emergency = false

  onTick: (delta) =>
    @time += delta
    if @time > @flipInterval
      @flip()
      @time -= @flipInterval

  copeEmergency: (sideId, turnNumber) ->
    @emergency = true
    @emergencySituation = [sideId, turnNumber]

module.exports = ControlSignals
