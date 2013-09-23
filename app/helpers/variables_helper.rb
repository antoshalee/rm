module VariablesHelper
  def variable key
    var = Variable.find_by_key(key)
    var.try(:value)
  end
end