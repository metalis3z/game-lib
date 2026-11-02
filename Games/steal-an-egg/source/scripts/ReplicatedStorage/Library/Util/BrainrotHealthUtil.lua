-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local t = {}

for k, v in pairs(Directory) do
	local BaseHealth = v.BaseHealth

	if typeof(BaseHealth) ~= "number" then
		BaseHealth = 100
	end

	local BaseModelScale = v.BaseModelScale

	if typeof(BaseModelScale) ~= "number" or BaseModelScale <= 0 then
		BaseModelScale = 1
	end

	local v2 = math.max(1, (math.floor(BaseHealth * 0.5 + 0.5)))
	local t2 = {}

	t2.Base = math.max(1, (math.floor(BaseHealth + 0.5)))
	t2.BaseScale = BaseModelScale
	t2.Min = v2
	t[k] = t2
end

return {
	GetDirectory = function() --[[ GetDirectory | Line: 42 | Upvalues: t (copy) ]]
		return t
	end,
	Get = function(p1) --[[ Get | Line: 46 | Upvalues: t (copy) ]]
		return t[p1]
	end,
	ComputeMaxHealth = function(p1, p2) --[[ ComputeMaxHealth | Line: 50 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		if v1 then
			return math.max(1, v1.Base)
		end

		return math.max(10, (math.floor(math.max(if typeof(p2) == "number" and p2 then p2 else 1, 0.1) * 100)))
	end
}