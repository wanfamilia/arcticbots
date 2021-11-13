require_relative '../poro/mapper'
require 'rspec'

describe Mapper do
  let(:mapper) {Mapper.new %w(theobald anatole Northwinds Southwinds Westwinds solsquare)}

  before do
    path = 'tmp/pathout.txt'
    File.delete path if File.exists? path
  end

  describe 'path' do

    subject(:path) {mapper.path(start, finish).strip}

    context 'to theobald' do
      let(:finish) {'theobald'}
      let(:expectedFragment) {'1n2e2s1w5s2e5n5e6s2e7s1u2n1w'}

      context 'matching upper case' do
        let(:start) {'Westwinds'}

        it 'has path' do
          expect(path).to include(expectedFragment)
        end
      end

      context 'lower case' do
        let(:start) {'westwinds'}

        it 'has path' do
          expect(path).to include(expectedFragment)
        end
      end

      context 'partial lower case' do
        let(:start) {'westwi'}

        it 'has path' do
          expect(path).to include(expectedFragment)
        end
      end
    end

    context 'one arg' do
      let(:start) {'theobald'}
      let(:finish) {nil}

      it 'has path' do
        expect(path).to eq 'solsquare -> theobald: 1u2n1w'
      end
    end
  end
end