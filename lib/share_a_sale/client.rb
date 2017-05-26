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
end
