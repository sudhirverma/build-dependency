# Copyright, 2017, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative 'package'

RSpec.describe Build::Dependency do
	describe "test packages" do
		let(:a) do
			Package.new('Library/Frobulate').tap do |package|
				package.provides 'Test/Frobulate' do
				end
			end
		end
		
		let(:b) do
			Package.new('Library/Barbulate').tap do |package|
				package.provides 'Test/Barbulate' do
				end
			end
		end
		
		it "should resolve all tests" do
			chain = Build::Dependency::Chain.expand(['Test/*'], [a, b])
			expect(chain.ordered.collect(&:provider)).to be == [a, b]
			expect(chain.unresolved).to be == []
		end
	end
end