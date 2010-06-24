class User < ActiveRecord::Base
    acts_as_authentic do |c|
        c.session_ids = [nil, :admin]
    end

    # validates_inclusion_of :role, :in => %w(user, admin)
end

