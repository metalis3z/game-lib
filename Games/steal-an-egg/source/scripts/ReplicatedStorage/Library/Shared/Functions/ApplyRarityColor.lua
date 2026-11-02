-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")

return function(p1, p2) --[[ Line: 4 | Upvalues: Assets (copy) ]]
	Assets:WaitForChild("UI"):WaitForChild("Rarity"):WaitForChild(p2):WaitForChild("Gradient"):Clone().Parent = p1
end