# -*- encoding : utf-8 -*-
require 'timeout'
require 'open-uri'
require 'zip/zip'

class FideRating < ActiveRecord::Base

  validates :fide_id, numericality: true, presence: true, uniqueness: {scope: [:year, :month]}
  validates :year, numericality: true, presence: true, inclusion: 1950..Time.now.year
  validates :month, numericality: true, presence: true,  inclusion: 1..12
  validates :rating, numericality: true, presence: true, inclusion: 1000..3500

  belongs_to :player, primary_key: :fide_id, foreign_key: :fide_id

def self.download_and_parse_rating(year=Time.now.year, month=Time.now.month)
  raise ArgumentError.new("Invalid input parameter") if !year.kind_of?(Fixnum) || !month.kind_of?(Fixnum) || !(1..12).include?(month)
  year = year % 100
  zip_file_path = "public/assets/rating_lists/rating_list_#{year}_#{month}_#{Time.now.strftime("%d%m%y")}.zip"

  return false unless download_file(year, month, zip_file_path)
  parse_local_file(zip_file_path)
  add_rating_info_to_players(year, month)
end


private

def self.download_file(year, month, zip_file_path)
  File.open(zip_file_path, "wb") do |new_file|
    remote_url = "http://ratings.fide.com/download/standard_#{Date::ABBR_MONTHNAMES[month].downcase}#{year}frl_xml.zip"
    Timeout::timeout(10) do
      new_file << open(remote_url).read
    end
  end
rescue OpenURI::HTTPError
  return false
rescue Timeout::Error
  return false
end

def self.parse_local_file(zip_file_path)
  Zip::ZipFile.open(zip_file_path, Zip::ZipFile::CREATE) do |zipfile|
    zipfile.each do |file|
      basename = File.basename(file.name)
      tempfile = Tempfile.new(basename)
      tempfile.binmode
      tempfile.write file.get_input_stream.read
      @parsed_xml = Nokogiri::XML.parse(File.open tempfile)
    end
  end
  @parsed_xml
end

def self.add_rating_info_to_players(year, month)
  @parsed_xml.root.xpath('.//player').each do |node|
    fide_id = node.xpath('.//fideid').children.text.to_i
    rating = node.xpath('.//rating').children.text.to_i
    next unless Player.find_by_fide_id(fide_id).present?
    begin
      FideRating.create!(rating: rating, fide_id: fide_id, year: year+2000, month: month)
    rescue
      next
    end
  end
  true
end

end