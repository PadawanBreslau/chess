# -*- encoding : utf-8 -*-
class Player < ActiveRecord::Base

  NAME_REGEX = /\A[\s[:alpha:]-]*\z/u
  FIDE_FILE_PATH = "public/standard_oct13frl.txt"

  #attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "400x400>", :thumb => "80x80>" }, :default_url => "/images/:style/example_player.png",                   :url  => "/assets/photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/player_photos/:id/:style/:basename.:extension"
  before_save :set_fide_id, if: proc {|player| player.fide_id.nil?}

  has_many :fide_ratings, foreign_key: :fide_id, primary_key: :fide_id


  validates :name, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}, uniqueness: {scope: :surname}
  validates :middlename, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}, allow_nil: true
  validates :surname, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}
  validates :fide_id, uniqueness: true, if: proc{|p| p.fide_id.present?}
  validates :photo, presence: false, attachment_content_type: { content_type: ["image/jpg","image/png"]}, attachment_size: { in: 0..3.megabytes }




private

  def set_fide_id
    File.open("#{Rails.root}/#{FIDE_FILE_PATH}").each_line do |line|
      @fide_id = extract_id_from_line(line) if line.match(name.parameterize.camelcase) && line.match(surname.parameterize.camelcase)
    end
    ST_LOG.info("Player found with fide_id: #{@fide_id}") if @fide_id
    self.fide_id = @fide_id
  end

  def extract_id_from_line(line)
    line =~ / /
    $`.to_i
  end

end
