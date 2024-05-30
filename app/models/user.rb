class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :patient, dependent: :destroy
  after_create :create_patient

  private

  def create_patient
    Patient.create(user: self, name: email, gender: 'User', date_of_birth: Date.today)
  end
end
