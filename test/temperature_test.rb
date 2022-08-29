require 'RSpec'
require_relative '../temperature'

RSpec.describe Temperature do
    describe ".new" do
        it "should make a temperature record" do
            temp = Temperature.new(0, 'C')
            expect(temp.value).to eq(0) 
            expect(temp.unit).to eq('C') 
        end
        it "should make a even invalid record" do
            temp = Temperature.new(0, 'X')
            expect(temp.value).to eq(0) 
            expect(temp.unit).to eq('X') 
        end
   end
   describe "#validate!" do
        it "should pass a valid temperature struct" do
            temp = Temperature.new(0, 'C')
            expect(temp.validate!).to eq(temp)
        end
        it "should raise an error for invalid units" do
            temp = Temperature.new(0, 'X')
            expect{temp.validate!}.to raise_error("あり得ない単位です。")
        end
        it "should raise an error for too low temperature" do
            temp = Temperature.new(-274, 'C')
            expect{temp.validate!}.to raise_error("絶対零度より低温になってしまいます。")
        end
        it "should raise an error for too low temperature in ℉" do
            temp = Temperature.new(-460, 'F')
            expect{temp.validate!}.to raise_error("絶対零度より低温になってしまいます。")
        end
    end
    describe "#to_f" do
        it "should do nothing if struct is already in ℉" do
            sample = Temperature.new(0, 'F')
            expect(sample.to_f).to eq(sample)
        end
        it "should be -459.67℉ when -273.15℃" do
            sample = Temperature.new(-273.15, 'C')
            temp = Temperature.new(-459.67, 'F')
            expect(sample.to_f).to eq(temp)
        end
        it "should be -40.0℉ when -40.0℃" do
            sample = Temperature.new(-40.0, 'C')
            temp = Temperature.new(-40.0, 'F')
            expect(sample.to_f).to eq(temp)
        end
        it "should be 32.0℉ when 0.0℃" do
            sample = Temperature.new(0.0, 'C')
            temp = Temperature.new(32.0, 'F')
            expect(sample.to_f).to eq(temp)
        end
        it "should be 100.0℉ when 37.78℃" do
            sample = Temperature.new(37.78, 'C')
            temp = Temperature.new(100.0, 'F')
            expect(sample.to_f).to eq(temp)
        end
        it "should be 212.0℉ when 100.0℃" do
            sample = Temperature.new(100.0, 'C')
            temp = Temperature.new(212.0, 'F')
            expect(sample.to_f).to eq(temp)
        end
    end
    describe "#to_c" do
        it "should do nothing if struct is already in ℃" do
            sample = Temperature.new(0, 'C')
            expect(sample.to_c).to eq(sample)
        end
        it "should be -273.15℃ when -459.67°F" do
            sample = Temperature.new(-459.67, 'F')
            temp = Temperature.new(-273.15, 'C')
            expect(sample.to_c).to eq(temp)
        end
        it "should be -40.0℃ when -40.0°F" do
            sample = Temperature.new(-40.0, 'F')
            temp = Temperature.new(-40.0, 'C')
            expect(sample.to_c).to eq(temp)
        end
        it "should be -17.78℃ when 0.0°F" do
            sample = Temperature.new(0.0, 'F')
            temp = Temperature.new(-17.78, 'C')
            expect(sample.to_c).to eq(temp)
        end
        it "should be 37.78℃ when 100.0℉" do
            sample = Temperature.new(100.0, 'F')
            temp = Temperature.new(37.78, 'C')
            expect(sample.to_c).to eq(temp)
        end
        it "should be 100.0℃ when 212.0℉" do
            sample = Temperature.new(212.0, 'F')
            temp = Temperature.new(100.0, 'C')
            expect(sample.to_c).to eq(temp)
        end
    end
end
