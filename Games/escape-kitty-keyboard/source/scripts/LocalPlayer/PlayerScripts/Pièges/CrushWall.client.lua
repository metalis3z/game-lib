-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = game:GetService("CollectionService")
local u3 = {}
v1.PreRender:Connect(function()
	-- upvalues: (copy) u3
	local v4 = workspace:GetServerTimeNow()
	for v5, v6 in u3 do
		if v5:IsDescendantOf(workspace) then
			local v7 = v5:GetAttribute("CycleStartTime") or 0
			if v7 ~= 0 then
				local v8 = v5:GetAttribute("CloseTime") or 2
				local v9 = v5:GetAttribute("WaitTime") or 1
				local v10 = v5:GetAttribute("OpenTime") or 1
				local v11 = v8 + v9 + v10
				local v12 = (v4 - v7) % v11
				if v12 < v8 then
					local v13 = v12 / v8
					v6.L.CFrame = v6.startL:Lerp(v6.endL, v13)
					v6.R.CFrame = v6.startR:Lerp(v6.endR, v13)
					if v6.SoundL and not v6.SoundL.IsPlaying then
						v6.SoundL:Play()
					end
					if v6.SoundR and not v6.SoundR.IsPlaying then
						v6.SoundR:Play()
					end
					v6.LastState = "Closing"
				elseif v12 < v8 + v9 then
					v6.L.CFrame = v6.endL
					v6.R.CFrame = v6.endR
					if v6.LastState == "Closing" then
						if v6.SoundL then
							v6.SoundL:Stop()
						end
						if v6.SoundR then
							v6.SoundR:Stop()
						end
						if v6.ImpactS then
							v6.ImpactS:Play()
						end
						v6.LastState = "Wait"
					end
				else
					local v14 = (v12 - (v8 + v9)) / v10
					v6.L.CFrame = v6.endL:Lerp(v6.startL, v14)
					v6.R.CFrame = v6.endR:Lerp(v6.startR, v14)
					if v6.SoundL and not v6.SoundL.IsPlaying then
						v6.SoundL:Play()
					end
					if v6.SoundR and not v6.SoundR.IsPlaying then
						v6.SoundR:Play()
					end
					v6.LastState = "Opening"
				end
			end
		end
	end
end)
v2:GetInstanceRemovedSignal("CrushTrap"):Connect(function(p15)
	-- upvalues: (copy) u3
	u3[p15] = nil
end)
local function u22(p16) -- name: setupTrap
	-- upvalues: (copy) u3
	local v17 = p16:WaitForChild("WallL", 5)
	local v18 = p16:WaitForChild("WallR", 5)
	local v19 = p16:WaitForChild("TargetL", 5)
	local v20 = p16:WaitForChild("TargetR", 5)
	local v21 = p16:WaitForChild("CrushCenter", 5)
	if v17 and (v18 and (v19 and (v20 and v21))) then
		u3[p16] = {
			["LastState"] = "Idle",
			["L"] = v17,
			["R"] = v18,
			["startL"] = v17.CFrame,
			["startR"] = v18.CFrame,
			["endL"] = v19.CFrame,
			["endR"] = v20.CFrame,
			["SoundL"] = v17:FindFirstChild("MoveSoundL"),
			["SoundR"] = v18:FindFirstChild("MoveSoundR"),
			["ImpactS"] = v21:FindFirstChild("ImpactSound")
		}
		v19.CanCollide = false
		v20.CanCollide = false
	end
end
for _, v23 in ipairs(v2:GetTagged("CrushTrap")) do
	u22(v23)
end
v2:GetInstanceAddedSignal("CrushTrap"):Connect(function(p24)
	-- upvalues: (copy) u22
	if p24:IsA("Model") then
		u22(p24)
	end
end)