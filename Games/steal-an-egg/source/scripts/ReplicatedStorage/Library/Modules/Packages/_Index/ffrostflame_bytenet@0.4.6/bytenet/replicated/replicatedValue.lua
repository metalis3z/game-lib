-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local v1 = if game:GetService("RunService"):IsServer() then "server" else "client"
local t = {}
local t2 = {
	__index = t
}

function t.write(p1, p2) --[[ write | Line: 16 | Upvalues: v1 (copy), HttpService (copy) ]]
	assert(if v1 == "server" then true else false, "cannot write to replicatdvalue on client")
	p1._luauData = p2
	p1._value.Value = HttpService:JSONEncode(p2)
end
function t.read(p1) --[[ read | Line: 25 ]]
	return p1._luauData
end

return function(p1) --[[ Line: 29 | Upvalues: t2 (copy), v1 (copy), HttpService (copy) ]]
	local v2 = setmetatable({}, t2)

	v2._luauData = {}
	v2._value = p1

	if v1 == "client" then
		v2._luauData = table.freeze(HttpService:JSONDecode(p1.Value))
		p1.Changed:Connect(function(p1) --[[ Line: 40 | Upvalues: v2 (copy), HttpService (ref) ]]
			if p1 then
				v2._luauData = table.freeze(HttpService:JSONDecode(p1))
			end
		end)
	end

	return v2
end