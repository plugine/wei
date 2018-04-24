(Dir.glob "#{Rails.root}/lib/activities/**/*").each do |file|
  begin
    load file
  rescue Exception => e
    Rails.logger.info "error load activity #{file}, #{e.inspect}"
  end
end