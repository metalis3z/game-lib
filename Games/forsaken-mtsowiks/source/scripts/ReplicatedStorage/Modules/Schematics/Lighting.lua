local v_u_1 = {
	["isInCutscene"] = false
}
local v_u_2 = require(game.ReplicatedStorage.Modules.Network)
local v3 = {
	["Ambient"] = Color3.fromRGB(141, 89, 79),
	["Brightness"] = 3,
	["ColorShift_Bottom"] = Color3.fromRGB(0, 0, 0),
	["ColorShift_Top"] = Color3.fromRGB(0, 0, 0),
	["EnvironmentDiffuseScale"] = 1,
	["EnvironmentSpecularScale"] = 1,
	["GlobalShadows"] = true,
	["OutdoorAmbient"] = Color3.fromRGB(70, 70, 70),
	["ShadowSoftness"] = 0.2,
	["ClockTime"] = workspace:GetAttribute("Testing") and 6.2 or 6.2,
	["GeographicLatitude"] = 71
}
workspace:GetAttribute("Testing")
local v4 = 0
v3.ExposureCompensation = v4
v3.FogColor = Color3.fromRGB(192, 192, 192)
v3.FogEnd = 100000
v3.FogStart = 0
v_u_1.Properties = v3
function v_u_1.SetAsCurrentLighting(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if not game["Run Service"]:IsServer() then
		v_u_1:SetDefaultLighting()
		local v5 = v_u_2:FireServerConnection("GetCurrentLighting", "REMOTE_FUNCTION")
		if v5 then
			v_u_1:SetCustomLighting(v5)
		end
	end
end
function v_u_1.SetCustomLighting(_, p6, _)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if game["Run Service"]:IsServer() then
		if typeof(p6) == "Instance" and p6:IsA("Folder") then
			p6 = p6:Clone()
			p6.Name = "CurrentReplicatedLighting"
			p6.Parent = game.ReplicatedStorage
		end
		v_u_1.CurrentLighting = p6
		v_u_2:FireAllClientConnection("SetCustomLighting", "REMOTE_EVENT", p6)
		return
	elseif typeof(p6) == "Instance" and p6:IsA("Folder") then
		game.Lighting:ClearAllChildren()
		for _, v7 in pairs(p6:GetChildren()) do
			if v7:IsA("ModuleScript") then
				v_u_1:SetCustomLighting((require(v7)))
			else
				v7:Clone().Parent = game.Lighting
			end
		end
	else
		for v8, v9 in pairs(p6 or {}) do
			game.Lighting[v8] = v9
		end
	end
end
function v_u_1.SetDefaultLighting(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if game["Run Service"]:IsServer() then
		local v10 = v_u_1.CurrentLighting
		if typeof(v10) == "Instance" then
			v_u_1.CurrentLighting:Destroy()
		end
		v_u_1.CurrentLighting = nil
		v_u_2:FireAllClientConnection("SetDefaultLighting", "REMOTE_EVENT")
	else
		v_u_1:SetCustomLighting(v_u_1.Properties)
		game.Lighting:ClearAllChildren()
		for _, v11 in pairs(script:GetChildren()) do
			v11:Clone().Parent = game.Lighting
		end
	end
end
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if game["Run Service"]:IsServer() then
		v_u_2:SetConnection("GetCurrentLighting", "REMOTE_FUNCTION", function(p12)
			-- upvalues: (ref) v_u_1
			if v_u_1.CurrentLighting then
				local v13 = v_u_1.CurrentLighting:Clone()
				v13.Parent = p12.PlayerGui
				game.Debris:AddItem(v13, 20)
				return v13
			end
		end)
	elseif game["Run Service"]:IsClient() then
		v_u_2:SetConnection("SetCustomLighting", "REMOTE_EVENT", function(p14)
			-- upvalues: (ref) v_u_1
			v_u_1:SetCustomLighting(p14)
		end)
		v_u_2:SetConnection("SetDefaultLighting", "REMOTE_EVENT", function()
			-- upvalues: (ref) v_u_1
			if not v_u_1.isInCutscene then
				v_u_1:SetDefaultLighting()
			end
		end)
		v_u_1:SetDefaultLighting()
	end
end
return v_u_1