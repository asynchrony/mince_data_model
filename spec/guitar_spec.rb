require_relative '../examples/guitar'

describe Guitar do
  let(:attrs) { { brand: 'Gibson', price: 3399.99, type: 'Les Paul', color: 'Mahogany' } }

  subject { described_class.new(attrs)}

  its(:brand){ should == attrs[:brand] }
  its(:price){ should == attrs[:price] }
  its(:type){ should == attrs[:type] }
  its(:color){ should == attrs[:color] }

  describe "storing the guitar" do
    let(:mock_id) { mock 'unique id for the guitar' }

    before do
      GuitarDataModel.stub(store: mock_id)
    end

    it 'uses the guitar document to store it' do
      GuitarDataModel.should_receive(:store).with(subject).and_return(mock_id)

      subject.store
    end

    it 'sets the id received from the document to the guitar so we can find it later' do
      subject.store

      subject.id.should == mock_id
    end
  end
end