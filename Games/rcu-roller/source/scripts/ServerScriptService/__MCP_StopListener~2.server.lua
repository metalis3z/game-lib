local LogService = game:GetService("LogService")
local StudioTestService = game:GetService("StudioTestService")
LogService.MessageOut:Connect(function(message)
	if message == "__MCP_STOP__" then
		pcall(function() StudioTestService:EndTest("stopped_by_mcp") end)
	end
end)