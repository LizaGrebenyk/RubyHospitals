class MainController < ApplicationController
    def index
        @hospitals = Hospital.all
        Rails.logger.info "=== Fetched #{@hospitals&.count} hospitals ==="
    rescue => e
        Rails.logger.error "=== Error occurred while fetching hospitals: #{e.message} ==="
    end
end
