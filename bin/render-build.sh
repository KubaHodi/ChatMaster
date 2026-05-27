#!/usr/bin/env bash

set -o errexit

echo "=== BUNDLE INSTALL ==="
bundle install

echo "=== DB PREPARE ==="
bin/rails db:prepare

echo "=== CHECK SOLID QUEUE ==="
bin/rails runner 'abort("Missing solid_queue_jobs") unless SolidQueue::Job.connection.data_source_exists?("solid_queue_jobs"); puts "Solid Queue tables OK"'

echo "=== ASSETS PRECOMPILE ==="
bin/rails assets:precompile

echo "=== ASSETS CLEAN ==="
bin/rails assets:clean