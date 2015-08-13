$ ->
  showFlash = (data) ->
    $flash = $('body')
      .prepend "<div class='flash #{data.status}'>#{data.status_text}</div>"
      .children '.flash'
    setTimeout(
      ->
        $flash.remove()
      , 3000
    )

  $students = $('.students')
  $students_list = $students.children '.students-list'

  $('body')
    .on 'ajax:success', (e, data) ->
      showFlash data
      if e.target.id is 'new_student' and e.target.nodeName is 'FORM'
        $students_list.find('> table > tbody').prepend "<tr>
          <td>#{data.student.first_name}</td>
          <td>#{data.student.last_name}</td>
          <td>#{data.student.study_group}</td>
          <td>#{data.student.birthday}</td>
          <td>#{data.student.email}</td>
          <td>#{data.student.ip}</td>
          <td>#{data.student.registered_at}</td>
        </tr>"
