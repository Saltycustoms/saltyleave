json.array!(@leaves) do |leave|
  json.extract! leave, :id, :title
  json.start leave.start_date.strftime("%Y-%m-%dT00:00:00")
  json.end leave.end_date.strftime("%Y-%m-%dT23:59:59")
  json.url leave_application_url(leave, format: :html)
end
