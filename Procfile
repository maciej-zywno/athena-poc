web: bundle exec puma -p $PORT -e ${RACK_ENV:-development}
worker: bundle exec sidekiq -e ${RACK_ENV:-development} -C ./config/sidekiq.yml