objects = {}
teamcolor = BrickColor.new(script.Parent.Name)
config = script.Parent.Parent.CoreScript.Configuration
wait(1)

script.Parent.Essentials.Spawn.TeamColor = teamcolor
script.Parent.Essentials.Spawn.BrickColor = teamcolor

script.Parent.Essentials.Collector.Transparency = 1

script.Parent.Essentials.Collector.Touched:connect(function(hit)
	if hit then
		if hit:FindFirstChild("Cash") then
			script.Parent.Cash.Value = script.Parent.Cash.Value + hit.Cash.Value
			hit:Destroy()
		end
	end
end)

frq = true
script.Parent.Essentials.Giver.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player ~= nil then
		if script.Parent.Owner.Value == player then
			if hit.Parent:FindFirstChild("Humanoid") then
				if hit.Parent.Humanoid.Health > 0 then
					if frq == true then
						frq = false
					local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
					if cashmoney ~= nil then 
						cashmoney.Value = cashmoney.Value + script.Parent.Cash.Value
						
						script.Parent.Cash.Value = 0
						wait(.25)
					end
					frq = true
					end
				end
			end
		end
	end
end)

script.Parent:WaitForChild("Buttons")
for i,v in pairs(script.Parent.Buttons:GetChildren()) do
	if v:FindFirstChild("Head") then
		
		local object = script.Parent.Purchases:FindFirstChild(v.Object.Value)
		if object ~= nil then
			objects[object.Name] = object:Clone()
			object:Destroy()
		else
			print("Button: "..v.Name.." is missing its object and has been removed.")
			v.Head.CanCollide = false
			v.Head.Transparency = 1
		end
								
		if v:FindFirstChild("Dependency") then
			v.Head.CanCollide = false
			v.Head.Transparency = 1
			coroutine.resume(coroutine.create(function()	
				if script.Parent.PurchasedObjects:WaitForChild(v.Dependency.Value) then		
					if v:FindFirstChild("RequiredGamepass") then
						local tycoonOwner = script.Parent.Owner.Value
						if tycoonOwner then
							if game.GamePassService:PlayerHasPass(tycoonOwner,v.RequiredGamepass.Value) then
								if config.ButtonFadeInDependency.Value == true then
									for i=1,20 do
										wait(config.ButtonFadeInTime.Value/20)
										v.Head.Transparency = v.Head.Transparency - 0.05
									end
								end
								v.Head.CanCollide = true
								v.Head.Transparency = 0
							end
						end
					elseif v:FindFirstChild("BadgeNeeded") then
						local tycoonOwner = script.Parent.Owner.Value
						if tycoonOwner then
							if game.BadgeService:UserHasBadge(tycoonOwner.userId,v.BadgeNeeded.Value) then
								if config.ButtonFadeInDependency.Value == true then
									for i=1,20 do
										wait(config.ButtonFadeInTime.Value/20)
										v.Head.Transparency = v.Head.Transparency - 0.05
									end
								end
								v.Head.CanCollide = true
								v.Head.Transparency = 0
							end
						end	
					elseif v:FindFirstChild("RequiredGroup") then
						local tycoonOwner = script.Parent.Owner.Value
						if tycoonOwner then
							if tycoonOwner:IsInGroup(v.RequiredGroup.Value) then
								if config.ButtonFadeInDependency.Value == true then
									for i=1,20 do
										wait(config.ButtonFadeInTime.Value/20)
										v.Head.Transparency = v.Head.Transparency - 0.05
									end
								end
								v.Head.CanCollide = true
								v.Head.Transparency = 0
							end
						end			
					else
						if config.ButtonFadeInDependency.Value == true then
							for i=1,20 do
								wait(config.ButtonFadeInTime.Value/20)
								v.Head.Transparency = v.Head.Transparency - 0.05
							end
						end
						v.Head.CanCollide = true
						v.Head.Transparency = 0
					end
				end		
			end))	
		end
		
		v.Head.Touched:connect(function(hit)
			local player = game.Players:GetPlayerFromCharacter(hit.Parent)
			if v.Head.CanCollide == true then
				if player ~= nil then
					if script.Parent.Owner.Value == player then
						if hit.Parent:FindFirstChild("Humanoid") then
							if hit.Parent.Humanoid.Health > 0 then
								local cashmoney = game.ServerStorage.MoneyStorage:FindFirstChild(player.Name)
								if cashmoney ~= nil then
									if cashmoney.Value >= v.Price.Value then
										cashmoney.Value = cashmoney.Value - v.Price.Value
										objects[v.Object.Value].Parent = script.Parent.PurchasedObjects
										objects[v.Object.Value]:MakeJoints()
										if config.ButtonExplodeOnBuy.Value == true then
											local explosion = Instance.new("Explosion",workspace)
											explosion.Position = v.Head.Position
											explosion.DestroyJointRadiusPercent = 0
											explosion.BlastPressure = 0
										end
										if config.ButtonFadeOutOnBuy.Value == true then
											v.Head.CanCollide = false
											coroutine.resume(coroutine.create(function()
												for i=1,20 do
													wait(config.ButtonFadeOutTime.Value/20)
													v.Head.Transparency = v.Head.Transparency + 0.05
												end
											end))
										else
											v.Head.CanCollide = false
											v.Head.Transparency = 1
										end
									end
								end
							end
						end
					end
				end
			end
		end)
		
	end
end