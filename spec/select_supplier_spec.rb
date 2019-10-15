require 'rspec'
require_relative '../src/select_supplier'

RSpec.describe SelectSupplier do
  let(:supplier_select) { described_class.new(suppliers) }
  let(:suppliers) do
    [
      {name: "FunePlus", advitam_grade: 3, works: [{type: "embalming", price: 350}, {type: "transport_before_casketing", price: 450}]},
      {name: "FuneTop", advitam_grade: 1, works: [{type: "graving", price: 10}]},
      {name: "FuneTruc", advitam_grade: 5, works: [{type: "embalming", price: 750}]},
      {name: "FuneCorp", advitam_grade: 2, works: [{type: "digging", price: 350}]}
    ]
  end

  describe '#suppliers' do
    subject { supplier_select.suppliers }

    it 'should return suppliers in order' do
      expected_suppliers = ['FuneTruc', 'FunePlus', 'FuneCorp', 'FuneTop']
      result             = subject.map { |supplier| supplier[:name] }
      expect(result).to eq(expected_suppliers)
    end
  end

  describe '#work' do
    subject { supplier_select.work('embalming') }

    before do
      supplier_select.grade_weight = grade_weight
    end

    context 'high grade weight' do
      let(:grade_weight) { 1 }

      it 'should return the correct supplier' do
        expect(subject[:name]).to eq('FuneTruc')
      end
    end

    context 'low grade weight' do
      let(:grade_weight) { -500 }

      it 'should return the correct supplier' do
        expect(subject[:name]).to eq('FunePlus')
      end
    end
  end

  describe '#work_all' do
    subject { supplier_select.work_all('embalming') }

    before do
      supplier_select.grade_weight = grade_weight
    end

    context 'high grade weight' do
      let(:grade_weight) { 1 }

      it 'should return the suppliers in correct order' do
        expected_suppliers = ['FuneTruc', 'FunePlus']
        result             = subject.map { |supplier| supplier[:name] }
        expect(result).to eq(expected_suppliers)
      end
    end

    context 'low grade weight' do
      let(:grade_weight) { -500 }

      it 'should return the suppliers in correct order' do
        expected_suppliers = ['FunePlus', 'FuneTruc']
        result             = subject.map { |supplier| supplier[:name] }
        expect(result).to eq(expected_suppliers)
      end
    end
  end

  describe '#supplier_grade' do
    subject { supplier_select.supplier_grade('FuneTruc', 'embalming') }

    before do
      supplier_select.grade_weight = grade_weight
    end

    context 'with grade_weight equal 1' do
      let(:grade_weight) { 1 }

      it 'should return the correct value' do
        expect(subject).to eq(755)
      end
    end

    context 'with grade_weight equal 42' do
      let(:grade_weight) { 42 }

      it 'should return the correct value' do
        expect(subject).to eq(960)
      end
    end
  end
end
