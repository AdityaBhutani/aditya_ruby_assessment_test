class User < ApplicationRecord
    enum kind: %i[student teacher student_teacher]

    has_many :enrollments
    has_many :programs, through: :enrollments
    has_many :teachers, -> { distinct }, through: :enrollments, class_name: "User"
end
