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

  def self.user_email_unregistered
    'Email user tidak terdaftar'
  end

  def self.phone_regex
    'harus diawali dengan angka 62'
  end

  def self.policy_number_regex
    'diawali dengan 3 huruf, dilanjut dengan dash, dan 9 angka, contoh: MDF-123456789'
  end

  def self.policy_number_not_found
    'nomor polis tidak ditemukan'
  end

  def self.no_imported_file
    'tolong masukkan file yang ingin diimport'
  end

  def self.already_registed_as_user
    'email telah terdaftar sebagai user, silahkan hubungi agen anda bila ingin membuat polis yang baru'
  end
end
