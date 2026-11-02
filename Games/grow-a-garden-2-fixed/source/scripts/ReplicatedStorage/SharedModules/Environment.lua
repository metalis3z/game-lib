--credit to leon games studio
local t = {
	Dev = 9638499374,
	Live = 10200395747
}
local t2 = {
	Dev = {
		Primary = 132935919810877,
		NewUser = 99129412870047,
		FirstSession = 115012049182484
	},
	Live = {
		Primary = 97598239454123,
		NewUser = 133438856880402,
		FirstSession = 77085202503540
	}
}
local RunService = game:GetService("RunService")

local function ResolveEnv() --[[ ResolveEnv | Line: 68 | Upvalues: t (copy), RunService (copy) ]]
	for v1, v2 in t do
		if v2 == game.GameId then
			return v1
		end
	end

	if RunService:IsStudio() then
		return "Dev"
	end

	warn((("[Environment] unknown gameId %*; defaulting to Live"):format(game.GameId)))

	return "Live"
end

local function ResolvePlaceType(p1) --[[ ResolvePlaceType | Line: 85 | Upvalues: t2 (copy), RunService (copy) ]]
	for v1, v2 in t2[p1] do
		if v2 == game.PlaceId then
			return v1
		end
	end

	if RunService:IsStudio() then
		return "Primary"
	end

	warn((("[Environment] unknown placeId %*; treating as Primary"):format(game.PlaceId)))

	return "Primary"
end

local v1 = ResolveEnv()
local v2 = ResolvePlaceType(v1)

local function ResolveServerType() --[[ ResolveServerType | Line: 102 ]]
	if game.PrivateServerId == "" then
		return "Standard"
	end

	if game.PrivateServerOwnerId == 0 then
		return "Reserved"
	end

	return "Private"
end

local v3

if RunService:IsServer() then
	v3 = if game.PrivateServerId == "" then "Standard" elseif game.PrivateServerOwnerId == 0 then "Reserved" else "Private"
	script:SetAttribute("serverType", v3)
else
	local v4 = script:GetAttribute("serverType")

	if v4 == nil then
		script:GetAttributeChangedSignal("serverType"):Wait()
		v4 = script:GetAttribute("serverType")
	end

	local v6 = if typeof(v4) == "string" then true else false

	assert(v6, (("serverType attribute missing or invalid: %*"):format((tostring(v4)))))
	v3 = v4
end

return table.freeze({
	env = v1,
	gameId = t[v1],
	placeType = v2,
	placeId = game.PlaceId,
	places = table.freeze(t2[v1]),
	serverType = v3,
	config = table.freeze(({
		Dev = {
			InstantPurchases = true
		},
		Live = {
			InstantPurchases = false
		}
	})[v1]),
	dataStoreVersion = ({
		Dev = 4
	})[v1]
})