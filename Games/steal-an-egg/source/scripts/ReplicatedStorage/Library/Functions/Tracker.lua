-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

local function onCall(p1, ...) --[[ onCall | Line: 3 ]]
	p1:track(...)
end

function t.new() --[[ new | Line: 7 | Upvalues: t (copy), onCall (copy) ]]
	return setmetatable({
		objects = {}
	}, {
		__index = t,
		__call = onCall
	})
end
function t.track(p1, ...) --[[ track | Line: 15 ]]
	for i, v in ipairs({ ... }) do
		table.insert(p1.objects, v)
	end
end
function t.destroy(p1) --[[ destroy | Line: 21 ]]
	local objects = p1.objects

	p1.objects = {}

	for i, v in ipairs(objects) do
		local ok, result = pcall(function() --[[ Line: 25 | Upvalues: v (copy) ]]
			if typeof(v) == "Instance" then
				if not v:IsA("AnimationTrack") then
					v:Destroy()

					return
				end

				v:Stop()
				v:Destroy()
			else
				if typeof(v) == "RBXScriptConnection" then
					v:Disconnect()

					return
				end

				if type(v) ~= "function" then
					return
				end

				v()
			end
		end)

		if not ok then
			warn(string.format("[Tracker] Destruction failed for type \'%s\': %s", typeof(v), (tostring(result))))
		end
	end

	return true
end

return function() --[[ Line: 44 | Upvalues: t (copy) ]]
	return t.new()
end