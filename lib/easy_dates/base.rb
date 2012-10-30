module EasyDates
  module Base
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      TIMESTAMPS = [:created_at, :updated_at]

      def define_easy_dates(&date_block)
        instance_eval(&date_block)
      end

      private

      def format_for(names = [], options = {})
        format = choose_date_format(options[:format]) || "%Y-%m-%d"
        type = options[:type] || :datetime
        names = [*names].flatten

        if names.include?(:timestamps)
          TIMESTAMPS.each {|ts| names << ts }
        end

        names.each do |name|
          chosen_name = names.size == 1 ? (options[:as] || "formatted_#{name}") : "formatted_#{name}"
          generate_method(name, chosen_name, format, type) unless name.equal?(:timestamps)
        end
      end

      def generate_method(name, chosen_name, format, type)
        class_eval <<-EOL
          def #{chosen_name}
            #{name}.nil? ? nil : #{name}.strftime("#{format}")
          end
        EOL

        case type
          when :datetime then
            class_eval <<-EOL
              def #{chosen_name}=(new_val)
                self.#{name} = DateTime.strptime(new_val, "#{format}")
              end
            EOL
          when :date then
            class_eval <<-EOL
              def #{chosen_name}=(new_val)
                self.#{name} = Date.strptime(new_val, "#{format}")
              end
            EOL
          when :time then
            class_eval <<-EOL
              def #{chosen_name}=(new_val)
                self.#{name} = DateTime.strptime(new_val, "#{format}").to_time
              end
            EOL
        end
      end

      def choose_date_format(format)
        case format
          when :us
            "%m-%d-%Y"
          when :world
            "%m-%d-%Y"
          else
            format
        end
      end
    end
  end
end
