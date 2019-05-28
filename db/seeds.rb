areas = ["北海道",
  "青森県",
  "岩手県",
  "宮城県",
  "秋田県",
  "山形県",
  "福島県",
  "茨城県",
  "栃木県",
  "群馬県",
  "埼玉県",
  "千葉県",
  "東京都",
  "神奈川県",
  "新潟県",
  "富山県",
  "石川県",
  "福井県",
  "山梨県",
  "長野県",
  "岐阜県",
  "静岡県",
  "愛知県",
  "三重県",
  "滋賀県",
  "京都府",
  "大阪府",
  "兵庫県",
  "奈良県",
  "和歌山県",
  "鳥取県",
  "島根県",
  "岡山県",
  "広島県",
  "山口県",
  "徳島県",
  "香川県",
  "愛媛県",
  "高知県",
  "福岡県",
  "佐賀県",
  "長崎県", 
  "熊本県",
  "大分県",
  "宮崎県",
  "鹿児島県",
  "沖縄県"]
  
areas.each do |name|
  Area.create(name: name)
end

["POP", "MODERN", "CLASSICAL"].each do |name|
  Category.create(name: name)
end

Product.create(title: "DOG", price: 6000, genre_id: 1, introduce: "pop-dog", image: "pop-dog.jpeg", category_id: 1) 
Product.create(title: "HEADPHONE", price: 6000, genre_id: 1, introduce: "pop-headphone", image: "pop-headphone.jpg", category_id: 1) 
Product.create(title: "LONDON", price: 6000, genre_id: 1, introduce: "modern-london", image: "modern-london.jpg", category_id: 2) 
Product.create(title: "HEPBURN", price: 6000, genre_id: 1, introduce: "pop-hepburn", image: "pop-hepburn.jpg", category_id: 1) 
Product.create(title: "MAN", price: 6000, genre_id: 1, introduce: "pop-man", image: "pop-man.jpg", category_id: 1) 