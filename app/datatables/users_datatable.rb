class UsersDatatable < ApplicationDatatable

  private

  def data
    users.map do |user|
      [].tap do |column|
        column << user.first_name
        column << user.last_name
        column << user.birthday
        column << user.address
      end
    end
  end

  def count
    User.count
  end

  def total_entries
    users.total_count
  end

  def users
    @users ||= fetch_users    

  end

  def fetch_users
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    users = User.order("#{sort_column} #{sort_direction}")
    users = users.page(page).per(per_page)
    
    condition = /#{params[:search][:value]}/i
    users = users.or({:first_name => condition}).or({last_name: condition}).or({birthday: condition}).or({address: condition})  
  end

  def columns
    %w(first_name last_name birthday address)
  end
end