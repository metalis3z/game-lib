-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BulkMoveController = require(ReplicatedStorage.Library.Client.BulkMoveController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}
local t2 = {}

local function newModelState(p1) --[[ newModelState | Line: 28 | Upvalues: Asserts (copy), Trove (copy), BulkMoveController (copy), t (copy), t2 (copy) ]]
	local PrimaryPart = p1.PrimaryPart

	Asserts.BasePart(PrimaryPart)
	PrimaryPart.Anchored = true

	local v1 = Trove.new()
	local t3 = {}

	for v2, v3 in { PrimaryPart } do
		t3[v2] = BulkMoveController.Register(v3)
	end

	v1:Add(function() --[[ Line: 40 | Upvalues: t3 (copy) ]]
		for v1, v2 in t3 do
			v2:Destroy()
		end
	end)

	local t4 = {
		Parts = { PrimaryPart },
		Components = t3,
		Trove = v1
	}

	t[p1] = t4
	v1:Connect(p1.Destroying, function() --[[ Line: 52 | Upvalues: t2 (ref), p1 (copy) ]]
		t2.Remove(p1)
	end)

	return t4
end

function t2.SetPivot(p1, p2) --[[ SetPivot | Line: 63 | Upvalues: Asserts (copy), t (copy), newModelState (copy) ]]
	Asserts.Model(p1)
	Asserts.finiteCFrame(p2)

	local v1 = t[p1] or newModelState(p1)
	local v2 = p1:GetPivot()

	for v3, v4 in v1.Parts do
		v1.Components[v3]:SetCFrame(p2 * v2:ToObjectSpace(v4.CFrame))
	end
end
function t2.Remove(p1) --[[ Remove | Line: 75 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p1)

	local v1 = t[p1]

	if v1 ~= nil then
		t[p1] = nil
		v1.Trove:Destroy()
	end
end

return t2