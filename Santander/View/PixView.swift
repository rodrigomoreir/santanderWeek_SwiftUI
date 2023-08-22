//
//  PixView.swift
//  Santander
//
//  Created by Rodrigo Alves Moreira on 28/07/23.
//

import SwiftUI

struct PixView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.fetchHome)
            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.santanderRed))
            case .loaded:
                ScrollView(showsIndicators: true, content: {
                    
                })
                .background(.white)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Pix")
                            .font(.openSansSemiBold(size: 22))
                            .kerning(0.58)
                            .foregroundColor(.white)
                    }
                }
                .preferredColorScheme(.dark)
                .navigationBarAppearance(backgroundColor: Color.santanderRed)
            case .failed(let error):
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .imageScale(.large)
                        .foregroundColor(.red)
                    Text(error)
                        .font(.openSansBold(size: 18))
                        .kerning(0.18)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding([.leading, .trailing], 20)
                    Text("Tentar novamente")
                        .font(.openSansBold(size: 18))
                        .kerning(0.18)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            viewModel.fetchHome()
                        }
                        .padding(.top, 2)
                }
            }
        }
        .onAppear {
            viewModel.fetchHome()
        }
    }
}

struct PixView_Previews: PreviewProvider {
    static var previews: some View {
        PixView()
    }
}
