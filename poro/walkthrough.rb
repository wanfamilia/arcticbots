require 'csv'

class Walkthrough
  kharolis = '
Thorbardin, all west to esd,
 - Eesee to overseer, kill, loot key, www, manager, get all table, shake cup, get key, een, unlock safe, unlock again, get all safe, sww, unlock vault, open vault, w, get all table, Eenww (initial esd)
 - ddnnun, 4nen, drop crate, light crate, esss, open door, s, nw3sds, (inside dwarven mine nws), ww, all south, eeneenu5ne, spellup, n
  '

  flying_citadel = '
Locations: thorb, rockhorde, dwarf keep, hylo, solace (11 e of gates, northeastish), firstwal
 - Rockhorde: bali all north to hot dry road, w6nees… climb rocks e..e
 - Hylo: w..swwnn (look east for ramp)
 - Solace east gates: 11enenenwn
 - Kalaman Firstwal: south gates, s.. w.. n..
 - Thorbardin: steep pass, w..w..e..e
 - Dwarf keep gates: sdee
  '

  dk_quest = '
- delphon to the dragonarmy compound, salute the leader guy drogo,
- solamnic encampment, nw corner (commander’s quarters), open flap, northish, kill gamso, and search corpse, then go back southish to flap area, n, hidden down to prison, kill jailer, northish, unlock door e, display seal, display ring
- delphon, insert coin altar or similar, embrace lily, learn all
  '

  regen_quest = 'Regen Quest:
- Go to Jungle 7w?, all s, Kill Serpent High Priest Get Snake Staff,
- Control Spirit, Bind Spirit Self, Hold Snake staff, Decipher Mark/writing (west is real dt)
- Go All East - Kill Carrion Crawler (Safe Flee, ancestral spirit helps) - N (Hidden Exit)- Move Boulders, Cast DELAY DEATH - N- Cast Sanctuary Self- Cure Self Up, north
- Flee hidden north (there will be some hard hit mob)- Flee/Scan till see pool.- Flee/Walk direction to Pool (Safe Room), - C Devouring Spirit stalactite - Remove Fly - Quaff Waterbreath Potion - C Sublime Resistant Breath - C Sublime Resistant Gas - C Sanctuary Self
- All D (No Spell room) - Rummage (Check for A corpse of Aboleth Scale) - Hack Corpse - get all corpse - Wear Amulet, uu, Go all W, all n, all w- Walk N & E (Scan till you see a room with a Serpent at N)
- C Sublime Resistance Breath/Gas/Negative Energy, spiritual guidance- N, Kill High Serpent (Reflect Mob/No Magic/Safe Flee), Flee when HP are Low- Cure Critical Self - Go In Kill Again Until It Rip, Open Altar (Charm at Altar)- Get all Altar
'


  dargaard_valley = '
Beside nes mountains (south of the dargaard keep nes): eenwwnw, sentries block evil (locate book?), wn, 4w
  - 2w2n hidden exit 3wdww, startled man in foliage, sw until cannot move s or w, nww4s to a copse
    - Acidic: fade all s, wse, fade sswss (stabber) eesess, rocky stand, climb tree, u u s, dsw get all hole
    - Goblin for omen quest: ssseen4es
  - 2w all north are kll knights, kill dragons,
  - 3n are scan 2 guards, kill them and they shout, boss east, paladin lady another
  '

  shadows = '
 - New khita: 3w9ne, climb opening, e, enter cave
   - wseenw, the dark pier, step w.., sentinels massive aoe, black iron key, (east safe) north zone
   - climb opening, e, (enter cave, w) climb cliff, jump ledge, rit people, climb wall
 - Killing room,
   - e or w, clear ramparts, back down,
   - get key, unlock portcullis, north, eene, search hay, nww, smith essww
 - All north, up, northern balcony, e.., e
   - climb stairs up, w, search bed (parchment), climb stairs up, climb stairs up, Eastern staircase, nw, enter confessional, unfold parchment, open window, ses, climb stairs up, west mortician, climb stairs dddd
 - wsw, snatch rose, ww, u kill, u u, open door for wraith, loot,
   - up until e, open, e, a lavish bedroom, l painting (with nightvision) gaze darkness, climb stairs d
   - D e, l painting, gaze darkness (with nv to get keyword) w d
 - Enne northern balcony, say kw from b4, (d for kelize) n, climb stairs up, south/flee if aggroed
'
  mystic = '
From Tarsis Mage to Mystic - w,s,3w,s,w,3s,w,s,5w,n,w,u,n,d,w,s,d,5w,2n,w (shark),w,4n,w,n,e (priest)
From Priest - 2w,d (move fountain/loot key),u,e,n,3e,n (kill commander/loot letter),s,2w (unlock/open gate),n, Locate(gift) silver.bow, royal.shield, book, silver fauld
send tank or poofer n and drag group n u have poofer relo,e,d,n,u,n @On a Large Tree Branch type open bark,e non evil type agree, if evil kill, get key
w,d,2n,2e,n,w (unlock/open gate),2w,2s (type enter),2n have group wait,
  - Nns, east at nes, graden in the court yard, open statue, open statue, get all statue; flee
  - Nn to es: east, get key smash orb,
  - If in labyrinth  unuds
