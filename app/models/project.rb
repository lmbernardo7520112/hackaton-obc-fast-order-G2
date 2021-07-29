class Project < ApplicationRecord
    has_many :issues

    def self.sync_from_api
        DoneDoneApi.sync_projects
    end
    
end
