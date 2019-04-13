# Usage
#     cl = DirCleaner.new(directoryToZip)
#     cl.cleanFiles()

class DirCleaner
  def initialize(inputDir)
    @inputDir = inputDir
  end

  def cleanFiles
    Dir.glob(@inputDir + '/**/*').each do |filename|
      FileUtils.rm(filename, :force => true ) if File.extname(filename) != ".zip"
    end
  end

  def cleanDir
    FileUtils.rm_rf(@inputDir)
  end
end