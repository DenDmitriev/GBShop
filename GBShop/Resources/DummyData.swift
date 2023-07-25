//
//  DummyData.swift
//  GBShop
//
//  Created by Denis Dmitriev on 19.07.2023.
//

import Foundation

struct DummyData {
    static let product = Product(name: "Молоко Самокат",
                                 price: Price(price: 80, discount: 9),
                                 description: "Пастеризованное, 3,2% 950 мл",
                                 image: "https://cm.samokat.ru/processed/l/original/158334_425819778.jpg")
    
    static let  review1 = Review(id: UUID(), reviewer: "Люба Гром", review: """
Магазинные молочные полки ломятся от разнообразия, и что тут выбрать!?
Поискала одну марку, кефирчик и йогурты которой я пила еще с институтских времен, но ее в этом магазине не оказалось
""", rating: 4, productID: UUID(), createdAt: Date.now - 10000000000)
    
    static let  review2 = Review(id: UUID(), reviewer: "Ольга Козлова", review: """
яркая упаковка, разрекламированная марка, много обещаний на этикетке
""", rating: 1, productID: UUID(), createdAt: Date.now - 100000)
    
    static let  review3 = Review(id: UUID(), reviewer: "Инна Стерлец", review: """
Молоко "Простоквашино" в последнее время нам нравится в пакетах, вот таких. Но до этого мы его уже неоднократно брали,
и не только его, а и другие молочные продукты. Какое замечательное название для фирмы, изготавливающей молочную...
""", rating: 0, productID: UUID(), createdAt: Date.now - 10000000)
}
