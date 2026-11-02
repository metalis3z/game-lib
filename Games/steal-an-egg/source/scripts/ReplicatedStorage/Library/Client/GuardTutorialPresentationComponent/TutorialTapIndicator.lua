-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v2 = Log.new()
local TutorialTap = ReplicatedStorage.Assets.UI.Tutorial.TutorialTap

return {
	Create = function(p1, p2, p3, p4) --[[ Create | Line: 36 | Upvalues: Asserts (copy), Trove (copy), TutorialTap (copy), TweenService (copy), v1 (copy), v2 (copy) ]]
		Asserts.GuiButton(p1)
		Asserts.optional.boolean(p2)
		Asserts.optional.UDim(p3)
		Asserts.optional.UDim2(p4)

		local v12

		if p2 == true then
			v12 = p1
		else
			local v22 = p1.Parent

			assert(v22 ~= nil, "Tutorial tap target button must have a parent")
			v12 = v22
		end

		local v4 = Trove.new()
		local GuardTutorialTap = TutorialTap:Clone()

		GuardTutorialTap.Name = "GuardTutorialTap"
		GuardTutorialTap.Active = false

		if p2 == true then
			GuardTutorialTap.Position = UDim2.new(0, 0, 0, 0)
			GuardTutorialTap.Size = UDim2.fromScale(1, 1)
			GuardTutorialTap.AnchorPoint = Vector2.zero
		else
			GuardTutorialTap.Position = p1.Position
			GuardTutorialTap.Size = p1.Size
			GuardTutorialTap.AnchorPoint = p1.AnchorPoint
		end

		if p3 ~= nil then
			local Frame = GuardTutorialTap.Frame

			assert(Frame:IsA("Frame"), "Tutorial tap template Frame must be a Frame")

			local UICorner = Frame.UICorner

			assert(UICorner:IsA("UICorner"), "Tutorial tap template UICorner must be a UICorner")
			UICorner.CornerRadius = p3
		end

		if p4 ~= nil then
			GuardTutorialTap.Size = p4
		end

		GuardTutorialTap.ZIndex = p1.ZIndex + 1
		GuardTutorialTap.Parent = v12
		v4:Add(GuardTutorialTap)

		local Arrow = GuardTutorialTap.Arrow

		assert(Arrow:IsA("ImageLabel"), "Tutorial tap template Arrow must be an ImageLabel")

		local Position = Arrow.Position

		Arrow.Position = UDim2.new(1, Position.X.Offset, Position.Y.Scale, Position.Y.Offset)

		local v8 = TweenService:Create(Arrow, v1, {
			Position = UDim2.new(1.2, Position.X.Offset, Position.Y.Scale, Position.Y.Offset)
		})

		v8:Play()
		v4:Add(function() --[[ Line: 96 | Upvalues: v8 (copy) ]]
			v8:Cancel()
			v8:Destroy()
		end)

		return function() --[[ Line: 101 | Upvalues: v2 (ref), v4 (copy) ]]
			v2:AtTrace():Log("[TutorialTapIndicator] Destroying tap indicator")
			v4:Destroy()
		end
	end
}