$ ->
  $lectures = $('.cell')
  $modal = $('#reschedulings-modal')

  getCategory = -> $modal.find('#rescheduling_form_category').val()

  hasBeforeLecture = ->

  showModal = ($lecture) ->
    lecture = $lecture.data('lecture')
    period = $lecture.data('period')
    date = $lecture.data('date')
    $modal.find('#rescheduled-date').text(date)
    $modal.find('#rescheduled-start-time').text(period.startTime)
    $modal.find('#rescheduled-end-time').text(period.endTime)
    $modal.find('#rescheduled-lecture').text(lecture.name)
    $modal.find('#rescheduled-class').text(lecture.klass)
    lecturers = _.map(lecture.lecturers, (l) -> "<li>#{l}</li>").join('')
    $modal.find('#rescheduled-lecturers').html(lecturers)
    $modal.find('#rescheduling_form_lecture_id').val(lecture.id)
    $modal.find('#rescheduling_form_before_period_id').val(period.id)
    $modal.find('#rescheduling_form_before_date').val(date)

    $modal.modal('show')

  $lectures.on 'click', (e) ->
    $lecture = $(e.target)
    showModal($lecture)
    false
