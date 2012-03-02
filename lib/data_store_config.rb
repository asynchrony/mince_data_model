require 'rails/application'

module DataStoreConfig
  def self.data_store
    Rails.application.config.data_store.to_s.camelize.constantize
  end
end