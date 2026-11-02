local Server = {}
local SS = script

for _, child in ipairs(SS:GetChildren()) do
	if child:IsA("ModuleScript") and child ~= script then
		local success, result = pcall(require, child)

		if success then
			Server[child.Name] = result
		else
			warn(string.format("[Server Loader] Failed to load %s: %s", child.Name, result))
		end
	end
end

return Server