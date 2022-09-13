# frozen_string_literal: true

class Prouse < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :check_existing_developer, ->(projId, devId) { where(project_id: projId, user_id: devId) }
  scope :check_existing_qa, ->(projId, qaId) { where(project_id: projId, user_id: qaId) }
end
