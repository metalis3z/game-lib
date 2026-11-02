-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

local function getToolHumanoid(p1) --[[ getToolHumanoid | Line: 22 ]]
	local v1 = p1.Parent

	if not (v1 and v1:IsA("Model")) then
		return nil
	end

	local Humanoid = v1:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		return Humanoid
	end

	return nil
end

function t.Bind(p1, p2) --[[ Bind | Line: 37 | Upvalues: Asserts (copy), Trove (copy), HttpService (copy) ]]
	Asserts.Tool(p1)
	Asserts.Instance(p2)
	assert(p2:IsA("Accessory"), "AccessoryToolTracker.Bind expects an Accessory")

	local v2 = Trove.new()
	local v3 = p2.Parent
	local v4 = HttpService:GenerateGUID(false)
	local v5 = nil
	local v6 = nil

	p2:SetAttribute("MurderMysteryToolAccessory", true)
	p2:SetAttribute("AccessoryToolTrackerId", v4)

	local function getRestoreParent() --[[ getRestoreParent | Line: 51 | Upvalues: v3 (copy), p1 (copy) ]]
		if v3 and v3.Parent then
			return v3
		end

		if p1.Parent then
			return p1
		end

		return nil
	end

	local function unequipAccessory() --[[ unequipAccessory | Line: 63 | Upvalues: v5 (ref), v6 (ref), v4 (copy), v3 (copy), p1 (copy), p2 (copy) ]]
		local v1 = v5 and v5.Parent

		if v6 then
			v6:Destroy()
			v6 = nil
		end

		if v1 and v1:IsA("Model") then
			for v2, v32 in v1:GetChildren() do
				if v32:IsA("Accessory") and v32:GetAttribute("AccessoryToolTrackerId") == v4 then
					v32:Destroy()
				end
			end
		end

		v5 = nil

		local v42 = if v3 and v3.Parent then v3 elseif p1.Parent then p1 else nil

		if p2.Parent == v42 then
			return
		end

		p2.Parent = v42
	end

	local function equipAccessory() --[[ equipAccessory | Line: 87 | Upvalues: p1 (copy), unequipAccessory (copy), v5 (ref), v6 (ref), p2 (copy), v4 (copy) ]]
		local v1 = p1.Parent
		local v2

		if v1 and v1:IsA("Model") then
			local Humanoid = v1:FindFirstChildOfClass("Humanoid")

			v2 = if Humanoid then Humanoid else nil
		else
			v2 = nil
		end

		if not v2 then
			unequipAccessory()

			return
		end

		if v5 == v2 and (v6 and v6.Parent == v2.Parent) then
			return
		end

		unequipAccessory()
		v5 = v2

		local v3 = p2:Clone()

		v3:SetAttribute("AccessoryToolTrackerId", v4)
		v6 = v3
		v2:AddAccessory(v3)
	end

	v2:Connect(p1.Equipped, function() --[[ Line: 106 | Upvalues: equipAccessory (copy) ]]
		equipAccessory()
	end)
	v2:Connect(p1.Unequipped, function() --[[ Line: 110 | Upvalues: unequipAccessory (copy) ]]
		unequipAccessory()
	end)
	v2:Connect(p1.Destroying, function() --[[ Line: 114 | Upvalues: unequipAccessory (copy) ]]
		unequipAccessory()
	end)
	v2:Connect(p1:GetPropertyChangedSignal("Parent"), function() --[[ Line: 118 | Upvalues: p1 (copy), equipAccessory (copy), unequipAccessory (copy) ]]
		local v1 = p1.Parent
		local v2

		if v1 and v1:IsA("Model") then
			local Humanoid = v1:FindFirstChildOfClass("Humanoid")

			v2 = if Humanoid then Humanoid else nil
		else
			v2 = nil
		end

		if v2 then
			equipAccessory()
		else
			unequipAccessory()
		end
	end)
	v2:Add(function() --[[ Line: 127 | Upvalues: unequipAccessory (copy) ]]
		unequipAccessory()
	end)
	v2:AttachToInstance(p1)
	equipAccessory()

	return {
		Destroy = function(p1) --[[ Destroy | Line: 136 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end,
		Sync = function(p12) --[[ Sync | Line: 139 | Upvalues: p1 (copy), equipAccessory (copy), unequipAccessory (copy) ]]
			local v1 = p1.Parent
			local v2

			if v1 and v1:IsA("Model") then
				local Humanoid = v1:FindFirstChildOfClass("Humanoid")

				v2 = if Humanoid then Humanoid else nil
			else
				v2 = nil
			end

			if v2 then
				equipAccessory()
			else
				unequipAccessory()
			end
		end
	}
end

return t