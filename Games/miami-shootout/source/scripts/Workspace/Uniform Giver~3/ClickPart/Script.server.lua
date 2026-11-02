-- Uniform Giver
-- Gullet
-- 2015/02/01

-- Tags --

local pantsId = script.Parent.Parent.Coathanger.Pants.PantsTemplate
local shirtId = script.Parent.Parent.Coathanger.Shirt.ShirtTemplate
local cPart = script.Parent
local cDetector = script.Parent.ClickDetector




-- Functions --

local function playSoundLocal(sId,sParent)
	local sound = Instance.new("Sound",sParent)
	sound.SoundId = "http://www.roblox.com/asset/?id="..sId
	sound:Play()
	sound:Destroy()
end

local shortSleeveId = script.ShortSleeve.ShirtTemplate
local groupId = 16324260

local function onClicked(player)
	print(player.Name.." clicked on Uniform Giver")
	
	playSoundLocal(152206246,player)	-- Declaring the sound ID and Parent
	if not player:IsInGroup(groupId) then return game.ReplicatedStorage.server:FireClient(player,"lmsg","You are not allowed to wear this uniform.") end
	
	local rank = player:GetRankInGroup(groupId)
	local sgt = false
	
	if rank >= 5 then
		sgt = true
	end
	
	local shirtGiving = shirtId
	local pantsGiving = pantsId
	
	local typer = "sleeves"
	
	if not player.Character:FindFirstChild("NYPDUNI") then
		Instance.new("NumberValue",player.Character).Name = "NYPDUNI"
	else

		-- already has SP uniform, let's see if they are wearing the coat

		if not player.Character:FindFirstChild("NYPDSSLEEVE") then
			Instance.new("NumberValue",player.Character).Name = "NYPDSSLEEVE"
			shirtGiving = shortSleeveId
			typer = "short"
		else
			shirtGiving = shirtId
			typer = "sleeves"
			player.Character:FindFirstChild("NYPDSSLEEVE"):Destroy()
		end


	end
	
	if sgt then
		
		if typer == "short" then
			shirtGiving = script.SGTShort.ShirtTemplate
		else
			shirtGiving = script.SGTLong.ShirtTemplate
		end
		
	end
	
	local foundShirt = player.Character:FindFirstChild("Shirt") -- Tries to find Shirt
	if not foundShirt then -- if there is no shirt
		print("No shirt found, creating for "..player.Name)
		local newShirt = Instance.new("Shirt",player.Character)
		newShirt.Name = "Shirt"
	else if foundShirt then -- if there is a shirt
		print("Shirt found, reconstructing for "..player.Name)
		player.Character.Shirt:remove()
		local newShirt = Instance.new("Shirt",player.Character)
		newShirt.Name = "Shirt"
	end
	end
	
	
	
	
	local foundPants = player.Character:FindFirstChild("Pants") -- Tries to find Pants
	if not foundPants then -- if there are no pants
		print("No pants found, creating for "..player.Name)
		local newPants = Instance.new("Pants",player.Character)
		newPants.Name = "Pants"
	else if foundPants then -- if there are pants
		print("Pants found, reconstructing for "..player.Name)
		player.Character.Pants:remove()
		local newPants = Instance.new("Pants",player.Character)
		newPants.Name = "Pants"
	end
	end
	
	player.Character.Shirt.ShirtTemplate = shirtGiving
	player.Character.Pants.PantsTemplate = pantsGiving
	end




local function onHoverEnter(player)
	cPart.Transparency = 1
	cPart.BrickColor = BrickColor.White()
end



local function onHoverLeave(player)
	cPart.BrickColor = BrickColor.Gray()
	cPart.Transparency = 1
end


-- Binds --

cDetector.MouseHoverEnter:connect(onHoverEnter)
cDetector.MouseHoverLeave:connect(onHoverLeave)
cDetector.MouseClick:connect(onClicked)



