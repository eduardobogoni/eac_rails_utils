require 'open-uri'
require 'fileutils'

module Eac
  module Parsers
    class Base
      def initialize(url)
        @url = url
      end

      def url
        @url.gsub(%r{/+$}, '')
      end
      
      def content
        s = content_by_url_type
        log_content(s)
        s
      end
      
      private
      
      def content_by_url_type
        if @url.is_a?(Hash)
          content_hash
        elsif /^http/ =~ @url
          content_get
        else
          content_file
        end
      end

      def content_file
        open(@url, &:read)
      end

      def content_get
        open(@url, { 'Accept-Language' => 'pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3' }, &:read)
      end

      def content_hash
        return content_post if @url[:method] == :post
        raise "Unknown URL format: #{@url}"
      end

      def content_post
        HTTPClient.new.post_content(@url[:url], @url[:params].merge(follow_redirect: true))
      end

      def log_content(s)
        File.write(log_file, s)
      end

      def log_file
        f = Rails.root.join('log', 'parsers', "#{self.class.name.parameterize}.log")
        FileUtils.mkdir_p(File.dirname(f))
        f
      end
    end
  end
end