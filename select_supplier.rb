require_relative 'supplier'

class SelectSupplier
  attr_accessor :grade_weight

  def initialize(suppliers)
    @suppliers    = suppliers.map { |data| Supplier.new(data) }
    @grade_weight = 1
  end

  def suppliers
    @suppliers.sort_by(&:advitam_grade).reverse.map(&:to_data)
  end

  def work(work_type)
    work_all(work_type).first
  end

  def work_all(work_type)
    selected_suppliers = @suppliers.select { |supplier| supplier.works.has_key?(work_type) }
    selected_suppliers.sort_by! do |supplier|
      global_grade_for(supplier, work_type)
    end
    selected_suppliers.map(&:to_data)
  end

  def supplier_grade(supplier_name, work_type)
    supplier = @suppliers.find { |supplier| supplier.name == supplier_name }
    global_grade_for(supplier, work_type) if supplier
  end

  private

  def global_grade_for(supplier, work_type)
    (@grade_weight.to_i * supplier.advitam_grade.to_i) + supplier.works[work_type].to_i
  end
end
