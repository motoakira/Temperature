require_relative '../temperature'

RSpec.describe Temperature do
    describe ".new" do
        it "should make a temperature record" do
            temp = Temperature.new(0, 'C')
            expect(temp.value).to eq(0) 
            expect(temp.unit).to eq('C') 
        end
    end

end
