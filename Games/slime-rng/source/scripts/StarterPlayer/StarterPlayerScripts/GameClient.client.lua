local ReplicatedStorage = game:GetService("ReplicatedStorage")
task.wait(1) -- Wait for data to load
local ok, err = pcall(function()
	require(ReplicatedStorage.Source.StartUp.ClientModule)
end)
if not ok then
	warn("[GameClient] Failed to start:", err)
end
