local v_u_1 = {
	["isInCutscene"] = false
}
local v_u_2 = require(game.ReplicatedStorage.Modules.Network)
v_u_1.Properties = {
	["Ambient"] = Color3.fromRGB(0, 0, 0),
	["Brightness"] = 3,
	["ColorShift_Bottom"] = Color3.fromRGB(0, 0, 0),
	["ColorShift_Top"] = Color3.fromRGB(0, 0, 0),
	["EnvironmentDiffuseScale"] = 1,
	["EnvironmentSpecularScale"] = 1,
	["GlobalShadows"] = true,
	["OutdoorAmbient"] = Color3.fromRGB(70, 70, 70),
	["ShadowSoftness"] = 0.2,
	["ClockTime"] = workspace:GetAttribute("Testing") and 3.8,
	["GeographicLatitude"] = 268,
	["ExposureCompensation"] = workspace:GetAttribute("Testing") and 0,
	["FogColor"] = Color3.fromRGB(192, 192, 192),
	["FogEnd"] = 100000,
	["FogStart"] = 0
}
function v_u_1.SetAsCurrentLighting(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if not game["Run Service"]:IsServer() then
		v_u_1:SetDefaultLighting()
		local v3 = v_u_2:FireServerConnection("GetCurrentLighting", "REMOTE_FUNCTION")
		if v3 then
			v_u_1:SetCustomLighting(v3)
		end
	end
end
function v_u_1.SetCustomLighting(_, p4, _)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if game["Run Service"]:IsServer() then
		if typeof(p4) == "Instance" and p4:IsA("Folder") then
			p4 = p4:Clone()
			p4.Name = "CurrentReplicatedLighting"
			p4.Parent = game.ReplicatedStorage
		end
		v_u_1.CurrentLighting = p4
		v_u_2:FireAllClientConnection("SetCustomLighting", "REMOTE_EVENT", p4)
		return
	elseif typeof(p4) == "Instance" and p4:IsA("Folder") then
		game.Lighting:ClearAllChildren()
		for _, v5 in pairs(p4:GetChildren()) do
			if v5:IsA("ModuleScript") then
				v_u_1:SetCustomLighting((require(v5)))
			else
				v5:Clone().Parent = game.Lighting
			end
		end
	else
		for v6, v7 in pairs(p4 or {}) do
			game.Lighting[v6] = v7
		end
	end
end
function v_u_1.SetDefaultLighting(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if game["Run Service"]:IsServer() then
		local v8 = v_u_1.CurrentLighting
		if typeof(v8) == "Instance" then
			v_u_1.CurrentLighting:Destroy()
		end
		v_u_1.CurrentLighting = nil
		v_u_2:FireAllClientConnection("SetDefaultLighting", "REMOTE_EVENT")
	else
		v_u_1:SetCustomLighting(v_u_1.Properties)
		game.Lighting:ClearAllChildren()
		for _, v9 in pairs(script:GetChildren()) do
			v9:Clone().Parent = game.Lighting
		end
	end
end
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if game["Run Service"]:IsServer() then
		v_u_2:SetConnection("GetCurrentLighting", "REMOTE_FUNCTION", function(p10)
			-- upvalues: (ref) v_u_1
			if v_u_1.CurrentLighting then
				local v11 = v_u_1.CurrentLighting:Clone()
				v11.Parent = p10.PlayerGui
				game.Debris:AddItem(v11, 20)
				return v11
			end
		end)
	elseif game["Run Service"]:IsClient() then
		v_u_2:SetConnection("SetCustomLighting", "REMOTE_EVENT", function(p12)
			-- upvalues: (ref) v_u_1
			v_u_1:SetCustomLighting(p12)
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
