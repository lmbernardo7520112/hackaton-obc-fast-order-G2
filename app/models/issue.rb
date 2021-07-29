class Issue < ApplicationRecord
  belongs_to :project
  has_many :histories

  def self.sync_from_api
    DoneDoneApi.sync_issues
    end
    
end
