# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.production?
  Event.create [{
    title: '横浜市大会 初戦',
    location: '日産スタジアム',
    date: '2015-11-28'
  }, {
    title: '横浜市大会 二回戦',
    location: '日産スタジアム',
    date: '2015-12-05'
  }, {
    title: '横浜市大会 三回戦',
    location: '日産スタジアム',
    date: '2015-12-12'
  }, {
    title: '横浜市大会 準決勝',
    location: '日産スタジアム',
    date: '2015-12-19'
  }, {
    title: '横浜市大会 決勝',
    location: '日産スタジアム',
    date: '2015-12-26'
  }]

  50.times do |i|
    Member.create(
      display_name: "元石川 #{i + 1}号機",
      description: "モトイシの#{i + 1}番"
    )
  end
end