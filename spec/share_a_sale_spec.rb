require 'share_a_sale'

describe ShareASale do

  describe '.client' do
    context 'without credentials in ENV' do
      it 'raises an error' do
        expect { ShareASale.client }.to raise_error(KeyError)
      end
    end

    context 'with credentials in ENV' do
      it 'returns an instance of ShareASale::Client' do
        ENV['SHAREASALE_MERCH_ID'] = '123'
        ENV['SHAREASALE_API_TOKEN'] = 'foo'
        ENV['SHAREASALE_API_SECRET'] = 'bar'

        expect(ShareASale.client).to be_instance_of(ShareASale::Client)
      end
    end
  end

end
