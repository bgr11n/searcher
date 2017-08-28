module LanguageData
  class FetchDataByIndexService
    include Interactor

    before do
      @data = context.data || (raise ArgumentError)
      @relevant_data_indexes = context.relevant_data_indexes || (raise ArgumentError)
    end

    def call
      context.relevant_data = data.values_at(*relevant_data_indexes)
    end

    private

    attr_reader :data, :relevant_data_indexes
  end
end
