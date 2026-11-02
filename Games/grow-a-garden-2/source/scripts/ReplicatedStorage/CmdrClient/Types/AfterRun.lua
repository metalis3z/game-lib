--credit to prince games studio
local v1 = if game:GetService("RunService"):IsServer() then require(game:GetService("ServerScriptService").UserGenerated.Analytics) else nil

local function truncate(p1) --[[ truncate | Line: 13 ]]
	if type(p1) ~= "string" then
		return nil
	end

	if #p1 <= 500 then
		return p1
	end

	return string.sub(p1, 1, 500)
end

return function(p1) --[[ Line: 26 | Upvalues: v1 (copy) ]]
	p1:RegisterHook("AfterRun", function(p1) --[[ Line: 27 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		local Executor = p1.Executor

		if typeof(Executor) ~= "Instance" or not Executor:IsA("Player") then
			return
		end

		if pcall(function() --[[ Line: 37 | Upvalues: v1 (ref), Executor (copy), p1 (copy) ]]
			local t = {
				Command = p1.Name,
				Alias = p1.Alias
			}
			local RawText = p1.RawText

			t.RawText = if type(RawText) == "string" then if #RawText <= 500 then RawText else string.sub(RawText, 1, 500) else nil
			t.Group = p1.Group

			local Response = p1.Response

			t.Response = if type(Response) == "string" then if #Response <= 500 then Response else string.sub(Response, 1, 500) else nil
			v1:LogPlayerEvent(Executor, "PlayerAdminCommand", t)
		end) then
			return
		end

		warn((("[CmdrService] AfterRun analytics log failed for %*"):format(p1.Name)))
	end)
end