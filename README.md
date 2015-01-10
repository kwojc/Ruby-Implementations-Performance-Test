# Ruby Implementations Performance Test

This repository is created for performance tests between Ruby, jRuby and Rubinius.
Tests runs single thread and multi thread tasks with few well-known math tasks.

Requirements:
Linux with RVM

How to run test?
select platform which you want test eg.: rvm use jruby
bundle
rake test:run > output.csv
(go shopping, drink coffee, whatever...)

In output.csv you can find rows with format:
test name;ruby platform;ruby version;time spent in test (float)


Want to display results?
Run rails server, google charts will do the job :confetti_ball:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
