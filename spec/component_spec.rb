require_relative '../poro/component'
require 'rspec'

describe Component do
  let(:component) {Component.new}
  describe 'component_for' do
    it 'ape sinew' do
      expect(component.component_for 'As the usefulness of cured ape sinew ends, it suddenly disappears.').to eq 'cured ape sinew'      
    end
    
    it 'musk gland' do
      expect(component.component_for 'As the usefulness of a powerfully odorous musk gland ends, it suddenly disappears.').to eq 'a powerfully odorous musk gland'      
    end

    it 'opaque cornea' do
      expect(component.component_for 'As the usefulness of an opaque cornea ends, it suddenly disappears.').to eq 'an opaque cornea'      
    end
  end
  
  describe 'component_hash' do
    it 'a tuft of skunk fur' do
      expect(component.component_hash['a tuft of skunk fur']).to eq 'High Abjuration'
    end
    
    it 'flower christine' do
      parsed = component.parse("1 x a flower of Queen Christine's lace            (Low Protection)")
      include_flower = include("a flower of Queen Christine's lace" => 'Low Protection')
      expect([parsed].to_h).to include_flower    
      expect(component.component_hash).to include_flower 
    end
  end
  
  describe 'recipe' do
    it 'parses sample' do
        text = "As the usefulness of a light-bending prism ends, it suddenly disappears.
        As the usefulness of a basilisk eyelash ends, it suddenly disappears.
        As the usefulness of a newly spun chrysalis ends, it suddenly disappears.
        As the usefulness of cured ape sinew ends, it suddenly disappears.
        As the usefulness of a small silver sea serpent's scale ends, it suddenly disappears.
        As the usefulness of a miniature golden lyre ends, it suddenly disappears.
        As the usefulness of a powerfully odorous musk gland ends, it suddenly disappears.
        As the usefulness of a heart of a hen ends, it suddenly disappears.
        As the usefulness of a smooth blank runestone ends, it suddenly disappears.
        As the usefulness of a soybean seed ends, it suddenly disappears.
        As the usefulness of a tiny acorn ends, it suddenly disappears.
        As the usefulness of a delicate honeysuckle bloom ends, it suddenly disappears.
        As the usefulness of a dried, discarded snakeskin ends, it suddenly disappears.
        "
        expect(component.recipe text).to include("High Alteration" => 2)  
    end
  end
  
  describe 'lines' do
     it 'introduces newlines' do
       text = "As the usefulness of a light-bending prism ends, it suddenly disappears. As the usefulness of a basilisk eyelash ends, it suddenly disappears."
       expect(component.lines(text).length).to eq 2
     end
  end
end