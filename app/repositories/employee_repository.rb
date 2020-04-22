require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @employees
  end

  def add(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    save_csv
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_name(name)
    @employees.find { |employee| employee.name == name }
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %w[id name password manager]
      @employees.each do |employee|
        csv << [employee.id, employee.name, employee.password, employee.manager]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:manager] = row[:manager] == "true"
      @employees << Employee.new(row)
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end

