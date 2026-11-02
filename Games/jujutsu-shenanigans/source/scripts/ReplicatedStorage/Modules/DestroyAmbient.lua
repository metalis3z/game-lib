local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')

local ComSet = game.ReplicatedStorage.Remotes.Comunicator.Set

local module = {}


local oParams = OverlapParams.new()
oParams.FilterType = Enum.RaycastFilterType.Include
oParams.FilterDescendantsInstances = { workspace.Map }


function module:Destroy(CF: CFrame, Size: Vector3, Burn: boolean, Velocity: Vector3, LookAt: Vector3)
	local PartsInBounds = workspace:GetPartBoundsInBox(CF, Size, oParams)
	if #PartsInBounds > 0 then
		for _,Part: Model in PartsInBounds do
			if Part and Part.Parent then
				if Part:IsDescendantOf(workspace.Map.Trees) then
					local Container = Part:FindFirstAncestorWhichIsA('Model')
					if not Container:FindFirstChild('TreeRoot') then continue end
					
					if Container:HasTag('Destroyed') then continue end
					ComSet:FireServer('destroyAmbient', { Container = Container, State = true })
					
					local TreeRoot: MeshPart = Container.TreeRoot

					local OriginalCF = TreeRoot.CFrame
					local OriginalColor = TreeRoot.Color


					for _, Leaf: Part in TreeRoot.Parent:GetChildren() do
						if Leaf.Name == 'MeshPart' then
							if Burn == true then
								Leaf.Transparency = 1
							else
								local RealVelocity = Velocity
								if LookAt then
									local LookVector = -CFrame.lookAt(Leaf.Position, LookAt).LookVector
									RealVelocity = Vector3.new(LookVector.X * Velocity.X, Velocity.Y, LookVector.Z * Velocity.Z)
								end
								RealVelocity *= Random.new():NextNumber(0.5, 1.5)

								local Clone = Leaf:Clone()
								Clone:RemoveTag('WindShake')
								Leaf.Transparency = 1
								Clone.CanCollide = false
								Clone.CanQuery = false
								Clone.Parent = workspace.Thrown
								Clone.Anchored = false
								Clone.AssemblyLinearVelocity = RealVelocity
								Clone.AssemblyAngularVelocity = Vector3.new(math.random(-5, 5),math.random(-5, 5),math.random(-5, 5))
								Debris:AddItem(Clone, 5)

								task.delay(2.5, function()
									TS:Create(Clone, TweenInfo.new(2.5), { Size = Vector3.zero }):Play()
								end)
							end
						end
					end

					if Burn == true then
						TreeRoot.Color = Color3.new(0,0,0)
					else
						local RealVelocity = Velocity
						if LookAt then
							local LookVector = -CFrame.lookAt(TreeRoot.Position, LookAt).LookVector
							RealVelocity = Vector3.new(LookVector.X * Velocity.X, Velocity.Y, LookVector.Z * Velocity.Z)
						end
						
						local Clone = TreeRoot:Clone()
						Clone.CanCollide = false
						Clone.CanQuery = false
						Clone.CollisionGroup = 'NonPColDebri'
						Clone.Parent = workspace.Thrown
						Clone.Anchored = false
						Clone.AssemblyLinearVelocity = RealVelocity
						Clone.AssemblyAngularVelocity = Vector3.new(math.random(-5, 5),math.random(-5, 5),math.random(-5, 5))
						Debris:AddItem(Clone, 5)
						
						task.delay(2.5, function()
							TS:Create(Clone, TweenInfo.new(2.5), { Size = Vector3.zero }):Play()
						end)
						
						
						TreeRoot.Transparency = 1
						TreeRoot.CanCollide = false
						TreeRoot.CanQuery = false
					end

					task.delay(math.random(10, 18), function()
						TS:Create(TreeRoot, TweenInfo.new(1), { Transparency = 0; Color = OriginalColor }):Play()
						TreeRoot.CanCollide = true
						TreeRoot.CanQuery = true
						
						for _, Leaf: Part in TreeRoot.Parent:GetChildren() do
							if Leaf.Name == 'MeshPart' then
								local OriginalSize = Leaf.Size
								TS:Create(Leaf, TweenInfo.new(1), { Transparency = 0; }):Play()
							end
						end

						task.delay(1, function()
							ComSet:FireServer('destroyAmbient', { Container = Container, State = false })
						end)
					end)
				elseif Part:IsDescendantOf(workspace.Map.Benchs) then
					local Container = Part:FindFirstAncestorWhichIsA('Model')
					if Container:HasTag('Destroyed') then continue end

					Container:AddTag('Destroyed')
					

					local time4Reco = math.random(10, 18)
					
					
					for _,Part2: Part in Container:GetChildren() do
						if Burn == true and (Part.Position - CF.Position).Magnitude > Size.Magnitude/2 then
							local OriginalColor = Part2.Color
							Part2.Color = Color3.new(0,0,0)

							task.delay(time4Reco, function()
								TS:Create(Part2, TweenInfo.new(1), { Color = OriginalColor }):Play()
							end)
						else
							Part2.Transparency = 1
							Part2.CanCollide = false
							Part2.CanQuery = false

							task.delay(time4Reco, function()
								TS:Create(Part2, TweenInfo.new(1), { Transparency = 0; }):Play()
								Part2.CanCollide = true
								Part2.CanQuery = true
							end)
						end
					end
					
					task.delay(time4Reco, function()
						Container:RemoveTag('Destroyed')
					end)
				elseif Part:IsDescendantOf(workspace.Map.Throwables) and Burn ~= true then
					Part:RemoveTag('Throwable')
					Part.Transparency = 1
					Part.CanCollide = false
					Part.CanQuery = false

					task.delay(math.random(10, 18), function()
						Part:AddTag('Throwable')
						Part.Transparency = 0
						Part.CanCollide = true
						Part.CanQuery = true
					end)
				end
			end
		end
	end
end

return module
