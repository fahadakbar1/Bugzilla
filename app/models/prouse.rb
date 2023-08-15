# frozen_string_literal: true

class Prouse < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :check_existing_developer, ->(proj_id, dev_id) { where(project_id: proj_id, user_id: dev_id) }
  scope :check_existing_qa, ->(proj_id, qa_id) { where(project_id: proj_id, user_id: qa_id) }
end
