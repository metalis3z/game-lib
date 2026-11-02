-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = game:GetService("CollectionService")
local u3 = {}
local function v6(p4) -- name: registerTimer
	-- upvalues: (copy) u3
	if p4:IsA("TextLabel") then
		local v5 = p4:FindFirstAncestorOfClass("Model")
		if v5 then
			u3[p4] = v5
		end
	end
end
local function v8(p7) -- name: unregisterTimer
	-- upvalues: (copy) u3
	u3[p7] = nil
end
for _, v9 in ipairs(v2:GetTagged("Timer")) do
	if v9:IsA("TextLabel") then
		local v10 = v9:FindFirstAncestorOfClass("Model")
		if v10 then
			u3[v9] = v10
		end
	end
end
v2:GetInstanceAddedSignal("Timer"):Connect(v6)
v2:GetInstanceRemovedSignal("Timer"):Connect(v8)
v1.RenderStepped:Connect(function()
	-- upvalues: (copy) u3
	local v11 = workspace:GetServerTimeNow()
	for v12, v13 in u3 do
		local v14 = v13:GetAttribute("BridgeDie")
		local v15 = v13:GetAttribute("ServerStartTime")
		if v14 and v15 then
			local v16 = v14 - (v11 - v15)
			local v17 = math.max(0, v16)
			if v17 > 0 then
				v12.Text = string.format("%.2f", v17)
				v12.TextColor3 = v17 < 1 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)
			else
				v12.Text = "Wait..."
				v12.TextColor3 = Color3.new(1, 0, 0)
			end
		end
	end
end)