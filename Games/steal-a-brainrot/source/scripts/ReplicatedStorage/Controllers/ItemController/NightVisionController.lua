local v_u_1 = game:GetService("Players")
game:GetService("Lighting")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = v_u_1.LocalPlayer
local v4 = v_u_2:WaitForChild("Packages")
local v5 = require(v4.Net):RemoteEvent("UseItem")
local v_u_6 = script.NightVision
local v_u_7 = script.Nickname
local v_u_8 = false
local v9 = {}
local function v_u_13()
	v_u_8 = false
	for _, v_u_10 in v_u_1:GetPlayers() do
		task.spawn(function()
			local v11 = v_u_10.Character or v_u_10.CharacterAdded:Wait()
			if v11 then
				for _, v12 in v11:GetDescendants() do
					if v12.Name == "NightVisionGoogles" then
						v12:Destroy()
					end
				end
			end
		end)
	end
end
local function v_u_21(p14)
	local v15 = p14.Character or p14.CharacterAdded:Wait()
	local v16 = v15:WaitForChild("Head")
	if p14.Name ~= v_u_3.Name then
		for _, v17 in v15:GetChildren() do
			if v17:IsA("BasePart") and (v17.Name ~= "__HITBOX" and v17:FindFirstChild("NightVisionGoogles") == nil) then
				for v18 = 1, 6 do
					local v19 = v_u_6:Clone()
					v19.Parent = v17
					v19.Face = v18 - 1
					v19.Name = "NightVisionGoogles"
				end
			end
		end
		local v20 = v_u_7:Clone()
		v20.TextLabel.Text = p14.Name
		v20.Parent = v16
		v20.Name = "NightVisionGoogles"
	end
end
local function v_u_23()
	v_u_8 = true
	for _, v_u_22 in v_u_1:GetPlayers() do
		task.spawn(function()
			v_u_21(v_u_22)
		end)
	end
end
v5.OnClientEvent:Connect(function(p24, p25)
	if p24 == "EnableNightVisionCape" or p24 == "EnableNightVision" then
		if p25 then
			v_u_23()
		else
			v_u_13()
		end
	else
		return
	end
end)
v_u_1.PlayerAdded:Connect(function(p26)
	if v_u_8 then
		v_u_21(p26)
	end
end)
v9.Enable = v_u_23
v9.Disable = v_u_13
task.spawn(function()
	local v_u_27 = require(v_u_2.Packages.Observers)
	v_u_27.observeCharacter(v_u_1.LocalPlayer, function(_, p28)
		return v_u_27.observeChildren(p28, function(p29)
			if p29:IsA("Tool") and p29.Name == "Witch's Broom" or p29.Name == "Flying Carpet" then
				return v_u_27.observeAttribute(p29, "IsActive", function(p30)
					if p30 then
						task.spawn(v_u_23)
						return v_u_13
					end
				end)
			else
				return nil
			end
		end)
	end)
end)
return v9