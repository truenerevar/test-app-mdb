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

  def valid_time?(string)
    Time.parse(string)
    true
  rescue ArgumentError
    false
  end

  def fetch_users

    users = User.order("#{sort_column} #{sort_direction}")
    users = users.page(page).per(per_page)

    condition = /#{params[:search][:value]}/i
    query = [{:first_name => condition},{last_name: condition}, {address: condition}] 
    query << {birthday: Date.parse(params[:search][:value])} if valid_time?(params[:search][:value])
    users.or(query)

  end

  def columns
    %w(first_name last_name birthday address)
  end
end