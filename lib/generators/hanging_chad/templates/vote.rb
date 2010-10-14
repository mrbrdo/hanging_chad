class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, :polymorphic => true

  validates_uniqueness_of :user_id, :scope => [:votable_id, :votable_type, :kind]

  after_save :update_total

  protected
  def update_total
    transaction do
      total = VoteTotal.
        find_or_create_by_votable_type_and_votable_id_and_kind(
          votable_type, votable_id, kind)

      total.total = votable.votes.count(:conditions => {:kind => kind})
      total.ayes = votable.votes.count(:conditions => {:kind => kind, :value => true})
      total.nays = votable.votes.count(:conditions => {:kind => kind, :value => false})
      total.update_attribute(:percent_ayes, total.ayes.to_f/total.total)
    end
  end
end
