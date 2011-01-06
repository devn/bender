unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks
  require 'capybara'
  Capybara.save_and_open_page_path = 'tmp/capybara'

  begin
    require 'cucumber/rake/task'

    namespace :cucumber do
      Cucumber::Rake::Task.new(:all, 'Run all features') do |t|
        t.fork = false # You may get faster startup if you set this to false
        t.profile = 'default'
      end
    end
    desc 'Alias for cucumber:all'
    task :cucumber => 'cucumber:all'

    task :default => :cucumber
  end

end
