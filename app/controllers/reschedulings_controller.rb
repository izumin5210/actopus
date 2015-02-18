class ReschedulingsController < ApplicationController

  layout 'unsignedin_users'

  def index
    @reschedulings = Rescheduling.available.includes(
        { lecture: [:lecturers, :klass] }, :period
      )
  end
end
