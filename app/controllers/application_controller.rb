class ApplicationController < ActionController::Base
    def health
        render status: 200, json: { status: 200, message: "OK" }
    end
end
