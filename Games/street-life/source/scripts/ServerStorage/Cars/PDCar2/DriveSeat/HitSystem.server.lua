local dbon = {"test"}

local crashdb = false
local Hit = script.Parent.Parent.Body:WaitForChild('FRONT')
Hit.Touched:Connect(function(h)
	local hum
	local value = (script.Parent.Velocity.magnitude) / 1
	if value >= 50 then
		if h.Parent:FindFirstChild("Humanoid") or h.Parent.Parent:FindFirstChild("Humanoid") then
			if h.Parent:FindFirstChild("Humanoid") then
				hum = h.Parent
			else
				hum = h.Parent.Parent
			end
		else
			if crashdb == false then
				if h.Parent then
					if h.Parent:FindFirstChild("FL") then return end
				end
				if h.Parent and h.Parent:FindFirstChild("Humanoid") then return end
				if h.Parent and h.Parent.Parent and h.Parent.Parent:FindFirstChild("Humanoid") then return end
				if h:IsA("Seat") then
					return
				end
				if h.Parent and h.Parent.Parent then
					if h.Parent.Parent:FindFirstChild("DriveSeat") then
						if h.Parent.Parent:FindFirstChild("DriveSeat").HitSystem == script then
							return
						end
					end
				end
				if h.Parent and h.Parent.Parent and h.Parent.Parent.Parent then
					if h.Parent.Parent.Parent:FindFirstChild("FL") then
						return
					end

				end
				if h.Parent and h.Parent.Parent then
					if h.Parent.Parent.Parent then
						if h.Parent.Parent.Parent:FindFirstChild("DriveSeat") then
							if h.Parent.Parent.Parent:FindFirstChild("DriveSeat"):FindFirstChild("HitSystem") == script then
								return
							end
						end
					end
				end
				if h.Transparency <= .9 then
					if script.Parent.Occupant and script.Parent.Occupant:IsA('Humanoid') then	
						local Humanoid = script.Parent.Occupant
						Humanoid.Health -= math.random(15, 20)
					else 
						pcall(function() hum.Health -= math.random(15, 20) end)
					end 
					crashdb = true
					local cp = game.ReplicatedStorage.Crash:Clone()
					cp.Parent = workspace.Map
					cp.Position = Hit.Position

					local Loop = true
					task.delay(1.75, function() Loop = false end)
					task.spawn(function()
						while (Loop) do task.wait()
							cp.Position = Hit.Position
						end
					end)

					for _,v in ipairs(cp:GetDescendants()) do
						if v:IsA('ParticleEmitter') then
							v.Enabled = true
							v:Emit(15)
							task.spawn(function()
								task.wait(1.75)
								v.Enabled = false
							end)
						end
					end

					local sound = math.random(1,2)
					if sound == 1 then
						script.Sound:Clone().Parent = cp
						cp.Sound:Play()
					else
						script.Sound2:Clone().Parent = cp
						cp.Sound2:Play()
					end
					game.Debris:AddItem(cp, 3)
					wait(.4)
					crashdb = false
				end
			end
		end
	end
end)