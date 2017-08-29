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
        data['index'] if match_text_query?(data['tokens'])
      end.compact
    end

    def match_text_query?(tokens)
      match_search_text_query(tokens) && match_subtract_text_query(tokens)
    end

    def match_search_text_query(tokens)
      (search_text_query - tokens).empty?
    end

    def match_subtract_text_query(tokens)
      return true if subtract_text_query.empty?
      (subtract_text_query - tokens).any?
    end

    def search_text_query
      @search_text_query ||= splited_text_query.flat_map { |text| text.scan(/\w+/) } - subtract_text_query
    end

    # TODO: Improve to support multi word subtract_text_query
    def subtract_text_query
      @subtract_query ||=
        splited_text_query
        .select { |text| text.to_s.start_with?('-') }
        .flat_map { |i| i.scan(/\w+/) }
    end

    def splited_text_query
      @splited_text_query ||= text_query.split(' ').map(&:downcase)
    end
  end
end
