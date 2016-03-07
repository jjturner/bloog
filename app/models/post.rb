class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :blog, :title, :body, :pubdate

  def initialize(attrs = {})
    attrs.each do |k,v|
      send("#{k}=", v)
    end
  end

  def persisted?
    false
  end

  # --> DI is about making it possible to pass
  # --> an object's collaborators in from the outside
  # this method utilizes 'parameter injection'
  # in order to pass in a Clock object
  def publish(clock=DateTime)
    self.pubdate = clock.now
    blog.add_entry(self)
  end
end
