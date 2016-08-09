class User < ApplicationRecord
  has_secure_password

  RESERVED_NAMES = %w{ logout login register signup activate verify forgot reset resend_activation         verifying about terms unsubscribe account users session admin }

  validates :username,  uniqueness:   { case_sensitive: false },
                        presence:     true,
                        length:       { minimum: 4, maximum: 20 },
                        format:       { with: /\A[a-z0-9_-]+\z/i,
                                      message: 'only letters, numbers, - and _ are allowed' },
                        exclusion:    { in: RESERVED_NAMES,
                                        message: 'not available.' }

  validates :email,     uniqueness:   { case_sensitive: false },
                        presence:     true,
                        format:       { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                                      message: 'Invalid email format.' }

  validates :password,  length:       { minimum: 8, maximum: 22 },
                        format:       { with: /\A[a-z0-9_-]+\z/i },
                        allow_nil: true
end
