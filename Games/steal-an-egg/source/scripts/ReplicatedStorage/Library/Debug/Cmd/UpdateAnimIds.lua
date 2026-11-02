-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = game:GetService("Selection"):Get()
local Anim = workspace.NewBrainrot.Anim

for i, v in ipairs(v1) do
	local v2 = string.split(v.Name, " : ")
	local v3 = v2[1]
	local v4 = v2[2]

	for i2, v5 in ipairs(Anim:GetDescendants()) do
		if v5:IsA("Animation") and v5.AnimationId:match(v3) then
			v5.AnimationId = "rbxassetid://" .. v4
			warn("done")
		end
	end
end