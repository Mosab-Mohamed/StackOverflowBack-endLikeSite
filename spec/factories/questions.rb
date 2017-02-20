FactoryGirl.define do
  	factory :question do
    	title { FFaker::Lorem.sentence(3) }
    	body { FFaker::Lorem.paragraph(2) }
    	user_id 0
	end
end

