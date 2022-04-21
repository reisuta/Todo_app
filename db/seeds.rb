5.times do |i|
  Task.create(name: "todo#{i}", body: "プログラミングの勉強その#{i}")
end
