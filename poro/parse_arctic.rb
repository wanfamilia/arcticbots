class ParseArctic
  def delimit(values)
    previous_return = false
    previous_yield = false
    values.chunk do |me|
      # every true yield marks the beginning of a new chunk
      current_yield = yield me
      current_return = previous_yield ? !previous_return : previous_return
      previous_yield = current_yield
      previous_return = current_return
    end.map{|me| me.last}
  end

  def parse_millis(value)
    /200 OK in (\d+)/.match(value)[1].to_i
  end

  def filter_file(input_name)
    output_name = input_name + '.short.txt'
    File.open(output_name, 'w') do |f|
      delimit(IO.foreach input_name) do |line|
        match = line =~ /^\d+H/
        !!match
      end.select{|lines| keep_chunk?(lines) }.each do |lines|
        showlines = lines.reject do |line|
          gag?(line)
        end
        to_write = to_write(showlines)
        f.write(to_write.join) unless to_write.empty?
      end
    end
    'echo done parse'
  end

  def to_write(lines)
    return [lines.first] if lines.length < 3
    last_line = lines.last.strip
    return lines unless last_line =~ /^\d+H.+Exits:/
    raw_exits = last_line.match(/Exits:([^>]*)>/)
    exits = raw_exits ? raw_exits[1] : ''
    direction = lines[0].strip.match(/^You follow \w+ (\w+)/)
    return lines.select{|line| talking? line} unless direction
    result = "\n#{direction[1]} -> #{lines[1].strip}: #{exits}\n"
    [result]
  end

  def gag?(line)
    line.strip.empty? || (line =~ /^\w+(( the)? (clay|fearsome blue|bronze) (dragon|golem))? (flies|leaves|arrives|bursts)/) ||
      (line =~ /^You feel a .whoosh/) || (line =~ /^The spirit/) || (line =~ /^\w+:/) || (line =~ /^:/)
  end

  def keep_chunk?(lines)
    lines.any? do |line|
      (line =~ /^You follow/) || (talking?(line))
    end
  end

  def talking?(line)
    line =~ /^\w+ (says|tells your group)/
  end

  def demo_old
    require 'CSV'
    puts 'hi'
    t = CSV.table('arctic-zones.csv', headers: true)
    puts t.map(&:to_hash)
  end

  def demo
#     %Q[curl -H "Content-Type: application/json" -X POST -d '{"content": "hello"}' #{key}]
    'hello world'
  end
end
