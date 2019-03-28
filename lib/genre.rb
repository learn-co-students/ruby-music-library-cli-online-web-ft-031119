# require_relative '../lib/moddable.rb'
class Genre
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
    self.new(name)
  end
  def save
    self.class.all << self
  end
end
