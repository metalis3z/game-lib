wait()
local player=game.Players.LocalPlayer
local character=player.Character
local humanoid=character.Humanoid

local tool=script.Parent
local handle=tool.Handle

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
		
		wait(1)
		script.Parent.Name = script.Parent.ToolName.Value.."[On]"
		event:InvokeServer("protect",{character,hum,protection})
		

	elseif ready == true then
		ready = false
		specialanim2:Play()
		wait(.3)
		script.Parent.Name = script.Parent.ToolName.Value
		event:InvokeServer("unprotect",{character,hum,protection})	
	

	end
end)