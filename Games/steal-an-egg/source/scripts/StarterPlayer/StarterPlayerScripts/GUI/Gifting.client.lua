-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Assets = require(ReplicatedStorage.Directory.Assets)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Gifting = Constants.NETWORK_MAP.Gifting
local Frame = GUI.GiftNotification().Frame
local Frame2 = ReplicatedStorage.Assets.UI.Gifting.Frame
local v1 = nil

local function clearGui() --[[ clearGui | Line: 29 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:Destroy()
	v1 = nil
end

ProximityPromptService.PromptTriggered:Connect(function(p1, p2) --[[ Line: 40 | Upvalues: Players (copy), Asserts (copy), Constants (copy), Assets (copy), Message (copy), Network (copy), Gifting (copy) ]]
	if p2 ~= Players.LocalPlayer or p1.Name ~= "GiftPrompt" then
		return
	end

	local v1 = p1.Parent

	if not v1 then
		return
	end

	local v2 = v1.Parent

	if not (v2 and v2:IsA("Model")) then
		return
	end

	local v3 = Players:GetPlayerFromCharacter(v2)

	if not v3 then
		return
	end

	local Character = p2.Character

	Asserts.Model(Character)

	local v4 = Character:FindFirstChildWhichIsA("Tool")

	if not v4 or v4:GetAttribute("ItemType") ~= Constants.SUPPORTED_GIFTS_TYPES.Asset then
		return
	end

	local v5 = v4:GetAttribute("Category")

	Asserts.string(v5)

	local v6 = Assets.Directory[v5]

	if Message.New(("Do you want to gift <font color=\"#%*\">%*</font> to %*?"):format(v6.Rarity.Color:ToHex(), v6.DisplayName, v3.DisplayName), true) then
		Network.Invoke(Gifting.SEND_REQUEST, v3.UserId)
	end
end)
Network.Fired(Gifting.GIFT_REQUEST):Connect(function(p1, p2, p3, p4) --[[ Line: 82 | Upvalues: v1 (ref), Frame2 (copy), Network (copy), Gifting (copy), Frame (copy) ]]
	local v12, v2, v3

	if not v1 then
		v12 = Frame2:Clone()
		v12.Holder.Notification_UI.TextLabel.Text = ("@%*"):format(p1)
		v12.Holder.TextLabel.Text = p3
		v2 = v12.Holder.Frame:FindFirstChild("Accept")
		v3 = v12.Holder.Frame:FindFirstChild("Decline")
		v2.MouseButton1Click:Connect(function() --[[ Line: 92 | Upvalues: v1 (ref), Network (ref), Gifting (ref), p2 (copy), p4 (copy) ]]
			if v1 then
				v1:Destroy()
				v1 = nil
			end

			Network.Invoke(Gifting.RESPONSE, p2, p4, true)
		end)
		v3.MouseButton1Click:Connect(function() --[[ Line: 96 | Upvalues: v1 (ref), Network (ref), Gifting (ref), p2 (copy), p4 (copy) ]]
			if not v1 then
				Network.Invoke(Gifting.RESPONSE, p2, p4, false)

				return
			end

			v1:Destroy()
			v1 = nil
			Network.Invoke(Gifting.RESPONSE, p2, p4, false)
		end)
		v12.Parent = Frame
		v1 = v12

		return
	end

	v1:Destroy()
	v1 = nil
	v12 = Frame2:Clone()
	v12.Holder.Notification_UI.TextLabel.Text = ("@%*"):format(p1)
	v12.Holder.TextLabel.Text = p3
	v2 = v12.Holder.Frame:FindFirstChild("Accept")
	v3 = v12.Holder.Frame:FindFirstChild("Decline")
	v2.MouseButton1Click:Connect(function() --[[ Line: 92 | Upvalues: v1 (ref), Network (ref), Gifting (ref), p2 (copy), p4 (copy) ]]
		if v1 then
			v1:Destroy()
			v1 = nil
		end

		Network.Invoke(Gifting.RESPONSE, p2, p4, true)
	end)
	v3.MouseButton1Click:Connect(function() --[[ Line: 96 | Upvalues: v1 (ref), Network (ref), Gifting (ref), p2 (copy), p4 (copy) ]]
		if not v1 then
			Network.Invoke(Gifting.RESPONSE, p2, p4, false)

			return
		end

		v1:Destroy()
		v1 = nil
		Network.Invoke(Gifting.RESPONSE, p2, p4, false)
	end)
	v12.Parent = Frame
	v1 = v12
end)