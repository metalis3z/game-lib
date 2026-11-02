local ServerScriptService = game:GetService("ServerScriptService")
local ServicesFolder = ServerScriptService:WaitForChild("Source"):WaitForChild("Services")

for _, module in ipairs(ServicesFolder:GetChildren()) do
	if not module:IsA("ModuleScript") then
		continue
	end

	local ok, result = pcall(require, module)
	if not ok then
		warn(string.format("[MainServer] Failed to require %s: %s", module.Name, result))
		continue
	end

	if result.Init then
		local initOk, initErr = pcall(result.Init, result)
		if not initOk then
			warn(string.format("[MainServer] Failed to init %s: %s", module.Name, initErr))
		end
	end
end