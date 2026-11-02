--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------

--------|    Variables    |--------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


_L.Network.Fired("Gamepass Bought"):Connect(function(gamepassId)
	_L.Audio.Play(5205173410, script, 1, 1)
	_L.Message.New("✅ Purchase successful! Thank you so much! 😁")
end)


_L.Network.Fired("Product Bought"):Connect(function(productId)
	_L.Audio.Play(5205173410, script, 1, 1)
	_L.Message.New("✅ Purchase successful! Thank you so much! 😁")
end)


_L.Network.Fired("Product Failed"):Connect(function(productId)
	_L.Message.New("⚠️ Purchase failed! Any lost Robux will be refunded automatically through Roblox. Let us know if this continue to happen! We apologize for any inconvenience. 🙁")
end)