#!/usr/bin/env ruby

require 'discordrb'
require 'csv'
require_relative 'poro/walkthrough'
require_relative 'poro/component'
require_relative 'poro/mapper'

def secret(key)
  require 'yaml'
  YAML::load_file(File.join(__dir__, 'secret.yml'))[key.to_s]
end

t2 = secret :disco_key

class MagicWords
  LONG_SYLLABLES = [
    ['ar', 'abra'], ['au', 'kada'], ['bless', 'fido'], ['blind', 'nose'],
    ['bur', 'mosa'], ['cu', 'judi'], ['de', 'oculo'], ['en', 'unso'], ['light', 'dies'],
    ['lo', 'hi'], ['mor', 'zak'], ['move', 'sido'], ['ness', 'lacri'], ['ning', 'illa'],
    ['per', 'duda'], ['ra', 'gru'], ['re', 'candus'], ['son', 'sabru'], ['tri', 'cula'],
    ['of', 'ay'], ['dark', 'dulak'], ['ho', 'pa'],
    ['ven', 'nofo'], ['tect', 'infra'], ['light', 'abrazak'], ['co', 'zahl'], ['sh', 'thol']
  ].to_h.freeze

  SHORT_SYLLABLES =[
    ['b', 'b'], ['c', 'q'], ['d', 'e'], [' ', ' '],
    ['f', 'y'], ['g', 'o'], ['h', 'p'], ['i', 'u'], ['k', 't'], ['l', 'r'], ['m', 'w'],
    ['n', 'i'], ['p', 's'], ['q', 'd'], ['r', 'f'], ['s', 'g'], ['t', 'h'], ['u', 'j'],
    ['w', 'x'], ['x', 'n'], ['y', 'l'], ['z', 'k']
  ].to_h.freeze

  MAIN_SYLLABLES = LONG_SYLLABLES.merge SHORT_SYLLABLES

  ENCODE_SYLLABLES = {'a' => 'a', 'o' => 'a', 'e' => 'z', 'v' => 'z'}.merge(MAIN_SYLLABLES)

  DECODE_SYLLABLES = {'a' => 'a|o', 'z' => 'v|e'}.merge(MAIN_SYLLABLES.invert)

  def decode(word)
    tokenize(word, DECODE_SYLLABLES).map{|x| DECODE_SYLLABLES[x]}.join('')
  end

  def encode(word)
    tokenize(word, ENCODE_SYLLABLES).map{|x| ENCODE_SYLLABLES[x]}.join('')
  end

  def foom
'       ** ****** ****
    ** ***     *****  **
   ** **      *     ***  *
   *    ** **   *   *  * **
  *  ** * *          *     *
  *  *    **            * * *
 * * ** *     *   ******  *
  *   * * **  ***     *  * *
    *  *  * **********  *** *
     *****   *     *   * * *
            *   * *
           *  * *  *
          *  *  **  *
          * **   * *
            *  * *
            * *  **
           **     ****
          ***  * *    ****
********** ** *   ** *   *********
     _____ ___   ___  __  __
    |  ___/ _ \ / _ \|  \/  |
    | |_ | | | | | | | |\/| |
    |  _|| |_| | |_| | |  | |
    |_|   \___/ \___/|_|  |_|

The mud has crashed. Please try again later.'
  end

  def tokenize(word, syllables)
    token(word, [], syllables)
  end

  def sound(bot, event, args)
    vb = bot.voice_connect(event.author.voice_channel)
    dirs = %w(mario protoss edited)
    folder = args.first
    return "#{folder} should be one of: #{dirs.join(', ')}" unless dirs.include? folder
    file = Dir["./sounds/#{folder}/*.wav", "./sounds/#{folder}/*.mp3"].sample
    puts file
    event.voice.play_file(file)
  end

  def token(word, tokens, syllables)
    return tokens if word.empty?
    subwords = (0..(word.length-1)).to_a.reverse.map { |i| word[0..i] }
    subword = subwords.select{|x| syllables.key?(x)}.first

    return token(word[1..(word.length)], tokens, syllables) if subword.nil?
    tokens << subword
    token(word[(subword.length)..(word.length-1)], tokens, syllables)
  end
end


bot = Discordrb::Commands::CommandBot.new token: t2, prefix: ':', client_id: 566506575569616898
words = MagicWords.new
zone = Walkthrough.new
mapper = Mapper.new(IO.readlines('shared/roomnames.txt'))
component = Component.new
bot.command(:hello, description: 'example :hello world')  do |_event, *args|
  "tty: #{STDIN.tty?}"
end

bot.command(:args, description: 'example :args one two three') do |_event, *args|
  args
end

recipe_help = 'example :recipe As the usefulness of a light-bending prism ends, it suddenly disappears. As the usefulness of a basilisk eyelash ends, it suddenly disappears. As the usefulness of a newly spun chrysalis ends, it suddenly disappears.'

bot.command(:recipe, description: recipe_help) do |_event, *args|
  component.recipe(args.join ' ')  
end

bot.command(:decode, description: 'Example :decode pzar') do |_event, *args|
  line = args.join(' ')
  words.decode line
end

bot.command(:restrict, description: 'invert the class restrctions') do |_event, *args|
  zone.restrict(args).join ', '
end

bot.command(:encode, description: 'Example :encode heal') do |_event, *args|
  line = args.join(' ')
  words.encode line
end

bot.command :zone, description: 'Example :zone dk quest' do |_event, *args|
  args.first ? zone.info(args.join ' ') : zone.list
end

bot.command :sheet, description: 'Example :sheet druid' do |_event, *args|
  zone.myth_sheet(args.first)
end

bot.command :rooms, description: 'Example :rooms recup' do |_event, *args|
  mapper.room_names(args.join ' ')
end

bot.command :path, description: 'Example (use rooms to filter lister of rooms) :path westwinds rec.kal' do |_event, *args|
  alen = args.length
  return "enter a start room and a destination room" if alen < 1
  return "use . instead of spaces for rooms that have spaces" if alen > 2
  mapper.path args[0], args[1]
end

bot.command :joke, description: 'bad dad joke' do |_event, *_args|
  `curl -H "Accept: text/plain" https://icanhazdadjoke.com/`
end

# bot.command :sound  do |event, *args|
#   words.sound(bot, event, args)
# end

bot.command :reload, description: 'reloads after code/data changes' do
  bot.stop
end

bot.command :foom, description: 'Shows the foom' do
  zone.pretty words.foom
end

bot.command :voice_off do |event, _args|
  event.voice.destroy
  nil
end

bot.run

