#!/usr/bin/env bash

set -o errexit

bundle install

bin/rails db:prepare
bin/rails runner 'abort("Missing solid_queue_jobs") unless SolidQueue::Job.connection.data_source_exists?("solid_queue_jobs"); puts "Solid Queue tables OK"'

bin/rails assets:precompile
bin/rails assets:clean