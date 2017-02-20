FactoryGirl.define do
  	factory :answer do
  		question_id 0
  		user_id 0
    	body { FFaker::Lorem.paragraph(2) }
	end
end

