module UsersHelper
  def find_customer u_id
    @user = User.find_by_id u_id
  end
end
