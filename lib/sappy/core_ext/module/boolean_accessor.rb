module Sappy
  module CoreExt
    module BooleanAccessor
      def boolean_accessor(*syms)
        syms.each do |sym|
          class_eval(<<-EOS, __FILE__, __LINE__)
            def #{sym}?; @#{sym} == 1; end
            def #{sym}=(value); @#{sym} = value.to_s.match(/true|yes|on|1/i) ? 1 : 0; end
            def #{sym}; @#{sym}; end
          EOS
        end
      end
    end
  end
end

Module.send(:include, Sappy::CoreExt::BooleanAccessor)
