local ServerStorage = game:GetService("ServerStorage")

local function clearForcedRoles()
	local folder = ServerStorage:FindFirstChild("ForcedRoles")
	if folder then
		local murderer = folder:FindFirstChild("Murderer")
		if murderer and murderer:IsA("StringValue") then
			murderer.Value = ""
		end

		local sheriff = folder:FindFirstChild("Sheriff")
		if sheriff and sheriff:IsA("StringValue") then
			sheriff.Value = ""
		end
	end

	_G.CustomMurderer = nil
	_G.CustomSheriff = nil
end

return function()
	clearForcedRoles()
	return "Forced Murderer and Sheriff picks cleared."
end