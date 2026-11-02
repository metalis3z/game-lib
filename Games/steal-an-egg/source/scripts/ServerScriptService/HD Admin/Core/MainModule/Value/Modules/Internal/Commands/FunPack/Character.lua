--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local MarketplaceService = game:GetService("MarketplaceService")
local getNeck = CommandAPI.getNeck
local getHumanoid = CommandAPI.getHumanoid
local applyDescription = CommandAPI.applyDescription
local getDescription = CommandAPI.getDescription
local getHead = CommandAPI.getHead
local isTypeAsync = CommandAPI.isTypeAsync
local outfitBuff = CommandAPI.outfitBuff
local setTransparency = CommandAPI.setTransparency
local setFakeBodyParts = CommandAPI.setFakeBodyParts
local clearFakeBodyParts = CommandAPI.clearFakeBodyParts
local createBundleCommand = CommandAPI.createBundleCommand
local runBundleId = CommandAPI.runBundleId


-- LOCAL FUNCTIONS
local function getAccessoryTypeAsync(integer)
	if integer <= 0 then
		return false, "Invalid accessoryID"
	end
	local MarketplaceService = game:GetService("MarketplaceService")
	local success, productInfo = pcall(function()
		return (MarketplaceService :: any):GetProductInfo(integer, Enum.InfoType.Asset)
	end)
	if not success then
		return false, tostring(productInfo)
	end
	local assetTypeId = tonumber(productInfo.AssetTypeId)
	if not assetTypeId then
		return false, "Invalid accessoryType"
	end
	local assetEnum = Enum.AssetType:FromValue(assetTypeId)
	local enumName = (assetEnum and assetEnum.Name) or ""
	local isHat = enumName == "Hat"
	if not (enumName:match("Accessory") or isHat) then
		return false, "Invalid accessory"
	end
	local function stipStringOfAccessory(s: string): string
		if type(s) ~= "string" then return s end
		local suffix = "Accessory"
		if #s >= #suffix and string.sub(s, -#suffix) == suffix then
			return string.sub(s, 1, #s - #suffix)
		end
		return s
	end
	local accessoryTypeName = if isHat then enumName else stipStringOfAccessory(enumName)
	local accessoryType = (Enum.AccessoryType :: any)[accessoryTypeName]
	if not accessoryType then
		return false, "Invalid accessory type enum"
	end
	return true, accessoryType
end

local function getClearHatsProperties()
	local properties = {
		["_ClearAccessories"] = true,
	}
	return properties :: {[string]: any}
end

local function getRunFromAccessoryCommand(name: string, validTypes: {[Enum.AccessoryType]: true})
	return function(task: CommandAPI.Task)
		local target = task.target
		local integer = task:getArg("Integer")
		local success, warning = isTypeAsync(integer, (Enum.AssetType :: any)[name])
		if not success then
			local success, accessoryTypeEnum: any = getAccessoryTypeAsync(integer)
			if not success or not validTypes[accessoryTypeEnum] then
				CommandAPI.prompt("warn", task.caller, `AssetId is not a {name}`)
				return
			end
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				["_Accessories"] = {
					{
						AssetId = integer,
						AccessoryType = accessoryTypeEnum,
						Order = 1,
					},
				}
			}))
			return
		end
		task:keep("UntilTargetRespawns")
		task:buff(target, "Outfit", outfitBuff(target, {
			[name] = integer,
		}))
	end
end

