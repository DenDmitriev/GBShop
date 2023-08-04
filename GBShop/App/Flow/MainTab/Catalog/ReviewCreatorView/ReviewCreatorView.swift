//
//  ReviewCreatorView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.08.2023.
//

import SwiftUI

struct ReviewCreatorView: View {
    
    @ObservedObject var viewModel: ReviewCreatorViewModel
    @EnvironmentObject var coordinator: CatalogCoordinator
    @State private var fullText: String = ""
    @State private var rating: Int?
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                if let url = URL(string: viewModel.product.image) {
                    AsyncImage(url: url, image: { image in
                        Image(uiImage: image)
                            .resizable()
                    })
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 64)
                    .cornerRadius(8)
                }
                
                VStack {
                    Text(viewModel.product.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Новый отзыв")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            
            LazyHGrid(rows: [GridItem(.flexible())], content: {
                Text("Рейтинг:")
                    .font(.title3)
                ForEach(1...5, id: \.self) { star in
                    Button {
                        rating = star
                    } label: {
                        if rating == nil {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                        } else {
                            Image(systemName: star > rating ?? .zero ? "star" : "star.fill")
                        }
                    }
                }
                .foregroundColor(.yellow)
            })
            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
            
            TextEditor(text: $fullText)
                .font(.title3)
                .lineSpacing(8)
                .overlay {
                    if fullText.isEmpty {
                        Text("Напишите ваше мнение...")
                            .foregroundColor(.gray)
                            .font(.title3)
                    }
                }
            
            Button("Создать отзыв") {
                viewModel.addReview(text: fullText, rating: rating) { isAdded in
                    DispatchQueue.main.async {
                        if isAdded {
                            coordinator.dismissSheet()
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
            .disabled(fullText.isEmpty || rating == nil)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Ошибка"), message: Text("Отзыв не был добавлен"), primaryButton: .cancel(
                Text("Ок"),
                action: { coordinator.dismissSheet() }
            ), secondaryButton: .default(
                Text("Повторить"),
                action: {}
            ))
        }
    }
}

struct ReviewCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCreatorView(viewModel: ReviewCreatorViewModel(product: DummyData.product))
            .environmentObject(CatalogCoordinator())
    }
}
