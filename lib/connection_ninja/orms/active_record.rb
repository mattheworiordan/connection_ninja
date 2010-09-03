require 'active_record'
require 'connection_ninja'

module ConnectionNinja
  module Orms
    module ActiveRecord
      def use_connection_ninja(config_group)
        begin
          establish_connection ninja_config(config_group)
        rescue Exception => e
          raise ::ActiveRecord::AdapterNotFound, e.message
        end
      end

      private
        def ninja_config(config_group)
          ConnectionNinja::Config.ninja_config(configurations, config_group)
        end
    end
  end
  class Config
    def self.ninja_config(configurations, config_group)
      begin
        configurations[config_group.to_s][::Rails.env]
      rescue
        raise "connection ninja could not find the #{::Rails.env} configuration for group \"#{config_group.to_s}\""
      end
    end
  end
end
