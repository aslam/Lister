class User < ActiveRecord::Base
    acts_as_authentic do |c|
        c.session_ids = [nil, :admin]
    end

    has_many :lists do
      def approved_count
        find(:all, :conditions => { :status => 'Approved'}).size
      end

      def rejected_count
        find(:all, :conditions => { :status => 'Rejected'}).size
      end
    end
    # validates_inclusion_of :role, :in => %w(user, admin)
end

