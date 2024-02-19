# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User'
  belongs_to :program
end
