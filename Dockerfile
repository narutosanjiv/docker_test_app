FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential nodejs

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/docker_example
 
# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids
 
# Set our working directory inside the image
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
 
COPY Gemfile.lock Gemfile.lock

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler
 
# Finish establishing our Ruby enviornment
RUN bundle install
 
# Copy the Rails application into place
COPY . ./
EXPOSE 3001

#RUN bundle exec unicorn -c config/containers/unicorn.rb -E production -D


#CMD ["bundle", "exec", "unicorn", "-c", "config/containers/unicorn.rb", "-E", "production"]
# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
#ENTRYPOINT ["config/containers/app_cmd.sh"]
#CMD "config/containers/app_cmd.sh"