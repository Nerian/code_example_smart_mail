# encoding: utf-8

class Deploy < Thor
  include Thor::Actions

  desc "production", "Deploy to production"
  def production
    run('git push heroku master:master')
  end
end