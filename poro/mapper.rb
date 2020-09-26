class Mapper
  require 'ostruct'

  def initialize(name_lines)
    @room_names = name_lines.uniq.map(&:strip).sort
  end
  def room_names(filter)
    filtered(filter).join(', ')
  end

  def filtered(filter)
    fragments = filter.split('.')
    all_rooms.select { |x| match_all(x, fragments) }
  end

  def match_all(text, fragments)
    fragments.all?{|x| text.downcase.include?(x.downcase)}
  end

  def all_rooms
    @room_names
  end

  def path(arg1, arg2)
    if arg2
      start = arg1
      finish = arg2
    else
      start = 'solsquare'
      finish = arg1
    end

    start_match = matches(start)
    end_match = matches(finish)
    start_match.error || end_match.error || path_impl(start_match.value, end_match.value)
  end

  def path_impl(start, finish)
    content = %Q{#read shared/path.txt
path {#{start}} {#{finish}}
#end}
    File.write('tmp/pathin.txt', content)
    run_shell 'tt++ tmp/pathin.txt'
    path = File.read('tmp/pathout.txt')
    "#{start} -> #{finish}: #{path}"
  end

  def run_shell(command)
    system command
    # pty command
  end

  def pty(command)
    require 'pty'
    PTY.spawn(command) do |_r, _, _pid|
    end
  end

  def matches(fragment)
    exact = all_rooms.select{|x| x.downcase == fragment.downcase}.first
    return OpenStruct.new(error: nil, value: exact) if exact
    loose = filtered(fragment)
    return OpenStruct.new(error: nil, value: loose.first) if loose.length == 1
    return OpenStruct.new(error: "No matches for #{fragment}") if loose.length < 1
    OpenStruct.new(error: "Multiples matches: #{loose.join(', ')}")
  end

end
