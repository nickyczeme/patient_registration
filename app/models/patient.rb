class Patient < ApplicationRecord
  has_one_attached :document_photo
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
end
