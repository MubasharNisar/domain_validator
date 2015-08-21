class TestDomain
  include ActiveModel::Validations

  validates :domain_name, domain: true

  attr_accessor :domain_name
end
