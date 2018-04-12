namespace :geocode do
  desc 'Queues jobs to geocode station addresses'
  task :station_addresses => :environment do
    Address.for_station.not_geocoded.find_each do |address|
      GeocodeJob.perform_later(address)
    end
  end
end
