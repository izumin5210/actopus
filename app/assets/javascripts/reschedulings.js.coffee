$ ->
  $lectures = $('.cell')
  $modal = $('#reschedulings-modal')

  $lectures.on 'click', (e) ->
    $lecture = $(e.target)
    period = $lecture.data('period')
    $modal.find('#rescheduled-date').text($lecture.data('date'))
    $modal.find('#rescheduled-start-time').text(period.startTime)
    $modal.find('#rescheduled-end-time').text(period.endTime)
    $modal.find('#rescheduled-lecture').text($lecture.data('name'))
    $modal.find('#rescheduled-class').text($lecture.data('class'))
    lecturers = _.map($lecture.data('lecturers'), (l) -> "<li>#{l}</li>").join('')
    $modal.find('#rescheduled-lecturers').html(lecturers)
    $modal.modal('show')
    false
