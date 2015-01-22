class ReschedulingsController < ApplicationController

  layout 'unsignedin_users'

  def index
    @reschedulings = Rescheduling.includes(
        lecture: [:lecturers, :klass],
        before_date_period: [:period],
        after_date_period: [:period]
      ).all
  end
end
