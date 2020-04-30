require 'active_record/connection_adapters/abstract/schema_definitions'

module HasTokenable
  module TableDefinition

    def token(*args)
      options = { length: HasTokenable.default_token_options[:length] }.merge(args.extract_options!)
      puts "opeiont: #{options}"
      column(:token, :string, options.merge(nil: false))
    end

  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, HasTokenable::TableDefinition)
