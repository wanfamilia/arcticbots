require_relative '../poro/walkthrough'

describe Walkthrough do
  it 'preserves newlines' do
    garg = Walkthrough.new.data['gargath']
    expect(garg.lines.count).to be > 1
  end
  
  it 'collapses removes spaces and tabs' do
    expect(Walkthrough.new.indent "a\t b\u00A0c").to eq 'a b c'
  end
  
  describe 'myth_sheet' do
    let(:walkthrough) {Walkthrough.new}
    it 'list gives list' do
      expect(walkthrough.myth_sheet 'list').to start_with 'sheets: '
    end
    it 'nil gives list' do
      expect(walkthrough.myth_sheet nil).to start_with 'sheets: '
    end
  end

  describe 'restrict' do
    subject {Walkthrough.new.restrict(rejections)}
    context 'scout' do
      let(:rejections) {%w(NOMAGE NOTHIEF NOPALADIN NODRUID NOCLERIC NOWARRIOR NODARK_KNIGHT NOBARBARIAN
NOBLACK_ROBE NORED_ROBE NOWHITE_ROBE NOSHAMAN)}
      it {is_expected.to contain_exactly 'scout'}
    end
  end
end