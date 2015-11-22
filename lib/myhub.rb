require "sinatra/base"
require "httparty"
require "pry"

require "myhub/version"
require "myhub/github"

module Myhub
  class App < Sinatra::Base
    set :logging, true

    # Your code here ...
    get "/" do
      api = Github.new
      data = api.get_issues("TIY-ATL-ROR-2015-Sep","assignments", { assignee: "violetaria", state: "all" })
      erb :index, locals: { issues: data }
    end

    post "/issue/reopen/:id" do
      api = Github.new
      api.reopen_issue("TIY-ATL-ROR-2015-Sep","assignments",params["id"].to_i)
      redirect back
    end

    post "/issue/close/:id" do
      api = Github.new
      api.close_issue("TIY-ATL-ROR-2015-Sep","assignments",params["id"].to_i)
      redirect back
    end

    run! if app_file == $0
  end
end
