-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Commas = require(ReplicatedStorage.Library.Functions.Commas)

return {
	Apply = function(p1, p2, p3) --[[ Apply | Line: 30 | Upvalues: Asserts (copy), Commas (copy) ]]
		Asserts.Instance(p1)
		Asserts.Color3(p2)
		Asserts.number(p3)

		local SpeedPerSecond = p1.SpeedPerSecond
		local v1 = SpeedPerSecond:IsA("BasePart")

		assert(v1, (("Treadmill \"%*\" SpeedPerSecond must be a BasePart"):format(p1.Name)))

		local BillboardGui = SpeedPerSecond.BillboardGui
		local v3 = BillboardGui:IsA("BillboardGui")

		assert(v3, (("Treadmill \"%*\" SpeedPerSecond.BillboardGui must be a BillboardGui"):format(p1.Name)))

		local TextLabel = BillboardGui.Frame.TextLabel
		local v5 = TextLabel:IsA("TextLabel")

		assert(v5, (("Treadmill \"%*\" SpeedPerSecond.BillboardGui.Frame.TextLabel must be a TextLabel"):format(p1.Name)))
		TextLabel.TextColor3 = p2
		TextLabel.Text = ("+%*/step"):format((Commas(p3)))

		return BillboardGui
	end
}