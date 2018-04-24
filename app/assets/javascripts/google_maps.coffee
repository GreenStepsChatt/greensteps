Greensteps.initMap = ->
  @map = new google.maps.Map document.getElementById('map'), {
    zoom: 10,
    center: {lat: 35.045631, lng: -85.309677}
  }

  @map.data.loadGeoJson 'api/geojson/v1/stations'

  @map.data.setStyle (feature) ->
    {
      title: feature.getProperty('title')
    }

  @map.data.addListener 'click', (event) ->
    $('#map_info #marker_title')[0].textContent =
      event.feature.getProperty('title')
    $('#map_info #marker_address')[0].textContent =
      event.feature.getProperty('address')
    $('#map_info').show().css('display', 'inline')
