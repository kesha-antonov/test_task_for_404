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

  $display_container = $students.siblings '.display-container'

  popupEditStudent = (student) ->

    draw_discipline = (discipline) ->
      "<div class='input'>
        <label>#{discipline.name}</label>
        <input type='string' value='#{discipline.mark}'  name='student[semesters_attributes][][semesters_disciplines_attributes][][mark]' >
        <input type='hidden' value='#{discipline.semester_id}' name='student[semesters_attributes][][semesters_disciplines_attributes][][semester_id]' >
        <input type='hidden' value='#{discipline.discipline_id}' name='student[semesters_attributes][][semesters_disciplines_attributes][][discipline_id]' >
        <input type='hidden' value='#{discipline.id}' name='student[semesters_attributes][][semesters_disciplines_attributes][][id]' >
      </div>"

    draw_semester = (semester) ->
      "<div class='input'>
        <label>Номер семестра</label>
        <input type='hidden' name='student[semesters_attributes][][id]' value='#{semester.id}'>
        <input type='string' name='student[semesters_attributes][][name]' value='#{semester.name}'>
        <input type='string' name='student[semesters_attributes][][characteristic]' value='#{semester.characteristic}' placeholder='Характеристика...'>
        <a href='#' class='delete-semester' data-semester-id='#{semester.id}'>Удалить</a>
        #{draw_discipline(discipline) for discipline in semester.disciplines}
        <a style='display:block;' href='#' class='add-discipline' data-semester-id='#{semester.id}'>Добавить предмет</a>
      </div>"

    $display_container.html "<div class='student-popup'>
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
          <h4>Семестры</h4>
          #{draw_semester(semester) for semester in student.semesters}
          <a href='#' class='add-semester' style='display:block;margin-bottom:1em;'>Добавить семестр</a>
          <input type='submit' value='Сохранить'>
        </form>
      </div>"

  popupShowStudent = (student) ->

    draw_discipline = (discipline) ->
      "<div>
        <div>
          <label>Название</label>
          <input disabled='disabled' value='#{discipline.name}'>
          <label>Оценка</label>
          <input disabled='disabled' value='#{if discipline.mark? then discipline.mark else 'Отсутствует'}'>
        </div>
      </div>"

    draw_semester = (semester) ->
      "<div class='semester'>
        <div>
          <label>Название</label>
          <input disabled='disabled' value='#{semester.name}'>
        </div>
        <div>
          <label>Средняя оценка</label>
          <input disabled='disabled' value='#{if semester.avg_mark? then semester.avg_mark else 'Отсутствует'}'>
        </div>
        <div>
          <label>Характеристика</label>
          <input disabled='disabled' value='#{if semester.characteristic? then semester.characteristic else 'Отсутствует'}'>
        </div>
        <div class='disciplines'>
          #{draw_discipline(discipline) for discipline in semester.disciplines}
        </div>
      </div>"

    $display_container.html "<div class='student-popup'>
        <a class='close' href='#'>Закрыть</a>
        <h3>Карточка студента</h3>
        <div class='card'>
          <div class='head'>
            <span>Имя</span>
            <span>Фамилия</span>
            <span>Группа</span>
            <span>Дата рождения</span>
            <span>Email</span>
            <span>IP</span>
            <span>Дата регистрации</span>
          </div>
          <div class='body'>
            <div>
              <span>#{student.first_name}</span>
              <span>#{student.last_name}</span>
              <span>#{student.study_group}</span>
              <span>#{student.birthday}</span>
              <span>#{student.email}</span>
              <span>#{student.ip}</span>
              <span>#{student.registered_at}</span>
            </div>
            <div>
              Семестры:
              #{draw_semester(semester) for semester in student.semesters}
            </div>
          </div>
        </div class='card'>
      </div>"

  $('body')
    .on 'ajax:success', (e, data) ->
      showFlash data
      if e.target.nodeName is 'FORM' and not /search\-students/.test(e.target.className)
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
          popupEditStudent data.student
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
      else if /(?:search\-students|get\-high\-(?:rated|registrated))/.test(e.target.className)
        e.preventDefault()
        $tbody = $(e.target)
          .siblings 'table'
          .children 'tbody'
        $tbody.html ''
        for student in data.students
          $tbody.append "<tr>
            <td>#{student.first_name}</td>
            <td>#{student.last_name}</td>
            <td>#{student.study_group}</td>
            <td>#{student.birthday}</td>
            <td>#{student.email}</td>
            <td>#{student.ip}</td>
            <td>#{student.registered_at}</td>
            #{if student.avg_mark? and e.target.nodeName isnt 'FORM' then "<td>#{student.avg_mark}</td>" else ''}
            <td><a href='#' class='show-student' data-student='#{JSON.stringify(student)}'>Подробности</a></td>
          </tr>"
    .on 'click', (e) ->
      if /edit\-student/.test(e.target.className)
        e.preventDefault()
        $target = $(e.target)
        $.ajax "/students/#{$target.data('student').id}",
          method: 'get'
          type: 'json'
          success: (data) ->
            if data.status is 'success'
              popupEditStudent data.student
            else
              showFlash data

      else if /show\-student/.test(e.target.className)
        e.preventDefault()
        $target = $(e.target)
        popupShowStudent $target.data('student')
      else if /close/.test(e.target.className) and /student\-popup/.test(e.target.parentNode.className)
        e.preventDefault()
        $(e.target).parent().remove()
      else if /add\-semester/.test(e.target.className)
        e.preventDefault()
        $(e.target).before "<div class='input'>
          <label>Номер семестра</label>
          <input name='student[semesters_attributes][][name]' value=''>
        </div>"
      else if /delete\-semester/.test(e.target.className)
        e.preventDefault()
        $target = $(e.target)
        $target
          .parent()
          .css 'display', 'none'
        $target.before "<input type='hidden' name='student[semesters_attributes][][_destroy]' value='1'>"
      else if /add\-discipline/.test(e.target.className)
        e.preventDefault()
        $target = $(e.target)
        $target.before "<div class='input disciplines-container'>
            <select name='student[semesters_attributes][][semesters_disciplines_attributes][][discipline_id]'>
              #{"<option value='#{discipline.id}'>#{discipline.name}</option>" for discipline in $students.data('disciplines')}
            </select>
            <input type='string' value='5' name='student[semesters_attributes][][semesters_disciplines_attributes][][mark]' >
            <input type='hidden' value='#{$target.data('semesterId')}' name='student[semesters_attributes][][semesters_disciplines_attributes][][semester_id]' >
          </div>"

