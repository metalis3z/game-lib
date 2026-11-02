local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

function Weld(x,y)
	local W = Instance.new("Weld")
	W.Name = "PizzaWeld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end


local events = {}
for _,obj in ipairs(script.Parent:GetChildren()) do
	if obj.Name == "Pumpkin" then
		obj.Glow.Locked = true
		
		local detector = Instance.new("ClickDetector")
		detector.Parent = obj
		
		local d = Instance.new("BindableEvent")
		d.Name = "Detector"
		d.Parent = detector
		
		local clicked = d.Event:connect(function(player)
			if not player:FindFirstChild("Pumpkins") then
				local pumpCount = Instance.new("IntValue")
				pumpCount.Name = "Pumpkins"
				pumpCount.Parent = player
			end
			if player.Pumpkins.Value < 10 then
				player.Pumpkins.Value = player.Pumpkins.Value + 1
				
				local pump = Instance.new("Tool")
				pump.Name = "Pumpkin"
				pump.GripPos = Vector3.new(0,0,obj.Size.Z/2+.2)
				
				local handle = obj:clone()
				handle.Name = "Handle"
				handle.Anchored = false
				handle.Glow.Anchored = false
				handle.Glow.Locked = true
				handle.Locked = true
				handle.CanCollide = false
				handle.Parent = pump
				Weld(handle,handle.Glow)
				
				
				
				local toolScript = script.ToolScript:clone()
				toolScript.Disabled = false
				toolScript.Parent = pump
				toolScript.Player.Value = player
				
				pump.Parent = player.Backpack
				delay(.05,function() pump.Parent = player.Character end)

			else
				Dialog:ShowMessage(player,"Limit","You've reached the maximum of 10 pumpkins")
			end
			
		end)
	end
end