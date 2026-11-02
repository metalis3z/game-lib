--!strict

--[[

	Qualifiers are terms that describe what pool of players should be returned
	For example, "All", returns all players in the server, while "Me" only returns you.
	The caller (the person who ran the command) might not actually be from
	*this server* (global executions are a thing), so only use the
	callerUserId and remember they may not have an associated Player instance

--]]


-- LOCAL
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local Qualifiers = {}
local requiresUpdating = true
local sortedNameAndAliasLengthArray = {}
local lowerCaseDictionary = {}


-- LOCAL FUNCTIONS
local function register(item: QualifierDetail): QualifierDetail
	return item :: QualifierDetail -- We do this to support type checking within the table
end


-- FUNCTIONS
function Qualifiers.update()
	if not requiresUpdating then
		return false
	end
	requiresUpdating = false
	local allItems = Qualifiers.getAll()
	sortedNameAndAliasLengthArray = {}
	lowerCaseDictionary = {}
	for itemNameOrAlias, item in allItems :: any do
		local lowerCaseName = tostring(itemNameOrAlias):lower()
		lowerCaseDictionary[lowerCaseName] = item
		table.insert(sortedNameAndAliasLengthArray, tostring(itemNameOrAlias))
	end
	table.sort(sortedNameAndAliasLengthArray, function(nameA: string, nameB: string): boolean
		return #nameA > #nameB
	end)
	return true
end

function Qualifiers.getSortedNameAndAliasLengthArray()
	Qualifiers.update()
	return sortedNameAndAliasLengthArray
end

function Qualifiers.getLowercaseDictionary()
	Qualifiers.update()
	return lowerCaseDictionary
end

function Qualifiers.get(qualifierKey: Qualifier): QualifierDetail?
	local qualifierKeyLower = tostring(qualifierKey):lower()
	local ourDictionary = Qualifiers.getLowercaseDictionary()
	local item = ourDictionary[qualifierKeyLower] :: QualifierDetail?
	if not item then
		return nil
	end
	local qualifierKeyCorrected = item.key
	if item.mustCreateAliasOf then
		local toCreateName = item.mustCreateAliasOf
		local qualifierToCreate = Qualifiers.items[toCreateName]
		if not qualifierToCreate then
			error(`Qualifiers: {qualifierKeyCorrected} can not create alias because {toCreateName} is not a valid qualifier`)
		end
		qualifierToCreate = qualifierToCreate :: any
		for fieldKey,fieldValue in qualifierToCreate do
			item = item :: any
			if not item[fieldKey] then
				item[fieldKey] = fieldValue
			end
		end
		item.mustCreateAliasOf = nil :: any
		item.aliasOf = toCreateName
	end
	return item :: QualifierDetail
end

function Qualifiers.getAll()
	-- We call .get to make sure all aliases are registered and set up correctly
	local items = Qualifiers.items :: {[string]: QualifierDetail}
	for qualifierKey, item in items do
		if not item.key then
			item.key = qualifierKey
		end
		Qualifiers.get(qualifierKey :: Qualifier)
	end
	return items
end

function Qualifiers.createAliasOf(qualifierKey: Qualifier, initialTable: any?)
	-- We don't actually create a mirror table here as the data of items will have
	-- not yet gone into memory. Instead, we record the table as an alias, then
	-- set it's data once .get is called or 
	task.defer(function()
		-- This servers as a warning as opposed to an actual error
		if not Qualifiers.items[qualifierKey] then
			error(`Qualifiers: {qualifierKey} is not a valid qualifier`)
		end
	end)
	if typeof(initialTable) ~= "table" then
		initialTable = {}
	end
	initialTable.mustCreateAliasOf = qualifierKey
	return initialTable
end


