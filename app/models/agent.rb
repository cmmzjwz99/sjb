class Agent < ActiveRecord::Base
  self.table_name='users'

  class_attribute :salt

  def self.salt
    '20ac4d290c2293702c64b3b287ae5ea79b26a5c1'
  end

  def self.password_hash(pass)
    Digest::SHA1.hexdigest("#{salt}--#{pass}--")
  end

  before_create :crypt_password

  before_create :crypt_verify_password

  def crypt_password
    # EmailNotify.send_user_create_notification self
    self[:password] =
        password_hash(password(true))
    @password = nil
  end

  def crypt_verify_password
    if verify_password(true).empty?
      self[:verify_password] =  self[:password]
    else
      self[:verify_password] = password_hash(verify_password(true))
      @verify_password = nil
    end
  end

  before_update :crypt_unless_empty

  def crypt_unless_empty
    if password(true).empty?
      user = self.class.find(id)
      self[:password] = user.password
    else
      crypt_password
    end

    if verify_password(true).empty?
      user = self.class.find(id)
      self[:verify_password] = user.verify_password
    else
      crypt_verify_password
    end

  end

  attr_writer :password

  attr_writer :verify_password

  def password(cleartext = nil)
    if cleartext
      @password.to_s
    else
      @password || self[:password]
    end
  end

  def verify_password(cleartext = nil)
    if cleartext
      @verify_password.to_s
    else
      @verify_password || self[:verify_password]
    end
  end

  protected

  def password_hash(pass)
    self.class.password_hash(pass)
  end

end