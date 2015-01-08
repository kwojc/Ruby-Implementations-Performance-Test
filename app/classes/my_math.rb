class MyMath
  def self.fibonacci(n)
    return n if (0..1).include? n
    (self.fibonacci(n - 1) + self.fibonacci(n - 2))
  end

  def self.factorial(n)
    return 1 if n <= 1
    n * self.factorial(n - 1)
  end
end