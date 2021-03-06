require_relative '../examples/guitar_data_model'

require_relative 'support/shared_examples/mince_data_model_examples'

describe GuitarDataModel do
  let(:collection_name) { :guitars }
  let(:data_field_attributes) do
    {
            brand: 'a brand everyone knows',
            price: 'a price you save up for',
            type: 'the kind you want',
            color: 'should be your favorite'
    }
  end

  it_behaves_like 'a data model'
end