

local u1 = game:GetService("PolicyService")
local u2 = game:GetService("Players").LocalPlayer
local v3, v4 = pcall(function()

	return u1:GetPolicyInfoForPlayerAsync(u2)
end)
if v3 and v4 then
	local v5 = v4.AllowedExternalLinkReferences
	local v6 = { "X", "Discord", "YouTube" }
	local v7 = 0
	for _, v8 in pairs(v5) do
		if table.find(v6, v8) then
			v7 = v7 + 1
		end
	end
	if v7 < #v6 then
		script.Parent.Text = "See HD Admin\'s description (in Marketplace) for updates"
	end
end