namespace :test do
  desc 'Run everything'
  task run: :environment do
    Rake::Task["test:single_fibo"].invoke
    Rake::Task["test:single_factorial"].invoke
    Rake::Task["test:multi_fibo"].invoke
    Rake::Task["test:multi_factorial"].invoke
    Rake::Task["test:single_hanoi"].invoke
    Rake::Task["test:multi_hanoi"].invoke
  end

  desc 'Calculates Fibonacci of 30 - one thread | 50 times'
  task single_fibo: :environment do
    for times in 1..50
      start = Time.now.to_f
      MyMath.fibonacci 30
      puts 'Single thread fibonacci;' + RUBY_ENGINE + ';' + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
    end
  end

  desc 'Calculates factorial of 20 - one thread | 50 times'
  task single_factorial: :environment do
    for times in 1..50
      start = Time.now.to_f
      MyMath.factorial 20
      puts 'Single thread factorial;' + RUBY_ENGINE+ ';' + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
    end
  end


  desc 'Calculates Fibonacci of 30 - $numberOfCpuCores..($numberOfCpuCores + 0..$numberOfCpuCores*3) threads | 50 times'
  task multi_fibo: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'my_math'
    for times in 1..50
      0.upto(processors_count*3) do |i|
        start = Time.now.to_f
        1.upto(processors_count+i).map do |n|
          Thread.new {
            MyMath.fibonacci 30
          }
        end.each(&:join)
        puts (processors_count+i).to_s + ' threads fibonacci;' + RUBY_ENGINE+ ';' + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
      end
    end
  end

  desc 'Calculates factorial of 20 - $numberOfCpuCores..($numberOfCpuCores + 0..$numberOfCpuCores*3) threads | 50 times'
  task multi_factorial: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'my_math'
    for times in 1..50
      0.upto(processors_count*3) do |i|
        start = Time.now.to_f
        1.upto(processors_count+i).map do |n|
          Thread.new {
            MyMath.factorial 20
          }
        end.each(&:join)
        puts (processors_count+i).to_s + ' threads factorial;' + RUBY_ENGINE+ ';' + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
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
      puts 'Single thread hanoi;' + RUBY_ENGINE+ ';' + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
    end
  end

  desc 'Calculates 25 elements hanoi tower - ($numberOfCpuCores + 0..$numberOfCpuCores*3) threads | 50 times'
  task multi_hanoi: :environment do
    Facter.loadfacts
    processors_count = Facter.value(:processors).count
    require 'hanoi_towers'
    for times in 1..50
      start = Time.now.to_f
      0.upto(processors_count*3) do |i|
        1.upto(processors_count+i).map do |n|
          Thread.new {
            toh = HanoiTowers.new(25)
            toh.run
          }
        end.each(&:join)
        puts (processors_count+i).to_s + ' threads hanoi;'+ ';' + RUBY_ENGINE + RUBY_VERSION + ';' + (Time.now.to_f - start).to_s
      end
    end
  end
end