class MainController < ApplicationController
    include ApplicationHelper
    def index
        get_user
    end
end
