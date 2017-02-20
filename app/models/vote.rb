class Vote < ActiveRecord::Base

	 belongs_to :user
	 belongs_to :votable , :polymorphic => true


	 scope :votes_up, lambda {|desired_votable_id , desired_votable_type|
	 	where(:votable_id => desired_votable_id , :votable_type => desired_votable_type , :up_or_down => true).count
	 }

	 scope :votes_down, lambda {|desired_votable_id , desired_votable_type|
	 	where(:votable_id => desired_votable_id , :votable_type => desired_votable_type , :up_or_down => false).count
	 }
end