-- PUBLIC
Qualifiers.items = {
	
	["Default"] = register({
		isHidden = true,
		description	= "Default action, returns players with matching shorthand names.",
		getTargets = function(callerUserId, stringToParse, useDisplayName)
			local ParserUtility = require(script.Parent.ParserUtility)
			local User = require(modules.Objects.User)
			local callerUser = User.getUser(callerUserId)
			local targets = ParserUtility.getPlayersFromString(stringToParse :: string, callerUser)
			return targets
		end,
	}),
	["Me"] = register({
		description = "You!",
		displayOrder = 1,
		getTargets = function(callerUserId: number)
			local targets: {Player} = {}
			local callerPlayer = Players:GetPlayerByUserId(callerUserId)
			if callerPlayer then
				table.insert(targets, callerPlayer)
			end
			return targets
		end,
	}),

	["All"] = register({
		description = "Every player in server",
		displayOrder = 2,
		getTargets = function()
			return Players:GetPlayers()
		end,
	}),

	["Others"] = register({
		description = "Everyone except you",
		displayOrder = 3,
		getTargets = function(callerUserId)
			local targets = {}
			for _, plr in (Players:GetPlayers()) do
				if plr.UserId ~= callerUserId then
					table.insert(targets, plr)
				end
			end
			return targets
		end,
	}),

	["Random"] = register({
		description = "Selects a random player",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 4,
		getTargets = function(callerUserId, ...)
			local subQualifiers = {...}
			if #subQualifiers == 0 then
				table.insert(subQualifiers, "all")
			end
			local pool = {}
			for _, subQualifier in (subQualifiers) do
				local qualifier = Qualifiers.get(subQualifier) or Qualifiers.get("Default")
				local subPool = qualifier and qualifier.getTargets(callerUserId, subQualifier)
				if subPool then
					for _, plr in (subPool) do
						table.insert(pool, plr)
					end
				end
			end
			local totalPool = #pool
			local targets = {}
			if totalPool > 0 then
				targets = {pool[math.random(1, #pool)]}
			end
			return targets
		end,
	}),

	["Role"] = register({
		description = "Players with these roles",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 5,
		configurable = "role1,role2,...",
		getTargets = function(callerUserId, ...)
			local roleNamesToCheck = {...}
			if #roleNamesToCheck == 0 then
				return {}
			end
			local Roles = require(services.Roles)
			local roles = Roles.getRoles()
			local LIMIT_TO_CHECK = 20 -- limits abuse
			local foundRolesDict = {}
			local totalFound = 0
			for index, roleName in roleNamesToCheck do
				local toCheckName = tostring(roleName):lower()
				for _, role in roles do
					local roleNameLower = tostring(role.name):lower()
					if string.sub(roleNameLower, 1, #toCheckName) == toCheckName then
						if not foundRolesDict[roleNameLower] then
							foundRolesDict[roleNameLower] = true
							totalFound += 1
						end
					end
				end
				if index >= LIMIT_TO_CHECK then
					break
				end
			end
			if totalFound <= 0 then
				return {}
			end
			local targets = {}
			local Players = game:GetService("Players")
			local User = require(modules.Objects.User)
			for _, player in Players:GetPlayers() do
				local user = User.getUser(player)
				local ownedRoles = Roles.getOwnedRoles(user)
				for _, roleNameToCheck in ownedRoles do
					local toCheckName = tostring(roleNameToCheck):lower()
					if foundRolesDict[toCheckName] then
						table.insert(targets, player)
						break
					end
				end
			end
			return targets
		end,
	}),

	["Friends"] = register({
		description = "Players friends with you",
		displayOrder = 6,
		getTargets = function(callerUserId)
			local targets = {}
			for _, player in (Players:GetPlayers()) do
				if (player :: any):IsFriendsWith(callerUserId) then
					table.insert(targets, player)
				end
			end
			return targets
		end,
	}),

	["Radius"] = register({
		description = "Players x studs from you",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 7,
		configurable = "number",
		getTargets = function(callerUserId, radiusString)
			local targets = {}
			local radius = tonumber(radiusString) or 10
			local callerPlayer = Players:GetPlayerByUserId(callerUserId)
			local getHeadPos = require(modules.PlayerUtil.getHeadPos)
			if callerPlayer then
				local callerHeadPos = getHeadPos(callerPlayer) or Vector3.new(0, 0, 0)
				for _, plr in (Players:GetPlayers()) do
					if plr:DistanceFromCharacter(callerHeadPos) <= radius then
						table.insert(targets, plr)
					end
				end
			end
			return targets
		end,
	}),

	["Amount"] = register({
		description = "x amount of players in server",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 8,
		configurable = "number",
		getTargets = function(_, amountString)
			local givenAmount = tonumber(amountString) or 5
			local playersInServer = Players:GetPlayers()
			local totalPlayers = #playersInServer
			local numberToAdd = math.min(givenAmount, totalPlayers)
			local targets = {}
			for _ = 1, numberToAdd do
				local randomIndex = math.random(1, #playersInServer)
				local selectedPlayer = playersInServer[randomIndex]
				table.insert(targets, selectedPlayer)
				table.remove(playersInServer, randomIndex)
			end
			return targets
		end,
	}),

	["Percent"] = register({
		description = "x% of players in server",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 9,
		configurable = "number",
		getTargets = function(_, percentString)
			local givenPercent = tonumber(percentString) or 50
			local percent = math.clamp(givenPercent, 0, 100) / 100
			local playersInServer = Players:GetPlayers()
			local totalPlayers = #playersInServer
			local round = require(modules.MathUtil.round)
			local numberToAdd = round(totalPlayers * percent)
			local targets = {}
			for _ = 1, numberToAdd do
				local randomIndex = math.random(1, #playersInServer)
				local selectedPlayer = playersInServer[randomIndex]
				table.insert(targets, selectedPlayer)
				table.remove(playersInServer, randomIndex)
			end
			return targets
		end,
	}),

	["Team"] = register({
		description = "Players in these teams",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 10,
		configurable = "team1,team2,...",
		getTargets = function(_, ...)
			local targets = {}
			local teamNames = {...}
			local selectedTeams = {}
			local validTeams = false
			if #teamNames == 0 then
				return {}
			end
			for _, team in (Teams:GetChildren()) do
				team = team :: Team
				local teamName = string.lower(team.Name)
				for _, selectedTeamName in (teamNames) do
					local selectedLower = string.lower(tostring(selectedTeamName))
					if string.sub(teamName, 1, #selectedLower) == selectedLower then
						selectedTeams[tostring(team.TeamColor)] = true
						validTeams = true
					end
				end
			end
			if not validTeams then
				return {}
			end
			for _, plr in (Players:GetPlayers()) do
				if selectedTeams[tostring(plr.TeamColor)] then
					table.insert(targets, plr)
				end
			end
			return targets
		end,
	}),

	["Group"] = register({
		description	= "Players in these groups",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 11,
		configurable = "groupId1,groupId2,...",
		getTargets = function(_, ...)
			local targets = {}
			local groupIds = {}
			for _, groupId in ({...}) do
				groupId = tonumber(groupId)
				if groupId then
					table.insert(groupIds, groupId)
				end
			end
			for _, plr in (Players:GetPlayers()) do
				for _, groupId in (groupIds) do
					if (plr :: any):IsInGroup(groupId) then
						table.insert(targets, plr)
						break
					end
				end
			end
			return targets
		end,
	}),

	["Premium"] = register({
		description = "Players with Roblox Premium",
		displayOrder = 12,
		getTargets = function(_)
			local targets = {}
			for _, player in (Players:GetPlayers()) do
				if player.MembershipType == Enum.MembershipType.Premium then
					table.insert(targets, player)
				end
			end
			return targets
		end,
	}),
	
}


-- TYPES
export type Qualifier = keyof<typeof(Qualifiers.items)>
export type QualifierDetail = {
	description: string?,
	getTargets: any, --(callerUserId: number?, stringToParse: string?, useDisplayName: boolean?) -> {Player},
	aliases: {[Qualifier]: boolean}?,
	isHidden: boolean?, -- hides it from the Commands Preview menu
	isCustomizable: boolean?, -- supports custom args (sub-qualifiers)
	mustCreateAliasOf: any?,
	requiresCapsule: boolean?,
	aliasOf: any?,
	key: any?,
}


return Qualifiers