require 'share_a_sale'

describe ShareASale::Request do
  context "API metadata" do

    let(:client) do
      ShareASale::Client.new(
        1234,
        'NGc6dg5e9URups5o',
        'ATj7vd8b7CCjeq9yQUo8cc2w3OThqe2e'
      )
    end

    subject do
      client.request(
        'bannerList',
        { param: 'value' },
        Time.gm(2011, 04, 14, 22, 44, 22)
      )
    end

    specify do
      expect(subject.date_string).to eq("Thu, 14 Apr 2011 22:44:22 GMT")
    end

    specify do
      expect(subject.string_to_hash).to eq(
        "NGc6dg5e9URups5o:Thu, 14 Apr 2011 22:44:22 GMT:bannerList:ATj7vd8b7CCjeq9yQUo8cc2w3OThqe2e"
      )
    end

    specify do
      expect(subject.authentication_hash).to eq(
        "78D54A3051AE0AAAF022AA2DA230B97D5219D82183FEFF71E2D53DEC6057D9F1"
      )
    end

    specify do
      expect(subject.url).to eq(
        "https://api.shareasale.com/w.cfm?merchantId=1234&token=NGc6dg5e9URups5o&version=2.8&action=bannerList&date=04/14/11&param=value"
      )
    end

  end
end
