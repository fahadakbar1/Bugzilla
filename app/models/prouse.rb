# frozen_string_literal: true

class Prouse < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
