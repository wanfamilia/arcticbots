class Component
  def component_for(line)
    match = line.match(/As the usefulness of ((a|an)?.+) ends, it suddenly/)
    match && match[1]
  end
  
  def component_hash
    @component_hash ||= unless @component_hash
      csv_data = CSV.table('poro/components.csv', headers: true, encoding: 'UTF-8').map(&:to_hash).map{|x| [x[:component].downcase.strip, x[:type]]}
      txt_lines = File.read('poro/Components.txt').lines.map(&:strip).reject(&:empty?)
      txt_data = txt_lines.map{|x| parse(x)}
      (csv_data + txt_data).to_h
    end
  end
  
  def recipe(text)
    lines(text).map{|x| component_for x}.compact.map do |x| 
      component_hash[x] || "UNKNOWN: #{x}"
    end.compact.group_by(&:to_s).transform_values{|v| v.length}  
  end
  
  def parse(line)
    match = line.match /^\S+ x ([^\(]+)\(([^)]+)/
    raise StandardError, "cannot parse: #{line}" unless match
    [match[1].strip, match[2]]
  end
  
  def lines(text)
    text.gsub('suddenly disappears. ', "suddenly disappears.\n").lines
  end
end