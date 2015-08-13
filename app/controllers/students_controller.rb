class StudentsController < ApplicationController

  def index
    @students = Student.order(created_at: :desc).limit(10)
  end

  def create
    student = Student.new(student_params)
    if student.save
      render json: { status: 'success',
                     status_text: 'Студент добавлен',
                     student: student_json(student)[:student] }
    else
      render json: { status: 'error', status_text: 'При добавлении студента произошла ошибка' }
    end
  end

  private

    def student_params
      params.require(:student).permit(:first_name,
                                      :last_name,
                                      :study_group,
                                      :birthday,
                                      :email,
                                      :ip,
                                      :registered_at)
    end

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
