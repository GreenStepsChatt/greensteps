class ApplicationForm
  include ActiveModel::Model

  def save
    if valid?
      yield
    else
      false
    end
  end
end
