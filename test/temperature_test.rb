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
end
