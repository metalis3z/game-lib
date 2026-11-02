local GroupService = game:GetService('GroupService')
local groupid = 898716319
script.Parent.Triggered:Connect(function(player)
	GroupService:PromptJoinAsync(groupid,player)
end)