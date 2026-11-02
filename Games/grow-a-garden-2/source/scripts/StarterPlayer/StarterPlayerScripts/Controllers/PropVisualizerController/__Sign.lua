--credit to prince games studio
local Networking = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"))
local Players = game:GetService("Players")

game:GetService("RunService")

local SmartProximityPrompt = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("SmartProximityPrompt"))
local v1 = require("../GuiController")
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local SignChangeTextMenu = Players.LocalPlayer.PlayerGui:WaitForChild("SignChangeTextMenu")
local v2 = 0

return function(p1) --[[ Line: 12 | Upvalues: Players (copy), SmartProximityPrompt (copy), v1 (copy), SignChangeTextMenu (copy), v2 (ref), NotificationController (copy), Networking (copy) ]]
	local v12

	repeat
		v12 = game:GetService("Players"):GetPlayerByUserId(p1:GetAttribute("UserId"))
	until v12 and p1:IsDescendantOf(workspace)

	if v12.UserId == Players.LocalPlayer.UserId then
		local Primary = p1:FindFirstChild("Primary")

		if Primary then
			local ChangeSignTextPrompt = Instance.new("ProximityPrompt")

			ChangeSignTextPrompt.Name = "ChangeSignTextPrompt"
			ChangeSignTextPrompt.ActionText = "Change Text"
			ChangeSignTextPrompt.ObjectText = "Sign"
			ChangeSignTextPrompt.HoldDuration = 0
			ChangeSignTextPrompt.RequiresLineOfSight = false
			ChangeSignTextPrompt.MaxActivationDistance = 10
			ChangeSignTextPrompt.Parent = Primary

			if ChangeSignTextPrompt and ChangeSignTextPrompt:IsA("ProximityPrompt") then
				SmartProximityPrompt.AttachToModel(ChangeSignTextPrompt, p1, {
					PartName = "ChangeSignTextPrompt",
					MaxActivationDistance = 10,
					TrackDistance = 24,
					SurfaceOffset = 0.75,
					FollowSpeed = 18
				})
				ChangeSignTextPrompt.Triggered:Connect(function() --[[ Line: 38 | Upvalues: v1 (ref), SignChangeTextMenu (ref), p1 (copy) ]]
					v1:Open("SignChangeTextMenu")
					SignChangeTextMenu.Frame.Input.Text = p1:GetAttribute("ExtraData")
					SignChangeTextMenu.Frame.Input:CaptureFocus()
					SignChangeTextMenu:SetAttribute("CurrentId", p1:GetAttribute("PropId"))
					SignChangeTextMenu.Frame.CharCount.Text = ("%*/100"):format(#p1:GetAttribute("ExtraData"))
				end)
				SignChangeTextMenu.Frame.Input:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 46 | Upvalues: SignChangeTextMenu (ref), p1 (copy) ]]
					SignChangeTextMenu.Frame.CharCount.Text = ("%*/100"):format(#SignChangeTextMenu.Frame.Input.Text)

					if p1:GetAttribute("PropId") ~= SignChangeTextMenu:GetAttribute("CurrentId") then
						return
					end

					local TextLabel = p1:FindFirstChild("TextLabel", true)

					if not TextLabel then
						return
					end

					TextLabel.Text = SignChangeTextMenu.Frame.Input.Text
				end)
				SignChangeTextMenu.Frame.Input.FocusLost:Connect(function() --[[ Line: 55 | Upvalues: p1 (copy), SignChangeTextMenu (ref), v2 (ref), v1 (ref), NotificationController (ref), Networking (ref) ]]
					if p1:GetAttribute("PropId") ~= SignChangeTextMenu:GetAttribute("CurrentId") then
						return
					end

					SignChangeTextMenu:SetAttribute("CurrentId", nil)

					local v12 = os.clock()
					local v22 = 5 - (v12 - v2)

					if v22 > 0 then
						v1:Close("SignChangeTextMenu")
						NotificationController:CreateNotification((("Please wait %*s before changing sign text."):format((math.ceil(v22)))))
					else
						v2 = v12
						Networking.Prop.SetPropExtraData:Fire(p1:GetAttribute("PropId"), SignChangeTextMenu.Frame.Input.Text)
						v1:Close("SignChangeTextMenu")
					end
				end)
			end
		end
	end

	local function updateDisplayText() --[[ updateDisplayText | Line: 75 | Upvalues: p1 (copy) ]]
		local v1 = p1:GetAttribute("ExtraData") or ""
		local TextLabel = p1:FindFirstChild("TextLabel", true)

		if not TextLabel then
			return
		end

		TextLabel.Text = v1
	end

	local v22 = p1:GetAttribute("ExtraData") or ""
	local TextLabel = p1:FindFirstChild("TextLabel", true)

	if not TextLabel then
		p1:GetAttributeChangedSignal("ExtraData"):Connect(updateDisplayText)

		return
	end

	TextLabel.Text = v22
	p1:GetAttributeChangedSignal("ExtraData"):Connect(updateDisplayText)
end