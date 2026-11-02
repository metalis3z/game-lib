local Players = game:GetService("Players")

local Discord = require(script.Discord)
local Webhook, Embed, EmbedField = Discord.Webhook, Discord.Embed, Discord.EmbedField

local db = {}

local avatars = {}
local placeHolder = ""

game.Players.PlayerAdded:Connect(function(p)
	avatars[p] = "https://blox.link/_next/image?url=https%3A%2F%2Fwww.roblox.com%2Fheadshot-thumbnail%2Fimage%3FuserId%3D"..p.UserId.."%26width%3D150%26height%3D150%26format%3Dpng&w=256&q=75"
end)

game.ReplicatedStorage.SendEmbed.Event:Connect(function(embedType,arg1,arg2,arg3,arg4,arg5,arg6,arg7)
	print("RECEIVED")
	if embedType == "arrestlog" then
		local Robot = Webhook.new()
		:SetUsername("NYPD Arrest Logs")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044021540456513555/1044452185154531398/Png_22.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		
		local embedColor = tonumber(0x00ff00)
		
		local Info3 = EmbedField.new()
		:SetName("🧍 Officer Info: ")
		:SetValue(arg1.Name .. " ("..arg1.UserId..") | [Profile](https://roblox.com/users/"..arg1.UserId.."/profile)")

		local Info = EmbedField.new()
		:SetName("🚓 Arrested: ")
		:SetValue(arg3)
		
		local Info4 = EmbedField.new()
		:SetName("⏰ Jail Time: ")
		:SetValue(arg4)
		
		local Info5 = nil
		
		if arg5 then
			Info5 = EmbedField.new()
			:SetName("📋 Charge List: ")
			:SetValue(arg5)
		end	
		
		local pName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
		
		local Message = Embed.new()
		:SetTitle("Arrest Log")
		:SetDescription("🏠 Place: ["..pName.."](https://www.roblox.com/games/"..game.PlaceId..")")
		:SetThumbnail(avatars[arg1])
		:SetColor(embedColor)
		:AddField(Info3)
		:AddField(Info)
		:AddField(Info4)
		if arg5 then
			Message:AddField(Info5)
		end	

		Robot:AddEmbed(Message)
		Robot:Post()
	end
	
	if embedType == "adminjlog" then
		local Robot = Webhook.new()
		:SetUsername("Bronx | Activity Logs")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044066423703609455/1051191152826663004/bronx3.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")

		local embedColor = tonumber(0x00ff00)

		local Info3 = EmbedField.new()
		:SetName("🧍 Staff: ")
		:SetValue(arg1.Name .. " ("..arg1.UserId..") | [Profile](https://roblox.com/users/"..arg1.UserId.."/profile)")
		
		local Info4 = EmbedField.new()
		:SetName("🔨 Rank: ")
		:SetValue(arg2)
		
		local pName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

		local Message = Embed.new()
		:SetTitle("Staff Joined")
		:SetDescription("🏠 Place: ["..pName.."](https://www.roblox.com/games/"..game.PlaceId..")")
		:SetThumbnail(avatars[arg1])
		:SetColor(embedColor)
		:AddField(Info3)
		:AddField(Info4)
		Robot:AddEmbed(Message)
		Robot:Post()
	end
	
	if embedType == "adminllog" then
		local Robot = Webhook.new()
		:SetUsername("Bronx | Activity Logs")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044066423703609455/1051191152826663004/bronx3.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")

		local embedColor = tonumber(0x00ff00)

		local Info3 = EmbedField.new()
		:SetName("🧍 Staff: ")
		:SetValue(arg1.Name .. " ("..arg1.UserId..") | [Profile](https://roblox.com/users/"..arg1.UserId.."/profile)")
		
		local Info4 = EmbedField.new()
		:SetName("⏰ Time Online: ")
		:SetValue(arg3)
		:SetInline(true)
		
		local Info5 = EmbedField.new()
		:SetName("🔨 Rank: ")
		:SetValue(arg2)
		--:SetInline()
		
		local pName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

		local Message = Embed.new()
		:SetTitle("Staff Left")
		:SetDescription("🏠 Place: ["..pName.."](https://www.roblox.com/games/"..game.PlaceId..")\n**Commands Ran**: "..arg4)
		:SetThumbnail(avatars[arg1])
		:SetColor(embedColor)
		:AddField(Info3)
		:AddField(Info4)
		:AddField(Info5)
		
		Robot:AddEmbed(Message)
		Robot:Post()
	end
	
	if embedType == "adminlog" then
		local Robot = Webhook.new()
		:SetUsername("Bronx | Command Logs")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044066423703609455/1051191152826663004/bronx3.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		
		local embedColor = tonumber(0x00ff00)
		local redColor = tonumber(0xFF0000)
		
		local Info3 = EmbedField.new()
		:SetName("🧍 Staff: ")
		:SetValue(arg1.Name .. " ("..arg1.UserId..") | [Profile](https://roblox.com/users/"..arg1.UserId.."/profile)")
		
		local Info4 = EmbedField.new()
		:SetName("⌨️ Command:")
		:SetValue(arg2)
		
		local Info5
		if arg4 and arg4 ~= "" then
			Info5 = EmbedField.new()
			:SetName("📋 Extra Info:")
			:SetValue(arg4)
		end
		
		local pName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

		local Message = Embed.new()
		:SetTitle("Command Log")
		:SetDescription("🏠 Place: ["..pName.."](https://www.roblox.com/games/"..game.PlaceId..")\n**Players Affected**: "..#arg6.."/"..#game.Players:GetPlayers())
		:SetThumbnail(avatars[arg1])
		:SetColor(embedColor)
		:AddField(Info3)
		:AddField(Info4)
		if arg4 and arg4 ~= "" then
			Message:AddField(Info5)
		end	
		if arg3 == "False" then
			Message:SetColor(redColor)
		end
				
		Robot:AddEmbed(Message)
		
		if arg5 and arg5 == "ABUSE" then
			Robot:SetContent("@everyone **POSSIBLE ADMIN ABUSE**")
		end
		
		Robot:Post()
	end
	
	if embedType == "radio" then
		local Robot = Webhook.new()
		:SetUsername("Police Radio")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044021540456513546/1044791300806950962/unknown.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		:SetContent(arg1)		
		Robot
		:Post()
	end
	if embedType == "exploitLog2" then
		local Robot = Webhook.new()
		:SetUsername("Exploit Logga")
		:SetAvatarURL("https://cdn.discordapp.com/emojis/1069889652544245770.webp?size=96&quality=lossless")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		:SetContent(arg1)
		Robot
		:Post()
	end
	if embedType == "bcam" then
		local Robot = Webhook.new()
		:SetUsername("AXON-Bodycam")
		--:SetAvatarURL("https://media.discordapp.net/attachments/1044021540456513546/1044791300806950962/unknown.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		:SetContent(arg1)		
		Robot
		:Post()
	end
	if embedType == "EMSradio" then
		local Robot = Webhook.new()
		:SetUsername("EMS Radio")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044021540456513546/1044791300806950962/unknown.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		:SetContent(arg1)		
		Robot
		:Post()
	end
	if embedType == "FBIradio" then
		local Robot = Webhook.new()
		:SetUsername("Police Radio")
		:SetAvatarURL("https://media.discordapp.net/attachments/1044021540456513546/1044791300806950962/unknown.png")
		:SetToken("https://discord.com/api/webhooks/REDACTED")
		:SetContent(arg1)		
		Robot
		:Post()
	end
end)