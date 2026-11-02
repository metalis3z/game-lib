local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local InsertService = game:GetService("InsertService")

local WeldHat = require(script:WaitForChild("WeldHat"))
local PassFaces = require(ServerStorage:WaitForChild("Gameplay"):WaitForChild("Faces"))
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))

local GameplayStorage = ServerStorage:WaitForChild("Gameplay")
local DatabaseStorage = ServerStorage:WaitForChild("Database")
local RoleSelectRemote = ReplicatedStorage
	:WaitForChild("Remotes")
	:WaitForChild("Gameplay")
	:WaitForChild("RoleSelect")

local RandomGenerator = Random.new()

local DEFAULT_FACE_TEXTURE = "rbxasset://textures/face.png"
local CHARACTER_WAIT_TIMEOUT = 5
local ACCESSORY_CHANCE = 0.5
local DEBUG_WARNINGS = true

local FaceTextureCache = {}

local function warnDebug(message)
	if DEBUG_WARNINGS then
		warn(("[MakeCharacter] %s"):format(message))
	end
end

local function chooseRandomChild(container)
	if not container then
		return nil
	end

	local children = container:GetChildren()
	if #children == 0 then
		return nil
	end

	return children[RandomGenerator:NextInteger(1, #children)]
end

local function getCharacterParts(player)
	local character = player.Character
	if not character then
		return nil, nil, nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
		or character:WaitForChild("Humanoid", CHARACTER_WAIT_TIMEOUT)

	local head = character:FindFirstChild("Head")
		or character:WaitForChild("Head", CHARACTER_WAIT_TIMEOUT)

	if not humanoid or not head then
		return character, nil, nil
	end

	return character, humanoid, head
end

local function prepareWearable(instance)
	for _, descendant in ipairs(instance:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
			descendant.CanCollide = false
			descendant.CanTouch = false
			descendant.Massless = true
		end
	end
end

local function weldWearable(template, character)
	if not template or not character then
		return false
	end

	local wearable = template:Clone()
	prepareWearable(wearable)

	local success, result = pcall(WeldHat, wearable, character, template)
	if not success then
		wearable:Destroy()
		warnDebug(("Failed to weld %s: %s"):format(template:GetFullName(), tostring(result)))
		return false
	end

	return true
end

local function removeExistingClass(character, className)
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA(className) then
			child:Destroy()
		end
	end
end

local function resetBodyAppearance(player, character, humanoid)
	local cleared, clearError = pcall(function()
		player:ClearCharacterAppearance()
	end)

	if not cleared then
		warnDebug(("ClearCharacterAppearance failed for %s: %s"):format(
			player.Name,
			tostring(clearError)
			))
	end

	local description
	local gotDescription, descriptionError = pcall(function()
		description = humanoid:GetAppliedDescription()
	end)

	if not gotDescription or not description then
		warnDebug(("Could not read HumanoidDescription for %s: %s"):format(
			player.Name,
			tostring(descriptionError)
			))
		return false
	end

	description.Head = 0
	description.LeftArm = 0
	description.RightArm = 0
	description.LeftLeg = 0
	description.RightLeg = 0
	description.Torso = 0

	local applied, applyError = pcall(function()
		humanoid:ApplyDescription(description)
	end)

	if not applied then
		warnDebug(("Could not apply HumanoidDescription for %s: %s"):format(
			player.Name,
			tostring(applyError)
			))
		return false
	end

	removeExistingClass(character, "BodyColors")

	local colorsTemplate = script:FindFirstChild("Colors")
	if colorsTemplate then
		colorsTemplate:Clone().Parent = character
	else
		warnDebug("Colors is missing from the MakeCharacter module.")
	end

	return true
end

local function getOutfitFolder(map)
	local success, gameMode = pcall(require, script.Parent)
	if not success or type(gameMode) ~= "table" then
		warnDebug(("Could not read the parent game mode: %s"):format(tostring(gameMode)))
		return nil
	end

	if gameMode.Outfits == "Map" then
		if not map then
			warnDebug("A map was not supplied while GameMode.Outfits is set to Map.")
			return nil
		end

		local mapsFolder = DatabaseStorage:FindFirstChild("Maps")
		local mapData = mapsFolder and mapsFolder:FindFirstChild(map.Name)
		local outfits = mapData and mapData:FindFirstChild("Outfits")

		if not outfits then
			warnDebug(("No outfit folder was found for map %s."):format(map.Name))
		end

		return outfits
	end

	if typeof(gameMode.OutfitFolder) == "Instance" then
		return gameMode.OutfitFolder
	end

	warnDebug("GameMode.OutfitFolder is missing or is not an Instance.")
	return nil
end

local function outfitIsUsable(outfit)
	return outfit
		and (
			outfit:FindFirstChildWhichIsA("Shirt", true)
			or outfit:FindFirstChildWhichIsA("Pants", true)
			or outfit:FindFirstChild("Accessories")
		)
end

local function chooseOutfit(outfitsFolder)
	if not outfitsFolder then
		return nil
	end

	local usableOutfits = {}

	for _, outfit in ipairs(outfitsFolder:GetChildren()) do
		if outfitIsUsable(outfit) then
			table.insert(usableOutfits, outfit)
		end
	end

	if #usableOutfits == 0 then
		return nil
	end

	return usableOutfits[RandomGenerator:NextInteger(1, #usableOutfits)]
end

local function applyClothing(character, outfit)
	local shirt = outfit:FindFirstChildWhichIsA("Shirt", true)
	local pants = outfit:FindFirstChildWhichIsA("Pants", true)
	local shirtGraphic = outfit:FindFirstChildWhichIsA("ShirtGraphic", true)

	if shirt then
		removeExistingClass(character, "Shirt")
		shirt:Clone().Parent = character
	end

	if pants then
		removeExistingClass(character, "Pants")
		pants:Clone().Parent = character
	end

	if shirtGraphic then
		removeExistingClass(character, "ShirtGraphic")
		shirtGraphic:Clone().Parent = character
	end
end

local function applyRandomAccessory(character, outfit)
	if RandomGenerator:NextNumber() > ACCESSORY_CHANCE then
		return
	end

	local accessoriesFolder = outfit:FindFirstChild("Accessories")
	if not accessoriesFolder then
		return
	end

	local accessory = chooseRandomChild(accessoriesFolder)
	if accessory then
		weldWearable(accessory, character)
	end
end

local function getFaceDecal(head)
	local face = head:FindFirstChild("face")

	if face and face:IsA("Decal") then
		return face
	end

	face = head:FindFirstChildWhichIsA("Decal")
	if face then
		return face
	end

	face = Instance.new("Decal")
	face.Name = "face"
	face.Face = Enum.NormalId.Front
	face.Parent = head

	return face
end

local function resolveFaceTexture(faceAsset)
	if faceAsset == nil then
		return nil
	end

	if type(faceAsset) == "string" then
		if faceAsset:match("^rbxasset://")
			or faceAsset:match("^rbxassetid://")
			or faceAsset:match("^https?://")
		then
			return faceAsset
		end

		faceAsset = tonumber(faceAsset)
	end

	if type(faceAsset) ~= "number" then
		return nil
	end

	if FaceTextureCache[faceAsset] ~= nil then
		return FaceTextureCache[faceAsset] or nil
	end

	local loadedContainer
	local success, loadError = pcall(function()
		loadedContainer = InsertService:LoadAsset(faceAsset)
	end)

	if not success or not loadedContainer then
		FaceTextureCache[faceAsset] = false
		warnDebug(("Could not load face asset %s: %s"):format(
			tostring(faceAsset),
			tostring(loadError)
			))
		return nil
	end

	local decal = loadedContainer:FindFirstChildWhichIsA("Decal", true)
	local texture = decal and decal.Texture or nil

	loadedContainer:Destroy()
	FaceTextureCache[faceAsset] = texture or false

	return texture
end

local function applyRandomFace(head)
	local face = getFaceDecal(head)
	face.Texture = DEFAULT_FACE_TEXTURE

	if type(PassFaces) ~= "table" or #PassFaces == 0 then
		return
	end

	local selectedFace = PassFaces[RandomGenerator:NextInteger(1, #PassFaces)]
	local texture = resolveFaceTexture(selectedFace)

	if texture and texture ~= "" then
		face.Texture = texture
	end
end

local function removeWeaponDisplays(character)
	local knifeDisplay = character:FindFirstChild("KnifeDisplay")
	local gunDisplay = character:FindFirstChild("GunDisplay")

	if knifeDisplay then
		knifeDisplay:Destroy()
	end

	if gunDisplay then
		gunDisplay:Destroy()
	end
end

local function applyDisguise(player, map)
	local character, humanoid, head = getCharacterParts(player)
	if not character or not humanoid or not head then
		warnDebug(("Character was not ready for %s."):format(player.Name))
		return false
	end

	resetBodyAppearance(player, character, humanoid)

	local hairFolder = GameplayStorage:FindFirstChild("Hair")
	local hair = chooseRandomChild(hairFolder)

	if hair then
		weldWearable(hair, character)
	else
		warnDebug("No disguise hair is available in ServerStorage.Gameplay.Hair.")
	end

	local outfitsFolder = getOutfitFolder(map)
	local outfit = chooseOutfit(outfitsFolder)

	if outfit then
		applyClothing(character, outfit)
		applyRandomAccessory(character, outfit)
	else
		warnDebug("No usable disguise outfit was found.")
	end

	applyRandomFace(head)
	removeWeaponDisplays(character)

	character:SetAttribute("DisguiseApplied", true)
	return true
end

local function MakeCharacter(player, roleName, map)
	if not player or not player:IsA("Player") or player.Parent ~= Players then
		return false
	end

	RoleSelectRemote:FireClient(
		player,
		roleName,
		nil,
		nil,
		nil,
		"Classic",
		nil,
		nil,
		nil,
		nil,
		nil
	)

	if game.PlaceId ~= Constants.Places.Disguises then
		return true
	end

	return applyDisguise(player, map)
end

return MakeCharacter