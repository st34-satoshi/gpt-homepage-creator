class ApplicationController < ActionController::Base
    def health
        GptJob.perform_later
        render status: 200, json: { status: 200, message: "OK" }
    end
end
