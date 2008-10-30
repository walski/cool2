require File.join(File.dirname(__FILE__), 'spec_helper')

require 'cool2/paragraphizer'
include Cool2::Tree

describe "Cool2::Paragraphizer" do
  it "should collapse text nodes when cleaned" do
    text = fixture(:paragraphs)
    parser = Cool2::Parser.new(text)
    parser.class.class_eval do
      include Cool2::Paragraphizer
    end
    parser.paragraphize!

    parser.should look_like_tree([
      Text, "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis",
      Text, "nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu\nfugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in",
      Text, "culpa qui officia deserunt mollit anim id est laborum."
    ])
  end
end