(Dir.glob "#{Rails.root}/lib/activities/**/*").each do |file|
  begin
    require file
  rescue
    # ignored
  end
end