class User < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :admin
  has_secure_password

  has_many :explanations
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_reputation :votes, source: {reputation: :votes, of: :explanations}, aggregated_by: :sum
  has_many :comments

  # this line was from skoglund; don't think i need it with hartl-style user authentication
  # attr_accessor :password

  ############
  # THESE ARE MY HARTL VALIDATIONS, email regex, before_save/after_save
  # before_save { |user| user.email = email.downcase }
  before_save { email.downcase! }
  before_save :create_remember_token

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  # END HARTL VALIDATIONS AND BEFORE_SAVE/AFTER_SAVE
  ####################

  ############
  # THESE WERE MY SKOGLUND VALIDATIONS, email regex, before_save/after_save

  # EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  # new "sexy" validations
  # validates :first_name, :presence => true, :length => { :maximum => 25 }
  # validates :last_name, :presence => true, :length => { :maximum => 50 }
  # validates :username, :length => { :within => 8..25 }, :uniqueness => true
  # validates :email, :presence => true, :length => { :maximum => 100 }, 
  #   :format => EMAIL_REGEX, :confirmation => true
  # validates :password, :presence => true, :confirmation => true

  # only on create, so other attributes of this user can be changed
  # validates_length_of :password, :within => 8..25, :on => :create, :on => :update
  # validates_confirmation_of :password, :on => :create
  # validates_presence_of :password_confirmation, :on => :create

  # before_save :create_hashed_password
  # after_save :clear_password

  # END SKOGLUND VALIDATIONS AND BEFORE_SAVE/AFTER_SAVE
  ####################

  # scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("users.last_name ASC, users.first_name ASC")

  def name
    "#{first_name} #{last_name}"
  end

  def voted_for?(explanation)
    evaluations.exists?(target_type: explanation.class, target_id: explanation.id)
    # note: the line above used to be (but i changed it per comment on ryan bates video):
    # evaluations.where(target_type: haiku.class, target_id: haiku.id).present?
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
