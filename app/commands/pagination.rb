module Pagination
  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 10
  end

  def pagination(records)
    {
      page: records.current_page,
      per_page: records.limit_value,
      next_page: records.next_page,
      total_page: records.total_pages
      total_count: records.total_count
    }
  end
end
