namespace :call_go_insta_scraper do
    desc "Runs an external Golang script"
    task :run, [:insta_path, :dest_path, :s_id]  do |t, args|
      s = Search.where( session_id: args[:s_id],
                        instagram_path: args[:insta_path],
                        file_downloaded: TRUE,
                        file_cleaned: FALSE)

      if !s.exists?
        puts "running Go!"
        filepath = Rails.root.join('lib', 'scripts', 'instadwldrgo')
        output = ` #{filepath} #{args[:insta_path]} #{args[:dest_path]}`
        puts output
        if output.to_s.strip == "0"
          Search.where( session_id: args[:s_id],
                        instagram_path: args[:insta_path],
                        file_downloaded: FALSE,
                        file_cleaned: FALSE).update_all(:file_downloaded => TRUE)
        end
      end
    end
end
