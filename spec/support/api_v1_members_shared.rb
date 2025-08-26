RSpec.shared_context "members api setup" do
  let!(:admin_user)     { create(:user, :admin) }
  let!(:secretary_user) { create(:user, :secretary) }
  let!(:programmer_user){ create(:user, :programmer) }
end
