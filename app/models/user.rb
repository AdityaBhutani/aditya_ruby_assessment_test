class User < ApplicationRecord
    enum kind: %i[student teacher student_teacher]

    has_many :enrollments
    has_many :programs, through: :enrollments
    has_many :teachers, -> { distinct }, through: :enrollments, class_name: "User"

    has_many :favorite_enrollments, -> { where(favorite: true) }, class_name: "Enrollment"
    has_many :favorite_teachers, through: :favorite_enrollments, source: :teacher
end
