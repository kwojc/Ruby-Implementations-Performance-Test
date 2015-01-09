class HanoiTowers
  FROM = 0
  TO = 1
  HELP_STACK = 2

  def initialize(n)
    @n = n
    @stacks = []
    @stacks[FROM] = (1..@n).to_a.reverse
    @stacks[TO] = []
    @stacks[HELP_STACK] = []
  end

  def move(from, to, n)
    #puts @stacks.to_s
    if n == 1
      @stacks[to].push(@stacks[from].pop)
    elsif n > 1
      help = ([FROM, TO, HELP_STACK] - [from, to])[0]
      move(from, help, n-1)
      move(from, to, 1)
      move(help, to, n-1)
    end
  end

  def run
    move(FROM, TO, @n)
  end

  def stacks
    @stacks
  end
end