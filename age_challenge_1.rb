class Validator
  def self.valid_parenthesis?(string)
    return 'Invalid input' if string.nil? || string.size > 100

    parenthesis_count = 0
    string.split('').detect do |char|
      parenthesis_count += 1 if char == '('
      parenthesis_count -= 1 if char == ')'

      parenthesis_count.negative?
    end

    parenthesis_count.zero?
  end

end
