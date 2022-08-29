#!/usr/bin/env ruby

class Temperature < Object
    MSG_ILLEGAL_UNIT = "あり得ない単位です。"
    MSG_LESS_THAN_ZERO = "絶対零度より低温になってしまいます。"

    attr_accessor :value, :unit

    def initialize(val, u)
        @value = val
        @unit = u
        return self
    end

    ABSOLUTE_ZERO = Temperature.new(-273.15, 'C')

    def to_c
        if self.unit == 'C'
            result = self
        elsif self.unit != 'F'
            result = nil
        else
            temp = (5 * (self.value - 32) / 9).round(2)
            result = Temperature.new(temp, 'C')
        end
        return result
    end

    def to_f
        if self.unit == 'F'
            result = self
        elsif self.unit != 'C'
            result = nil
        else
            temp = (9 * self.value / 5 + 32).round(2)
            result = Temperature.new(temp, 'F')
        end
        return result
     end

    def to_k
        result = nil
        if self.unit == 'C'
            result = Temperature.new(self.value + 
                Temperature::ABSOLUTE_ZERO.value, 'K')
        end
    end

    ABS_Z_F = ABSOLUTE_ZERO.to_f

    def validate!
        if self.unit == 'F'
            if self.value < ABS_Z_F.value
                raise MSG_LESS_THAN_ZERO
            end
        elsif self.unit != 'C'
            raise MSG_ILLEGAL_UNIT
        else
            if self.value < ABSOLUTE_ZERO.value
                raise MSG_LESS_THAN_ZERO
            end
        end
        
        return self
    end
end
