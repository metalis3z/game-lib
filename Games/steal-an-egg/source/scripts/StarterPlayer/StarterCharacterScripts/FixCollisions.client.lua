-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = { "UpperTorso", "LowerTorso" }

local function processDescendant(p1) --[[ processDescendant | Line: 10 | Upvalues: t (copy) ]]
	if not (p1:IsA("BasePart") and table.find(t, p1.Name)) then
		return
	end

	p1.CanCollide = false
end

local function disableCollisions(p1) --[[ disableCollisions | Line: 16 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and table.find(t, v.Name) then
			v.CanCollide = false
		end
	end
end

while task.wait(0.4) do
	for i, v in ipairs(script.Parent:GetDescendants()) do
		if v:IsA("BasePart") and table.find(t, v.Name) then
			v.CanCollide = false
		end
	end
end