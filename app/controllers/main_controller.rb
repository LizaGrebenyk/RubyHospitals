class MainController < ApplicationController
    def index
        @hospitals = Hospital.all
    end
end