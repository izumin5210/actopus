$ ->
  $lectures = $('.cell')
  $btnExtraModal = $('#btn-extra-modal')
  $modal = $('#reschedulings-modal')
  $extraModal = $('#extra-modal')

  showModal = ($lecture) ->
    lecture = $lecture.data('lecture')
    period = $lecture.data('period')
    takenOn = $lecture.data('taken-on')
    $modal.find('#rescheduled-lecture').text(lecture.name)
    $modal.find('#rescheduled-date').text(takenOn)
    $modal.find('#rescheduled-class').text(lecture.klass)
    lecturers = _.map(lecture.lecturers, (l) -> "<li>#{l}</li>").join('')
    $modal.find('#rescheduled-lecturers').html(lecturers)
    $modal.find('#rescheduling_lecture_id').val(lecture.id)
    $modal.find('#rescheduled-start-time').text(period.startTime)
    $modal.find('#rescheduled-end-time').text(period.endTime)
    $modal.find('#rescheduling_period_id').val(period.id)
    $modal.find('#rescheduling_taken_on').val(takenOn)

    $modal.modal('show')

  $lectures.on 'click', (e) ->
    $lecture = $(e.target)
    showModal($lecture)
    false

  $lectures.on 'click', (e) ->
    $lecture = $(e.target)
    showModal($lecture)
    false

  $btnExtraModal.on 'click', (e) ->
    $extraModal.modal('show')
    false
