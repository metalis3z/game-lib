-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v2 = Log.new()
local ClickTarget = ReplicatedStorage.Assets.UI.Tutorial.ClickTarget

return {
	Create = function(p1) --[[ Create | Line: 32 | Upvalues: Asserts (copy), GUI (copy), Trove (copy), ClickTarget (copy), TweenService (copy), v1 (copy), v2 (copy) ]]
		Asserts.GuiObject(p1)

		local v12 = GUI.TutorialInstructions()

		assert(v12:IsA("ScreenGui"), "TutorialInstructions must be a ScreenGui")

		local v3 = v12.Parent

		assert(if v3 == nil then false else v3:IsA("PlayerGui"), "TutorialInstructions must be parented to PlayerGui")

		local v5 = Trove.new()
		local GuardTutorialHighlight = ClickTarget:Clone()

		GuardTutorialHighlight.Name = "GuardTutorialHighlight"
		GuardTutorialHighlight.Parent = v3
		GuardTutorialHighlight.Enabled = true
		v5:Add(GuardTutorialHighlight)

		local Container = GuardTutorialHighlight.Container

		assert(Container:IsA("Frame"), "Tutorial highlight Container must be a Frame")
		Container.Size = UDim2.fromScale(0.01, 0.01)

		local v7 = nil

		local function updateOverlay() --[[ updateOverlay | Line: 52 | Upvalues: p1 (copy), GuardTutorialHighlight (copy), v7 (ref), TweenService (ref), Container (copy), v1 (ref) ]]
			local AbsoluteSize = p1.AbsoluteSize
			local v12 = p1.AbsolutePosition + AbsoluteSize * 0.5 - GuardTutorialHighlight.AbsolutePosition
			local v2

			if v7 ~= nil then
				v7:Cancel()
				v7:Destroy()
			end

			v2 = TweenService:Create(Container, v1, {
				Size = UDim2.fromOffset(AbsoluteSize.X * 1.15, AbsoluteSize.Y * 1.15),
				Position = UDim2.fromOffset(v12.X, v12.Y)
			})
			v7 = v2
			v2:Play()
		end

		updateOverlay()
		v5:Add(p1:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateOverlay))
		v5:Add(p1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateOverlay))
		v5:Add(GuardTutorialHighlight:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateOverlay))
		v5:Add(function() --[[ Line: 74 | Upvalues: v7 (ref) ]]
			if v7 == nil then
				return
			end

			v7:Cancel()
			v7:Destroy()
		end)

		return function() --[[ Line: 81 | Upvalues: v2 (ref), v5 (copy) ]]
			v2:AtTrace():Log("[TutorialHighlightOverlay] Destroying highlight overlay")
			v5:Destroy()
		end
	end
}