class Payment < ApplicationRecord
  belongs_to :user

  validates_presence_of :name,:user
  validates :card_number, presence: true, credit_card_number: true
  validate :validate_expiration_date

  def set_expiration_date(expiration_date_param)
    return unless expiration_date_param.present?
    begin
      self.expiration_date  = expiration_date_param.to_date.end_of_month
    rescue Date::Error => e
      puts "Error while parsing date. #{e.message}"
    end
    
  end

  private
  
  def validate_expiration_date
    if self.expiration_date.present?
      begin
        if self.expiration_date < Date.today
          errors.add(:expiration_date, "cannot be less than current month")
        end
      rescue Date::Error => e
        puts "Error while parsing date. #{e.message}"
        errors.add(:expiration_date, ": Please provide a valid date in mm/yyyy format")
      end
    else
      errors.add(:expiration_date, ": Please provide a valid date in mm/yyyy format")
    end
  end

end
