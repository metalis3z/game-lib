-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Network = require(ReplicatedStorage.Library.Client.Network)
local CoreCall = require(ReplicatedStorage.Library.Functions.CoreCall)
local t = {}
local LocalPlayer = Players.LocalPlayer
local Friend_Notification = LocalPlayer.PlayerGui:WaitForChild("Friend_Notification")
local BodyLabel = Friend_Notification.Frame.Frame.Background.Holder.BodyLabel
local t2 = {}
local v1 = nil

function t.DismissCurrent() --[[ DismissCurrent | Line: 23 | Upvalues: v1 (ref), t2 (copy), BodyLabel (copy), Friend_Notification (copy) ]]
	if not v1 then
		return
	end

	local v12 = table.find(t2, v1)

	if v12 then
		table.remove(t2, v12)
	end

	v1 = nil

	if not (#t2 > 0) then
		Friend_Notification.Show_VAL.Value = false

		return
	end

	if not v1 then
		local v2 = t2[1]

		v1 = v2
		BodyLabel.Text = ("Friend request from\n%*"):format(v2.Name)
		Friend_Notification.Show_VAL.Value = true
	end
end
function t.AcceptCurrent() --[[ AcceptCurrent | Line: 45 | Upvalues: v1 (ref), t (copy), CoreCall (copy) ]]
	local v12 = v1

	t.DismissCurrent()

	if not v12 then
		return
	end

	CoreCall("SetCore", "PromptSendFriendRequest", v12)
end
Network.Fired(Network.NET_MAP.Gifting.FRIEND_REQUEST):Connect(function(p1) --[[ Line: 53 | Upvalues: LocalPlayer (copy), t2 (copy), v1 (ref), BodyLabel (copy), Friend_Notification (copy) ]]
	if p1:IsFriendsWith(LocalPlayer.UserId) then
		return
	end

	if not table.find(t2, p1) then
		table.insert(t2, p1)
	end

	if v1 then
		return
	end

	local v2 = t2[1]

	v1 = v2
	BodyLabel.Text = ("Friend request from\n%*"):format(v2.Name)
	Friend_Notification.Show_VAL.Value = true
end)
Friend_Notification.Frame.Frame.Background.Holder.Frame.Accept.MouseButton1Click:Connect(t.AcceptCurrent)
Friend_Notification.Frame.Frame.Background.Holder.Frame.Decline.MouseButton1Click:Connect(t.DismissCurrent)

return t