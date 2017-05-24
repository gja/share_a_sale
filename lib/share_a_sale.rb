require "share_a_sale/version"
require 'digest'
require 'uri'
require 'rest-client'

module ShareASale

  class Client < Struct.new(:merchant_id, :token, :api_secret)
    { banner_list: "bannerList", transaction_detail: "transactionDetail", reference: "reference" }.each do |method, api_action|
      class_eval <<-EORUBY, __FILE__, __LINE__
        def #{method}(options = {}, date = Time.now.utc)
          request('#{api_action}', options, date).execute!
        end
      EORUBY
    end

    def request(action, options, date = Time.now.utc)
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
        ['version', version],
        ['action', action],
        ['date', date.strftime("%D")]
      ] + options.to_a

      URI::HTTPS.build(
        host:  host,
        path:  path,
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

  protected

    def host
      ENV.fetch('SHAREASALE_HOST', 'api.shareasale.com')
    end

    def path
      ENV.fetch('SHAREASALE_PATH', '/w.cfm')
    end

    def version
      ENV.fetch('SHAREASALE_VERSION', '2.8')
    end
  end
end
