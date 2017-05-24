require 'digest'
require 'uri'
require 'rest-client'

require 'share_a_sale/version'
require 'share_a_sale/request'
require 'share_a_sale/client'


module ShareASale
  def self.client
    @client ||= ShareASale::Client.new(
      ENV.fetch('SHAREASALE_MERCH_ID'),
      ENV.fetch('SHAREASALE_API_TOKEN'),
      ENV.fetch('SHAREASALE_API_SECRET')
    )
  end
end
