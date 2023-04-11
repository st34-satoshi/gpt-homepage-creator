class ApplicationController < ActionController::Base

    def health
        render status: 200, json: { status: 200, message: "OK" }
    end

    def save_access
        Access.create(
            ip_address: request.remote_ip,
            user_agent: request.user_agent,
            referer: request.referer,
            params: params
        )
    end
end
