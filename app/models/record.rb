class Record < ApplicationRecord
  belongs_to :user
  belongs_to :leave_type
  accepts_nested_attributes_for :leave_type, allow_destroy: true,
                                reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? }}
end
