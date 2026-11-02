-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)

local TreadmillStaticCover = require(ReplicatedStorage.Library.Client.UI.TreadmillStaticCover)
local TreadmillStaticRateSign = require(ReplicatedStorage.Library.Client.UI.TreadmillStaticRateSign)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)

require(ReplicatedStorage.Library.Client.TreadmillVideoController.Types.Interface)
require(script.Parent.Types.Interface)

local Treadmills2 = ReplicatedStorage.Assets.Models.Treadmills
local t = {
	SetGroundedScale = function(p1, p2) --[[ SetGroundedScale | Line: 30 | Upvalues: Asserts (copy), TreadmillUtil (copy) ]]
		Asserts.table(p1)
		Asserts.number(p2)
		p1.Model:ScaleTo(p2)

		local Root = p1.Model.Root
		local v1 = Root:IsA("BasePart")

		assert(v1, (("Treadmill \"%*\" Root must be a BasePart"):format(p1.TreadmillId)))

		local v3 = p1.Model:GetPivot():ToObjectSpace(Root.CFrame)
		local v4 = TreadmillUtil.ResolveGroundedToolRootCFrameAtLocation(p1.Bottom, p1.Model)

		p1.Model:PivotTo(v4 * v3:Inverse())
	end
}

function t.Build(p1, p2, p3, p4, p5, p6) --[[ Build | Line: 41 | Upvalues: Asserts (copy), Workspace (copy), Treadmills (copy), Treadmills2 (copy), TreadmillStaticRateSign (copy), TreadmillUtil (copy), TreadmillStaticCover (copy), t (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.table(p3)
	Asserts.number(p4)
	Asserts.boolean(p5)
	Asserts.Folder(p6)

	local Plots = Workspace.Plots

	assert(Plots:IsA("Folder"), "Treadmill rendering requires the plots folder")

	local v2 = Plots[tostring(p1)]

	assert(v2:IsA("Model"), (("Plot \"%*\" must be a Model"):format(p1)))

	local TreadmillBottom = v2.TreadmillBottom

	assert(TreadmillBottom:IsA("BasePart"), (("Plot \"%*\" TreadmillBottom must be a BasePart"):format(p1)))

	local v7 = Treadmills.GetByUpgradeLevel(p3.TreadmillUpgradeLevel)

	assert(v7 ~= nil, (("Invalid treadmill upgrade level %*"):format(p3.TreadmillUpgradeLevel)))

	local v10 = Treadmills2[v7._id]

	assert(v10:IsA("Tool"), (("Treadmill render template \"%*\" must be a Tool"):format(v7._id)))

	local v13 = v10:Clone()

	v13.Name = ("TreadmillRender_%*"):format(p1)
	v13.Parent = p6

	for i, v in ipairs(v13:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.CanCollide = false
			v.CanQuery = true
			v.CanTouch = false

			continue
		end

		if v:IsA("BaseScript") then
			v:Destroy()
		end
	end

	local v14 = TreadmillStaticRateSign.Apply(v13, v7.Rarity.Color, v7.SpeedMultiplier)
	local v15 = TreadmillUtil.FindVideoFeedScreenPart(v13)
	local v16

	if p5 and v15 ~= nil then
		local v17 = TreadmillStaticCover.Create(("StaticTreadmillCover_%*"):format(p1), v15)

		TreadmillStaticCover.ApplyFeed(v17, p3.TreadmillMediaFeedState)
		v16 = v17
	else
		v16 = nil
	end

	local t2 = {
		Bottom = TreadmillBottom,
		Cover = v16,
		Model = v13,
		OwnerUserId = p2,
		RateSign = v14,
		Slot = p1,
		TreadmillId = v7._id
	}

	t.SetGroundedScale(t2, v13:GetScale() * p4)

	return t2
end

return t