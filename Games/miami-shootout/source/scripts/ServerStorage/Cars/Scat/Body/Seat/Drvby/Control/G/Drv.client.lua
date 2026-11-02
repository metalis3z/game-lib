


local mouse=game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("src")
src=script.Parent.src.Value
local hum = game.Players.LocalPlayer.Character.Humanoid

local ani = hum:LoadAnimation(script.Animation)


local keyd = false


local db = false


local Info = TweenInfo.new(
    .3, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.Out, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local TweenService = game:GetService("TweenService")
local CurrentCamera = workspace.CurrentCamera



local CameraOffset = {CameraOffset = Vector3.new(-2,2,0)}
local CameraOffset2 = {CameraOffset = Vector3.new(0,0,0)}


local Tween3 = TweenService:Create(hum,Info,CameraOffset)
local Tween4 = TweenService:Create(hum,Info,CameraOffset2)

local uis = game:GetService("UserInputService")



mouse.KeyDown:connect(function(key)
	if key=="x" and keyd == false and not uis:GetFocusedTextBox() then
		keyd = true
		
		if db == true or not src.Parent:FindFirstChild("SeatWeld") then return end
		
		db = true
		
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		
		ani:Play()
		Tween3:Play()
		
		
		ani.KeyframeReached:connect(function(keyframe)
			
			if keyframe == "ended" then
				
				if keyd == true then
					
					game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
					game.ReplicatedStorage.cartings:FireServer("LEAN OUT")
					
				end
				
			end
			
		end)
		
		
		db = false
	end
end)

mouse.KeyUp:connect(function(key)
	if key=="x" and keyd == true then
		
		keyd = false
		Tween4:Play()
		game.ReplicatedStorage.cartings:FireServer("LEAN STOP")
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		ani:Stop()
	end
end)







src.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		
		
		ani:Stop()
		game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		keyd = false

		Tween4:Play()		
		
		
		
		script.Parent:Destroy()
	end
end)