module LanguageData
  class CreateTokensService
    include Interactor

    before do
      @data             = context.data || (raise ArgumentError)
      @data_path        = context.data_path || (raise ArgumentError)
      @data_tokens_path = context.data_tokens_path || (raise ArgumentError)
    end

    def call
      File.delete(data_tokens_path) if File.exist?(data_tokens_path)

      File.open(data_tokens_path, 'w') do |file|
        file.write(data_tokens.to_json)
      end
    end

    private

    attr_reader :data, :data_path, :data_tokens_path

    def data_tokens
      data_tokens = [{ version: File.mtime(data_path).to_i }]
      data.each_with_index do |element, index|
        data_tokens << { index: index, tokens: split_to_tokens(element) }
      end
      data_tokens
    end

    def split_to_tokens(element)
      tokens = []

      tokens += element['Name'].split(' ').map(&:downcase)
      tokens += element['Type'].split(', ').map(&:downcase)
      tokens += element['Designed by'].split(', ').map(&:downcase)

      tokens.uniq
    end
  end
end
