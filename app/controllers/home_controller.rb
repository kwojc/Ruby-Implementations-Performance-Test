class HomeController < ApplicationController
  def index
    @tests = Result.select("distinct name")
    @results = {}
    @tests.each do |system|
      @results[system.name] = Result.where(
          name: system.name
      ).order('id desc')
    end

    @system_groups = {}
    @tests.each do |test|
      @system_groups[test.name] = {}
      @results[test.name].each do |result|
        @system_groups[test.name][result.engine + result.version] = [] if @system_groups[test.name][result.engine + result.version] == nil
        @system_groups[test.name][result.engine + result.version] << result
      end
    end
  end
end
