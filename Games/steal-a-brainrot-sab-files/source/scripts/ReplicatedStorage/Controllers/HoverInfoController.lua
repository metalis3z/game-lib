-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local HoverInfoController = {}
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local GuiService        = game:GetService("GuiService")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local FFlags        = require(ReplicatedStorage.Packages.FFlags)
local Gradients     = require(ReplicatedStorage.Packages.Gradients)
local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Animals       = require(ReplicatedStorage.Datas.Animals)
local Rarities      = require(ReplicatedStorage.Datas.Rarities)
local Mutations     = require(ReplicatedStorage.Datas.Mutations)
local NumberUtils   = require(ReplicatedStorage.Utils.NumberUtils)
local Animals2      = require(ReplicatedStorage.Shared.Animals)
local MutationStyle = require(ReplicatedStorage.Shared.MutationStyle)

local LuckyBlockSource = {}
for blockName, blockData in require(ReplicatedStorage.Datas.LuckyBlocks) do
	for _, entry in blockData.Animals do
		local name = type(entry) ~= "string" and entry.Name or entry
		if name and not LuckyBlockSource[name] then
			LuckyBlockSource[name] = blockName
		end
	end
end

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Popup     = PlayerGui:WaitForChild("Index"):WaitForChild("Popup")
local Txt1      = Popup:WaitForChild("Header"):WaitForChild("Txt1")
local Infos     = Popup:WaitForChild("Infos")
local Rarity    = Infos:WaitForChild("Rarity")
local Cps       = Infos:WaitForChild("Cps")
local Obtained  = Infos:WaitForChild("Obtained")
local Exists    = Infos:WaitForChild("Exists")
local Label     = Exists:WaitForChild("Label")
local ItemImage = Exists:WaitForChild("ITEM_IMAGE")

local EXIST_COUNTS_ID = "ExistCounts"
local existsRep = ReplicatorClient.get(EXIST_COUNTS_ID)

local function getExistData()
	local data = existsRep.Data
	if type(data) == "table" then return data end
	return {}
end

local registered   = {}
local activeCount  = 0
local connection   = nil
local hoveredObj   = nil
local lastKey      = nil
local cleanupGrad1 = nil
local cleanupGrad2 = nil
local GRAY         = Color3.fromRGB(166, 166, 166)

local function cleanupEffects()
	if cleanupGrad1 then cleanupGrad1(); cleanupGrad1 = nil end
	if cleanupGrad2 then cleanupGrad2(); cleanupGrad2 = nil end
end

local function populate(animalKey, mutation)
	local cacheKey = animalKey .. "\0" .. (mutation or "Default")
	if cacheKey == lastKey then return end
	lastKey = cacheKey

	local animalData = Animals[animalKey]
	local rarityData = Rarities[animalData.Rarity]
	local hasMutation = mutation ~= nil and mutation ~= "Default" and mutation ~= "All" and Mutations[mutation] ~= nil

	cleanupEffects()

	Txt1.Text   = animalData.DisplayName
	Rarity.Text = animalData.Rarity

	if rarityData and rarityData.GradientPreset then
		Rarity.TextColor3 = Color3.fromRGB(255, 255, 255)
		cleanupGrad1 = Gradients.apply(Rarity, rarityData.GradientPreset)
	elseif rarityData then
		Rarity.TextColor3 = rarityData.Color
	end

	if animalData.Generation or animalData.Price then
		local gen = Animals2:GetGeneration(animalKey, hasMutation and mutation or nil)
		Cps.Text    = "$" .. NumberUtils:ToString(gen) .. "/s"
		Cps.Visible = true
	else
		Cps.Visible = false
	end

	local fflagOverride = FFlags:GetInstant("Sources", {})[animalKey]
	local source        = nil
	local obtainable    = true

	if animalData.ObtainedFrom then
		source     = animalData.ObtainedFrom.Source
		obtainable = animalData.ObtainedFrom.Obtainable ~= false
	elseif animalData.RoadWeight then
		source = "The Red Carpet"
	elseif LuckyBlockSource[animalKey] then
		source = LuckyBlockSource[animalKey]
	end

	if source then
		Obtained.Visible = true
		if fflagOverride then
			Obtained.Text = fflagOverride
		elseif animalData.ObtainedFrom and animalData.ObtainedFrom.FullText then
			Obtained.Text = source
		else
			Obtained.Text = "This " .. (not obtainable and "was" or "is") .. " obtained from " .. source
		end
	else
		Obtained.Visible = false
	end

	local existData   = getExistData()
	local animalExist = existData[animalKey]

	if animalExist then
		local mutKey   = hasMutation and mutation or "None"
		local count    = animalExist.mutations and animalExist.mutations[mutKey] or 0

		if count == 0 then
			Exists.Visible = false
			return
		end

		local countStr = count > 999999 and NumberUtils:ToString(count) or NumberUtils:Comma(count)

		Label.Text       = countStr .. " Exist"
		Label.TextColor3 = GRAY
		ItemImage.Image  = hasMutation and Mutations[mutation].Icon or "rbxassetid://139326264265904"
		cleanupGrad2     = MutationStyle.ApplyToLabel(Label, hasMutation and mutation or nil)
		Exists.Visible   = true
	else
		Exists.Visible = false
	end
end

local function movePopup(mouse)
	local viewport  = workspace.CurrentCamera.ViewportSize
	local popupSize = Popup.AbsoluteSize
	local x = mouse.X + 16
	local y = mouse.Y + 16
	if x + popupSize.X > viewport.X then x -= popupSize.X end
	if y + popupSize.Y > viewport.Y then y -= popupSize.Y end
	Popup.Position = UDim2.fromOffset(x, y)
end

local function findHovered(objects)
	for _, obj in ipairs(objects) do
		local current = obj
		while current and current ~= PlayerGui do
			if registered[current] then return current, registered[current] end
			current = current.Parent
		end
	end
	return nil, nil
end

local function onRender()
	local mouse   = UserInputService:GetMouseLocation()
	local insetY  = GuiService:GetGuiInset().Y
	local objects = PlayerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y - insetY)
	local obj, fn = findHovered(objects)

	if obj and fn then
		local animalKey, mutation = fn()
		if animalKey and Animals[animalKey] then
			hoveredObj = obj
			populate(animalKey, mutation)
			movePopup(mouse)
			Popup.Visible = true
			return
		end
	end

	hoveredObj = nil
	lastKey    = nil
	Popup.Visible = false
end

function HoverInfoController:Add(guiObject, fn)
	if registered[guiObject] then return function() end end

	registered[guiObject] = fn
	activeCount += 1

	if not connection then
		connection = RunService.RenderStepped:Connect(onRender)
	end

	local destroyed = false
	local destroyConn = guiObject.Destroying:Once(function()
		destroyed = true
		HoverInfoController:Remove(guiObject)
	end)

	return function()
		if destroyed then return end
		destroyed = true
		destroyConn:Disconnect()
		HoverInfoController:Remove(guiObject)
	end
end

function HoverInfoController:Remove(guiObject)
	if not registered[guiObject] then return end

	registered[guiObject] = nil
	activeCount -= 1

	if guiObject == hoveredObj then
		hoveredObj = nil
		lastKey    = nil
		Popup.Visible = false
	end

	if activeCount <= 0 and connection then
		connection:Disconnect()
		connection = nil
		cleanupEffects()
		hoveredObj = nil
		lastKey    = nil
		Popup.Visible = false
	end
end

function HoverInfoController:Start()
	Popup.Visible = false
end

return HoverInfoController