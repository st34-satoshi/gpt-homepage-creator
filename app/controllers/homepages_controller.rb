class HomepagesController < ApplicationController
    def show
        message = Message.find_by(uuid: params[:id])
        raise ActionController::RoutingError.new('Not Found') if message.nil?
        html_text = message.html_text
        raise ActionController::RoutingError.new('Not Found') unless html_text
        render :html => html_text.html_safe
    end
end
