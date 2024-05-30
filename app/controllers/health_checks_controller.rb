class HealthChecksController < ApplicationController
  def index
    database_result = check_database
    migrations_result = check_migrations
    cache_result = check_cache
    # env_vars_result = check_environment_variables

    if database_result == 'OK' && migrations_result == 'OK' && cache_result == 'OK' #&& env_vars_result == 'OK'
      render json: {
        code: 200,
        status: {
          database: database_result,
          migrations: migrations_result,
          cache: cache_result,
          # environment_variables: env_vars_result
        }
      }
    else
      render json: {
        code: 503,
        error: 'Service Unavailable',
        status: {
          database: database_result,
          migrations: migrations_result,
          cache: cache_result,
          # environment_variables: env_vars_result
        }
      }, status: :service_unavailable
    end
  end

  private

  def check_database
    ActiveRecord::Base.connection.execute('select 1')
    'OK'
  rescue StandardError => e
    "Error: #{e.message}"
  end

  def check_migrations
    ActiveRecord::Migration.check_pending!
    'OK'
  rescue StandardError => e
    "Error: #{e.message}"
  end

  def check_cache
    Rails.cache.read('some_key')
    'OK'
  rescue StandardError => e
    "Error: #{e.message}"
  end

  # def check_environment_variables
  #   required_vars = %w[ENV_NAME ANOTHER_ENV]
  #   missing_vars = required_vars.select { |var| ENV[var].blank? }

  #   if missing_vars.empty?
  #     'OK'
  #   else
  #     "Missing environment variables: #{missing_vars.join(', ')}"
  #   end
  # end
end
