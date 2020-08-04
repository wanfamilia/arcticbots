require_relative '../poro/mapper'
describe Mapper do
  let(:mapper) {Mapper.new %w(theobald anatole Northwinds Southwinds Westwinds solsquare)}

  describe 'path' do

    subject(:path) {mapper.path(start, finish).strip}

    context 'to theobald' do
      let(:finish) {'theobald'}

      context 'matching upper case' do
        let(:start) {'Westwinds'}

        it 'has path' do
          expect(path).to include('n2e2sw5s2e5n5e6s2e7su2nw')
        end
      end

      context 'lower case' do
        let(:start) {'westwinds'}

        it 'has path' do
          expect(path).to include('n2e2sw5s2e5n5e6s2e7su2nw')
        end
      end

      context 'partial lower case' do
        let(:start) {'westwi'}

        it 'has path' do
          expect(path).to include('n2e2sw5s2e5n5e6s2e7su2nw')
        end
      end
    end

    context 'one arg' do
      let(:start) {'theobald'}
      let(:finish) {nil}

      it 'has path' do
        expect(path).to eq 'solsquare -> theobald: u2nw'
      end
    end
  end
end