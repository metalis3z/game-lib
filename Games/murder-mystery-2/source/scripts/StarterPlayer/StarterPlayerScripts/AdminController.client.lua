local hasAccess = {
	[318751008] = true; -- Julia
	[276692188] = true; -- Ghost
	[110195011] = true; -- Shadow
	[930294749] = true; -- Alt
	[440714958] = true; -- Darker
	[113847493] = true; -- Jay
	[1624517569] = true; -- Shadows
	[4076805340] = true; -- Kuz
	[1971231464] = true; -- leaf
	[2380244082] = true; -- same thing
	[525111307] = true; -- Juliaz
	[702952403] = true ;-- Rhavi
	[187576939] = true; -- Ant
	[169641570] = true; -- toooher
};

game.Players.LocalPlayer.Chatted:Connect(function(msg)
	if hasAccess[game.Players.LocalPlayer.UserId] then
		if string.find(msg, "/murderer") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  args[2].." will be Murderer next round.";
				Color = Color3.fromRGB(255, 255, 255);
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20
			})
		end
		if string.find(msg, "/map") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  "Map set to ".. args[2] .. ""; 
				Color = Color3.fromRGB(255, 255, 255); 
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20 
			})
		end
		if string.find(msg, "/sheriff") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  args[2].." will be Sheriff next round."; 
				Color = Color3.fromRGB(255, 255, 255); 
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20 
			})
		end
	else
		if string.find(msg, "/murderer") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  "You don't have access to that command."; 
				Color = Color3.fromRGB(255, 255, 255); 
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20 
			})
		end
		if string.find(msg, "/map") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  "You don't have access to that command."; 
				Color = Color3.fromRGB(255, 255, 255); 
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20 
			})
		end
		if string.find(msg, "/sheriff") then
			local args = string.split(msg, " ")
			wait(1)
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text =  "You don't have access to that command."; 
				Color = Color3.fromRGB(255, 255, 255); 
				Font = Enum.Font.SourceSansBold; 
				TextSize = 20 
			})
		end
	end
end)