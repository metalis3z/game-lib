-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = script.Parent
local v2 = true
local Network = require(ReplicatedStorage.Library.Client.Network)
local GetMouseToWorld = require(ReplicatedStorage.Library.Functions.GetMouseToWorld)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)

v1.Activated:Connect(function() --[[ Line: 9 | Upvalues: v2 (ref), v1 (copy), GetMouseToWorld (copy), Message (copy), Network (copy) ]]
	if not v2 then
		return
	end

	v2 = false
	task.delay(0.4, function() --[[ Line: 12 | Upvalues: v2 (ref) ]]
		v2 = true
	end)

	local v12 = v1:GetAttribute("Uses") or 1

	if math.min(v12, v1:GetAttribute("LocalUses") or 1) <= 0 then
		return
	end

	local v3 = RaycastParams.new()

	v3.FilterDescendantsInstances = { workspace.Map.CanPlace }
	v3.FilterType = Enum.RaycastFilterType.Include

	local v4 = GetMouseToWorld(v3, 1000)

	if not v4 then
		Message.Bottom({
			Message = "You cannot place your egg here!",
			Time = 0.5
		})

		return
	end

	Network.Fire(Network.NET_MAP.Pets.PET_EGG_SERVICE, "CreateEgg", v4.Position)
end)
v1:GetAttributeChangedSignal("Uses"):Connect(function() --[[ Line: 33 | Upvalues: v1 (copy) ]]
	local v12 = v1:GetAttribute("Uses") or 1

	v1:SetAttribute("LocalUses", v12)
	v1.Name = (v1:GetAttribute("EggName") or "Common") .. " x" .. v12
end)

local v3 = v1:GetAttribute("Uses") or 1

v1:SetAttribute("LocalUses", v3)
v1.Name = (v1:GetAttribute("EggName") or "Common") .. " x" .. v3