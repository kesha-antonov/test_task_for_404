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

  def show
    student = Student.includes(:semesters).find(params[:id])
    if student.persisted?
      render json: { status: 'success', student: student_json(student)[:student] }
    else
      render json: { status: 'error', status_text: 'Студент не найден' }
    end
  end

  def update
    student = Student.find(params[:id])
    if student && student.update_attributes(student_params)
      render json: { status: 'success',
                     status_text: 'Данные студента обновлены',
                     student: student_json(student)[:student] }
    else
      render json: { status: 'error', status_text: 'При обновлении данных студента произошла ошибка' }
    end
  end

  def destroy
    student = Student.find(params[:id])
    if student && student.destroy
      render json: { status: 'success', status_text: 'Студент удалён' }
    else
      render json: { status: 'error', status_text: 'При удалении студента произошла ошибка' }
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
                                      :registered_at,
                                      semesters_attributes: [
                                        :id,
                                        :name,
                                        :_destroy
                                      ])
    end

end
