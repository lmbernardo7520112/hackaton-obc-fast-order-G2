class IssuesController < ApplicationController
  def index
    @issues = Issue.order(last_updated_on: :desc)
  end

  def show
    @issue = Issue.find(params[:id])
    @histories = @issue.histories.order(:created_on)
  end
end
