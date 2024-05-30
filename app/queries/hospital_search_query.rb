class HospitalSearchQuery
  def initialize(title)
    @title = title.downcase
  end

  def call
    Hospital.where('LOWER(title) LIKE ?', "%#{@title}%")
  end
end
