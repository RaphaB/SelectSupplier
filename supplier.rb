class Supplier
  attr_reader :name, :advitam_grade, :works

  def initialize(supplier_data)
    @name          = supplier_data[:name]
    @advitam_grade = supplier_data[:advitam_grade]

    works_arr = supplier_data[:works].map { |work| [work[:type], work[:price]] }
    @works    = Hash[works_arr]
  end

  def to_data
    {
      name:          @name,
      advitam_grade: @advitam_grade,
      works:         @works.map { |type, price| {type: type, price: price} }
    }
  end
end
