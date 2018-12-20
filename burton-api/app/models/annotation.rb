class Annotation < ActiveRecord::Base

  serialize :ranges, Array

end
