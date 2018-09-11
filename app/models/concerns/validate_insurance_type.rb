module ValidateInsuranceType
  def insurance_type=(value)
    super value
  rescue ArgumentError => exception
    error_message = 'is not a valid insurance_type'
    if exception.message.include? error_message
      @insurance_type_backup = value
    else
      raise
    end
  end

  private

  def insurance_type_should_be_valid
    if @insurance_type_backup
      self.insurance_type = @insurance_type_backup
      error_message = 'should be Cyber Privacy Risk, Mobile & Tablet, or Social Media Account'
      errors.add(:insurance_type, error_message)
    end
  end
end