unlock/open hatch and crate, loot key,d (unlock/open silver),3e (open hatch),
U (rittable),n,2w,s (open wooden),e,2u (kill quock),2d,w,n,2e,2s (ki Mira),n,d,
2n (pull rug then touch floor),n present letter, get key, kill amit/general
North, nomagic queen, east
vault combo; pull handle
Nnsn, get key bones, unlock door, nomagic w
'

  forgotten_temple = '
all north, sseneu, get key officer, south, west, get all commander, eenndws, to statue of paladine, unlock/loot statue, wnn, unlock doors at dead end,
NESW:
  - east is toward the mages and balor, west is toward the trainer and Krona, and north is toward Ombra.  E, get all shelf, kill tesiak, combine page page, decipher page (in tesiak room) get key, unlock loot chest, destroy circle to fight balor
  - Wwws kill trainer/trainees, nw, kill 3knights, en, kill general and krona, unlock/loot desk (piece of rose), sseee
  - North west kill priest, smash statue 2nd rose, combine rod bud, east north to ombra, slide tapestry, fight goodie stoneskin golem with nocleric magic, place rose pedestal,
enter portal, say evil, say will, say win, poke man, ees, lg touch rune, push rune, sss samus
  '

  pax = '
Nsw south of quali fork in the road: w.. Checkpoint, kill, south
 - W.., s nofly dt, pull stone in room, ee nomagic fight, u.., big tank knock door solo fight, klur, loot chest, back down, west S.. to wounded knight, give vial me, back to start,
 - east until nsw, 3s, discovered near the guard towers
   - S under a guard tower, tank first climb ladder, loot bow, down, north
 - insert figurine hole, say huma, e.., n..
 - Goodie pray statue, n, turn wheel, s e (to group), E.., e.., e.., enter waterfall, n.., e (muddy passage way)
   - At centre of action nesw before edd to waterfall is north to druid
   - All west, s,  open crack to roc
   - East.. (north to sigurd), e..
 - Hidden south, d, origins, kinslayer, vinas solamnus, cataclysm, (turn statue and back)
 - D.. small circle (rittable), 3new, n (kill w e), n kill e, (to get out wws all west, follow path, centre of the cation)
'

  dk_spells = '
- Hct unholy wrath: atriho druul, you kill portcullis guards, unlock it, there are 2 sets of wandering knights then kill straph for the key, he has some people with him take the key and go s w (maybe one more west) of straph then go n, regen the tank, tank u then head south and up until you get to the hatch have a thief or white robe pick that hatch and then send your dk u if a non evil goes up draco will come out and murder everyone
- irda dark blessing: gnobo ras, irda all east, south, just before storm giant unessd, head westish down eastish to cells"
- raynes impunity: freya, Start in Pal S Gate 2s w 2s w 2s e s u s e 3s e s u w s u e to "Outside a Black Gate", east of gate is two rooms with lots of agro guards that dont see dark. Also, once fighting starts, more guards enter. Need to darkness at "Outside a Black Gate", go east, kill guards, go back to "Outside a Black Gate", recup/mem, and repeat until all guards are dead, get a thin silver whistle from the corpse of one of the guards, blow whistle, will get message, then open door,
s to "In the Vestibule", open door, darkness, w d w to "A Misty Corridor", killing any guards on the way
open door, Xill will insta agro. Stabs, bashes, triple massacres. Hard fight. Kill him, get a long black iron key
2s, unlock door e, open door e. e. Learn all if Freya Tamerley is present to learn the impunity spell.
'
  align = %{
Alignment Change
GL = A priest of Paladine has a pure soul, with good intentions. (Near Palanthas clerics guild)
GC = A disciple of Habbakuk's soul is in turmoil, but it is yet pure. (NW corner of Kalaman park)
GN = A monk of Majere's soul shines slightly with elements of purity. (SE corner of Solace reading room)
NG = A disciple of Chislev's soul shines slightly with elements of purity. (East of Caergoth, off of highway)
NL = A young disciple of Shinare has a balanced soul. (Outside W gate of Tarsis)
NC = A priest of Gilean's soul is in turmoil, having no direction. (E side of Hopeful)
NE = A disciple of Sirrion's soul is slightly tinged with shades of darkness. (NE from Pasal in Newport)
EN = A withered servant of Morgion's soul is slightly tinged with shades of darkness. (2n of Balifor Thieve's guild)
EC = A servant of Hiddukel's soul is in turmoil, but it is yet dark. (Delphon, S from bank)
EL = A dark acolyte of Takhisis has a dark soul, with dark intentions. (Neraka, southern part of temple)
  }

  sword_quest = '
