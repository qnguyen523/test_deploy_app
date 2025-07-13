# filepath: /Users/csteam/Documents/github/test_deploy_app/Dockerfile
FROM ruby:3.2.6

# Set environment variables
ENV RAILS_ENV=development
ENV RAILS_LOG_TO_STDOUT=true

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copy the rest of the app
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]