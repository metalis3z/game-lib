local tool= script.Parent
local handle= tool:WaitForChild("Handle")
local ha= script.Parent.RedeemScript.h
DB = true
local player = game.Players.LocalPlayer

repeat wait(0.1) until player.Character

local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

local animation = Instance.new("Animation")
animation.Name = "Idle"
animation.Parent = script.Parent

animation.AnimationId = "http://www.roblox.com/asset/?id=6688737480"
local animtrack = humanoid:LoadAnimation(animation)

function onRedeem()
	if DB == true then
		DB = false

		local player = game.Players:FindFirstChild(script.Parent.Parent.Name)
        script.h:InvokeServer(handle)
		game.Players.LocalPlayer.PlayerGui:FindFirstChild("Pocketcash"):Destroy()
		animtrack:Stop()
		animtrack:Remove()
		script.Parent:Destroy()
		
	end
end

script.Parent.Activated:connect(onRedeem)



script.Parent.Equipped:connect(function()
	animtrack:Play()
end)

script.Parent.Unequipped:connect(function()
	animtrack:Stop()
	animtrack:Remove()
end)