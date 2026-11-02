-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)

return {
	Create = function(p1, p2) --[[ Create | Line: 17 | Upvalues: Asserts (copy), BBFromModelVisibleOnly (copy) ]]
		Asserts.Model(p1)
		Asserts.BasePart(p2)

		local v1 = p1:GetPivot()
		local v2, v3 = BBFromModelVisibleOnly(p1)
		local AssetInteractionPromptAnchor = Instance.new("Part")

		AssetInteractionPromptAnchor.Name = "AssetInteractionPromptAnchor"
		AssetInteractionPromptAnchor.Size = Vector3.new(1, 1, 1)
		AssetInteractionPromptAnchor.Transparency = 1
		AssetInteractionPromptAnchor.CanCollide = false
		AssetInteractionPromptAnchor.CanQuery = false
		AssetInteractionPromptAnchor.CanTouch = false
		AssetInteractionPromptAnchor.Massless = true

		local v4 = v3.Y * 0.5

		AssetInteractionPromptAnchor.CFrame = CFrame.new(v1.Position.X, v2.Position.Y - v4 + math.min(3, v4), v1.Position.Z)
		AssetInteractionPromptAnchor.Parent = p1

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p2
		WeldConstraint.Part1 = AssetInteractionPromptAnchor
		WeldConstraint.Parent = AssetInteractionPromptAnchor

		return AssetInteractionPromptAnchor
	end
}