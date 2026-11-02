

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("TextChatService")
v1:WaitForChild("Remotes"):WaitForChild("PurchaseAnnounce").OnClientEvent:Connect(function(p3)

	local v4 = u2:FindFirstChild("TextChannels")
	local v5
	if v4 then
		v5 = v4:FindFirstChild("RBXGeneral")
	else
		v5 = nil
	end
	if v5 then
		v5:DisplaySystemMessage("<font size=\"17\"><b>" .. p3 .. "</b></font>")
	end
end)