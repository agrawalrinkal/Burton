class Book < ActiveRecord::Base

  has_attached_file :epub,
    :path => ':class/:uuid/:filename'
  validates_attachment_content_type :epub, content_type: ['application/epub+zip']

  belongs_to :user

end
