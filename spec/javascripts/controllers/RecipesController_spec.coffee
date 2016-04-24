describe "RecipesController", ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null

  # access injected service
  httpBackend = null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      #capture the injected service
      httpBackend = $httpBackend
      if results
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('RecipesController',
          $scope: scope
          $location: location)
    )
  beforeEach(module("receta"))
  beforeEach(setupController())

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  it "defaults to no recipes", ->
    expect(scope.recipes).toEqualData([])

describe 'controller initialization', ->
  describe 'when no keywords present', ->
    beforeEach(setupController())

    it "defaults to no recipes", ->
      expect(results).toEqualData([])
