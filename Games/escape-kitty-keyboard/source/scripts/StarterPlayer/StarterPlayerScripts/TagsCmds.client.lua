

local v1 = game:GetService("TextChatService")
local u2 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AdminTagToggle", 10)
local v3 = Instance.new("TextChatCommand")
v3.Name = "HeadTagCommand"
v3.PrimaryAlias = "/headtag"
v3.AutocompleteVisible = false
v3.Enabled = true
v3.Parent = v1
local u4 = "Head"
v3.Triggered:Connect(function()

	if u2 then
		u2:FireServer(u4)
	end
end)
local v5 = Instance.new("TextChatCommand")
v5.Name = "ChatTagCommand"
v5.PrimaryAlias = "/chattag"
v5.AutocompleteVisible = false
v5.Enabled = true
v5.Parent = v1
local u6 = "Chat"
v5.Triggered:Connect(function()

	if u2 then
		u2:FireServer(u6)
	end
end)