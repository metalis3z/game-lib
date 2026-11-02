local _M = {}
local v2, v3, v4, v5, v6
_M.WaterBodies = {}
_M.Difficulties = {
	{"Easy", Color3.fromRGB(85, 255, 127), 50},
	{"Normal", Color3.fromRGB(255, 255, 127), 75},
	{"Hard", Color3.fromRGB(255, 85, 127), 125},
	{"Insane", Color3.fromRGB(170, 85, 255), 200},
	{"Crazy", Color3.fromRGB(230, 126, 34), 300},
	{"Crazy+", Color3.fromRGB(211, 84, 0), 400}
}

local gamePlaceIds = {0, 1, 1, 1, 1, 1, 1, 1}
local isAllowedPlace = false

for _, placeId in ipairs(gamePlaceIds) do
	if placeId == game.PlaceId then
		isAllowedPlace = true
		break
	end
end
local loginBonus = {
	{amount = 2, currency = 0},
	{amount = 4, currency = 0},
	{amount = 8, currency = 0},
	{amount = 14, currency = 0},
	{amount = 4, currency = 1},
	{amount = 20, currency = 0},
	{amount = 10, currency = 1}
}
_M.Difficulties_Goals = {
	{Name = "Easy", Color = Color3.fromRGB(85, 255, 127), 50},
	{Name = "Normal", Color = Color3.fromRGB(255, 255, 127), 75},
	{Name = "Hard", Color = Color3.fromRGB(255, 85, 127), 125},
	{Name = "Insane", Color = Color3.fromRGB(170, 85, 255), 200},
	{Name = "Crazy", Color = Color3.fromRGB(230, 126, 34), 300},
	{Name = "Crazy+", Color = Color3.fromRGB(211, 84, 0), 400}
}

local MapData = {}

