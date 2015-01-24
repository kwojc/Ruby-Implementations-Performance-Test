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

  def test

  end

  def run
    request_time = Time.now.to_f

    require 'my_math'
    @tests = []

    0.upto(params[:times].to_i).map do |i|
      start = Time.now.to_f
      MyMath.factorial(params[:factorial].to_i)
      @tests << Result.new(name: '1 thread factorial', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)

      start = Time.now.to_f
      MyMath.fibonacci(params[:fibonacci].to_i)
      @tests << Result.new(name: '1 thread fibonacci', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)


      start = Time.now.to_f
      0.upto(params[:threads].to_i).map do |n|
        Thread.new {
          MyMath.factorial(params[:factorial].to_i)
        }
      end.each(&:join)
      @tests << Result.new(name: params[:threads].to_s + ' thread factorial', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)


      start = Time.now.to_f
      0.upto(params[:threads].to_i).map do |n|
        Thread.new {
          MyMath.fibonacci(params[:fibonacci].to_i)
        }
      end.each(&:join)
      @tests << Result.new(name: params[:threads].to_s + ' thread fibonacci', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
    end
    #@tests.reverse!
    @results = {}
    @tests.each do |test|
      @results[test.name] = [] if @results[test.name].nil?
      @results[test.name] << test
    end

    test

    @request_time = Time.now.to_f - request_time
  end
end
