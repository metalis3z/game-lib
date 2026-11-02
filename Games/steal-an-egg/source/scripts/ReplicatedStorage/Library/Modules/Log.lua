-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = { "fatal", "error", "warn", "info", "debug", "trace" }
local t2 = {}

local function fallbackSentinel() --[[ fallbackSentinel | Line: 64 ]] end

function t2.createDefaultCallback(p1) --[[ createDefaultCallback | Line: 66 | Upvalues: RunService (copy) ]]
	local v1, v2, v3

	if typeof(p1) == "string" then
		v1 = p1

		if not v1 and typeof(p1) == "Instance" then
			v2 = "%*/%*"
			v3 = p1.Parent and p1.Parent.Name or "?"
			v1 = v2:format(v3, p1.Name) or "UNKNOWN"
		elseif not v1 then
			v1 = "UNKNOWN"
		end
	elseif typeof(p1) == "Instance" then
		v2 = "%*/%*"
		v3 = p1.Parent and p1.Parent.Name or "?"
		v1 = v2:format(v3, p1.Name) or "UNKNOWN"
	else
		v1 = "UNKNOWN"
	end

	local v4 = v1

	local function setTraceBackIfNeeded(p1, p2) --[[ setTraceBackIfNeeded | Line: 71 ]]
		if p1.level == "error" or p1.level == "fatal" then
			warn(debug.traceback(p2 or "Log faced fatal or error case!"))

			return true
		end
	end

	if RunService:IsStudio() then
		return function(p1) --[[ Line: 81 | Upvalues: v4 (ref) ]]
			local v1 = p1.level == "warn" and warn or print
			local v2 = ("[%*][%*] %*"):format(v4, p1.level, p1.message)

			if p1.context then
				print("[Log_Pre_State]:(Context):", p1.context)
			end

			local v3

			if p1.level == "error" or p1.level == "fatal" then
				warn(debug.traceback(v2 or "Log faced fatal or error case!"))
				v3 = true
			else
				v3 = nil
			end

			if not v3 then
				v1(v2)
			end
		end
	end

	return function(p1) --[[ Line: 96 | Upvalues: v4 (ref) ]]
		local v1 = ("[%*] %*"):format(v4, p1.message)

		if p1.level == "error" or p1.level == "fatal" then
			warn(debug.traceback(v1 or "Log faced fatal or error case!"))
		end
	end
end

local t3 = {}

t3.__index = t3
function t3.log(p1, p2, p3, p4) --[[ log | Line: 105 | Upvalues: t (copy) ]]
	if table.find(t, p2) > table.find(t, p1._level) then
		return
	end

	local v1 = table.clone(p1._context)

	if p4 then
		for v2, v3 in p4 do
			v1[v2] = v3
		end
	end

	local ok, result = pcall(function() --[[ Line: 117 | Upvalues: p1 (copy), p2 (copy), p3 (copy), v1 (copy) ]]
		p1._logCallback({
			level = p2,
			message = p3,
			context = v1
		})
	end)

	if ok then
		return
	end

	warn((("Error logging message: %*"):format(result)))
end
function t3.extend(p1, p2) --[[ extend | Line: 130 | Upvalues: t3 (copy) ]]
	local v1 = table.clone(p1._context)

	for v2, v3 in p2 do
		v1[v2] = v3
	end

	return setmetatable({
		_logCallback = p1._logCallback,
		_context = v1,
		_level = p1._level
	}, t3)
end
function t3.setLevel(p1, p2) --[[ setLevel | Line: 143 | Upvalues: t (copy) ]]
	if table.find(t, p2) ~= nil then
		p1._level = p2

		return p1
	end

	error("Invalid log level")
end
function t2.createLogger(p1, p2) --[[ createLogger | Line: 151 | Upvalues: fallbackSentinel (copy), t3 (copy) ]]
	local t = {
		_level = "info"
	}

	t._logCallback = if typeof(p1) == "function" and p1 then p1 else fallbackSentinel
	t._context = if p2 then p2 else {}

	return setmetatable(t, t3)
end

return t2