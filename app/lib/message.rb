class Message
  def self.unauthorized
      'Anda tidak diizinkan untuk melakukan aksi ini.'
  end

  def self.link_expired
    'Link tidak valid atau telah expired, mohon ulang proses Forgot Password.'
  end

  def self.email_sent
    'Email telah dikirim, periksa email Anda.'
  end

  def self.reset_password_succeed
    'Password telah diubah, silahkan login kembali'
  end

  def self.invalid_email
    'Email salah.'
  end

  def self.invalid_password
    'Password salah.'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end
end
