module ValidateClaimStatus
  def status=(value)
    super value
  rescue ArgumentError => exception
    error_message = 'is not a valid status'
    if exception.message.include? error_message
      @status_backup = value
    else
      raise
    end
  end

  private

  def status_should_be_valid
    if @status_backup
      self.status = @status_backup
      error_message = 'value must be Requirements Accepted (0), On Process (1), Success (2), or Rejected (3)'
      errors.add(:status, error_message)
    end
  end
end
