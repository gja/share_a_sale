require "share_a_sale/version"
require 'digest'
require 'uri'
require 'rest-client'

module ShareASale
  SHARE_A_SALE_HOST = "shareasale.com"
  SHARE_A_SALE_PATH = "/w.cfm"
  SHARE_A_SALE_VERSION = "1.8"

  class Client < Struct.new(:merchant_id, :token, :api_secret)
    { banner_list: "bannerList", transaction_detail: "transactionDetail", reference: "reference" }.each do |method, api_action|
      class_eval <<-EORUBY, __FILE__, __LINE__
        def #{method}(options = {}, date = Time.now)
          request('#{api_action}', options, date).execute!
        end
      EORUBY
    end

    def request(action, options, date = Time.now)
      Request.new(merchant_id, token, api_secret, action, options, date)
    end
  end

  class Request < Struct.new(:merchant_id, :token, :api_secret, :action, :options, :date)
    def date_string
      date.strftime("%a, %d %b %Y %H:%M:%S GMT")
    end

    def string_to_hash
      "#{token}:#{date_string}:#{action}:#{api_secret}"
    end

    def authentication_hash
      Digest::SHA256.hexdigest(string_to_hash).upcase
    end

    def url
      params = [
        ['merchantId', merchant_id],
        ['token', token],
        ['version', SHARE_A_SALE_VERSION],
        ['action', action],
        ['date', date.strftime("%D")]
      ] + options.to_a

      URI::HTTPS.build(
        host: SHARE_A_SALE_HOST,
        path: SHARE_A_SALE_PATH,
        query: params.map{|p| p.join('=') }.join('&')
      ).to_s
    end

    def custom_headers
      {
        "x-ShareASale-Date" => date_string,
        "x-ShareASale-Authentication" => authentication_hash
      }
    end

    def execute!
      RestClient.get(url, custom_headers)
    end
  end
end
