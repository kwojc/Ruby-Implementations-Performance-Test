namespace :math do
  desc "Calculates Fibonacci of 30 - one time in one thread"
  task single_fibo: :environment do
    start = Time.now.to_f
    MyMath.fibonacci 30
    puts 'math_single_fibo:' + (Time.now.to_f - start).to_s
  end

  desc "Calculates factorial of 20 - one time in one thread"
  task single_factorial: :environment do
    start = Time.now.to_f
    MyMath.factorial 20
    puts 'math_single_factorial:' + (Time.now.to_f - start).to_s
  end


  desc "Calculates Fibonacci of 30 - $numberOfCpuCores * 2 times"
  task double_of_cpu_fibo: :environment do
    Facter.loadfacts
    start = Time.now.to_f
    1.upto(Facter.value(:processors).count*2).map do |n|
      Thread.new { puts "Thread #{n}: #{sleep(0.5)}" }
    end.each(&:join)
    puts 'math_single_factorial:' + (Time.now.to_f - start).to_s
  end
end
