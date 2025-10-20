# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.destroy_all

Admin.create!(
  email: "admin@example.com",
  password: "adminpass",
  password_confirmation: "adminpass"
  )

Tag.create!([
  { tag: '#清潔感'},
  { tag: '#優しい' },
  { tag: '#説明がわかりやすい' },
  { tag: '#診療費がが安い' },
  { tag: '#予約あり' },
  { tag: '#緊急診療対応' },
  { tag: '#駐車場あり' },
  { tag: '#駅近' },
  { tag: '#待ち時間短い' }
])

