-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = game:GetService("CollectionService")
local u3 = {}
local function v9(p4) -- name: setupTrap
	-- upvalues: (copy) u3
	local v5 = p4:WaitForChild("LavaPart", 10)
	local v6 = p4:WaitForChild("LavaBottom", 10)
	local v7 = p4:WaitForChild("LavaTop", 10)
	if v5 and (v6 and v7) then
		v6.Transparency = 1
		v6.CanCollide = false
		v7.Transparency = 1
		v7.CanCollide = false
		local v8 = v5:FindFirstChildOfClass("Sound")
		if v8 then
			v8:Play()
		end
		u3[p4] = {
			["Lava"] = v5,
			["Bottom"] = v6,
			["Top"] = v7,
			["Sound"] = v8
		}
	end
end
v1.PreRender:Connect(function()
	-- upvalues: (copy) u3
	local v10 = workspace:GetServerTimeNow()
	for v11, v12 in u3 do
		if v11:IsDescendantOf(workspace) then
			local v13 = v11:GetAttribute("CycleStartTime") or 0
			if v13 ~= 0 then
				local v14 = v11:GetAttribute("RiseTime") or 5
				local v15 = v11:GetAttribute("TopWait") or 1
				local v16 = v11:GetAttribute("FallTime") or 2
				local v17 = v11:GetAttribute("BottomWait") or 2
				local v18 = v14 + v15 + v16 + v17
				local v19 = (v10 - v13) % v18
				local v20 = v12.Bottom.CFrame
				local v21 = false
				if v19 < v14 then
					v20 = v12.Bottom.CFrame:Lerp(v12.Top.CFrame, v19 / v14)
					v21 = true
				elseif v19 < v14 + v15 then
					v20 = v12.Top.CFrame
				elseif v19 < v14 + v15 + v16 then
					local v22 = (v19 - (v14 + v15)) / v16
					v20 = v12.Top.CFrame:Lerp(v12.Bottom.CFrame, v22)
					v21 = true
				end
				v12.Lava.CFrame = v20
				if v12.Sound then
					v12.Sound.Volume = v21 and 1 or 0
				end
			end
		end
	end
end)
v2:GetInstanceAddedSignal("LavaTrap"):Connect(v9)
v2:GetInstanceRemovedSignal("LavaTrap"):Connect(function(p23)
	-- upvalues: (copy) u3
	u3[p23] = nil
end)
for _, v24 in ipairs(v2:GetTagged("LavaTrap")) do
	v9(v24)
end