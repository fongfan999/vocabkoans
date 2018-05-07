class Bot::Base::Deliverer
  include Service

  attr_reader :user

  def initialize(user)
    @user = user
  end

  private

  def recipient
    { id: user.messenger_uid }
  end
end
