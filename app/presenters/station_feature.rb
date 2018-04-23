class StationFeature
  delegate :id, :name, :longitude, :latitude, to: :@station
  delegate :to_json, to: :to_h

  def initialize(station)
    @station = station
  end

  def to_h
    RGeo::GeoJSON.encode(feature)
  end

  def feature
    entity_factory.feature(point, id, properties)
  end

  private

  def point
    geo_factory.point(longitude, latitude)
  end

  def properties
    { title: name }
  end

  def geo_factory
    RGeo::Cartesian.simple_factory(srid: 4326)
  end

  def entity_factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
