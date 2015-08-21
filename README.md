Domain Validator [![Travis](https://secure.travis-ci.org/Shuttlerock/domain_validator.png)](http://travis-ci.org/Shuttlerock/domain_validator) [![Code Climate](https://codeclimate.com/github/Shuttlerock/domain_validator/badges/gpa.svg)](https://codeclimate.com/github/Shuttlerock/domain_validator)
============================

This is a ActiveModel validator for domains.

Installation
------------
    gem install domain-validator

Usage
-------

In your models, the gem provides new :domain validator

    class Model < ActiveRecord::Base
      validates :domain_name, domain: true
    end


Domain Validator
----------------

    validates :domain_name, domain: true

    validates :domain_name, domain: { message: 'custom message' }

Localization Tricks
-------------------
To customize error message, you can use { message: "your custom message" } or simple use Rails localization en.yml file, for instance:

    en:
      errors:
        messages:
          domain:
            long: "your custom length error message"
      activemodel:
        errors:
          messages:
            domain:
              invalid: "custom error message only for activemodel"
           models:
             your_model:
               domain:
                 invalid: "custom error message for YourDomain model"


Copyright
---------

Copyright 2015 Shuttlerock Ltd. See LICENSE for details.
