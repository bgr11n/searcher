module LanguageData
  class SearchInTokensService
    include Interactor

    before do
      @text_query = context.text_query || (raise ArgumentError)
      @data_tokens = context.data_tokens || (raise ArgumentError)
    end

    def call
      context.relevant_data_indexes = relevant_data_indexes
    end

    private

    attr_reader :text_query, :data_tokens

    def relevant_data_indexes
      data_tokens.map do |data|
        data['index'] if (splited_text_query - data['tokens']).empty?
      end.compact
    end

    def splited_text_query
      text_query.scan(/\w+/).map(&:downcase)
    end
  end
end
