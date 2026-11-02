--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local DevAllowedIDs = require(ReplicatedStorage.SharedModules.DevAllowedIDs)
local v1 = if RunService:IsServer() then require(game:GetService("ServerScriptService").UserGenerated.Analytics) else nil
local t = {
	fillgarden = 132935919810877,
	fg = 132935919810877
}

local function truncate(p1) --[[ truncate | Line: 21 ]]
	if type(p1) ~= "string" then
		return nil
	end

	if #p1 <= 500 then
		return p1
	end

	return string.sub(p1, 1, 500)
end

return function(p1) --[[ Line: 31 | Upvalues: t (copy), DevAllowedIDs (copy), v1 (copy) ]]
	p1:RegisterHook("BeforeRun", function(p1) --[[ Line: 32 | Upvalues: t (ref), DevAllowedIDs (ref), v1 (ref) ]]
		local v12 = t[p1.Name]

		if v12 and game.PlaceId == v12 then
			return
		end

		if DevAllowedIDs.IsAllowed(p1.Executor.UserId) or game:GetService("RunService"):IsStudio() then
			return
		end

		local Executor = p1.Executor

		if not v1 or (typeof(Executor) ~= "Instance" or not Executor:IsA("Player")) then
			return "Not allowed"
		end

		pcall(function() --[[ Line: 44 | Upvalues: v1 (ref), Executor (copy), p1 (copy) ]]
			local t = {
				Command = p1.Name
			}
			local RawText = p1.RawText

			t.RawText = if type(RawText) == "string" then if #RawText <= 500 then RawText else string.sub(RawText, 1, 500) else nil
			v1:LogPlayerEvent(Executor, "PlayerAdminCommandDenied", t)
		end)

		return "Not allowed"
	end)
end