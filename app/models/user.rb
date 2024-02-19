# frozen_string_literal: true

class User < ApplicationRecord
  enum kind: %i[student teacher student_teacher]
  has_many :enrollments
  has_many :programs, through: :enrollments
  has_many :teachers, -> { distinct }, through: :enrollments, class_name: 'User'

  has_many :favorite_enrollments, -> { where(favorite: true) }, class_name: 'Enrollment'
  has_many :favorite_teachers, through: :favorite_enrollments, source: :teacher

  has_many :taught_enrollments, foreign_key: :teacher_id, class_name: "Enrollment"
  has_many :students, through: :taught_enrollments, source: :user

  before_update :validate_kind_change_for_teacher, if: :kind_changed?

  def classmates
    User.joins(:enrollments)
        .where(enrollments: { program_id: programs.ids })
        .where.not(id: id)
        .distinct
  end

  private

  def validate_kind_change_for_teacher
    if kind_was == 'teacher' && kind == 'student' && teaches_program?
      errors.add(:kind, 'Kind can not be student because is teaching in at least one program')
      throw(:abort)
    elsif kind_was == 'student' && kind == 'teacher' && student_in_program?
      errors.add(:kind, 'Kind can not be teacher because is studying in at least one program')
      throw(:abort)
    end
  end

  def teaches_program?
    Enrollment.exists?(teacher_id: id)
  end

  def student_in_program?
    Enrollment.exists?(user_id: id)
  end
end
