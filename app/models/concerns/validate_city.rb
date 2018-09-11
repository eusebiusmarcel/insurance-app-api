module ValidateCity
  def city=(value)
    super value
  rescue ArgumentError => exception
    error_message = 'is not a valid city'
    if exception.message.include? error_message
      @city_backup = value
    else
      raise
    end
  end

  private

  def city_should_be_valid
    if @city_backup
      self.city = @city_backup
      error_message = 'should be Jakarta, Bandung, Yogyakarta, Surabaya, or Bali'
      errors.add(:city, error_message)
    end
  end
end
