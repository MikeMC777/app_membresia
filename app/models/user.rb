class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  # Devise modules (ajustá según lo que uses realmente)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :member, inverse_of: :user

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  validates :member, presence: true

  # Roles globales

  # Cache ligero de nombres de rol para evitar múltiples queries
  def global_role_names
    @global_role_names ||= roles.pluck(:name)
  end

  def has_global_role?(role_name)
    global_role_names.include?(role_name.to_s)
  end

  def admin?
    has_global_role?("admin")
  end

  def secretary?
    has_global_role?("secretary")
  end

  def programmer?
    has_global_role?("programmer")
  end

  def need_change_password?
    false
  end
end
