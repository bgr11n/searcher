module LanguageData
  class EnsureTokensUpdatedService
    include Interactor

    before do
      @data_path        = context.data_path || (raise ArgumentError)
      @data_tokens_path = context.data_tokens_path || (raise ArgumentError)
    end

    def call
      context.data = data
      create_tokens if tokens_outdated?

      # To be sure we get rid of version
      context.data_tokens = data_tokens[1..-1]
    end

    private

    attr_reader :data_path, :data_tokens_path

    def create_tokens
      LanguageData::CreateTokensService.call!(context)
    end

    def tokens_outdated?
      tokens = data_tokens
      tokens.nil? || old_version?(tokens)
    end

    def old_version?(tokens)
      !updated_version?(tokens)
    end

    def updated_version?(tokens)
      tokens[0]['version'] == data_updated_at
    end

    def data_updated_at
      File.mtime(data_path).to_i
    end

    def data_tokens
      return unless File.exist?(data_tokens_path)

      JSON.parse(File.read(data_tokens_path))
    end

    def data
      @data ||= JSON.parse(File.read(data_path))
    end
  end
end
