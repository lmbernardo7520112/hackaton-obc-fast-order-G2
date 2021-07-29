class DoneDoneApi
    def self.conn
        connection = Faraday.new(:url => 'DONEDONE_API_BASE_URL')
        connection.basic_auth('DONEDONE_API_USERNAME', 'DONEDONE_API_TOKEN')
        connection
    end
    def self.sync_projects
        response = conn.get '/issuetracker/api/v2/projects.json'
            if response.body
                api_projects = JSON.parse(response.body)
                api_projects.each do |api_project|
                p = Project.find_or_initialize_by(project_id: api_project['id'])
                p.title = api_project['title']
                p.save
                end
            end
    end
    def self.sync_issues
        issues_response = conn.get '/issuetracker/api/v2/issues/all.json'
            if issues_response.body
                api_issues = JSON.parse(issues_response.body)['issues']
                api_issues.each do |api_issue|
                project_id = api_issue['project']['id']
                    order_number = api_issue['order_number']
                    created_on = convert_to_datetime(api_issue['created_on'])
                    last_updated_on = convert_to_datetime(api_issue['last_updated_on'])
                    last_updater = api_issue['last_updater']['name']
                    p = Project.find_by(project_id: project_id)
                    sync_issue_detail(p.id, project_id, order_number, created_on, last_updated_on, last_updater)
                end
            end
    end
private
    def self.sync_issue_detail(local_project_id, project_id, order_number, created_on, last_updated_on, last_updater)
        issue_response = conn.get "/issuetracker/api/v2/projects/#{project_id}/issues/#{order_number}.json"
            if issue_response.body
                api_issue_detail = JSON.parse(issue_response.body)
                i = Issue.find_or_initialize_by(project_id: local_project_id, order_number: api_issue_detail['order_number'])
                i.title = api_issue_detail['title']
                i.description = api_issue_detail['description']
                i.status = api_issue_detail['status']['name']
                i.priority = api_issue_detail['priority']['name']
                i.fixer = api_issue_detail['fixer']['name']
                i.tester = api_issue_detail['tester']['name']
                i.creator = api_issue_detail['creator']['name']
                i.created_on = created_on
                i.last_updated_on = last_updated_on
                i.last_updater = last_updater
            if api_issue_detail['due_date']
                i.due_date = convert_to_date(api_issue_detail['due_date'])
            end
                i.save
                sync_issue_histories(i, api_issue_detail['histories'])
            end
    end
    def self.sync_issue_histories(issue, histories)
        histories.each do |api_history|
        h = History.find_or_initialize_by(issue: issue, history_id: api_history['id'])
        h.created_on = convert_to_datetime(api_history['created_on'])
        h.action = api_history['action']
        h.description = api_history['description']
        h.creator = api_history['creator']['name']
        h.save
        end
    end
    def self.convert_to_date(raw_val)
        num = raw_val.gsub(/[^0-9]/, '').to_f
        Time.at(num / 1000).to_date
    end
    def self.convert_to_datetime(raw_val)
        num = raw_val.gsub(/[^0-9]/, '').to_f
        Time.at(num / 1000).to_datetime
    end
end

