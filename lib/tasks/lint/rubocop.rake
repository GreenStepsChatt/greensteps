namespace :lint do
  namespace :rubocop do
    desc 'Runs rubocop with autocorrections turned on'
    task :autocorrect do
      puts "\n"
      system 'rubocop --auto-correct'
      puts "\n"
    end
  end
end
