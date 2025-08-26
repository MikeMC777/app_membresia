module MembersHelper
  def member_status_text(member)
    member.status_human
  end

  def member_gender_text(member)
    member.gender_human
  end

  def member_marital_status_text(member)
    member.marital_status_human
  end

  def member_full_name(member)
    member.full_name
  end

  def member_age(member)
    return nil if member.birth_date.blank?
    today = Time.zone.today
    age = today.year - member.birth_date.year
    age -= 1 if Date.new(today.year, member.birth_date.month, member.birth_date.day) > today
    age
  end
end

