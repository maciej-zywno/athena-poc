class InviteUserService
  def self.call(attributes: {}, invited_by:)
    User.invite!(attributes, invited_by)
  end
end
