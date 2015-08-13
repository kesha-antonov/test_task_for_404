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

  popupEditStudent = (student) ->
    $students.prepend "<div class='student-popup'>
        <a class='close' href='#'>Закрыть</a>
        <h3>Редактируем студента</h3>
        <form action='/students/#{student.id}' id='edit-student' data-remote='true' data-type='json' method='put'>
          <div style='display:none'>
            <input name='utf8' type='hidden' value='✓'>
            <input name='_method' type='hidden' value='patch'>
          </div>
          <div class='input'>
            <label>Имя: </label>
            <input name='student[first_name]' value='#{student.first_name}'>
          </div>
          <div class='input'>
            <label>Фамилия: </label>
            <input name='student[last_name]' value='#{student.last_name}'>
          </div>
          <div class='input'>
            <label>Группа: </label>
            <input name='student[study_group]' value='#{student.study_group}'>
          </div>
          <div class='input'>
            <label>Дата рождения: </label>
            <input name='student[birthday]' value='#{student.birthday}'>
          </div>
          <div class='input'>
            <label>Email: </label>
            <input name='student[email]' value='#{student.email}'>
          </div>
          <div class='input'>
            <label>IP: </label>
            <input name='student[ip]' value='#{student.ip}'>
          </div>
          <div class='input'>
            <label>Дата регистрации: </label>
            <input name='student[registered_at]' value='#{student.registered_at}'>
          </div>
          <input type='submit' value='Сохранить'>
        </form>
      </div>"

  $students
    .on 'ajax:success', (e, data) ->
      showFlash data
      if e.target.nodeName is 'FORM'
        if e.target.id is 'new_student'
          $students_list.find('> table > tbody').prepend "<tr class='student-#{data.student.id}'>
            <td class='first_name'>#{data.student.first_name}</td>
            <td class='last_name'>#{data.student.last_name}</td>
            <td class='study_group'>#{data.student.study_group}</td>
            <td class='birthday'>#{data.student.birthday}</td>
            <td class='email'>#{data.student.email}</td>
            <td class='ip'>#{data.student.ip}</td>
            <td class='registered_at'>#{data.student.registered_at}</td>
          </tr>"
        else if e.target.id is 'edit-student'
          $student = $students.find("tr.student-#{data.student.id}")
          if $student.length
            $student
              .children 'td.first_name'
              .text data.student.first_name
              .siblings 'td.last_name'
              .text data.student.last_name
              .siblings 'td.study_group'
              .text data.student.study_group
              .siblings 'td.birthday'
              .text data.student.birthday
              .siblings 'td.email'
              .text data.student.email
              .siblings 'td.ip'
              .text data.student.ip
              .siblings 'td.registered_at'
              .text data.student.registered_at
      else if /delete\-student/.test(e.target.className)
        $(e.target).parent().parent().remove()
    .on 'click', (e) ->
      if /edit\-student/.test(e.target.className)
        e.preventDefault()
        $target = $(e.target)
        popupEditStudent $target.data('student')
      else if /close/.test(e.target.className) and /student\-popup/.test(e.target.parentNode.className)
        e.preventDefault()
        $(e.target).parent().remove()
