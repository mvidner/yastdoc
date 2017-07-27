require "pathname"

module Yastdoc
  class Search
    # dead stupid index implementation: Array of pairs: [term, project name]

    # @param index_dir [String]
    def initialize(index_dir)
      @index = []
      Dir.chdir(index_dir) do
        Dir.glob("**/*.list") do |list_fn|
          # eg:
          # github/yast/yast-ruby-bindings
          project = list_fn.chomp(".list").freeze

          File.readlines(list_fn).map(&:chomp).each do |term|
            @index << [term, project]
          end
        end
      end
    end

    # Query the index for a term
    # (it is not specified yet how smart the query is)
    #
    # @param [String] needle
    # @return [Array<Yastdoc::Result>] results
    def query(needle)
      rx = Regexp.new(needle, Regexp::IGNORECASE) # escaping?
      found = @index.find_all do |term, project|
        rx.match(term)
      end
      results = found.map do |term, project|
        # Yast::Logger#log -> Yast/Logger:log
        path = term.gsub(/::/, "/").sub("#", ":")
        # Term:empty? -> Term%3Aempty%3F
        path = Rack::Utils.escape_path(path)
        Result.new(term, "http://www.rubydoc.info/#{project}/#{path}")
      end
      results.sort_by(&:text)
    end
  end

  # A search result suitable to be rendered as an item on a web page
  # (or to help an IDE in symbol completion?)
  class Result
    # @return [String]
    attr_accessor :text
    # @return [String]
    attr_accessor :url

    def initialize(t, u)
      @text = t
      @url = u
    end
  end
end
