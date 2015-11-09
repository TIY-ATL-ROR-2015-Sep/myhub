module Myhub
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    # Your code here too!
    def initialize
      @headers = {
        "Authorization"  => "token #{ENV["AUTH_TOKEN"]}",
        "User-Agent"     => "HTTParty"
      }
    end

    def get_issues(user)
      issues = self.class.get("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues", 
        :headers => @headers, :query => { state: "all", assignee: user } )
      issues.map { |hw| { 
          :number   => hw["number"], 
          :title    => hw["title"], 
          :assignee => hw["assignee"]["login"],
          :state    => hw["state"]
          } 
        }
    end

    def reopen_issue(number)
      self.class.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/#{number}", 
        :headers => @headers, :body => {state: "open"}.to_json)
    end

    def close_issue(number)
      self.class.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/#{number}", 
        :headers => @headers, :body => {state: "close"}.to_json)
    end

  end
end
