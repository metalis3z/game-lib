local players = game:GetService("Players")
local chatService = require(game.ServerScriptService:WaitForChild("ChatServiceRunner"):WaitForChild("ChatService"))

local tags = {
	{TagText = "[Elite]", TagColor = Color3.fromRGB(255, 0, 0)},
}


local eliteName = {

}




local MPS = game:GetService("MarketplaceService")
chatService.SpeakerAdded:Connect(function(playerName)
	pcall(function()
		local speaker = chatService:GetSpeaker(playerName)
		local Player = game.Players[playerName]
		
		local Elite = MPS:UserOwnsGamePassAsync(Player.userId, 120067201) or _G.ElitePlayers[Player.Name] or _G.ElitePlayers[Player.userId]
		if Elite or eliteName[Player.Name] then
			_G.ElitePlayers[Player.Name] = true
			speaker:SetExtraData("Tags", {{TagText = "Elite", TagColor = Color3.new(1, 0, 0)}})
			speaker:SetExtraData("NameColor",Color3.fromRGB(255, 0, 0))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
   		else
			speaker:SetExtraData("NameColor",Color3.fromRGB(163, 162, 165))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 113847493  then  
			speaker:SetExtraData('Tags', {{TagText = "Creator", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 525111307  then  
			speaker:SetExtraData('Tags', {{TagText = "Developer", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 0, 0))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(0, 0, 127))
		end	
		if Player.UserId == 1750374412  then  
			speaker:SetExtraData('Tags', {{TagText = "Head Admin", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 699023308  then  
			speaker:SetExtraData('Tags', {{TagText = "Moderator", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 1184483773  then  
			speaker:SetExtraData('Tags', {{TagText = "Community Manager", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 85, 255))
		end
		if Player.UserId == 3450101203 then  
			speaker:SetExtraData('Tags', {{TagText = "Trial-Mod", TagColor = Color3.fromRGB(0, 0, 0)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(255, 85, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 85, 255))
		end
		if Player.UserId == 943484865  then  
			speaker:SetExtraData('Tags', {{TagText = "Senior Admin", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 2408006274  then  
			speaker:SetExtraData('Tags', {{TagText = "Senior Moderator", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 3522116067  then  
			speaker:SetExtraData('Tags', {{TagText = "Moderator", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 772821463  then  
			speaker:SetExtraData('Tags', {{TagText = "Admin", TagColor = Color3.fromRGB(0, 170, 255)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 170, 255))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 702952403  then  
			speaker:SetExtraData('Tags', {{TagText = "Developer", TagColor = Color3.fromRGB(255, 162, 0)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(255, 200, 33))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 255))
		end
		if Player.UserId == 3582027804  then  
			speaker:SetExtraData('Tags', {{TagText = "Tyrone", TagColor = Color3.fromRGB(0, 0, 0)}}); 
			speaker:SetExtraData("NameColor",Color3.fromRGB(0, 0, 0))
			speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 0, 0))
		end
	end)
end)
-- .z