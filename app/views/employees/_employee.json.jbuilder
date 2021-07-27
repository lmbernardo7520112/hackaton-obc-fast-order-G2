json.extract! employee, :id, :name, :type_function, :status, :created_at, :updated_at
json.url employee_url(employee, format: :json)
