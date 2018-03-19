Greensteps.initMap = ->
  @map = new google.maps.Map document.getElementById('map'), {
    zoom: 10,
    center: {lat: 35.045631, lng: -85.309677}
  }
