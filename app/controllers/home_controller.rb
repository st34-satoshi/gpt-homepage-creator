class HomeController < ApplicationController
    before_action :save_access, only: [:index]

    def main; end
end
