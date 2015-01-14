$ ->
  $lectures = $('.cell')
  $modal = $('#reschedulings-modal')

  $lectures.on 'click', (e) ->
    $lecture = $(e.target)
    period = $lecture.data('period')
    date = $lecture.data('date')
    $modal.find('#rescheduled-date').text(date)
    $modal.find('#rescheduled-start-time').text(period.startTime)
    $modal.find('#rescheduled-end-time').text(period.endTime)
    $modal.find('#rescheduled-lecture').text($lecture.data('name'))
    $modal.find('#rescheduled-class').text($lecture.data('class'))
    lecturers = _.map($lecture.data('lecturers'), (l) -> "<li>#{l}</li>").join('')
    $modal.find('#rescheduled-lecturers').html(lecturers)
    $modal.find('#rescheduling_form_lecture_id').val($lecture.data('id'))
    $modal.find('#rescheduling_form_before_period_id').val(period.id)
    $modal.find('#rescheduling_form_before_date').val(date)
    $modal.modal('show')
    false
