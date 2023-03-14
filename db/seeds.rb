# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Genre.create([
    { name: '肉類' },
    { name: '魚介類' },
    { name: '発酵食品'},
    { name: '野菜類'},
    { name: '白米、パン類'},
    { name: '粉物類'},
    { name: '甘味類'},
    { name: 'その他'},
    ])

#管理者でログイン機能を実装しない場合はここで定義してrake db:seedを実行する
#!をつけることで途中でエラーを吐き出してくれる
Admin.create!(email: 'watanabe389274@icloud.com', password: 'watanabe')