class User < ApplicationRecord
  # Devise modules, según los habilitados
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :member

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :team_roles, dependent: :destroy
  has_many :teams, through: :team_roles

  # Helpers para roles globales
  def has_role?(role_name)
    roles.any? { |role| role.name == role_name.to_s }
  end

  def admin?
    has_role?("admin")
  end

  def secretary?
    has_role?("secretary")
  end

  def programmer?
    has_role?("programmer")
  end

  # Helpers para roles por equipo
  def role_in_team(team)
    team_roles.find_by(team: team)&.role
  end

  def encargado_de?(team)
    role_in_team(team) == "encargado"
  end

  def asistente_de?(team)
    role_in_team(team) == "asistente"
  end

  def auxiliar_de?(team)
    role_in_team(team) == "auxiliar"
  end

  def integrante_de?(team)
    role_in_team(team) == "integrante"
  end
end
