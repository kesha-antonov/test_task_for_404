class StudentsController < ApplicationController

  def index
  end

  def create
    student = Student.new(student_params)
    if student.save
      render json: { status: 'success', status_text: 'Студент добавлен' }
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

end
