(Dir.glob "#{Rails.root}/activities/**/*").each do |file|
  require file
end