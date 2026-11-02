local GUI = script.Welcome


---------------------
--General Functions--
---------------------

Join = (function (Plyr)
	local GuiClone = GUI:Clone()
	if not Plyr.Character then 
		Plyr.CharacterAdded:wait()
	end
	GuiClone.Warning.Visible = false --Set visible to false to be handled by local script
	GuiClone.Parent = Plyr:findFirstChild"PlayerGui"
end)


--------
--Main--
--------
wait(1)

game.Players.PlayerAdded:connect(Join)
for _,v in next, game.Players:GetPlayers() do
	Join(v)
end

-- reaperz928 --