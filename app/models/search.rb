require 'rake'
Instadwldr::Application.load_tasks

class Search
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
  field :device_platform, type: String
  #field :os, type: String

  validates :instagram_path, presence: true

  after_create do
    Search.run_rake('call_go_insta_scraper:run', self.instagram_path, './public/')
  end

  def self.run_rake(task_name, insta_path, dest_path)
    load File.join(Rails.root, 'lib', 'tasks', 'call_go_insta_scraper.rake')
    Rake::Task[task_name].execute(OpenStruct.new({param1: insta_path, param2: dest_path}))
  end
end
