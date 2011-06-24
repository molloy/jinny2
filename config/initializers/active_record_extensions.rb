class ActiveRecord::Base
  def self.create_or_update(params = {})
    id = params.delete(:id)
    record = find_by_id(id) || new
    record.id = id
    record.attributes = params
    record.save!
    
    record
  end

  def get_file_ext_from_content_type(content_type)
    return content_type.match(/[^\/]+$/).to_s
  end
end
