namespace :call_go_insta_scraper do
    desc "Runs an external Golang script"
    task :run, [:param1, :param2]  do |t, args|
      puts "running Go!"
      filepath = Rails.root.join('lib', 'scripts', 'instadwldrgo')
      output = ` #{filepath} #{args[:param1]} #{args[:param2]}`
      puts output
    end
end
