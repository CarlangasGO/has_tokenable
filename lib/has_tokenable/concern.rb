module HasTokenable
  module Concern

    METHODS = %w(urlsafe_base64 hex alphanumeric random_number uuid).freeze

    def self.included(base)
      base.send(:extend,  ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        validates :token, presence: true, uniqueness: true
        before_validation :generate_token, on: :create, if: proc{|record| record.token.nil? }
      end
    end

    module ClassMethods

      def method_random=(value)
        values = value.is_a?(Array) ? value : [value]
        values.map! { |v| v.to_s }
  
        raise ArgumentError.new('Method is not supported') if (values - METHODS).size > 0
        values
      end

      # Default options as well as an overwrite point so you can assign different defaults to different models
      def default_token_options
        @default_token_options ||= begin
          options = HasTokenable.default_token_options
          options[:prefix] ||= self.name[0, 1]
          options
        end
      end

      def generate_method(options)
        args = [ options[:method_random], options[:length].to_i ]
  
        args.slice!(-1) if options[:method_random] == 'uuid'

        SecureRandom.send(*args)
      end

      # Generates a unique token based on the options
      def generate_unique_token
        record, options = true, @has_tokenable_options
        conditions = {}

        token = loop do
          random_token = self.generate_method(options)

          conditions[options[:param_name].to_sym] = random_token

          break random_token unless self.exists?(conditions)
        end

        token
      end

    end # ClassMethods

    module InstanceMethods

      # Returns the resource's token
      def to_param
        self.send(self.class.has_tokenable_options[:param_name])
      end

    private

      def generate_token
        self.token = self.class.generate_unique_token
      end

    end # InstanceMethods

  end # Concern

end # HasTokenable
