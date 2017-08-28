module LanguageData
  class SearchOrganizer
    include Interactor::Organizer

    before do
      context.data_path = File.join(Rails.root, 'config/data.json').freeze
      context.data_tokens_path = File.join(Rails.root, 'config/data_tokens.json').freeze
    end

    organize EnsureTokensUpdatedService,
             SearchInTokensService,
             FetchDataByIndexService,
             FormatResponseService
  end
end
