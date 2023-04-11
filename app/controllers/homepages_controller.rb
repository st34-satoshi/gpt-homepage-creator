class HomepagesController < ApplicationController
    before_action :save_access, only: [:show]

    def show
        message = Message.find_by(uuid: params[:id])
        raise ActionController::RoutingError.new('Not Found') if message.nil?
        message.increment!(:access_count, 1)
        html_text = message.html_text
        unless html_text
            logger.error "ERROR: cannot create html from gpt_message. message id = #{message.id}"
            render plain: "HTML作成に失敗しました。ホームページの作成をやり直してください。"
            return
        end
        render :html => html_text.html_safe
    end
end
