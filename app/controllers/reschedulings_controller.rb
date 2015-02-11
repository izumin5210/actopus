class ReschedulingsController < ApplicationController

  layout 'unsignedin_users'

  def index
    @reschedulings = Rescheduling.available.includes(
        lecture: [:lecturers, :klass],
        before_date_period: [:period],
        after_date_period: [:period]
      )
  end
end
