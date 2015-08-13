class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
        registered_at: student.registered_at
      }
    }
  end
end
