class Player < ActiveRecord::Base

  attr_accessor :name, :surname, :middlename, :fide_id
  NAME_REGEX = /\A[\s[:alpha:]-]*\z/u
  FIDE_FILE_PATH = "public/standard_oct13frl.txt"

  validates :name, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}
  validates :middlename, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}, allow_nil: true
  validates :surname, presence: true, format: { with: NAME_REGEX }, length: {minimum: 2, maximum: 32}

  before_save :set_fide_id, if: proc {|player| player.fide_id.nil?}


private

  def set_fide_id
    File.open("#{Rails.root}/#{FIDE_FILE_PATH}").each_line do |line|
      @fide_id = extract_id_from_line(line) if line.match(name.parameterize.camelcase) && line.match(surname.parameterize.camelcase)
    end
    self.fide_id = @fide_id
  end

  def extract_id_from_line(line)
    line =~ / /
    $`.to_i
  end

end
