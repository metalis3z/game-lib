-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Instances = {}
}

t.__index = t
function t.new() --[[ new | Line: 6 | Upvalues: t (copy) ]]
	local v1 = Instance.new("BindableEvent")

	v1.Parent = script

	local t2 = {
		OnUpdate = v1.Event,
		Event = v1
	}

	setmetatable(t2, t)

	return t2
end
function t.Add(p1, p2, p3) --[[ Add | Line: 17 ]]
	local v1 = game:GetService("HttpService"):GenerateGUID()

	p1.Instances[p2] = p3 or 1

	return v1
end
function t.SetWeight(p1, p2, p3) --[[ SetWeight | Line: 23 ]]
	if p1.Instances[p2] then
		p1.Instances[p2] = p3
	end

	p1.Event:Fire()
end
function t.GetHighestObject(p1) --[[ GetHighestObject | Line: 30 ]]
	local v1 = nil
	local v2 = nil

	for k, v in pairs(p1.Instances) do
		if v1 == nil or v1 <= v then
			v1 = v
			v2 = k
		end
	end

	return v2, v1
end

return t