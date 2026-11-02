wait()
local player=game.Players.LocalPlayer
local character=player.Character
local humanoid=character.Humanoid

local tool=script.Parent
local handle=tool.Handle

local event=tool:WaitForChild("RemoteFunction")
local protection=50

local ready=true

local debris=game:GetService("Debris")
local specialanim=humanoid:LoadAnimation(tool.special)

tool.Activated:connect(function()
	local hum=character:FindFirstChild("Humanoid")
	if hum and ready then
		ready=false
		specialanim:Play()
		wait(.3)
		event:InvokeServer("protect",{character,hum,protection})
		ready=true
		
	end
end)