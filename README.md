# Ruby Implementations Performance Test

This repository is created for performance tests between Ruby, jRuby and Rubinius.
Tests runs single thread and multi thread tasks with few well-known math tasks.

Requirements:
Linux with RVM

How to run test?

select platform which you want test eg.: rvm use jruby

bundle

rake test:run

(go shopping, drink coffee, whatever...)

In output.csv you can find rows with format:

test name;ruby platform;ruby version;time spent in test (float)


##What we test?
Single and multi-thread fibonacci, factorial and hanoi tower.


##Want to display results?
Run rails server, google charts will do the job :confetti_ball:
