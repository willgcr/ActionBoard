require 'faker'

puts 'Seeding database...'

users = {}
users['willian@penyapp.com'] = User.find_or_create_by!(email: 'willian@penyapp.com') { |u| u.password = '123456' }
users['lio@penyapp.com']     = User.find_or_create_by!(email: 'lio@penyapp.com')     { |u| u.password = '123456' }
users['casey@penyapp.com']   = User.find_or_create_by!(email: 'casey@penyapp.com')   { |u| u.password = '123456' }
users['aaron@penyapp.com']   = User.find_or_create_by!(email: 'aaron@penyapp.com')   { |u| u.password = '123456' }

puts 'Creating lists...'
lists = []
users.each do |email, user|
  3.times do
    lists << List.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.sentence,
      owner_user: user
    )
  end
end

puts 'Sharing lists...'
lists.sample(5).each do |list|
  User.where.not(id: list.owner_user_id).sample(2).each do |user|
    ListShare.find_or_create_by!(list: list, user: user)
  end
end

puts 'Creating tasks...'
lists.each do |list|
  rand(5..10).times do
    Task.create!(
      title: Faker::Lorem.sentence(word_count: 4),
      description: Faker::Lorem.paragraph,
      list: list,
      completed: [true, false].sample
    )
  end
end

puts 'Done!'