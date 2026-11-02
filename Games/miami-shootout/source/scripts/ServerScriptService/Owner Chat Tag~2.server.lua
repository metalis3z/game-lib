local plrs = game.Players
 
local sss = game.ServerScriptService
 
local chatService = require(sss:WaitForChild('ChatServiceRunner'):WaitForChild('ChatService'))
 
 
chatService.SpeakerAdded:Connect(function(plr)

    local speaker = chatService:GetSpeaker(plr)


	if plrs[plr].UserId == 316573416 then

        speaker:SetExtraData('ChatColor', Color3.fromRGB(255, 255, 255))
		speaker:SetExtraData('Tags', {{TagText = 'OWNER 👑', TagColor = Color3.fromRGB(166, 111, 0)}})

    end
end)