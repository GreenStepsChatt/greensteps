module SynchronizationHelper
  def wait_for_ajax
    wait_until { finished_all_ajax_requests? }
  end

  def wait_for_animations
    wait_until { finished_all_animations? }
  end

  def wait_for_css(*args)
    page.find(*args)
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def finished_all_animations?
    page.evaluate_script('$(":animated").length').zero?
  end

  def wait_until
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until yield
    end
  end
end

RSpec.configure do |config|
  config.include SynchronizationHelper, type: :feature
end
