# SQL injection is a code injection technique that might destroy your database.
# SQL injection is one of the most common web hacking techniques.
# SQL injection is the placement of malicious code in SQL statements, 
# via web page input.

module Validation
    # validation_nil_empty_input used to verify fields contain input.
    def validation_nil_empty_input(*input)
        return true if input.nil? || input.empty?
        false
    end

    # validation_lenght_of_sting used to stop large sting insertion.
    def validation_lenght_of_sting(input)
        return false if input.length.between?(8, 25)
        true
    end

    # validation_no_asperand used to help verify email syntax.
    def validation_no_asperand(input)
        return true unless input.include?("@")
        false
    end

    # forbidden_char not allowed in the input field.
    def validation_forbidden_char(*input)
        char = ['<', '>',]
        return true if char.any? { |charater| input.include?(charater) }
        false
    end
end