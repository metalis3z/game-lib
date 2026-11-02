-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = game:GetService("RunService"):IsServer()
local t = {}

function t.parent(p1) --[[ parent | Line: 108 | Upvalues: t (copy) ]]
	return function(p12) --[[ Line: 109 | Upvalues: t (ref), p1 (copy) ]]
		return t.func(p12, p1)
	end, function(p12) --[[ Line: 111 | Upvalues: t (ref), p1 (copy) ]]
		return t.event(p12, p1)
	end
end
function t.func(p1, p2) --[[ func | Line: 122 | Upvalues: v1 (copy) ]]
	if v1 then
		local v12 = Instance.new("RemoteFunction")

		v12.Name = p1
		v12.Parent = if p2 then p2 else script

		return v12
	end

	local v4 = (if p2 then p2 else script):WaitForChild(p1)

	assert(v4:IsA("RemoteFunction"), "expected remote function")

	return v4
end
function t.event(p1, p2) --[[ event | Line: 141 | Upvalues: v1 (copy) ]]
	if v1 then
		local v12 = Instance.new("RemoteEvent")

		v12.Name = p1
		v12.Parent = if p2 then p2 else script

		return v12
	end

	local v4 = (if p2 then p2 else script):WaitForChild(p1)

	assert(v4:IsA("RemoteEvent"), "expected remote event")

	return v4
end
table.freeze(t)

return t