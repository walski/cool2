require File.join(File.dirname(__FILE__), 'spec_helper')

include Cool2::Tree
describe "Cool2 Tree" do

  describe "Text" do
    it "Should be able to translate a plain text" do
      text = fixture(:plain_text)
      parser = Cool2::Parser.new(text)

      parser.should look_like_tree([
        Text, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor',
        Text, 'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
        Text, 'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        Text, 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore',
        Text, 'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,',
        Text, 'sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ])

    end
  end

  describe "Lists" do
    it "should translate a very simple list to a flat tree" do
      list   = fixture(:very_simple_list)
      parser = Cool2::Parser.new(list)

      parser.should look_like_tree([
        List, [Text, 'One'],
        List, [Text, 'Two'],
        List, [Text, 'Three'],
        List, [Text, 'Four']
      ])
    end

    it "should translate a simple (flat) list with multi line texts to a flat tree" do
      list   = fixture(:multi_line_simple_list)
      parser = Cool2::Parser.new(list)

      parser.should look_like_tree([
        List, [Text, 'One'],
        List, [Text, "Two", Text, "Another Two", Text, "And again Two"],
        List, [Text, "Three", Text, "And three has Four lines, too!"],
        List, [Text, "Four"]
      ])    
    end

    it "should be able to translate a nested list" do
      list   = fixture(:nested_list)
      parser = Cool2::Parser.new(list)

      parser.should look_like_tree([
        List, [Text, 'One',
           List, [Text, 'One.One',
             List, [Text, 'One.One.One'],
             List, [Text, 'One.One.Two'],
             List, [Text, 'One.One.Three']],
           List, [Text, 'One.Two']
        ],
        List, [Text, 'Two',
           List, [Text, 'Two.One'],
           List, [Text, 'Two.Two',
             List, [Text, 'Two.Two.One']],
        ],
        List, [Text, 'Three'],
        List, [Text, 'Four',
          List, [Text, 'Four.One'],
          List, [Text, 'Four.Two']
        ]
      ])
    end
  end

  describe "Title" do
    it "should translate a simple title" do
      text   = fixture(:simple_title)
      parser = Cool2::Parser.new(text)

      parser.should look_like_tree([
        Title, 'A title'
      ])

    end

    it "should translate a title and subtitle" do
      text   = fixture(:title_and_subtitle)
      parser = Cool2::Parser.new(text)

      parser.should look_like_tree([
        Title,    'A title',
        Text,     'A sample text schalalal this is sooooo',
        Text,     'SAAAAAMPLE! Always sample!',
        Subtitle, 'A suuuby subtitle',
        Text,     'And subtitlelieyeah!'
      ])
    end
  end

  describe "All togehter" do
    it "should translate a mix up correctly" do
      text   = fixture(:all_together)
      parser = Cool2::Parser.new(text)

      parser.should look_like_tree([
        Title, 'Some Title',
        Subtitle, 'And a subcategory',
        Text, 'With some beautiful text! I love it when I run my specs and everything is',
        Text, 'sooooooo green!',
        Text, 'Fantastic! I don\'t really know what to do! Exciting!',
        Subtitle, 'Another category',
        Text, 'Here we have:',
        Text, '',
        List, [Text, 'First some List',
               List, [Text, 'With sublists',
                      List, [Text, 'And Sublists of sublists'],
                      List, [Text, 'Yeah it\'s true!']],
               List, [Text, 'Amazing']],
        List, [Text, 'Really cooL!'],
        List, [Text, 'Again, it rocks!'],
        Text, '',
        Text, 'And than there is another Text',
        Text, '',
        Title, 'And another Title',
        List, [Text, 'With a simple list'],
        List, [Text, 'I think'],
        List, [Text, 'that\'s'],
        List, [Text, 'it'],
        Text, 'Fin!'
      ])
    end
  end
end
