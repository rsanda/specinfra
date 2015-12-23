require 'nokogiri'

class Specinfra::Command::Base::Hdfs < Specinfra::Command::Base
  class << self
    def get_value(config)
      regx = /#{@config}/
      doc = Nokogiri::XML( open('/etc/hadoop/conf/hdfs-site.xml') )
      doc.xpath('/configuration/property').each do |property|
      case property.xpath('name').text
        when regx
          return property.xpath('value').text
        end
      end
    end
  end
end
