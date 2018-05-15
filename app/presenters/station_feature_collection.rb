class StationFeatureCollection
  delegate :to_json, to: :to_h

  def initialize(station_relation)
    @stations = station_relation.includes(
      :coordinate_pair,
      address: :coordinate_pair
    )
  end

  def to_h
    RGeo::GeoJSON.encode(feature_collection)
  end

  private

  def feature_collection
    entity_factory.feature_collection(array_of_features)
  end

  def array_of_features
    @stations.map { |station| StationFeature.new(station).feature }
  end

  def entity_factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
