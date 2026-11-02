-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ ProcessDeal | Line: 1 ]]
	if p3 == 0 then
		p1.title.Text = "Bad Deal"
		p1.title.TextColor3 = Color3.fromRGB(254, 79, 82)

		return
	end

	if p3 == 1 then
		p1.title.Text = "Good Deal"
		p1.title.TextColor3 = Color3.fromRGB(129, 253, 255)

		return
	end

	if p3 == 2 then
		p1.title.Text = "Great Deal!"
		p1.title.TextColor3 = Color3.fromRGB(113, 255, 62)
	end
end