module ValidateGender
  def gender=(value)
    super value
  rescue ArgumentError => exception
    error_message = 'is not a valid gender'
    if exception.message.include? error_message
      @gender_backup = value
    else
      raise
    end
  end

  private

  def gender_should_be_valid
    if @gender_backup
      self.gender = @gender_backup
      error_message = 'seharusnya perempuan (P) atau laki-laki (L)? Masukkan L/P'
      errors.add(:gender, error_message)
    end
  end
end
