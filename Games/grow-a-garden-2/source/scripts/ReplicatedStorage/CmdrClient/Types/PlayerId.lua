--credit to prince games studio
local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local t = {}

local function getUserId(p1) --[[ getUserId | Line: 5 | Upvalues: t (copy), Players (copy) ]]
	if t[p1] then
		return t[p1]
	end

	if Players:FindFirstChild(p1) then
		t[p1] = Players[p1].UserId

		return Players[p1].UserId
	end

	local ok, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)

	if ok then
		t[p1] = result

		return result
	end

	return nil
end

local t2 = {
	DisplayName = "Full Player Name",
	Prefixes = "# integer",
	Transform = function(p1) --[[ Transform | Line: 27 | Upvalues: Util (copy), Players (copy) ]]
		return p1, Util.MakeFuzzyFinder(Players:GetPlayers())(p1)
	end,
	ValidateOnce = function(p1) --[[ ValidateOnce | Line: 33 | Upvalues: t (copy), Players (copy) ]]
		local v1

		if t[p1] then
			v1 = t[p1]
		elseif Players:FindFirstChild(p1) then
			t[p1] = Players[p1].UserId
			v1 = Players[p1].UserId
		else
			local ok, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)

			if ok then
				t[p1] = result
				v1 = result
			else
				v1 = nil
			end
		end

		return v1 ~= nil, "No player with that name could be found."
	end,
	Autocomplete = function(p1, p2) --[[ Autocomplete | Line: 37 | Upvalues: Util (copy) ]]
		return Util.GetNames(p2)
	end,
	Parse = function(p1) --[[ Parse | Line: 41 | Upvalues: t (copy), Players (copy) ]]
		if t[p1] then
			return t[p1]
		end

		if Players:FindFirstChild(p1) then
			t[p1] = Players[p1].UserId

			return Players[p1].UserId
		end

		local ok, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)

		if ok then
			t[p1] = result

			return result
		end

		return nil
	end,
	Default = function(p1) --[[ Default | Line: 45 ]]
		return p1.Name
	end,
	ArgumentOperatorAliases = {
		me = ".",
		all = "*",
		others = "**",
		random = "?"
	}
}

return function(p1) --[[ Line: 57 | Upvalues: t2 (copy), Util (copy) ]]
	p1:RegisterType("playerId", t2)
	p1:RegisterType("playerIds", Util.MakeListableType(t2, {
		Prefixes = "# integers"
	}))
end