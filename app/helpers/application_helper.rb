module ApplicationHelper
  def datetime_md(datetime)
    return datetime unless datetime
    datetime.strftime("%m/%d")
  end

  def datetime_mdhm(datetime)
    return datetime unless datetime
    datetime.strftime("%m/%d %H:%M")
  end
end
