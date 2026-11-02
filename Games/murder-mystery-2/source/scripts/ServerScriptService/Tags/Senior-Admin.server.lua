local ServerScriptService = game:GetService("ServerScriptService")
local ChatService = require(ServerScriptService:WaitForChild("ChatServiceRunner"):WaitForChild("ChatService"))
local Players = game:GetService("Players")
local Owner = {0} --Change Username to your username

ChatService.SpeakerAdded:Connect(function(PlrName)
	local Speaker = ChatService:GetSpeaker(PlrName)
	for _, v in pairs(Owner) do
		if Players[PlrName].UserId == v then
			Speaker:SetExtraData('Tags', {{TagText = "Senior-Admin", TagColor = Color3.fromRGB(0, 170, 255)}}) -- You can change the color of the text by adjusting the color code. 
		end
	end
end) 
