class HomepagesController < ApplicationController
    def show
        # TODO: message = Message.first
        render :html => "<!DOCTYPE html><html>hello</html>".html_safe
    end
end
