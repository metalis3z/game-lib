local CommandModules = script.Parent

return function(ChatService)
	local dead = ChatService:AddChannel("dead")
	dead.AutoJoin = true
	dead:SetChannelNameColor(BrickColor.new("Medium stone grey").Color)
	
	_G.SetChatToAlive = function(player)
		ChatService:GetSpeaker(player.Name):LeaveChannel("dead")
	end
	_G.SetChatToDead = function(player)
		ChatService:GetSpeaker(player.Name):JoinChannel("dead")
	end
end