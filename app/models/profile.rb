class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_or_last_name, :male_is_not_sue
  validates :gender, inclusion: { in: %w{male female}, message: "%{value} must be male or female" }

  def first_or_last_name
  	if first_name.nil? && last_name.nil?
  		errors.add(:first_name, "cannot be nil with last_name.")
  	end
  end

  def male_is_not_sue
  	if gender == 'male' && first_name == "Sue"
  		errors.add(:first_name, "cannot be Sue for male.")
    end
  end

  scope :get_all_profiles, -> (min, max) { where("birth_year BETWEEN :min_year AND :max_year", min_year: min, max_year: max).order(:birth_year) }
end
