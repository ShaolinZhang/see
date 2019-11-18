'use strict'

{random} = Math
require '../helpers'
_ = require 'underscore'
Car = require './car'
Intersection = require './intersection'
Road = require './road'
Pool = require './pool'
Rect = require '../geom/rect'
settings = require '../settings'

class World
  constructor: ->
    @set {}

  @property 'instantSpeed',
    get: ->
      speeds = _.map @cars.all(), (car) -> car.speed
      return 0 if speeds.length is 0
      return (_.reduce speeds, (a, b) -> a + b) / speeds.length

  set: (obj) ->
    obj ?= {}
    @intersections = new Pool Intersection, obj.intersections
    @roads = new Pool Road, obj.roads
    @cars = new Pool Car, obj.cars
    @carsNumber = 0
    @time = 0

  save: ->
    data = _.extend {}, this
    delete data.cars
    localStorage.world = JSON.stringify data

  load: (data) ->
    data = '{"intersections":{"intersection409":{"id":"intersection409","rect":{"x":-70,"y":140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.5223158689897542,"phaseOffset":13.934294273699365}},"intersection410":{"id":"intersection410","rect":{"x":0,"y":-140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.19433383480020017,"phaseOffset":95.56476886169601}},"intersection411":{"id":"intersection411","rect":{"x":-70,"y":70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.855861669622815,"phaseOffset":36.31472831007467}},"intersection412":{"id":"intersection412","rect":{"x":70,"y":70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.3944724193558886,"phaseOffset":91.173102757145}},"intersection413":{"id":"intersection413","rect":{"x":0,"y":140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.2280916598144651,"phaseOffset":55.74789528287567}},"intersection414":{"id":"intersection414","rect":{"x":0,"y":0,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.5602375913334101,"phaseOffset":62.67388643916705}},"intersection415":{"id":"intersection415","rect":{"x":0,"y":70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.48799129855740575,"phaseOffset":3.4152361474941717}},"intersection416":{"id":"intersection416","rect":{"x":70,"y":-70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.5557569805031644,"phaseOffset":7.0307358547175625}},"intersection417":{"id":"intersection417","rect":{"x":-140,"y":0,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.8930801965133066,"phaseOffset":66.07343121385081}},"intersection418":{"id":"intersection418","rect":{"x":-140,"y":-140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.8729098754802895,"phaseOffset":55.39337771066404}},"intersection419":{"id":"intersection419","rect":{"x":0,"y":-70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.04175933377758989,"phaseOffset":28.06115288401545}},"intersection420":{"id":"intersection420","rect":{"x":140,"y":-140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.14428864920594875,"phaseOffset":40.787224214721206}},"intersection421":{"id":"intersection421","rect":{"x":-140,"y":-70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.6980535980324061,"phaseOffset":15.768074638286622}},"intersection422":{"id":"intersection422","rect":{"x":-140,"y":70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.9255848489688054,"phaseOffset":0.05072780009423017}},"intersection423":{"id":"intersection423","rect":{"x":140,"y":0,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.4780148084604141,"phaseOffset":68.6420755472996}},"intersection424":{"id":"intersection424","rect":{"x":-70,"y":0,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.6036075738191291,"phaseOffset":93.21192451888322}},"intersection425":{"id":"intersection425","rect":{"x":140,"y":70,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.5494600185975052,"phaseOffset":92.99701008089225}},"intersection426":{"id":"intersection426","rect":{"x":70,"y":140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.21114565707924315,"phaseOffset":51.68090343601139}},"intersection427":{"id":"intersection427","rect":{"x":140,"y":140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.5177317378239843,"phaseOffset":34.273221431722156}},"intersection428":{"id":"intersection428","rect":{"x":-140,"y":140,"_width":14,"_height":14},"controlSignals":{"flipMultiplier":0.8645645427136464,"phaseOffset":2.350678910604209}}},"roads":{"road429":{"id":"road429","source":"intersection421","target":"intersection418"},"road430":{"id":"road430","source":"intersection418","target":"intersection421"},"road431":{"id":"road431","source":"intersection417","target":"intersection421"},"road432":{"id":"road432","source":"intersection421","target":"intersection417"},"road433":{"id":"road433","source":"intersection428","target":"intersection422"},"road434":{"id":"road434","source":"intersection422","target":"intersection428"},"road435":{"id":"road435","source":"intersection411","target":"intersection424"},"road436":{"id":"road436","source":"intersection424","target":"intersection411"},"road437":{"id":"road437","source":"intersection419","target":"intersection410"},"road438":{"id":"road438","source":"intersection410","target":"intersection419"},"road439":{"id":"road439","source":"intersection414","target":"intersection419"},"road440":{"id":"road440","source":"intersection419","target":"intersection414"},"road441":{"id":"road441","source":"intersection415","target":"intersection414"},"road442":{"id":"road442","source":"intersection414","target":"intersection415"},"road443":{"id":"road443","source":"intersection413","target":"intersection415"},"road444":{"id":"road444","source":"intersection415","target":"intersection413"},"road445":{"id":"road445","source":"intersection412","target":"intersection416"},"road446":{"id":"road446","source":"intersection416","target":"intersection412"},"road447":{"id":"road447","source":"intersection426","target":"intersection412"},"road448":{"id":"road448","source":"intersection412","target":"intersection426"},"road449":{"id":"road449","source":"intersection423","target":"intersection420"},"road450":{"id":"road450","source":"intersection420","target":"intersection423"},"road451":{"id":"road451","source":"intersection425","target":"intersection423"},"road452":{"id":"road452","source":"intersection423","target":"intersection425"},"road453":{"id":"road453","source":"intersection427","target":"intersection425"},"road454":{"id":"road454","source":"intersection425","target":"intersection427"},"road455":{"id":"road455","source":"intersection410","target":"intersection418"},"road456":{"id":"road456","source":"intersection418","target":"intersection410"},"road457":{"id":"road457","source":"intersection420","target":"intersection410"},"road458":{"id":"road458","source":"intersection410","target":"intersection420"},"road459":{"id":"road459","source":"intersection419","target":"intersection421"},"road460":{"id":"road460","source":"intersection421","target":"intersection419"},"road461":{"id":"road461","source":"intersection416","target":"intersection419"},"road462":{"id":"road462","source":"intersection419","target":"intersection416"},"road463":{"id":"road463","source":"intersection424","target":"intersection417"},"road464":{"id":"road464","source":"intersection417","target":"intersection424"},"road465":{"id":"road465","source":"intersection414","target":"intersection424"},"road466":{"id":"road466","source":"intersection424","target":"intersection414"},"road467":{"id":"road467","source":"intersection423","target":"intersection414"},"road468":{"id":"road468","source":"intersection414","target":"intersection423"},"road469":{"id":"road469","source":"intersection411","target":"intersection422"},"road470":{"id":"road470","source":"intersection422","target":"intersection411"},"road471":{"id":"road471","source":"intersection415","target":"intersection411"},"road472":{"id":"road472","source":"intersection411","target":"intersection415"},"road473":{"id":"road473","source":"intersection412","target":"intersection415"},"road474":{"id":"road474","source":"intersection415","target":"intersection412"},"road475":{"id":"road475","source":"intersection425","target":"intersection412"},"road476":{"id":"road476","source":"intersection412","target":"intersection425"},"road477":{"id":"road477","source":"intersection409","target":"intersection428"},"road478":{"id":"road478","source":"intersection428","target":"intersection409"},"road479":{"id":"road479","source":"intersection413","target":"intersection409"},"road480":{"id":"road480","source":"intersection409","target":"intersection413"},"road481":{"id":"road481","source":"intersection426","target":"intersection413"},"road482":{"id":"road482","source":"intersection413","target":"intersection426"},"road483":{"id":"road483","source":"intersection427","target":"intersection426"},"road484":{"id":"road484","source":"intersection426","target":"intersection427"},"road787":{"id":"road787","source":"intersection417","target":"intersection422"},"road788":{"id":"road788","source":"intersection422","target":"intersection417"}},"carsNumber":100,"time":92.24885999999967}'
    data = data and JSON.parse data
    return unless data?
    @clear()
    @carsNumber = data.carsNumber or 0
    for id, intersection of data.intersections
      @addIntersection Intersection.copy intersection
    for id, road of data.roads
      road = Road.copy road
      road.source = @getIntersection road.source
      road.target = @getIntersection road.target
      @addRoad road

  generateMap: (minX = -2, maxX = 2, minY = -2, maxY = 2) ->
    @clear()
    intersectionsNumber = (0.8 * (maxX - minX + 1) * (maxY - minY + 1)) | 0
    map = {}
    gridSize = settings.gridSize
    step = 5 * gridSize
    @carsNumber = 100
    while intersectionsNumber > 0
      x = _.random minX, maxX
      y = _.random minY, maxY
      unless map[[x, y]]?
        rect = new Rect step * x, step * y, gridSize, gridSize
        intersection = new Intersection rect
        @addIntersection map[[x, y]] = intersection
        intersectionsNumber -= 1
    for x in [minX..maxX]
      previous = null
      for y in [minY..maxY]
        intersection = map[[x, y]]
        if intersection?
          if random() < 0.9
            @addRoad new Road intersection, previous if previous?
            @addRoad new Road previous, intersection if previous?
          previous = intersection
    for y in [minY..maxY]
      previous = null
      for x in [minX..maxX]
        intersection = map[[x, y]]
        if intersection?
          if random() < 0.9
            @addRoad new Road intersection, previous if previous?
            @addRoad new Road previous, intersection if previous?
          previous = intersection
    null


  clear: ->
    @set {}

  onTick: (delta) =>
    throw Error 'delta > 1' if delta > 1
    @time += delta
    @refreshCars()
    for id, intersection of @intersections.all()
      intersection.controlSignals.onTick delta
    for id, car of @cars.all()
      car.move delta
      @removeCar car unless car.alive

  refreshCars: ->
    @addRandomCar() if @cars.length < @carsNumber
    @removeRandomCar() if @cars.length > @carsNumber

  addRoad: (road) ->
    @roads.put road
    road.source.roads.push road
    road.target.inRoads.push road
    road.update()

  getRoad: (id) ->
    @roads.get id

  addCar: (car) ->
    @cars.put car

  getCar: (id) ->
    @cars.get(id)

  removeCar: (car) ->
    @cars.pop car

  addIntersection: (intersection) ->
    @intersections.put intersection

  getIntersection: (id) ->
    @intersections.get id

  addRandomCar: ->
    road = _.sample @roads.all()
    if road?
      lane = _.sample road.lanes
      @addCar new Car lane if lane?

  removeRandomCar: ->
    car = _.sample @cars.all()
    if car?
      @removeCar car

module.exports = World
