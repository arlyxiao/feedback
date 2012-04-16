class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SimpleCaptcha::ControllerHelpers
  helper :all
end
