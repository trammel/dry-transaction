require "dry/monads/either"

module Dry
  module Transaction
    class StepAdapters
      # @api private
      class Raw
        include Dry::Monads::Either::Mixin

        def call(step, *args, input)
          result = step.operation.call(*args, input)

          unless result.is_a?(Dry::Monads::Either)
            raise ArgumentError, "step +#{step.step_name}+ must return an Either object"
          end

          result
        end
      end

      register :step, Raw.new
    end
  end
end