function InitMapData()
	if game:GetService("RunService"):IsServer() then
		local Maps = game.ServerStorage.Maps
		for _, Map in next, Maps:GetChildren() do
			if Map:IsA("Model") then
				if Map.Settings:FindFirstChild("Featured") or Map.Settings:GetAttribute("Featured") then
					continue
				else
					local Tab = {}
					Tab.mapName = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapName")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapName") and Map:FindFirstChild("Settings"):FindFirstChild("MapName").Value) or "???"
					Tab.mapDif = math.floor((Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("Difficulty")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty").Value) or 6.9)
					Tab.mapImg = tostring((Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapImage")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage").Value))
					table.insert(MapData, Tab)
				end
			end
		end
	end
end

local modeInfo = {}

if isAllowedPlace then
	modeInfo = {
		startPlace = game.PlaceId == 0 and 0 or 1,
		allowedData = {1},
		allowedMapTesting = {},
		allowedPro = {1},
		allowedChaos = {1, 1},
		allowedChill = {1},
		allowedRetro = {1}
	}
else
	modeInfo = {
		startPlace = 1,
		allowedData = {1, 1},
		allowedMapTesting = { --TODO change this!
			1, 1
		},
		allowedPro = {1},
		allowedChaos = {1},
		allowedChill = {1},
		allowedRetro = {1}
	}
end

for _, id in ipairs(modeInfo.allowedData) do
	if game.PlaceId == id then
		v2 = true
		break
	end
end

for _, id in ipairs(modeInfo.allowedMapTesting) do
	if game.PlaceId == id then
		v3 = true
		break
	end
end

for _, id in ipairs(modeInfo.allowedPro) do
	if game.PlaceId == id then
		v4 = true
		break
	end
end

for _, id in ipairs(modeInfo.allowedChaos) do
	if game.PlaceId == id then
		v5 = true
		break
	end
end

for _, id in ipairs(modeInfo.allowedChill) do
	if game.PlaceId == id then
		v6 = true
		break
	end
end

local themeColor = Color3.fromRGB(0, 170, 255)
if v4 then
	themeColor = Color3.fromRGB(142, 68, 173)
elseif v3 then
	themeColor = Color3.fromRGB(127, 140, 141)
elseif v5 then
	themeColor = Color3.fromRGB(231, 76, 60)
elseif v6 then
	themeColor = Color3.fromRGB(26, 188, 156)
end

function _M.getModeInfo()
	return modeInfo
end
function _M.getDifInfo()
	return _M.Difficulties_Goals
end

function _M.getOfficialMapData()
	--print(MapData)
	return MapData
end
function _M.getThemeColor()
	return themeColor
end
function _M.abbreviateNumber(value)
	local suffixes = {"", "K", "M", "B", "T"}
	local index = 1
	while value >= 1000 and index < #suffixes do
		value = value / 1000
		index = index + 1
	end
	-- Format the number based on whether it has a fractional part
	local formattedValue = tostring(value)
	if suffixes[index] == "" then
		formattedValue = formattedValue:sub(1, string.len(value))
	else
		if formattedValue:sub(4, 4) > tostring(0) then
			formattedValue = formattedValue:sub(1, 4)
		else
			formattedValue = formattedValue:sub(1, 2)
		end
	end
	return formattedValue .. suffixes[index]
end
function _M.calcLevelXP(level)
	local xpMath = 200 + (level - 1) * 400
	local xpCap = 10000
	local requiredXP = math.clamp(xpMath, 1, xpCap)
	return requiredXP
end
function _M.getLoginBonus(day)
	while day > #loginBonus do
		day = day - #loginBonus
	end
	return loginBonus[day].amount, loginBonus[day].currency
end
function _M.getXPCoinAward(XP)
	return math.ceil(XP * 0.02)
end
function _M.getXPGemAward(XP)
	return math.floor(XP * 0.01)
end
function _M.getEnabled()
	return v2, v3, v4, v5, v6, isAllowedPlace, modeInfo.startPlace
end
function _M.CheckIsSwimming(pos, tab)
	if tab == nil then
		tab = _M.WaterBodies
	end
	for i, water in pairs(tab) do
		local isIn = _M.inPart(pos, water)
		if isIn then
			return isIn
		end
	end
end
function _M.generateOptionsTab()
	local data = {
		Main = {
			BGMenabled = {
				LayoutOrder = 1, 
				Name = "Music", 
				Property = {
					Value = true, 
					Type = "boolean"
				}
			}, 
			AurasEnabled = {
				LayoutOrder = 4, 
				Name = "Auras", 
				Property = {
					Value = 1, 
					Type = "cycle", 
					Cycles = { "All", "Only Me", "Off" }
				}
			}, 
			locatorEnabled = {
				LayoutOrder = 7, 
				Name = "Goal Locator", 
				Property = {
					Value = true, 
					Type = "boolean"
				}
			}, 
			camFXEnabled = {
				LayoutOrder = 5, 
				Name = "Camera FX", 
				Property = {
					Value = false, 
					Type = "boolean"
				}
			}, 
			isHighDetail = {
				LayoutOrder = 6, 
				Name = "High Detail", 
				Property = {
					Value = true, 
					Type = "boolean"
				}
			}, 
			ghostState = {
				LayoutOrder = 3, 
				Name = "Visible Players", 
				Property = {
					Value = 2, 
					Type = "cycle", 
					Cycles = { "All", "Far", "None" }
				}
			}, 
			boomboxEnabled = {
				LayoutOrder = 10, 
				Name = "Boombox/Emotes", 
				Property = {
					Value = 3, 
					Type = "cycle", 
					Cycles = { "Off", "Lobby Only", "On" }
				}
			}, 
			controlPrompts = {
				LayoutOrder = 8, 
				Name = "Control Prompts", 
				Property = {
					Value = true, 
					Type = "boolean"
				}
			}, 
			autoSlide = {
				LayoutOrder = 9, 
				Name = "Auto-Slide", 
				Property = {
					Value = true, 
					Type = "boolean"
				}
			},
		},
		Controls = {
			EMOTE = {
				LayoutOrder = 1, 
				Name = "Emote", 
				KeyString = {
					Keyboard = "F",
					Gamepad = "ButtonX"
				}
			}, 
			SWIMDIVE = {
				LayoutOrder = 2, 
				Name = "Swim Down", 
				KeyString = {
					Keyboard = "E",
					Gamepad = "ButtonB"
				}
			}, 
			SWIMJUMP = {
				LayoutOrder = 3, 
				Name = "Swim Up", 
				KeyString = {
					Keyboard = "Space",
					Gamepad = "ButtonA"
				}
			}, 
			RUNSLIDE = {
				LayoutOrder = 4, 
				Name = "Slide", 
				KeyString = {
					Keyboard = "E",
					Gamepad = "ButtonB"
				}
			},
		},
		Others = {
			FOV_Input = {
				LayoutOrder = 1, 
				Name = "FOV Range", 
				Property = {
					Value = 70, 
					Type = "manual", 
				}
			}, 
		}
	}
	return data
end
function _M.inPart(pos, item, swimmables)
	if item then
		if typeof(item) == "table" then
			for i, water in pairs(item) do
				local isIn = _M.inPart(pos, water)
				if isIn then
					return isIn
				end
			end
			return
		end
		if item:IsA("BasePart") then
			local cf = item.CFrame:toObjectSpace(CFrame.new(pos.X, pos.Y, pos.Z))
			if item:IsA("Part") then
				if item.Shape == Enum.PartType.Block then
					if math.abs(cf.p.X * 2) <= item.Size.X and math.abs(cf.p.Y * 2) <= item.Size.Y and math.abs(cf.p.Z * 2) <= item.Size.Z then
						return item
					end
				elseif item.Shape == Enum.PartType.Ball then
					local axis = {
						"X",
						"Y",
						"Z"
					}
					local lowestSize = 10000
					for _, p in next, axis, nil do
						if lowestSize > item.Size[p] then
							lowestSize = item.Size[p]
						end
					end
					if (pos - item.Position).magnitude < lowestSize * 0.5 then
						return item
					end
				end
			elseif item:IsA("WedgePart") then
				local zScale = (cf.p.Z + item.Size.Z * 0.5) / item.Size.Z
				local yScale = (cf.p.Y + item.Size.Y * 0.5) / item.Size.Y
				if zScale >= yScale and math.abs(cf.p.X * 2) <= item.Size.X and math.abs(cf.p.Y * 2) <= item.Size.Y and math.abs(cf.p.Z * 2) <= item.Size.Z then
					return item
				end
			end
		end
	end
	return nil
end

return _M