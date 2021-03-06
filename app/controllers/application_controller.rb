class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ActionView::Helpers::NumberHelper
  helper_method :student_json

  def student_json(student)
    {
      student: {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        study_group: student.study_group,
        birthday: student.birthday,
        email: student.email,
        ip: student.ip,
        registered_at: student.registered_at,
        avg_mark: student.semesters.map{|s| number_with_precision(s.avg_mark, precision: 2) }.join(', '),
        semesters: student.semesters.map{|s|
          {
            id: s.id,
            name: s.name,
            characteristic: s.characteristic,
            avg_mark: s.avg_mark,
            disciplines: s.semesters_disciplines.map{|sd|
              {
                id: sd.id,
                discipline_id: sd.discipline_id,
                name: sd.discipline.name,
                mark: sd.mark,
                semester_id: s.id
              }
            }
          }
        }
      }
    }
  end
end
