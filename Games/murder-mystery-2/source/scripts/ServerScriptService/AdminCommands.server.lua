local hasAccess = {
	[1971231464] = true; -- leaf
	[113847493] = true; -- jay
	[2380244082] = true; -- leaf mm2 modding alt
	[318751008] = true; -- Juliaz
	[525111307] = true; -- pres
	[276692188] = true; -- GhostfaceMatt
	[702952403] = true; -- Rhavi
	[4664957679] = true; --Rhavi's Alt
	[187576939] = true; -- Ant
	[169641570] = true; -- Toooher
}

-- Create the screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DeveloperProfile"
gui.ResetOnSpawn = false

-- Create the UI elements
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.4, 0)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(64, 64, 64)
frame.Parent = gui

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0.2, 0)
nameLabel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
nameLabel.BorderSizePixel = 0
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.TextSize = 24
nameLabel.TextXAlignment = Enum.TextXAlignment.Center
nameLabel.Text = "A Developer has Joined!"
nameLabel.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 24
closeButton.Text = "X"
closeButton.Parent = frame


-- Listen for when a player joins the game
game.Players.PlayerAdded:Connect(function(player)
	-- Check if the player is a developer with access
	if hasAccess[player.UserId] then
		-- Update the UI elements with the player's name and profile picture
		nameLabel.Text = player.Name
		local profilePicture = Instance.new("ImageLabel")
		profilePicture.Size = UDim2.new(0.4, 0, 0.4, 0)
		profilePicture.Position = UDim2.new(0.3, 0, 0.2, 0)
		profilePicture.BackgroundTransparency = 1
		profilePicture.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
		profilePicture.Parent = frame

		-- Show the GUI to all players
		gui.Parent = game.Players.LocalPlayer.PlayerGui

		-- Listen for when the close button is clicked
		closeButton.MouseButton1Click:Connect(function()
			-- Hide the GUI
			gui.Parent = nil
		end)
	end
end)
game.Players.PlayerAdded:Connect(function(player)
	if hasAccess[player.UserId] then
		player.Chatted:Connect(function(msg)
			if string.find(msg, "/murderer") then
				local args = string.split(msg, " ")
				warn(args[2].." will be Murderer next round.")
				_G.ForceChance(args[2])
			end
			if string.find(msg, "/map") then
				local args = string.split(msg, " ")
				warn("Map set to ".. args[2] .. "")
				_G.ForceMap = args[2]
			end
			if string.find(msg, "/sheriff") then
				local args = string.split(msg, " ")
				warn(args[2].." will be Sheriff next round.")
				_G.ForceSheriff = args[2]
			end
			if string.find(msg, "/give") then
				local args = string.split(msg, " ")
				_G.LogCommand(player.Name,args[1],args[2])
				game.ReplicatedStorage.GiveMerch:Fire(args[2],args[3],tonumber(args[4]))
			end
			if string.find(msg, "/remove") then
				local args = string.split(msg, " ")
				_G.LogCommand(player.Name,args[1],args[2])
				game.ReplicatedStorage.RemoveMerch:Fire(args[2],args[3],tonumber(args[4]))
			end
			if string.find(msg, "/gun") then
				local args = string.split(msg, " ")
				if args[2] == "all" then
					for i,Player in pairs(game.Players:GetChildren()) do
						require(script.Parent.GameScript.GameFunctions.GiveWeapon).Gun(Player,true)
					end
					return
				end
				if game.Players[args[2]] then
					require(script.Parent.GameScript.GameFunctions.GiveWeapon).Gun(game.Players[args[2]],true)
				end
			end
			if string.find(msg, "/knife") then
				local args = string.split(msg, " ")
				if args[2] == "all" then
					for i,Player in pairs(game.Players:GetChildren()) do
						require(script.Parent.GameScript.GameFunctions.GiveWeapon).Knife(Player,true)
					end
					return
				end
				if game.Players[args[2]] then
					require(script.Parent.GameScript.GameFunctions.GiveWeapon).Knife(game.Players[args[2]],true)
				end
			end
			if string.find(msg, "/ban") then
				local args = string.split(msg, " ")
				if game.Players:GetUserIdFromNameAsync(args[2]) then
					_G.LogCommand(player.Name,args[1],args[2])
					warn(args[2].." has been banned from Jays Murder Mystery.")
					game:GetService("DataStoreService"):GetDataStore("BanStore"):SetAsync(game.Players:GetUserIdFromNameAsync(args[2]), {true})
					game:GetService("MessagingService"):PublishAsync("BanAsync",{PlayerToBan=args[2]})
				else
					warn(args[2].." is not existen.")
				end
			end
			if string.find(msg, "/unban") then
				local args = string.split(msg, " ")
				if game.Players:GetUserIdFromNameAsync(args[2]) then
					_G.LogCommand(player.Name,args[1],args[2])
					warn(args[2].." has been unbanned from Jays Murder Mystery.")
					game:GetService("DataStoreService"):GetDataStore("BanStore"):RemoveAsync(game.Players:GetUserIdFromNameAsync(args[2]))
				else
					warn(args[2].." is not existen.")
				end
			end
			if string.find(msg, "/publicshout") then
				if msg:sub(1,12) == "/publicshout" then
					local args = string.split(msg, " ")
					game:GetService("MessagingService"):PublishAsync("DeveloperShout",{u=player.Name,m=msg:sub(14)})
				end
			end
			if string.find(msg, "/shout") then
				if msg:sub(1,6) == "/shout" then
					game.ReplicatedStorage.AdminAlert:FireAllClients(msg:sub(8))
				end
			end
		end)
	end
end)

spawn(function()
	game:GetService("MessagingService"):SubscribeAsync("BanAsync", function(mdata)
		local player = mdata.Data.PlayerToBan
		if player then
			game.Players[player]:Kick("You have been banned from Jays Murder Mystery.")
		end
	end)
end)
game:GetService("MessagingService"):SubscribeAsync("DeveloperShout", function(mdata)
	local player, message = mdata.Data.u, mdata.Data.m
	if message then
		game.ReplicatedStorage.AdminAlert:FireAllClients(message)
	end
end)


