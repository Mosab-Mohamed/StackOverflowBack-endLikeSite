FactoryGirl.define do
  	factory :comment do
  		user_id 0
  		commentable_id 0
  		commentable_type "question"
    	body { FFaker::Lorem.paragraph(2) }
	end
end

