class MediaResource < ActiveRecord::Base

  def self.upload(file, name)
    # 上传文件
    put_policy = Qiniu::Auth::PutPolicy.new('lejita', nil, 3600)
    token = Qiniu::Auth.generate_uptoken put_policy
    code, result, _ = Qiniu::Storage.upload_with_token_2(
        token,
        file.path,
        nil,
        nil,
        bucket: 'lejita'
    )
    Rails.logger.info "MODEL_EIP: upload result: #{code}, #{result}"
    [code, result]
    if code == 200
      self.create name: name, qiniu_key: result.symbolize_keys[:key]
    else
      false
    end
  end

  def qiniu_url
    "http://static.njupt.org/#{self.key}"
  end
end
