local GroupService = game:GetService('GroupService')
local groupid = 157775952
script.Parent.Triggered:Connect(function(player)
	GroupService:PromptJoinAsync(groupid,player)
end)