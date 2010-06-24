# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def javascript(*files)
        content_for(:head) { javascript_include_tag(*files) }
    end

    def stylesheet(*files)
        content_for(:head) { stylesheet_link_tag(*files) }
    end

    def display_categories(categories)
        ret = "<ul>"
        for category in categories
            if category.parent.nil?
                ret += "<li>"
                ret += link_to category.name
                ret += find_all_subcategories(category).to_s
                ret += "</li>"
            end
        end
        ret += "</ul>"
    end

    def find_all_subcategories(category)
        if category.children.size > 0
            ret = "<ul>"
            category.children.each { |subcat|
                if subcat.children.size > 0
                    ret += "<li>"
                    ret += link_to h(subcat.name), :action => 'edit', :id => subcat
                    ret += find_all_subcategories(subcat)
                    ret += "</li>"
                else
                    ret += "<li>"
                    ret += link_to h(subcat.name), :action => 'edit', :id => subcat
                    ret += "</li>"
                end
            }
            ret += "</ul>"
        end
    end
end

