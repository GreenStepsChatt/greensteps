require Rails.root.join('lib', 'code_climate_cli.rb').to_s

namespace :lint do
  desc 'Runs codeclimate cli if it is available'
  task :codeclimate do
    if CodeClimateCli.available?
      CodeClimateCli.run('analyze')
    else
      CodeClimateCli.give_install_instructions
    end
  end

  namespace :rubocop do
    task :autocorrect do
      puts "\n"
      system 'rubocop --auto-correct'
      puts "\n"
    end
  end
end
