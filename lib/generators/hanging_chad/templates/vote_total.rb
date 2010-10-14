class VoteTotal < ActiveRecord::Base
  belongs_to :votable, :polymorphic => true
  validates_uniqueness_of :kind, :scope => [:votable_id, :votable_type]
end
