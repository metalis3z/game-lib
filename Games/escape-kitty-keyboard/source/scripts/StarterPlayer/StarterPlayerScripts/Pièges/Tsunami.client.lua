

local v1 = game:GetService("RunService")
local v2 = game:GetService("CollectionService")
local u3 = {}
v1.PreRender:Connect(function()

	local v4 = workspace:GetServerTimeNow()
	for v5, v6 in u3 do
		local v7 = v5:GetAttribute("TsunamiStartTime") or -1
		local v8 = v5:GetAttribute("TravelTime") or 1
		if v7 ~= -1 then
			local v9 = v4 - v7
			local v10 = v9 / v8
			local v11 = math.clamp(v10, 0, 1)
			v6.union.CFrame = v6.startCF:Lerp(v6.endCF, v11)
			if v6.label then
				local v12 = v8 - v9
				local v13 = math.max(0, v12)
				v6.label.Text = string.format("%.1f", v13)
			end
		end
	end
end)
local function v19(p14) 

	local v15 = p14:FindFirstChild("Tsunami")
	local v16 = p14:FindFirstChild("TsunamiSpawn")
	local v17 = p14:FindFirstChild("TsunamiEnd")
	local v18 = p14:FindFirstChild("Timer", true)
	if v15 and (v16 and v17) then
		u3[p14] = {
			["union"] = v15,
			["label"] = v18,
			["startCF"] = v16.CFrame,
			["endCF"] = v17.CFrame
		}
	end
end
for _, v20 in ipairs(v2:GetTagged("TsunamiModel")) do
	v19(v20)
end
v2:GetInstanceAddedSignal("TsunamiModel"):Connect(v19)