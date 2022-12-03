class ParseArctic
  def delimit(values)
    previous_return = false
    previous_yield = false
    values.chunk do |me|
      # every true yield marks the end of a chunk
      current_yield = yield me
      current_return = previous_yield ? !previous_return : previous_return
      previous_yield = current_yield
      previous_return = current_return
    end.map{|me| me.last}
  end

  def schema_info
    output_name = 'log/small-schema.rb'
    File.open(output_name, 'w') do |f|
      td = table_lines.map{|lines| table_data lines}.to_h
      f.write td
    end
    "echo done schema_info"
  end

  def table_data(lines)
    table_name = lines.first.gsub /.+create_table\s+"(\w+)".+/, '\1'
    columns = lines.select{|line| line.include? 'null: false'}.map{|line| column_name line}
    [table_name.strip, columns.map(&:strip)]
  end

  def column_name(line)
    line.gsub /\s+t.\w+\s+"(\w+)".+/, '\1'
  end

  def table_lines
    input_name = 'db/schema.rb'
    delimit(IO.foreach input_name) do |line|
      line.strip.start_with?('end')
    end.map{|lines| table_block lines}.reject{|lines| lines.empty?}
  end

  def table_block(lines)
    lines.drop_while{|line| !line.strip.start_with? 'create_table'}
  end

  def krynn201
    input_name = 'krynn.txt'
    output_name = 'krynn201.txt'
    File.open(output_name, 'w') do |f|
      delimit(IO.foreach input_name) do |line|
        line.start_with?('V 2020') || line.start_with?('T')
      end.reject{|lines| lines.last.start_with? 'T' }.each do |lines|
        f.puts lines.reject{|line| line.start_with? 'V 2020'}
      end
    end
    "echo done krynn201"
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


  def motes(input_name)
    # cat logs/white.txt | grep "vanishes leaving behind \(a\|several\) sparkling mote" > shared/motes.txt
    outlines = File.open(input_name).each.uniq.map do |line|
      pat = /(A |An |The |Some )?([^(]+)(\(.+\))? vanishes leaving.+$/
      item = line.gsub(pat, '\2').strip
      "#sub {#{item}}{#{item}(mote)}"
    end

    output_name = input_name + '.short.txt'
    File.open(output_name, 'w') do |f|
      outlines.each {|line| f.puts line}
    end
    'echo done motes'
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
