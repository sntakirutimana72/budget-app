require 'warden'

module DeviseSpecHelpers
  include Warden::Test::Helpers

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    login_as(resource, scope:)
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end

  def auto_sign_out(resource_or_scope, resource = nil)
    sign_in(resource_or_scope, resource)
    yield
    sign_out(resource_or_scope)
  end
end
