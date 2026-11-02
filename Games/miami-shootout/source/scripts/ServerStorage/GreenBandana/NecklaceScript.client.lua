wait()
local player=game.Players.LocalPlayer
local character=player.Character
local humanoid=character.Humanoid

local tool=script.Parent
local handle=tool.Handle

local owner

local event=tool:WaitForChild("function")
local protection=50

local ready=false

local debris=game:GetService("Debris")
local specialanim=humanoid:LoadAnimation(tool.wear)
local specialanim2=humanoid:LoadAnimation(tool.takeoff)


tool.Activated:connect(function()
	local hum=character:FindFirstChild("Humanoid")
	if hum and ready == false then
		ready = true
		specialanim:Play()
		wait(.3)
		event:InvokeServer("protect",{character,hum,protection})
	elseif ready == true then
		ready = false
		specialanim2:Play()
		wait(.3)
		event:InvokeServer("unprotect",{character,hum,protection})		
	end
end)

script.Parent.AncestryChanged:Connect(function()
	if script.Parent.Parent == game.Workspace then
		event:InvokeServer("drop",{character,humanoid,protection})		
	end
end)