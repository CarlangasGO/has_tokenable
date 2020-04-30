require 'has_tokenable/concern'
require 'has_tokenable/finder_methods'
require 'has_tokenable/table_definition'

module HasTokenable

  module ActiveRecordTie

    def has_tokenable(options={})
      self.send(:include, HasTokenable::Concern)
      @has_tokenable_options ||= HasTokenable.default_token_options.merge(options)
    end

    def has_tokenable_options
      @has_tokenable_options ||= HasTokenable.default_token_options
    end
  end

  def self.default_token_options
    @default_token_options ||= {
      :prefix             => nil, # if nil use first letter of class name
      :length             => 10,
      :param_name         => 'token',
      :method_random      => 'urlsafe_base64'
    }
  end

end

ActiveRecord::Base.send(:extend, HasTokenable::ActiveRecordTie)
ActiveRecord::Base.send(:extend, HasTokenable::FinderMethods)