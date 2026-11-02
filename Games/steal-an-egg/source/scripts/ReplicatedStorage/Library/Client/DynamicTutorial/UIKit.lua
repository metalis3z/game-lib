-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local TutorialBeam = require(ReplicatedStorage.Library.Client.WorldFX.TutorialBeam)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local TutorialTap = ReplicatedStorage.Assets.UI.OTHER.TutorialTap
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v2 = 0
local v3 = 0
local v4 = nil
local v5 = nil

task.spawn(function() --[[ Line: 30 | Upvalues: Players (copy), v4 (ref), v5 (ref) ]]
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local DynamicTutorialMessage = PlayerGui:WaitForChild("NotificationsTuto"):Clone()

	DynamicTutorialMessage.Name = "DynamicTutorialMessage"
	DynamicTutorialMessage.Enabled = false
	DynamicTutorialMessage.Parent = PlayerGui
	v4 = DynamicTutorialMessage
	v5 = DynamicTutorialMessage.MessageTop.Message.Frame.TextLabel
end)

return {
	CreateBeam = function(p1) --[[ CreateBeam | Line: 48 | Upvalues: TutorialBeam (copy) ]]
		return TutorialBeam.Create(p1)
	end,
	UpdateBeamTarget = function(p1, p2) --[[ UpdateBeamTarget | Line: 52 | Upvalues: TutorialBeam (copy) ]]
		TutorialBeam.UpdateTarget(p1, p2)
	end,
	DestroyBeam = function(p1) --[[ DestroyBeam | Line: 56 | Upvalues: TutorialBeam (copy) ]]
		TutorialBeam.Destroy(p1)
	end,
	CreateTapIndicator = function(p1, p2, p3, p4) --[[ CreateTapIndicator | Line: 60 | Upvalues: Asserts (copy), Trove (copy), TutorialTap (copy), TweenService (copy), v1 (copy) ]]
		local v12 = if p2 then p1 else p1.Parent

		if not p2 and p1.Parent == nil then
			return nil
		end

		Asserts.optional.UDim(p3)
		Asserts.optional.UDim2(p4)

		local v2 = Trove.new()
		local TutorialTap2 = TutorialTap:Clone()

		TutorialTap2.Name = "TutorialTap"
		TutorialTap2.Active = false

		if p2 then
			TutorialTap2.Position = UDim2.new(0, 0, 0, 0)
			TutorialTap2.Size = UDim2.fromScale(1, 1)
			TutorialTap2.AnchorPoint = Vector2.new(0, 0)
		else
			TutorialTap2.Position = p1.Position
			TutorialTap2.Size = p1.Size
			TutorialTap2.AnchorPoint = p1.AnchorPoint
		end

		if p3 then
			TutorialTap2.Frame.UICorner.CornerRadius = p3
		end

		if p4 then
			TutorialTap2.Size = p4
		end

		TutorialTap2.ZIndex = p1.ZIndex + 1
		TutorialTap2.Parent = v12
		v2:Add(TutorialTap2)

		local Arrow = TutorialTap2.Arrow
		local Position = Arrow.Position

		Arrow.Position = UDim2.new(1, Position.X.Offset, Position.Y.Scale, Position.Y.Offset)

		local v3 = TweenService:Create(Arrow, v1, {
			Position = UDim2.new(1.2, Position.X.Offset, Position.Y.Scale, Position.Y.Offset)
		})

		v3:Play()
		v2:Add(function() --[[ Line: 101 | Upvalues: v3 (copy) ]]
			v3:Cancel()
		end)

		return {
			_trove = v2
		}
	end,
	DestroyTapIndicator = function(p1) --[[ DestroyTapIndicator | Line: 109 ]]
		if not p1 then
			return
		end

		p1._trove:Destroy()
	end,
	ShowMessage = function(p1, p2) --[[ ShowMessage | Line: 115 | Upvalues: v4 (ref), v5 (ref), v2 (ref), v3 (ref) ]]
		if v4 == nil or v5 == nil then
			return {
				_id = -1
			}
		end

		v2 = v2 + 1
		v3 = v2

		local v1 = v5

		v1.RichText = true
		v1.Text = p1
		v1.TextColor3 = p2
		v4.Enabled = true

		return {
			_id = v2
		}
	end,
	DestroyMessage = function(p1) --[[ DestroyMessage | Line: 133 | Upvalues: v3 (ref), v4 (ref), v5 (ref) ]]
		if p1 == nil or p1._id ~= v3 then
			return
		end

		v3 = 0

		if v4 then
			v4.Enabled = false
		end

		if not v5 then
			return
		end

		v5.Text = ""
	end
}