- Glade of whitestone, pray gladestone, say Est Sularus Oth Mithas, kyle (sw of garret commons), say measure
- Storms: noom room, look nightstand, exam nightstand, look letter
- FC: Tenlo, search crates - malaak, sarson, terzak, gal’vari, nria, serra
- Present books, pray at whitestone
  - Boku: climb ladder, northeastish, researchers, move wall, kill malaak open cage, gather pages cages, kyle present sheaf, pray whitestone
  - Terzak, get book shelf, kyle present code, pray whitestone
  - Gal’vari: xoc west, south display branch, kzazz all east, give block old, look desk, get package desk, kyle present package, pray whitestone
  - Balcombe, kill serra, kill balcombe, north library, listen librarian, c ‘abso’ librarian, kyle present parchment, kneel whitestone
- Garret marquinn, embrace sword
'
  def gids
    @gids ||= {
      scout: 639581645, druid: 1441633397, conclave: 500434377, cleric: 1585221168
    }
  end

  def myth_sheet(name)
    return 'sheets: '+gids.keys.sort.join(', ') if ['list', '', nil].include?(name)
    "https://docs.google.com/spreadsheets/d/1CaY1OIsBGBRqq6kvNlachl8FNQUjW6FGcE2FlYEvTwo/edit#gid=#{gids[name.to_sym]}"
  end

  essence = '
 - water: Lezi is NW part of Dargo in the coral gardens
 - earth: Directions to EERN (Earth Essence), N Gate Balifor nneenennneeneseeeeessesesww to Dense Forest of Beasts Run sseeeneenee to Fork in the Path, fight ssseeesenessenen, fall down (featherfall) esseneneeeu a bunch east. Fights along the way, they might not see invis though
 - fire: Slarn stormhead wanders around the crater level. Watch out for nofly dt
 - air: Dara is north of the straight path leading to the gate/door of cloud kingdom palace In some spinny cloudy area with... Ki-rins I think
'

  INLINE_DATA = {
    'drac tower' => "coast, 4w2(4?)n, w, drop coin, w(shark), flee-w, nn, e,  nws-ish, north, open bush, armory, get key, move cabinet, search rubble, north, up, kitchen (nw) open box, get all box, forge  fix key, horse squire knight, north, poison meat, get meat, eastup, throw meat, Unlock insignia, touch/move insignia, incubator, present egg",
    'dim door' => 'hylo west gates, 3w4nwnww, loot corpse',
    'tultuk' => 'solace west gate, all south until nsw, w.. To nes, all n, ent opening, north till d, all s, wn, tultuk',
    'stingworm' => 'Solace - 18e6n3w (ent), 4nene2n, 2ne8n3e',
    'shaman regen quest' => regen_quest,
    'bonfair' =>  'tarsis west gate, wsw3n4w3n', 'forgotten temple ft' => forgotten_temple,
    'kharolis' => kharolis, 'align' => align, 'dark knight dk quest' => dk_quest,
    'dkspells' => dk_spells, 'sword paladin quest' => sword_quest,
    'dargaard valley dv' => dargaard_valley, 'glymmer pax ' => pax,
    'flying citadel locations' => flying_citadel, 'shadows night golem bladeless' => shadows,
    'stone skin essence' => essence, 'mystic' => mystic,
    'hippo hide' => 'reef torturer knife, shoal corpse rummage/search, peel/slice, bring flap to pirate ship, climb ship, 2k coins for navigator, present, khegar the mountain of blood shoal, climb ladder, crocodiles, hippo',
    'dargo shop' => "dargo, wake, nww open gates, ssw, (y of waterway)\n  - shark bow: wnne\n  - components: ssessw",
    'crystal quest' => 'palanthas, n to open sea, nwn (jade somewhere search stream get all stream, dracolisk get shard, chip shard in basilisk rooms), crystal knight, ne,  slide jade niche, slide shard stand'
  }.freeze

  def sheet_data
    hashes = CSV.table('arctic-zones.csv', headers: true, encoding: 'UTF-8').map(&:to_hash)
    hashes.map{|x| [x[:eq].downcase.strip, indent(x[:directions])]}.to_h
  end

  def indent(raw)
    raw.lines.map{|x| x.gsub(/[[:space:]]+/, ' ').strip}.join("\n")
  end

  def data
    @data ||= INLINE_DATA.merge(sheet_data)
  end

  def list
    zones = data.keys.sort.join(', ')
    "I have zone info for: #{zones}"
  end

  # def sheet(name)

  def info(name)
    return list if name == 'list'
    result = data[name.to_s] || loose_match(name) || "No zone info for #{name}. #{self.list}"
    pretty(result)
  end

  def restrict(items)
    %w(scout mage)
  end

  def pretty(raw)
    "```#{raw}```"
  end

  def loose_match(name)
    return nil if name.to_s.strip.empty?
    keys = filtered(name, data.keys)
    return data[keys.first] unless keys.length > 1
    "Multiple matches for #{name}: #{keys.join(', ')}"
  end
  
  def filtered(filter, all_rooms)
    fragments = filter.split('.')
    all_rooms.select { |x| match_all(x, fragments) }
  end

  def match_all(text, fragments)
    fragments.all?{|x| text.include?(x)}
  end  
end