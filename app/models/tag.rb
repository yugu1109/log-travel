class Tag < ApplicationRecord
  has_many :log_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :logs, through: :log_tags

  scope :merge_logs, -> (tags){ }

  def self.search_logs_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.logs}

  end
end
