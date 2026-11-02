

local v1 = script.Parent.Parent
local v2 = {
	["Notices"] = true
}
for _, v3 in pairs(v1:GetChildren()) do
	if v3:IsA("Frame") then
		if v2[v3.Name] then
			v3.Visible = true
		else
			v3.Visible = false
		end
	elseif v3:IsA("Folder") then
		for _, v4 in pairs(v3:GetChildren()) do
			if v4:IsA("Frame") then
				v4.Visible = false
			end
		end
	end
end