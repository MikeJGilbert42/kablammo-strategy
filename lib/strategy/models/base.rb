module Strategy
  module Model
    module Base
      def initialize(args)
        args.each do |k, v|
          method = "#{k}="
          #puts "Initializing class #{self.class} attribute #{k} using value #{v}"
          if v.instance_of? Array
            klass = Strategy::Model.const_get(depluralize(k.capitalize))
            #puts "Instantiating array of #{klass} from attributes #{v}"
            v = v.map { |x| klass.new(self, x)}
          elsif v.instance_of? Hash
            klass = Strategy::Model.const_get(k.capitalize)
            #puts "Instantiating #{klass} from attributes #{v}"
            v = klass.new(self, v)
          end
          send method, v if respond_to?(method.to_sym)
        end
      end

      def depluralize(s)
        return "String" if s == "Abilities"
        return "PowerUp" if s == "Power_ups"
        s[0..-2]
      end
    end
  end
end