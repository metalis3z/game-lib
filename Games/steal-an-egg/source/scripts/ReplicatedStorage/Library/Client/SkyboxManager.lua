-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = require(game:GetService("ReplicatedStorage").Library.Modules.WeightedTable).new()

function t.AddSkybox(p1, p2) --[[ AddSkybox | Line: 4 | Upvalues: v1 (copy) ]]
	v1:Add(p1, p2 or 0)
end
function t.UpdateSkybox(p1, p2) --[[ UpdateSkybox | Line: 8 | Upvalues: v1 (copy) ]]
	v1:SetWeight(p1, p2)
end

local v2 = nil

local function checkSkyboxes() --[[ checkSkyboxes | Line: 14 | Upvalues: v1 (copy), v2 (ref) ]]
	local v12, _ = v1:GetHighestObject()

	if v2 then
		v2.Parent = script
	end

	v2 = v12
	v12.Parent = game:GetService("Lighting")
end

t.AddSkybox(game:GetService("Lighting").Cartoon, 1)
v1.OnUpdate:Connect(checkSkyboxes)

local v3, _ = v1:GetHighestObject()

if not v2 then
	v2 = v3
	v3.Parent = game:GetService("Lighting")

	return t
end

v2.Parent = script
v2 = v3
v2.Parent = game:GetService("Lighting")

return t