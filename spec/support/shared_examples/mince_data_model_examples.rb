require 'digest'

shared_examples_for 'a data model' do
  let(:mock_data_store) { mock 'data store data model' }
  let(:mock_data_store_class) { mock 'data store data model', :instance => mock_data_store, :generate_unique_id => unique_id, :primary_key_identifier => primary_key }
  let(:unique_id) { mock 'id' }
  let(:primary_key) { "custom_id" }

  before do
    DataStoreConfig.stub(:data_store => mock_data_store_class)
  end

  describe "storing a data model" do
    let(:mock_model) { mock 'a model', instance_values: data_field_attributes }

    before do
      mock_data_store.stub(:add)
    end

    it 'generates a unique id using the model as a salt' do
      mock_data_store_class.should_receive(:generate_unique_id).with(mock_model).and_return(unique_id)

      described_class.store(mock_model)
    end

    it 'adds the data model to the db store' do
      mock_data_store.should_receive(:add).with(collection_name, HashWithIndifferentAccess.new({primary_key => unique_id}).merge(data_field_attributes))

      described_class.store(mock_model)
    end
  end

  describe "updating a data model" do
    let(:data_model_id) { '1234567' }
    let(:mock_model) { mock 'a model', id: data_model_id, instance_values: data_field_attributes }

    before do
      mock_data_store.stub(:replace)
    end

    it 'replaces the data model in the db store' do
      mock_data_store.should_receive(:replace).with(collection_name, HashWithIndifferentAccess.new({primary_key => data_model_id}).merge(data_field_attributes))

      described_class.update(mock_model)
    end
  end

  describe 'updating a specific field for a data model' do
    let(:data_model_id) { '1234567' }
    
    it 'has the data store update the field' do
      mock_data_store.should_receive(:update_field_with_value).with(collection_name, data_model_id, :some_field, 'some value')

      described_class.update_field_with_value(data_model_id, :some_field, 'some value')
    end
  end

  describe "pushing a value to an array for a data model" do
    let(:data_model_id) { '1234567' }

    it 'replaces the data model in the db store' do
      mock_data_store.should_receive(:push_to_array).with(collection_name, primary_key, data_model_id, :array_field, 'some value')

      described_class.push_to_array(data_model_id, :array_field, 'some value')
    end
  end

  describe "getting all data models with a specific value for a field" do
    let(:mock_data_model) { {primary_key => 'some id'} }
    let(:expected_data_models) { [HashWithIndifferentAccess.new({:id => 'some id', primary_key => 'some id'})] }
    let(:mock_data_models) { [mock_data_model] }
    subject { described_class.array_contains(:some_field, 'some value') }

    it 'returns the stored data models with the requested field / value' do
      mock_data_store.should_receive(:array_contains).with(collection_name, :some_field, 'some value').and_return(mock_data_models)

      subject.should == expected_data_models
    end
  end

  describe "removing a value from an array for a data model" do
    let(:data_model_id) { '1234567' }

    it 'removes the value from the array' do
      mock_data_store.should_receive(:remove_from_array).with(collection_name, primary_key, data_model_id, :array_field, 'some value')

      described_class.remove_from_array(data_model_id, :array_field, 'some value')
    end
  end

  describe 'getting all of the data models' do
    let(:mock_data_model) { {primary_key => 'some id'} }
    let(:expected_data_models) { [HashWithIndifferentAccess.new({:id => 'some id', primary_key => 'some id'})] }
    let(:mock_data_models) { [mock_data_model] }

    it 'returns the stored data models' do
      mock_data_store.should_receive(:find_all).with(collection_name).and_return(mock_data_models)

      described_class.all.should == expected_data_models
    end
  end

  describe "getting all the data fields by a parameter hash" do
    let(:mock_data_model) { {primary_key => 'some id'} }
    let(:expected_data_models) { [{:id => 'some id', primary_key => 'some id'}] }
    let(:mock_data_models) { [mock_data_model] }
    let(:expected_data_models) { [HashWithIndifferentAccess.new(mock_data_model)] }

    it 'passes the hash to the mock_data_store_class' do
      mock_data_store.should_receive(:get_all_for_key_with_value).with(collection_name, :field2, 'not nil').and_return(mock_data_models)

      described_class.all_by_field(:field2, 'not nil').should == expected_data_models
    end
  end

  describe "getting a record by a set of key values" do
    let(:mock_data_model) { {primary_key => 'some id'} }
    let(:mock_data_models) { [mock_data_model] }
    let(:expected_data_models) { [{:id => 'some id', primary_key => 'some id'}] }

    let(:sample_hash) { {field1: nil, field2: 'not nil'} }

    it 'passes the hash to the mock_data_store_class' do
      mock_data_store.should_receive(:get_by_params).with(collection_name, sample_hash).and_return(mock_data_models)

      described_class.find_by_fields(sample_hash).should == HashWithIndifferentAccess.new(expected_data_models.first)
    end
  end

  describe "getting all of the data models for a where a field contains any value of a given array of values" do
    let(:mock_data_models) { [{primary_key => 'some id'}, {primary_key => 'some id 2'}] }
    let(:expected_data_models) { [{"id" => 'some id', primary_key => 'some id'}, {"id" => 'some id 2', primary_key => 'some id 2'}] }

    subject { described_class.containing_any(:some_field, ['value 1', 'value 2']) }

    it 'returns the stored data models' do
      mock_data_store.should_receive(:containing_any).with(collection_name, :some_field, ['value 1', 'value 2']).and_return(mock_data_models)

      subject.should == expected_data_models
    end
  end

  describe "getting a record by a key and value" do
    let(:mock_data_model) { {primary_key => 'some id'} }
    let(:expected_data_model) { {:id => 'some id', primary_key => 'some id'} }

    it 'returns the correct data model' do
      mock_data_store.should_receive(:get_for_key_with_value).with(collection_name, :field2, 'not nil').and_return(mock_data_model)

      described_class.find_by_field(:field2, 'not nil').should == HashWithIndifferentAccess.new(expected_data_model)
    end
  end

  describe "getting all data models with a specific value for a field" do
    let(:mock_data_models) { [{primary_key => 'some id'}, {primary_key => 'some id 2'}] }
    let(:expected_data_models) { [HashWithIndifferentAccess.new({:id => 'some id', primary_key => 'some id'}), HashWithIndifferentAccess.new({id: 'some id 2', primary_key => 'some id 2'})] }
    subject { described_class.all_by_field(:some_field, 'some value') }

    it 'returns the stored data models with the requested field / value' do
      mock_data_store.should_receive(:get_all_for_key_with_value).with(collection_name, :some_field, 'some value').and_return(mock_data_models)

      subject.should == expected_data_models
    end
  end

  describe 'getting a specific data model' do
    let(:mock_data_model) { {primary_key => 'id', :id => 'id' } }

    it 'returns the data model from the data store' do
      mock_data_store.should_receive(:find).with(collection_name, primary_key, 'id').and_return(mock_data_model)

      described_class.find(mock_data_model[:id]).should == HashWithIndifferentAccess.new(mock_data_model)
    end
  end
end
