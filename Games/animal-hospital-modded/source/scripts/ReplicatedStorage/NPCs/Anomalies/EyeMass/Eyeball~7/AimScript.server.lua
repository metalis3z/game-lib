function findTorso(p1) --[[ findTorso | Line: 1 ]]
	local Character = game.Players.LocalPlayer.Character

	return if Character then Character:FindFirstChild("Head") else Character
end

while true do
	local v1

	repeat
		wait()
		v1 = findTorso(script.Parent.Position)
	until v1 ~= nil

	script.Parent.CFrame = CFrame.new(script.Parent.Position, v1.Position)
end