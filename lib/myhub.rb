require "sinatra/base"
require "httparty"
require "pry"

require "myhub/version"
require "myhub/github"

module Myhub
  class App < Sinatra::Base
    attr_reader :github

    set :logging, true

    # Your code here ...
    get "/" do
      api = Github.new
      issues = api.get_issues("sepehrvakili")
      erb :index, locals: { issues: issues }
    end

    post "/issue/reopen/:number" do
      api = Github.new
      api.reopen_issue(params["number"].to_i)
      redirect to('/')
    end

    post "/issue/close/:number" do
      api = Github.new
      api.close_issue(params["number"].to_i)
      redirect to('/')
    end

    #binding.pry

    run! if app_file == $0
  end
end
