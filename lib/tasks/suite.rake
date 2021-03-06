namespace :suite do
  desc 'Run everything'
  task run: :environment do
    Rake::Task['suite:clean'].invoke
    Rake::Task['suite:single_fibo'].invoke
    Rake::Task['suite:single_factorial'].invoke
    Rake::Task['suite:multi_fibo'].invoke
    Rake::Task['suite:multi_factorial'].invoke
    Rake::Task['suite:single_hanoi'].invoke
    Rake::Task['suite:multi_hanoi'].invoke
  end

  desc 'Clean environment with current RUBY_ENGINE and RUBY_VERSION'
  task clean: :environment do
    Result.all.where(engine: RUBY_ENGINE, version: RUBY_VERSION).each do |result|
      result.delete
    end
  end

  desc 'Calculates Fibonacci of 30 - one thread | 50 times'
  task single_fibo: :environment do
    for times in 1..50
      start = Time.now.to_f
      MyMath.fibonacci 30
      r = Result.new(name: '1 thread fibonacci', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
      r.save
      puts r.to_csv
    end
  end

  desc 'Calculates factorial of 20 - one thread | 50 times'
  task single_factorial: :environment do
    for times in 1..50
      start = Time.now.to_f
      MyMath.factorial 20
      r = Result.new(name: '1 thread factorial', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
      r.save
      puts r.to_csv
    end
  end


  desc 'Calculates Fibonacci of 30 - $numberOfCpuCores..($numberOfCpuCores + 0..$numberOfCpuCores+2) threads | 50 times'
  task multi_fibo: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'my_math'
    for times in 1..50
      0.upto(processors_count+2) do |i|
        start = Time.now.to_f
        1.upto(processors_count+i).map do |n|
          Thread.new {
            MyMath.fibonacci 30
          }
        end.each(&:join)
        r = Result.new(name: (processors_count+i).to_s + ' threads fibonacci', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
        r.save
        puts r.to_csv
      end
    end
  end

  desc 'Calculates factorial of 20 - $numberOfCpuCores..($numberOfCpuCores + 0..$numberOfCpuCores+2) threads | 50 times'
  task multi_factorial: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'my_math'
    for times in 1..50
      0.upto(processors_count+2) do |i|
        start = Time.now.to_f
        1.upto(processors_count+i).map do |n|
          Thread.new {
            MyMath.factorial 20
          }
        end.each(&:join)
        r = Result.new(name: (processors_count+i).to_s + ' threads factorial', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
        r.save
        puts r.to_csv
      end
    end
  end

  desc 'Calculates 25 elements hanoi tower - one thread | 50 times'
  task single_hanoi: :environment do
    for times in 1..50
      start = Time.now.to_f
      toh = HanoiTowers.new(25)
      #puts toh.stacks.to_s
      toh.run
      #puts toh.stacks.to_s
      r = Result.new(name: '1 thread hanoi', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
      r.save
      puts r.to_csv
    end
  end

  desc 'Calculates 25 elements hanoi tower - ($numberOfCpuCores + 0..$numberOfCpuCores+2) threads | 50 times'
  task multi_hanoi: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'hanoi_towers'
    for times in 1..50
      start = Time.now.to_f
      0.upto(processors_count+2) do |i|
        1.upto(processors_count+i).map do |n|
          Thread.new {
            toh = HanoiTowers.new(25)
            toh.run
          }
        end.each(&:join)
        r = Result.new(name: (processors_count+i).to_s + ' threads hanoi', engine: RUBY_ENGINE, version: RUBY_VERSION, time: (Time.now.to_f - start).to_s)
        r.save
        puts r.to_csv
      end
    end
  end
end