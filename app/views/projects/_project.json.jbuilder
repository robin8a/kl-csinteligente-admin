json.extract! project, :id, :pr_name, :pr_description, :pr_start_date, :pr_end_date, :pr_admon, :pr_incidental, :pr_indirect_cost, :pr_profit, :pr_tax_iva, :created_at, :updated_at
json.url project_url(project, format: :json)
