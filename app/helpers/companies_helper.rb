module CompaniesHelper
  def comment_id
    Digest::MD5.new.update(request.remote_ip).to_s[0..10]
  end
end
