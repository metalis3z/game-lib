-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Pads = require(ReplicatedStorage.Library.Client.WorldFX.Pads)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Pads2 = Workspace:WaitForChild("Stands"):WaitForChild("Pads")

local function bindPad(p1, p2, p3) --[[ bindPad | Line: 16 | Upvalues: Pads (copy), TabController (copy) ]]
	local v1 = Pads.new(p2)

	p1:Add(v1)
	p1:Add(v1:AddEnterListener(function() --[[ Line: 19 | Upvalues: TabController (ref), p3 (copy) ]]
		TabController.OpenTab(p3)
	end))
	p1:Add(v1:AddLeaveListener(function() --[[ Line: 22 | Upvalues: TabController (ref), p3 (copy) ]]
		if TabController.Get() ~= p3 then
			return
		end

		TabController.CloseTab(true)
	end))
end

for v1, v2 in Pads2:GetChildren() do
	if v2:IsA("BasePart") then
		bindPad(Trove.new(), v2, v2.Name)
	end
end