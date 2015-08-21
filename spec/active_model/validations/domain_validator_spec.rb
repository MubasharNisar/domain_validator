require 'spec_helper'
require 'test_classes/domain'

module ActiveModel
  module Validations
    describe DomainValidator do
      let(:domain) { TestDomain.new }

      describe "validations" do
        # for blank domain
        it { expect(domain).to be_valid }

        describe 'valid' do

          it {
            domain.domain_name = 'this-should-be-valid.com'
            expect(domain).to be_valid
          }

          it "could start with letter" do
            domain.domain_name = "correct.com"
            expect(domain).to be_valid
          end

          it "could start with number" do
            domain.domain_name = "4correct.com"
            expect(domain).to be_valid
          end

          it "should be valid for domain with full length 253 and max length per label 63" do
            domain.domain_name = "#{'a'*63}.#{'b'*63}.#{'c'*63}.#{'d'*57}.com"
            expect(domain).to be_valid
          end

          it {
            domain.domain_name = "#{'w'*63}.com"
            expect(domain).to be_valid
          }

          it "should be valid with TLD [.com, .com.ua, .co.uk, .travel, .info, etc...]" do
            %w(.com .com.ua .co.uk .travel .info).each do |tld|
              domain.domain_name = "domain#{tld}"
              expect(domain).to be_valid
            end
          end

          it "should be valid if TLD length is between 2 and 6" do
            %w(ua museum).each do |tld|
              domain.domain_name = "domain.#{tld}"
              expect(domain).to be_valid
            end
          end

          it "should be valid for custom length and label length" do
            domain.domain_name = "valid-domain.com"
            expect(domain).to be_valid
          end

          it "should be valid with unknown TLD" do
            domain.domain_name = "valid-domain.abcabc"
            expect(domain).to be_valid
          end

        end

        describe 'invalid' do
          it "should be invalid if domain length is too short" do
            domain.domain_name = 'a.b'
            expect(domain).to_not be_valid
            expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.short')
          end

          it 'should be invalid if domain length is too long' do
            [
              "not-valid-because-of-length-#{'w'*230}.com",
              "not-valid-because-of-length-of-label#{'w'*230}.com"
            ].each do |domain_name|
              domain.domain_name = domain_name
              expect(domain).to_not be_valid
              expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.long')
            end
          end

          it 'should be invalid if label length is too long' do
            domain.domain_name = "#{'w'*64}.com"
            expect(domain).to_not be_valid
            expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.invalid')
          end

          it "should be invalid if consists of special symbols (&, _, {, ], *, etc)" do
            domain.domain_name = "&_{]*.com"
            expect(domain).to_not be_valid
            expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.invalid')
          end

          it "should not start with special symbol" do
            domain.domain_name = "_incorrect.com"
            expect(domain).to_not be_valid
            expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.invalid')
          end

          it "should not be valid with TLD length more than 6" do
            domain.domain_name = "domain.abcabcd"
            expect(domain).to_not be_valid
            expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.invalid')
          end

          it "should not be valid if TLD consists of numbers or special symbols (&, _, {, ], *, etc)" do
            %w(2 & _ { ] *).each do |tld|
              domain.domain_name = "domain.a#{tld}"
              expect(domain).to_not be_valid
              expect(domain.errors[:domain_name]).to include I18n.t(:'errors.messages.domain.invalid')
            end
          end

        end
      end
    end
  end
end
