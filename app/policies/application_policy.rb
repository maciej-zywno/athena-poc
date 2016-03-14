class ApplicationPolicy
  attr_reader :user, :record

  delegate :admin?, :doctor?, :patient?, to: :user

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  class << self
    %w(admin doctor patient).each do |role|
      define_method("permit_#{role}_to") do |*actions|
        actions.each do |action|
          define_method("#{action}?") do
            eval("#{role}?")
          end
        end
      end
    end
  end
end
