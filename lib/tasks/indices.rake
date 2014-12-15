# coding: utf-8
require 'csv'

namespace :indices do
  desc "TODO"
  indices = {
    "メーカー" => ["食品", "化学", "医薬品", "機械", "自動車", "総合電機", "住宅", "建設", "化粧品", "輸送機器", "半導体・電子部品・その他", "文具・事務機器・インテリア", "印刷関連", "医療機器", "精密機器", "その他製造", "コンピュータ・通信機器・ＯＡ機器", "プラント・エンジニアリング", "繊維", "非鉄金属", "鉄鋼", "設備関連", "重電・産業用電気機器", "ゲーム・アミューズメント機器", "金属製品", "家電・ＡＶ機器", "紙・パルプ", "農林", "建材・エクステリア", "石油・石炭", "タイヤ・ゴム製品", "服飾雑貨・皮革製品", "ガラス・セラミックス", "水産", "鉱業", "セメント"],
    "商社" => ["総合商社", "食料品", "アパレル・服飾雑貨・貴金属", "自動車・輸送機器", "機械", "繊維製品", "電機・電子・半導体", "事務機器・ＯＡ関連", "医療機器", "化粧品", "建材・エクステリア", "医薬品", "インテリア", "その他商社", "化学製品", "金属", "石油製品", "紙", "スポーツ用品", "教育関連"],
    "百貨店・ストア・専門店" => ["服飾雑貨・繊維製品・貴金属", "音楽・書籍・インテリア", "スーパー・ストア", "ドラッグストア・医薬品・化粧品", "百貨店", "スポーツ用品", "ホームセンター", "その他専門店・小売", "家電・事務機器・カメラ", "複合", "コンビニエンスストア", "自動車関連", "メガネ・コンタクト・医療関連", "生活協同組合"],
    "金融・証券・保険" => ["都市銀行・信託銀行", "生命保険", "損害保険", "地方銀行", "証券", "信用金庫・信用組合・労働金庫", "クレジット・信販", "リース・レンタル", "政府系・系統金融機関", "その他金融", "共済", "消費者金融", "外資系金融"],
    "情報（通信・マスコミ）" => ["広告", "放送", "通信", "出版", "新聞"],
    "ソフトウェア・情報処理" => ["ソフトウェア", "情報処理", "インターネット関連", "ゲームソフト"],
    "サービス" => ["不動産", "冠婚葬祭", "旅行", "教育関連", "鉄道", "ホテル", "専門コンサルタント", "航空", "レストラン・フード", "人材関連（派遣・職業紹介・業務請負）", "レジャー・アミューズメント", "福祉関連", "陸運（貨物）", "海運", "その他サービス", "公社・官庁", "電気", "医療関連", "スポーツ・ヘルス関連施設", "団体・連合会", "芸能・芸術", "エネルギー", "倉庫", "建設コンサルタント", "ガス", "エステ・理容・美容", "各種ビジネスサービス", "建築設計", "メンテナンス・清掃事業", "陸運（観光バス・バス・タクシー）", "シンクタンク", "安全・セキュリティ産業", "機械設計", "水道"]
  }
  task add: :environment do
    indices.each do |k, v|
      mi = MainIndex.create(name: k)
      v.each do |i|
        mi.sub_indices.create(name: i)
      end
    end
  end

  task reset: :environment do
    cph = {}
    CSV.foreach(Rails.root.join('config', 'company.csv')) do |row|
      indexname = row[1].split("／")[0]
      indexname = "総合商社" if indexname == "商社（総合）"
      indexname = "建材・エクステリア" if indexname == "鉱"
      indexname = "安全・セキュリティ産業" if indexname == "安全・セキュリティ産"
      indexname = "重電・産業用電気機器" if indexname == "重電・産用電気機器"
      indexname = "人材関連（派遣・職業紹介・業務請負）" if indexname == "人材関連（派遣・職紹介・務請負）"
      indexname = "メンテナンス・清掃事業" if indexname == "メンテナンス・清掃事"
      indexname = indexname.split("専門店（")[1].delete("）") if indexname.include?("専門店（")
      indexname = indexname.split("商社（")[1].delete("）") if indexname.include?("商社（")
      indexname = "各種ビジネスサービス" if indexname == "各ビジネスサービス"
      indexname = "その他商社" if indexname == "商社（建材・エクステリア）"
      indexname = "メガネ・コンタクト・医療関連" if indexname == "商社（医療機器）"
      subindex = SubIndex.find_by(name: indexname)
      cph[row[0]] = subindex
    end
    count = 0
    Company.all.each do |company|
      cph.each do |k, v|
        if company.name.include?(k) || k.include?(company.name)
          company.sub_index = v
          count += 1
          puts "#{company.id}, #{v.name}"
          company.save
          break
        end
        if company.alice_name && company.alice_name.length > 0
          name = company.alice_name
          if name.include?(k) || k.include?(name)
            company.sub_index = v
            count += 1
            puts "#{company.id}, #{v.name}"
            company.save
            break
          end
        end
      end
    end
    puts count
  end
end
