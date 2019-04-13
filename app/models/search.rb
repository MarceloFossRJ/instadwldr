require 'rake'
Instadwldr::Application.load_tasks

class Search
  include SessionInfo

  include Mongoid::Document
  include Mongoid::Timestamps

  field :instagram_path, type: String
  field :user_id, type: Integer
  field :ip, type: String
  field :country, type: String
  field :state, type: String
  field :city, type: String
  field :referer, type: String
  field :postal_code, type: String
  field :address, type: String
  field :coordinates, type: String
  field :browser_name, type: String
  field :browser_version, type: String
  field :is_bot, type: Boolean
  field :is_mobile, type: Boolean
  field :device_name, type: String
  field :platform_name, type: String
  field :platform_version, type: String

  validates :instagram_path, presence: true

  after_create do
    dir = Rails.root.join('public', 'dwlds', session_id)
    Dir.mkdir(dir) unless Dir.exist?(dir)
    Search.run_rake('call_go_insta_scraper:run', self.instagram_path, "./public/dwlds/#{session_id}/")
  end

  def self.zip(dir)
    directoryToZip = Rails.root.join('public', 'dwlds', dir)
    logger.debug("PATH=#{directoryToZip}" )
    outputFile = Rails.root.join('public', 'dwlds', dir, 'instaDwldr.zip')
    zf = ZipFileGenerator.new(directoryToZip, outputFile)
    zf.write()
    return outputFile
  end

  private

  def self.run_rake(task_name, insta_path, dest_path)
    load File.join(Rails.root, 'lib', 'tasks', 'call_go_insta_scraper.rake')
    Rake::Task[task_name].execute(OpenStruct.new({param1: insta_path, param2: dest_path}))
  end


end
