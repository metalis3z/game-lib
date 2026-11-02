wait()
local player=game.Players.LocalPlayer
local character=player.Character
local humanoid=character.Humanoid

local tool=script.Parent
local handle=tool.Handle

local event=tool:WaitForChild("function")
local protection=50

local ready=false
local Hi = false
local debris=game:GetService("Debris")
local specialanim=humanoid:LoadAnimation(tool.wear)
local specialanim2=humanoid:LoadAnimation(tool.takeoff)
local animation = Instance.new("Animation")
animation.Name = "Idle"
animation.Parent = script.Parent

animation.AnimationId = "http://www.roblox.com/asset/?id=" .. "5140170197" -- Animation id here.

local animtrack = humanoid:LoadAnimation(animation)
script.Parent.Equipped:connect(function()
	if Hi == false then
		animtrack:Play()
	end
	
end)


script.Parent.Unequipped:connect(function() -- When player unequipped the tool.
	animtrack:Stop()
end)

tool.Activated:connect(function()
	local hum=character:FindFirstChild("Humanoid")
	if hum and ready == false then
		ready = true
		Hi = true
		animtrack:Stop()
		specialanim:Play()
		
		wait(.3)
		script.Parent.Name = script.Parent.ToolName.Value.."[On]"
		event:InvokeServer("protect",{character,hum,protection})
	elseif ready == true then
		ready = false
		Hi = false
		specialanim2:Play()
		wait(.2)
		script.Parent.Name = script.Parent.ToolName.Value
		event:InvokeServer("unprotect",{character,hum,protection})	
		wait(1.5)
		
	animtrack:Play()	
	end
end)