local function createMaterialBodyCommand(commandName, properties)
	local command: CommandAPI.Command = {
		name = commandName,
		groups = {"Material"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			local stopWatching = setFakeBodyParts(target.Character, properties)
			task:onEnded(function()
				if stopWatching then
					stopWatching()
				end
				clearFakeBodyParts(target.Character)
			end)
		end
	}
	return command
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	createBundleCommand("Buffify", 594200, {RemoveBodyParts = {"Head"}, Aliases = {"Buff"}}),
	createBundleCommand("Wormify", 394523, {}),
	createBundleCommand("Chibify", 6470, {Aliases = {"Chibi"}}),
	createBundleCommand("Plushify", 3416, {RemoveBodyParts = {"Head"}, ScaleHead = 1.15}),
	createBundleCommand("Freakify", 1186597, {Aliases = {"Freak"}}),
	createBundleCommand("Frogify", 386731, {}),
	createBundleCommand("Spongify", 393419, {}),
	createBundleCommand("Bigify", 455999, {}),
	createBundleCommand("Creepify", 946396, {}),
	createBundleCommand("Dinofy", 369985, {IgnoreAccessories = {"Hair"}}),
	createBundleCommand("Fatify", 637696, {}),

    --------------------
	createMaterialBodyCommand("Glass", {Color = Color3.fromRGB(255, 255, 255), Material = Enum.Material.Glass, Transparency = 0.5}),
	createMaterialBodyCommand("Neon", {Color = Color3.fromRGB(180, 180, 180), Material = Enum.Material.Neon, Transparency = 0}),
	createMaterialBodyCommand("Shine", {Reflectance = 0, Material = Enum.Material.Neon, Transparency = 0.5}),
	createMaterialBodyCommand("Ghost", {Reflectance = 0, Color = Color3.fromRGB(255, 255, 255), Material = Enum.Material.SmoothPlastic, Transparency = 0.7}),
	createMaterialBodyCommand("Gold", {Reflectance = 0.5, Color = Color3.fromRGB(255, 176, 0), Material = Enum.Material.SmoothPlastic, Transparency = 0}),

    --------------------
	{
		name = "Paint",
		aliases	= {"Color", "Colour"},
		args = {"Player", "Color"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local color = task:getArg("Color")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", function(hasEnded, originalValue)
				local humanoid = getHumanoid(target)
				if not humanoid then return end
				local originalDesc = (originalValue or humanoid:GetAppliedDescription()) :: any
				if hasEnded then
					applyDescription(humanoid, originalDesc)
				else
					applyDescription(humanoid, originalValue, {
						HeadColor = color,
						LeftArmColor = color,
						RightArmColor = color,
						LeftLegColor = color,
						RightLegColor = color,
						TorsoColor = color,
					})
				end
				return originalDesc
			end)
		end
	},

    --------------------
	{
		name = "Reflect",
		aliases	= {"Ref", "Shiny", "Reflectance"},
		groups = {"Material"},
		args = {
			"Player",
			{arg = "Number", display = "Reflectance", default = 1, min = 0, max = 1, step = 0.1},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Number")
			task:keep("UntilTargetRespawns")
			local stopWatching = setFakeBodyParts(target.Character, {Reflectance = number})
			task:onEnded(function()
				if stopWatching then
					stopWatching()
				end
				clearFakeBodyParts(target.Character)
			end)
		end
	},

    --------------------
	{
		name = "Material",
		aliases	= {"Mat", "Surface"},
		groups = {"Material"},
		args = {"Player", "Material"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local material = task:getArg("Material")
			task:keep("UntilTargetRespawns")
			local stopWatching = setFakeBodyParts(target.Character, {Material = material})
			task:onEnded(function()
				if stopWatching then
					stopWatching()
				end
				clearFakeBodyParts(target.Character)
			end)
		end
	},

    --------------------
	{
		name = "Size",
		groups = {"CharSize"},
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				DepthScale = 1*scale,
				HeightScale = 1*scale,
				WidthScale = 1*scale,
				HeadScale = 1*scale,
			}))
		end
	},

    --------------------
	{
		name = "BigHead",
		aliases = {"BHead", "LargeHead"},
		groups = {"HeadSize"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				HeadScale = 2.5,
			}))
		end
	},

    --------------------
	{
		name = "SmallHead",
		groups = {"SHead", "HeadSize"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				HeadScale = 0.6,
			}))
		end
	},

    --------------------
	{
		name = "PotatoHead",
		aliases = {"PHead"},
		groups = {"HeadSize"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				Head = 14917727535,
				HeadScale = 3,
			}))
			task:buff(target, "Outfit", function(hasEnded, originalValue: any)
				local humanoid = getHumanoid(target)
				if not humanoid then return end
				local originalDescription = (originalValue or getDescription(humanoid)) :: any
				if hasEnded then
					applyDescription(humanoid, originalDescription)
				else
					local clearProperties = getClearHatsProperties()
					applyDescription(humanoid, originalValue, clearProperties)
					task.spawn(function()
						humanoid.ApplyDescriptionFinished:Wait()
						local neck = getNeck(target)
						if neck and neck:IsA("Motor6D") and neck.Parent then
							-- Rig may rebuild as we yield; C0 goes readonly on orphaned joints
							pcall(function()
								neck.C0 *= CFrame.Angles(0, 0, math.rad(90)) * CFrame.new(0.5, -0.9, 0)
							end)
						end
					end)
				end
				return originalDescription
			end)
		end
	},

    --------------------
	{
		name = "Dwarf",
		groups = {"HeadSize", "CharSize"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = 1
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				DepthScale = 0.75*scale,
				HeightScale = 0.5*scale,
				WidthScale = 0.75*scale,
				HeadScale = 1.4*scale,
			}))
		end
	},

    --------------------
	{
		name = "Fat",
		groups = {"CharWidth"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				WidthScale = 2,
				DepthScale = 1.5,
			}))
		end
	},

    --------------------
	{
		name = "Depth",
		aliases	= {"DScale", "DepthScale"},
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				DepthScale = scale,
			}))
		end
	},

    --------------------
	{
		name = "Thin",
		aliases = {"Skinny"},
		groups = {"CharWidth"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				WidthScale = 0.2,
				DepthScale = 0.2,
			}))
		end
	},

    --------------------
	{
		name = "Height",
		aliases	= {"HScale", "HeightScale"};
		args = {"Player", "Scale"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local scale = task:getArg("Scale")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				HeightScale = scale,
			}))
		end
	},

    --------------------
	{
		name = "Squash",
		aliases	= {"Flat", "Flatten"};
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				HeightScale = 0.1,
				HeadScale = 0.5,
			}))
		end
	},

    --------------------
	--!!! bring back later
	--[[{
		name = "Face",
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			local success, warning = isTypeAsync(integer, Enum.AssetType.Face)
			if not success then
				CommandAPI.prompt("warn", task.caller, warning)
				return
			end
			local head = getHead(target)
			local headId = nil
			if not head or not head:FindFirstChild("face") then
				headId = 0
			end
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				Head = headId,
				Face = integer,
			}))
		end
	},--]]

    --------------------
	--!!! bring back later
	--[[{
		name = "Head",
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			local function getHeadIdAsync()
				local success, warningOrInfo = isTypeAsync(integer, Enum.AssetType.Head)
				if success then
					return true, integer
				end
				success, warningOrInfo = isTypeAsync(integer, Enum.AssetType.DynamicHead)
				if success then
					return true, integer
				end
				success, warningOrInfo = isTypeAsync(integer, Enum.BundleType.DynamicHead)
				if not success then
					return false, warningOrInfo
				end
				local items = (warningOrInfo :: any).Items
				if items then
					for _, item in items do
						if item.Name:match("Dynamic Head") then
							return true, item.Id
						end
					end
				end
				return false, "No DynamicHead found"
			end
			local success, headId = getHeadIdAsync()
			if not success then
				CommandAPI.prompt("warn", task.caller, headId)
				return
			end
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				Head = headId,
			}))
		end
	},--]]

    --------------------
	{
		name = "Invisible",
		aliases = {"Invis"},
		groups = {"Transparency"},
		undoAliases = {"Visible", "Vis"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = 1
			task:keep("UntilTargetRespawns")
			task:buff(target, "Transparency", function(isEnded, originalValue)
				local head = getHead(target)
				if not head then return 0 end
				local char = target.Character
				local original = (originalValue or head.Transparency) :: number
				local value = if isEnded then original else number
				setTransparency(char, value)
				return original
			end)
		end
	},

    --------------------
	{
		name = "Transparency",
		groups = {"Transparency"},
		aliases = {"Trans"},
		args = {
			"Player",
			{arg = "Unit", default = 0.5},
		},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local number = task:getArg("Unit")
			task:keep("UntilTargetRespawns")
			task:buff(target, "Transparency", function(isEnded, originalValue)
				local head = getHead(target)
				if not head then return 0 end
				local char = target.Character
				local original = (originalValue or head.Transparency) :: number
				local value = if isEnded then original else number
				setTransparency(char, value)
				return original
			end)
		end
	},

    --------------------
	{
		name = "Shirt",
		stackable = true,
		args = {"Player", "Integer"},
		run = getRunFromAccessoryCommand("Shirt", {
			[Enum.AccessoryType.Shirt] = true,
			[Enum.AccessoryType.Jacket] = true,
			[Enum.AccessoryType.Sweater] = true,
			[Enum.AccessoryType.TShirt] = true,
		}),
	},

    --------------------
	{
		name = "Pants",
		stackable = true,
		args = {"Player", "Integer"},
		run = getRunFromAccessoryCommand("Pants", {
			[Enum.AccessoryType.Pants] = true,
			[Enum.AccessoryType.DressSkirt] = true,
			[Enum.AccessoryType.Waist] = true,
		}),
	},

    --------------------
	{
		name = "Accessory",
		aliases = {"Hair", "Hat"},
		stackable = true,
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local integer = task:getArg("Integer")
			local success, accessoryTypeEnum = getAccessoryTypeAsync(integer)
			if not success then
				CommandAPI.prompt("warn", task.caller, accessoryTypeEnum)
				return
			end
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, {
				["_Accessories"] = {
					{
						AssetId = integer,
						AccessoryType = accessoryTypeEnum,
					},
				}
			}))
		end
	},

    --------------------
	{
		name = "ClearHats",
		aliases	= {"ClrHats", "ClearAccessories", "ClrAccessories", "RemoveHats", "RemoveAccessories"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local clearProperties = getClearHatsProperties()
			task:keep("UntilTargetRespawns")
			task:buff(target, "Outfit", outfitBuff(target, clearProperties))
		end
	},

    --------------------
	--[[{
		name = "Bundle",
		groups = {"Bundle"},
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local bundleId = task:getArg("Integer")
			runBundleId(task, bundleId)
		end
	},--]]

    --------------------

}


return commands
