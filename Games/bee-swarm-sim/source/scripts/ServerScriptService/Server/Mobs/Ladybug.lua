local Module = {}; do
	
	local function RotationThing()
		local Part = Instance.new("Part", workspace)
		Part.Name = "Rotation"
		Part.Anchored = true
		Part.CanCollide = false
		Part.Transparency = 1
		return Part
	end
	
	function Module:Spawn()
		local MobInfo = require(game.ReplicatedStorage.Modules.Mobs[self.Name])
		local function CreateModel()
			local Model = game.ReplicatedStorage.Assets.Mobs.Ladybug:Clone()
			Model.Parent = workspace
			--for _, child in Model:GetChildren() do
			--	if child:IsA("BasePart") and child.Name ~= "Body" then
			--		local Weld = Instance.new("WeldConstraint", child)
			--		Weld.Part0 = child
			--		Weld.Part1 = Model.Body
			--	end
			--end
			for _, child in Model:GetChildren() do
				if child:IsA("BasePart") then
					child.Anchored = true
				end
			end
			local Att = Instance.new("Attachment", self.Mover)
			--Model.AlignOrientation.Attachment1 = Att
			Model.AlignPosition.Attachment1 = Att
			Model.AlignPosition.MaxVelocity = MobInfo.Speed or 12
			Model:PivotTo(self.Mover.CFrame)
			return Model
		end
		local Model = CreateModel()
		local Task = ""
		local Character: Model = self.Owner.Character
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
		local Offset = nil
		local Connection = nil
		task.defer(function()
			while self.Mover do task.wait()
				Model:PivotTo(Model:GetPivot():Lerp(
					CFrame.lookAt(self.Position, Character:GetPivot().Position),
					0.2
					))
				--Model:GetPivot().Rotation:Lerp(
				--CFrame.lookAt(self.Position, Character:GetPivot().Position),
				--0.2
				--)
				--Model:PivotTo(Model:GetPivot():Lerp(
				--	CFrame.lookAt(self.Position, Character:GetPivot().Position),
				--	0.2
				--	))
				--Rotation.CFrame = CFrame.lookAt(self.Position, Character:GetPivot().Position)
				--self.Mover.CFrame = CFrame.lookAt(self.Position, Character:GetPivot().Position)
				--Model:PivotTo(Model:GetPivot():Lerp(CFrame.new(self.Position), 0.3))
				----Model.Humanoid:MoveTo(self.Position)
				----local Part = Instance.new("Part", workspace)
				----Part.Size = Vector3.one
				----Part.Anchored = true
				----Part.CanCollide = false
				----Part.Transparency = 0.6
				----Part.Color = Color3.fromRGB()
				----Part.Position = self.Position
			end
		end)
		task.spawn(function()
			while self.Mover and self.Mover.Parent do task.wait()
				local Distance = (self.Position - Character:GetPivot().Position).Magnitude
				if Distance <= 17 then
					-- Attacking
					local Started = tick()
					local CanAttack = true
					while true do task.wait(0.1)
						if tick() - Started >= 2.5 then
							break
						end
						if (self.Position - Character:GetPivot().Position).Magnitude >= 17 then
							CanAttack = false
							break
						end
					end
					if CanAttack then
						local Time = 0.15
						local Finished = false
						local StartedPosition = self.Position
						Started = tick()
						self.Mover.Position = Character:GetPivot().Position
						Connection = game["Run Service"].Heartbeat:Connect(function(deltaTime)
							local TargetPosition = self.Mover.Position
							local Elapsed = tick() - Started
							local Alpha = math.min(Elapsed / Time, 1)
							self.Position = StartedPosition:Lerp(TargetPosition, Alpha)
							if Alpha == 1 then
								if Finished then
									Connection:Disconnect()
									Connection = nil
									return
								else
									Finished = true
									self.Mover.Position = StartedPosition
									StartedPosition = self.Position
									Started = tick()
									Humanoid:TakeDamage(3)
									return
								end
							end
						end)
						repeat task.wait()
						until not Connection
					end
				else
					Offset = Vector3.new(math.random(-5, 5), math.random(5, 12), math.random(-5, 5))
					local StartPosition = self.Position
					local TargetPosition = Character:GetPivot().Position + Offset
					Distance = (self.Position - TargetPosition).Magnitude
					local Time = Distance / MobInfo.Speed
					local Started = tick()
					self.Mover.Position = TargetPosition
					-- Idling
					Connection = game["Run Service"].Heartbeat:Connect(function(deltaTime)
						local CurrentDistance = (self.Mover.Position - Character:GetPivot().Position).Magnitude
						if CurrentDistance >= 45 or CurrentDistance <= 10 then
							Connection:Disconnect()
							Connection = nil
							return
						end
						local Elapsed = tick() - Started
						local Alpha = math.min(Elapsed / Time, 1)
						self.Position = StartPosition:Lerp(TargetPosition, Alpha)
						if Alpha == 1 then
							Connection:Disconnect()
							Connection = nil
							return
						end
					end)
					repeat task.wait()
					until not Connection
				end
			end
		end)
	end
end

return Module