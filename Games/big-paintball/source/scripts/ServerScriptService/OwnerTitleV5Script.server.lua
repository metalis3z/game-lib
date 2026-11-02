--[[
	
	Hello! Thanks for using OwnerTitleV5.
	
	If you want to become an awesome scripter and stop using free models, check out the links below :D
	
	https://www.youtube.com/channel/UCp1R0TBvgM7gj0rwTYULmSA -- AlvinBlox (not sponsored, but I do endorse)
	https://developer.roblox.com/en-us/api-reference -- Roblox DevWiki (full of super useful info) 
	https://devforum.roblox.com/ -- Roblox DevForum (full of other cool devs who can help)
	
	!! IF YOU'RE CHANGING ANYTHING BELOW,  MAKE SURE YOU'RE CAREFUL AS TO WHAT YOU'RE DOING !!
	!! IF YOU ACCIDENTALLY BREAK SOMETHING JUST DELETE THE MODEL AND RE-ADD IT FROM TOOLBOX !!
	
--]] 

local otherOwners = {"Example","Roblox","builderman"} -- Add your friends name or UserId if you want them to have the title

local useName = true -- Set this to true if you want to title to be your username instead of "Owner"

local titletext = "Owner" -- This doesn't matter if useName is set to true

local SizeX = 8 -- Width of the title inj studs

local SizeY = 2.5 -- Height of the title in studs

local font = Enum.Font.Code -- Remember to follow the enum format! (like Enum.Font.Arial, Enum.Font.Cartoon)

local rainbow = true -- Set to 'false' if you want it to follow 'color' instead

local color_red = 0 -- I tried to make the color format easy for new coders to understand.

local color_green = 100 -- The numbers are percentages so if you did 0,100,0 it would be 100% green,

local color_blue = 100  -- If you did all 100s it would be white, all 0s it would be black.

local text_outline = true

local allow_model_sales = true	-- If set to true, players can take the model by saying !title. 
								-- I made sure it is as unobtrusive as possible, players will ONLY
								-- get the purchase prompt if they say !title in chat.
							
								-- There is no other advertising in the script, I only have this to
								-- hopefully help me out getting this to the frontpage, and letting
								-- people who are interested in getting their own owner title
								-- be able to. Also, it's all free. Thank you!
													
-- Actual script starts here. Only edit the stuff below if you REALLY know what you're doing!

local baseTitle = script:WaitForChild("OwnerTitleV5")
baseTitle.Size = UDim2.new(SizeX,0,SizeY,0)

local temp = script.Parent
script.Parent = game:GetService("ServerScriptService")
baseTitle.Parent = game:GetService("ServerStorage")
if temp.Name == "OwnerTitleV5 by Zeezy2204" then temp:Destroy() end

local color = Color3.new(color_red/100,color_green/100,color_blue/100)
local function giveTitle(owner)
	owner.CharacterAdded:Connect(function(character)
		local head = character:WaitForChild("Head")
		local newTitle = baseTitle:Clone()
		newTitle.Parent = head
		newTitle.Adornee = head
		newTitle.Enabled = true
		local newText = newTitle:WaitForChild("TextLabel")
		if useName then
			newText.Text = owner.Name
		end
		if color then
			newText.TextColor3 = color
		end
		if font then
			newText.Font = font
		end
		if text_outline then
			newText.TextStrokeTransparency = 0
		else
			newText.TextStrokeTransparency = 1
		end
		if titletext then
			newText.Text = tostring(titletext)
		end
		if rainbow then
			while head do
				wait()
				newText.TextColor3 = Color3.fromHSV(tick()%1,1,1)
			end
		end
	end)
end


game:GetService("Players").PlayerAdded:Connect(function(Player)
	local isOwner = false
	for i,v in ipairs(otherOwners) do
		if Player.Name == v or Player.UserId == v then
			isOwner = true
		end
	end
	if Player.UserId == game.CreatorId then
		isOwner = true
	end
	if isOwner then
		giveTitle(Player)
	end
	if allow_model_sales then -- This is turned off if you set allow_model_sales to false up above.
		Player.Chatted:Connect(function(message)
			if string.lower(message) == "!title" then -- Players can say !title to put this model in their game
				game:GetService("MarketplaceService"):PromptPurchase(Player,4340182608)
			end
		end)
	end
end)
wait(1)
print("OwnerTitleV5 by Zeezy2204 loaded successfully.")
