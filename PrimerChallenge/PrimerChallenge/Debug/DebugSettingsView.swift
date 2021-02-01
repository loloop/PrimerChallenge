//
//  DebugSettingsView.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import SwiftUI
import Combine

#if DEBUG

final class DebugSettingsViewModel: ObservableObject {

    var cancellables: Set<AnyCancellable> = []

    @Published var isStagingEnvironmentEnabled: Bool = DebugSettings.shared.isStagingEnabled

    init() {
        setupPublishers()
    }

    func setupPublishers() {
        $isStagingEnvironmentEnabled
            .assign(to: \.isStagingEnabled, on: DebugSettings.shared)
            .store(in: &cancellables)
    }

}

struct DebugSettingsView: View {

    @ObservedObject var viewModel: DebugSettingsViewModel

    var body: some View {
        List {
            HStack {
                Toggle(isOn: $viewModel.isStagingEnvironmentEnabled, label: {
                    Text("Staging Environment")
                })
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct DebugSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DebugSettingsView(viewModel: .init())
    }
}

#endif
