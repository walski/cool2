begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

class LookLikeTree
  require 'enumerator'
  
  def initialize(expected)
    @expected = expected
  end
  
  
  def matches?(target)
    @target = target
    @tree   = @target.tree

    tree_matches?(@tree, @expected)
  end

  def failure_message
    "expected #{@expected.inspect} but got #{@target.tree.content.map {|e| e.class}.inspect}"
  end
  
  private 
  def tree_matches?(tree, expected)
    return false unless tree.content.size == expected.size / 2
    i = 0
    expected.each_slice(2) do |expected_class, expected_content|
      return false unless tree.content[i].class == expected_class
      
      if expected_content.class == Array
        return false unless tree_matches?(tree.content[i], expected_content)
      else
        return false unless tree.content[i].content == expected_content
      end
      i += 1
    end

    true
  end
end

def look_like_tree(expected)
    LookLikeTree.new(expected)
  end


def fixture(fixture_name)
  content = ''
  File.open("#{File.dirname(__FILE__)}/fixtures/#{fixture_name}.txt", 'r') do |f|
    while !f.eof?
      content << f.gets
    end
  end
  content
end

 
require File.join(File.dirname(__FILE__), '..', 'lib', 'cool2')
