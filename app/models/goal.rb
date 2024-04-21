class Goal < ApplicationRecord
  has_many :okrs, dependent: :destroy

  def calculate_completion_percentage
    total_okrs = okrs.count
    return 0 if total_okrs.zero?

    completed_okrs = okrs.where(completion_status: true).count
    ((completed_okrs.to_f / total_okrs) * 100).round(2)
  end
end