class MoneyFlow
  TYPES = { 'expenses' => 1,
            'income' => 2,
            'saving' => 3,
            'investment' => 4 }.freeze

  TYPES.keys.each do |mf|
    define_singleton_method(mf) { TYPES[mf] }
  end

  def self.type_string(value)
    TYPES.key(value)
  end

  def self.include?(value)
    TYPES.values.include?(value.to_i)
  end
end
