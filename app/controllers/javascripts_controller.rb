class JavascriptsController < ApplicationController
    def dynamic_categories
        @categories = Category.find(:all, :conditions => ["parent_id > 0"])
    end

    def dynamic_cities
        @cities = City.all
    end
end

