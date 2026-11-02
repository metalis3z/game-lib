-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")

function UpdateUI(p1, p2, p3, p4, p5) --[[ UpdateUI | Line: 3 | Upvalues: Assets (copy) ]]
	p1.title.Text = p3

	if typeof(p5) == "Color3" then
		p1.title.TextColor3 = p5
	end

	if p4 == "Mythical" or p4 == "Exclusive" then
		p1.title.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		Assets.UI.Rarity:FindFirstChild(p4):Clone().Parent = p1.title
	end

	p1.title.RichText = if string.find(p3, "<.->") == nil then false else true
end

return UpdateUI