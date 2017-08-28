module LanguageData
  class FormatResponseService
    include Interactor

    before do
      @relevant_data = context.relevant_data || (raise ArgumentError)
    end

    def call
      context.response = { result: relevant_data }
    end

    private

    attr_reader :relevant_data
  end
end
