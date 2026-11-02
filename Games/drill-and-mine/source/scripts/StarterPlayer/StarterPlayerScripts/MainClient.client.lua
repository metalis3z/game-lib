local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ControllerFolder = ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers")

for _, module in ipairs(ControllerFolder:GetChildren()) do
	if module:IsA("ModuleScript") then
		task.spawn(function()
			local ok, result = pcall(require, module)
			if not ok then
				warn(string.format("[MainClient] Failed to require %s: %s", module.Name, result))
				return
			end
			if type(result) ~= "table" then
				warn(string.format("[MainClient] %s returned non-table: %s", module.Name, type(result)))
				return
			end
			if result.Init then
				local initOk, initErr = pcall(result.Init, result)
				if not initOk then
					warn(string.format("[MainClient] Failed to init %s: %s", module.Name, initErr))
				end
			end
		end)
	end
end