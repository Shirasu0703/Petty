# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.destroy_all

Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD']
)

Tag.create!([
  { tag: '#犬'},
  { tag: '#猫'},
  { tag: '#うさぎ'},
  { tag: '#鳥'},
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


taro = User.find_or_create_by!(email: "taro@example.com") do |user|
  user.name = "山田 太郎"
  user.password = "yamadataro"
end
taro.image.attach(io: File.open("#{Rails.root}/db/fixtures/pet_dog.png"), filename: "pet_dog.png")

hanako = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.name = "佐藤 花子"
  user.password = "satohanako"
end
hanako.image.attach(io: File.open("#{Rails.root}/db/fixtures/pet_cat.png"), filename: "pet_cat.png")

jiro = User.find_or_create_by!(email: "jiro@example.com") do |user|
  user.name = "吉田 二郎"
  user.password = "yoshidajiro"
end
jiro.image.attach(io: File.open("#{Rails.root}/db/fixtures/usaghi.png"), filename: "usaghi.png")

users = [taro, hanako, jiro]

hospital_a = Hospital.find_or_create_by(name: "渋谷ペットクリニック") do |hospital|
  hospital.address = "〒150-1111 東京都渋谷区1-1-1"
  hospital.phone_number = "03-1111-1111"
  hospital.opening_hours = "定休日 月・祝\n火〜日 9:00~12:00, 15:00~18:30"
  hospital.animal_types = "犬・猫"
end
if File.exist?("#{Rails.root}/db/fixtures/main_image1.png")
  hospital_a.main_image.attach(io: File.open("#{Rails.root}/db/fixtures/main_image1.png"), filename: "main_image1.png")
end
if File.exist?("#{Rails.root}/db/fixtures/sub_image.png1")
  hospital_a.sub_images.attach(io: File.open("#{Rails.root}/db/fixtures/sub_image1.png"), filename: "sub_image1.png")
end

hospital_b = Hospital.find_or_create_by(name: "新宿動物病院") do |hospital|
  hospital.address = "〒101-2222 東京都新宿区2-2-2"
  hospital.phone_number = "03-2222-2222"
  hospital.opening_hours = "定休日 月・祝\n火〜日 9:00~12:00, 15:00~18:30"
  hospital.animal_types = "犬・猫・小動物"
end
if File.exist?("#{Rails.root}/db/fixtures/main_image2.png")
  hospital_b.main_image.attach(io: File.open("#{Rails.root}/db/fixtures/main_image2.png"), filename: "main_image2.png")
end
if File.exist?("#{Rails.root}/db/fixtures/sub_image.png2")
  hospital_b.sub_images.attach(io: File.open("#{Rails.root}/db/fixtures/sub_image2.png"), filename: "sub_image2.png")
end

hospital_c = Hospital.find_or_initialize_by(name: "サンプル動物病院") do |hospital|
  hospital.address = "〒106-3333 東京都港区3-3-3"
  hospital.phone_number = "03-3333-3333"
  hospital.opening_hours = "定休日 月・祝\n火〜日 9:00~12:00, 15:00~18:30"
  hospital.animal_types = "犬・猫・小動物・爬虫類"
end

if File.exist?("#{Rails.root}/db/fixtures/main_image3.png")
  hospital_c.main_image.attach(io: File.open("#{Rails.root}/db/fixtures/main_image3.png"), filename: "main_image3.png")
end
if File.exist?("#{Rails.root}/db/fixtures/sub_image.png3")
  hospital_c.sub_images.attach(io: File.open("#{Rails.root}/db/fixtures/sub_image3.png"), filename: "sub_image3.png")
end
# hospital.save!

hospitals = [hospital_a, hospital_b, hospital_c]

review_data = [
  {
    title: "快適",
    cleanliness_rating: 5,
    cleanliness_comment: "とても清潔感がありました。",
    doctor_rating: 4,
    doctor_comment: "先生の説明が丁寧で安心できました。",
    staff_rating: 5,
    staff_comment: "受付の方の対応が親切でした。",
    price_rating: 3,
    price_comment: "料金は少し高めですが納得できます。",
    waiting_rating: 4,
    waiting_comment: "少し待ちましたが許容範囲内でした。",
    rating: 4,
    body: "院内もとても清潔感があり安心して受診することができました。また利用しようと思います。",
    animal_comment: "うちの犬もリラックスしていました。"
  },
  {
    title: "清潔で安心",
    cleanliness_rating: 4,
    cleanliness_comment: "院内比較的綺麗です。",
    doctor_rating: 4,
    doctor_comment: "信頼できる先生です。",
    staff_rating: 4,
    staff_comment: "親切な対応でした。",
    price_rating: 4,
    price_comment: "料金も良心的です。",
    waiting_rating: 3,
    waiting_comment: "少し混雑していました。",
    rating: 3,
    body: "院内もとても綺麗でとてもよかったのですが、少し混雑していたため、待ち時間が長かったです。",
    animal_comment: "猫も落ち着いて診察を受けていました。"
  },
  {
    title: "また行きたい",
    cleanliness_rating: 5,
    cleanliness_comment: "院内がとても綺麗です。",
    doctor_rating: 5,
    doctor_comment: "とても親切で信頼できる先生です。",
    staff_rating: 5,
    staff_comment: "薬の説明もわかりやすくて親切な対応でした。",
    price_rating: 4,
    price_comment: "料金もとても良心的です。",
    waiting_rating: 5,
    waiting_comment: "受付してからすぐ診てもらえました。",
    rating: 5,
    body: "院内もとても綺麗で、先生もとても親切で症状について詳しく説明してもらえたのでとても安心できました。受付の方も薬の使用方法など詳しく説明してもらえました。ぜひまた行きたいです。",
    animal_comment: "院内のBGM音量が低めで安心して受診ができました。"
  }
]

# review_data.each do |data|
#   hospital.reviews.find_or_create_by!(user: taro, title: data[:title]) do |review|
users.each_with_index do |user, i|
  hospitals.each do |hospital|
    data = review_data[i % review_data.size]
    Review.find_or_create_by!(user: user, hospital: hospital, title: data[:title]) do |review|
      review.cleanliness_rating = data[:cleanliness_rating]
      review.cleanliness_comment = data[:cleanliness_comment]
      review.doctor_rating = data[:doctor_rating]
      review.doctor_comment = data[:doctor_comment]
      review.staff_rating = data[:staff_rating]
      review.staff_comment = data[:staff_comment]
      review.price_rating = data[:price_rating]
      review.price_comment = data[:price_comment]
      review.waiting_rating = data[:waiting_rating]
      review.waiting_comment = data[:waiting_comment]
      review.rating = data[:rating]
      review.body = data[:body]
      review.animal_comment = data[:animal_comment]
    end
  end
end



