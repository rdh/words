class Passwords

  attr_reader :list
  attr_reader :counts

  def initialize( attributes = {} )
    self.list = attributes[ :list ]
    remove_mismatches( attributes[ :word ], attributes[ :matches ].to_i )
  end

  def list=(list)
    @list = []
    @list = list.split( /\s/ ).sort if list
    build_counts
  end

  def build_counts
    @counts = {}
    @list.each do |word|
      @counts[ word ] =  build_count( word )
    end
  end

  def build_count( word )
    counts = { total: 0 }

    @list.each do |target|
      if word != target
        count = compare( word, target )
        counts[ target ] = count
        counts[ :total ] += count
      end
    end

    return counts
  end

  def compare( word, target )
    count = 0

    0.upto( word.length - 1 ) do |i|
      count += 1 if word[i] == target[i]
    end

    return count
  end

  def remove_mismatches( word, matches )
    return unless word.present?

    @list.reject! { |target| matches != matches( word, target )  }
    build_counts
  end

  def targets
    return @counts.sort_by { |word, counts| counts[ :total ] }.map { |a| a[0] }.reverse
  end

  def matches( word, target )
    return @counts[ word ][ target ]
  end

  def total( word )
    return @counts[ word ][ :total ]
  end

  def valid?
    return true if @list.empty?
    return @list.select { |word| word.length != @list[0].length }.empty?
  end

  def words
    @list.join( ' ' )
  end
end