require 'share_a_sale'

module ShareASale
  describe Request do
    context "API metadata" do
      let(:client) { Client.new(1234, 'NGc6dg5e9URups5o', 'ATj7vd8b7CCjeq9yQUo8cc2w3OThqe2e') }
      subject { client.request('bannerList', { param: 'value' }, Time.gm(2011, 04, 14, 22, 44, 22)) }

      its(:date_string) { should eq "Thu, 14 Apr 2011 22:44:22 GMT" }
      its(:string_to_hash) { should eq "NGc6dg5e9URups5o:Thu, 14 Apr 2011 22:44:22 GMT:bannerList:ATj7vd8b7CCjeq9yQUo8cc2w3OThqe2e" }
      its(:authentication_hash) { should eq "78D54A3051AE0AAAF022AA2DA230B97D5219D82183FEFF71E2D53DEC6057D9F1" }
      its(:url) { should eq "https://shareasale.com/w.cfm?merchantId=1234&token=NGc6dg5e9URups5o&version=1.8&action=bannerList&date=04/14/11&param=value"}
    end
  end
end
