class Moddable
  attr_accessor :name
  @@all = []
  def initialize(name)
    @name = name
    self.save
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def self.create(name)
    self.Class.new(name)
  end
  def save
    self.Class.all << self
  end
end
