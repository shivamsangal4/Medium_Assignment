# config/initializers/stripe.rb
Rails.configuration.stripe = {
    publishable_key: 'pk_test_51NbePvSFSvQjpfBnW7eXcGKPzuqCXAO4wSiRXIqFXeGFidhjkkJOIhXyxH38akxplgOvdIyLYSsXr34dDkgdOIbb002iH99PIK',
    secret_key: 'sk_test_51NbePvSFSvQjpfBn3xf5RCrbpKTmue78A3HPGbZ7aUIfQFsz8oDjjaUeQIPW4NnHL5FnREqspW6ooPFrJ7QrlOUz001atXc0Si'
  }
  
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
  