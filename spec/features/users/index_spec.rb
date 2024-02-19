# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Index of Users' do
    let!(:user_1) { User.create(kind: 0, name: 'Student 1', age: 21) }
    let!(:teacher_1) { User.create(kind: 1, name: 'Teacher 1', age: 50) }
    let!(:teacher_student) { User.create(kind: 2, name: 'Student and Teacher', age: 40) }
    
    
    feature 'Index' do
        scenario 'when student, teacher and student_teachers have been created' do
            visit users_path
    
            expect(page).to have_text(user_1.name)
            expect(page).to have_text(teacher_1.name)
            expect(page).to have_text(teacher_student.name)
        end
    end
end
