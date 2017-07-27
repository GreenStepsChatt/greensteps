module BrowserHelpers
  def click_browser_back_button
    page.evaluate_script('window.history.back()')
  end
end

RSpec.configure do |config|
  config.include BrowserHelpers, type: :feature
end
