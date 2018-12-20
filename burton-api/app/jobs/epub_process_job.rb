class EpubProcessJob < ActiveJob::Base
  queue_as :default

  def perform(book)

    base_url = Rails.application.secrets.base_url.to_s + "books/#{book.uuid}/extract/"

    # Unzip Archive
    epub_path = Rails.public_path.join(book.epub.path)
    dest_path = Rails.public_path.join('books', book.uuid, 'extract')

    system "unzip #{epub_path} -d #{dest_path}"

    # Locate & Parse *.opf

    Dir.chdir(dest_path)

    opf_path = Dir.glob("**/*.opf")[0]
    opf = File.open(opf_path) { |f| Nokogiri::XML(f) }

    book.url = base_url + opf_path

    opf.remove_namespaces!

    book.title = opf.css('title').text.strip
    book.description = opf.css('description').text.strip

    cover = opf.xpath('//*[@id="cover-image"]').attr('href').text
    cover_path = Dir.glob("**/#{cover}")[0]
    book.cover = base_url + cover_path

    # Update Changes
    book.save


    # Create Resume Record

    resume = Resume.new
    resume.user_id = book.user_id
    resume.book_id = book.id
    resume.save

  end
end
