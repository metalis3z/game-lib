-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Rarity = game:GetService("ReplicatedStorage"):WaitForChild("Assets").UI.Rarity

return function(p1, p2, p3, p4) --[[ Line: 4 | Upvalues: Rarity (copy) ]]
	p1.title.Text = p3

	if p4 ~= "Exclusive" then
		return
	end

	p1.title.TextColor3 = Color3.new(255/255, 255/255, 255/255)

	local v1 = Rarity:FindFirstChild(p4)

	if not v1 then
		return
	end

	v1:Clone().Parent = p1.title
end