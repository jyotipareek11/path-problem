# Given that the text file 'input.txt' contains a rectangular block of dot
# characters ('.') and exactly two hash characters ('#')
# joining two '#' characters by asterisks ('*').
# The vertical line of the path (if any) is drawn first, then the horizontal line
# Approach ---
# 1) Reading file from command line and checking format of file should be ".txt".
# 2) Finding out both the positions(line_index, char_index in line) of hash characters.
# 3) Replacing dots with stars in vertical line then horizontally between both the hash characters
#    and keeping both hash characters unchanged.
# 4) Creating a new "output.txt" file and putting the result.

class Pather

  def initialize(lines)
    @lines = lines.to_a
    if @lines.map { |line| line.length }.uniq.length > 1
      raise ArgumentError, "All lines in input file are expected to have the same number of characters."
    end
  end

  def draw_path
    positions = hash_char_positions
    start_hash_line, start_hash_char, end_hash_line, end_hash_char = *positions.flatten
    min_char, max_char = [start_hash_char, end_hash_char].sort
    draw_vertical_stars(start_hash_line, end_hash_line, start_hash_char)
    draw_horizontal_stars(end_hash_line, min_char, max_char)
    draw_endpoints_with_hash(positions)
    @lines.join('')
  end

  STAR_CHAR = '*'

  # draw the vertical portion of the path with star character (if any)
  def draw_vertical_stars(start_hash_line, end_hash_line, start_hash_char)
    start_hash_line.upto(end_hash_line) do |line_idx|
      @lines[line_idx][start_hash_char] = STAR_CHAR
    end
  end

  # draw the horizontal portion of the path with star character (if any)
  def draw_horizontal_stars(line, start_char, end_char)
    start_char.upto(end_char) { |char_idx| @lines[line][char_idx] = STAR_CHAR }
  end

  # ensure that the endpoints are hash characters
  def draw_endpoints_with_hash positions
    positions.each { |line_idx, char_idx| @lines[line_idx][char_idx] = '#' }
  end

  # returns an array of hash character position subarrays, each containing a hash line index and a hash character index
  def hash_char_positions
    hash_positions= []
    @lines.each_with_index do |line, line_index|
      line.enum_for(:scan, /#/).each do
        hash_positions << [line_index, Regexp.last_match.begin(0)]
      end
    end
    if hash_positions.count != 2
      raise ArgumentError, "Incorrect hash symbol number!!! except exactly two hash symbols."
    end
    hash_positions
  end

end

## Main script ##
if __FILE__ == $0
  if ARGV.length != 2
    raise ArgumentError, "Hey this pather program needs two input files to run \n
          Proper usage is:  ruby pather.rb <input file> <output file>"
  else
    accepted_format = ".txt"
    raise ArgumentError, "Input only txt format file. "  unless File.extname(ARGV[0]).eql?(accepted_format)
    pather = Pather.new(File.readlines(ARGV[0]))
    File.open(ARGV[1], 'w') {|f| f.write(pather.draw_path) }
  end
end
