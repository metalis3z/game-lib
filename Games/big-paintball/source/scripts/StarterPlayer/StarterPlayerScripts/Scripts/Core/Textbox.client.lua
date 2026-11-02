--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Check when player is typing in chat or typing in general (this was originally setting _L.Typing instead of _L.Variables.Typing for 2 years LMFAO oops)


_L.Services.UserInputService.TextBoxFocused:Connect(function(textBox)
	_L.Variables.Typing = true
	if textBox:IsDescendantOf(_L.Player.Chat) then
		_L.Variables.Chatting = true
	end
end)


_L.Services.UserInputService.TextBoxFocusReleased:Connect(function(textBox)
	_L.Variables.Typing = false
	if textBox:IsDescendantOf(_L.Player.Chat) then
		_L.Variables.Chatting = false
	end
end)
