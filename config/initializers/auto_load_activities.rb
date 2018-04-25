dir = "#{Rails.root}/tmp/activities/"

Dir.mkdir(dir) unless Dir.exist?(dir)
(Dir.glob "#{dir}/**/*").each do |file|
  begin
    load file
  rescue Exception => e
    Rails.logger.info "error load activity #{file}, #{e.inspect}"
  end
end