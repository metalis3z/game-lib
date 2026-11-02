local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local rp = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local ServerScriptService = game:GetService("ServerScriptService")
local HitboxHandler = require(script.Parent.HitboxHandler)
local RemotesFolder = rp:WaitForChild("Remotes")
local ReplicateRemote = shared.repfire
local module = {}

module.Groups = {}

module.ActiveDomain = function(character : Model, OriginalPos: Vector3, DomainRadius: number, DomainModule: ModuleScript)
	local FoundAGroup = false
	local Hitbox =  HitboxHandler.new()
	Hitbox.Size = Vector3.new(DomainRadius,DomainRadius,DomainRadius)
	Hitbox.Instance = character.HumanoidRootPart
	Hitbox.Ignore = {character}
	Hitbox.ResetCharactersList = true
	Hitbox.onTouch = function(EnemyChar : Model)
		local EnemyHum = EnemyChar:FindFirstChild("Humanoid")
		local EnemyRP = EnemyChar:FindFirstChild("HumanoidRootPart")
		if EnemyHum.Health > 0 then
			local distance = (OriginalPos - EnemyRP.Position).Magnitude
			if distance <= DomainRadius then

				if EnemyChar:GetAttribute("DomainExpanding") then
					for I, group in pairs(module.Groups) do
						if not group.Clashing then
							if group.Ended then
								module.Groups[I] = nil
								continue
							end

							if group[EnemyChar] == true then
								local total, InMyRadius = 0, 0
								for CHAR, _ in pairs(group) do 
									if typeof(CHAR) == "Instance" then
										total += 1
									end
								end

								for OtherCharacter, _ in pairs(group) do
									if typeof(OtherCharacter) == "Instance" then
										local OtherCharRP = OtherCharacter:FindFirstChild("HumanoidRootPart")
										if OtherCharRP then
											local distance = (OriginalPos - OtherCharRP.Position).Magnitude
											if distance <= DomainRadius then
												InMyRadius += 1
											end
										end
									end
								end

								if InMyRadius == total then
									character:SetAttribute("DomainExpanding", true)

									group.Ended = false
									group.Modules[character] = DomainModule

									group[character] = true
									FoundAGroup = true

									pcall(task.cancel, group.Countdown)
									group.Countdown = task.delay(2, function()
										group.Countdown = nil

										group.Clashing = true
										group.Points = {
											--character = 0,
										}

										warn("DOMAIN CLASHING STARTED IN A GROUP, ALL PEOPLE IN THIS GROUP :")
										print(group)

										ReplicateRemote:FireAllClients('DomainExpansion',{Stage = "DomainGui"; Char = character, DomainName = DomainModule.DomainName, Action = "StartClashing" ; DomainRadius = DomainRadius})

										for member, _ in pairs(group) do
											if typeof(member) == "Instance" then
												member:SetAttribute("DomainExpanding", false)
												member:SetAttribute("DomainClashing", true)
											end
										end

										task.delay(6, function()
											group.Clashing = false

											local winner
											local mostPoint = 0

											for OtherCharacter, _ in pairs(group) do
												if typeof(OtherCharacter) == "Instance" then
													OtherCharacter:SetAttribute("DomainClashing", false)

													if not group.Points[OtherCharacter] then
														group.Points[OtherCharacter] = 0
													end

													if not mostPoint then
														mostPoint = group.Points[OtherCharacter]
													end

													if group.Points[OtherCharacter] > mostPoint then
														winner = OtherCharacter
														mostPoint = group.Points[OtherCharacter]
													end
												end
											end

											for OtherCharacter, _ in pairs(group) do
												if typeof(OtherCharacter) == "Instance" then
													if OtherCharacter == winner then
														warn(OtherCharacter.Name, "WON THE DOMAIN CLASH")

														winner:SetAttribute("DomainActive", true)
														ReplicateRemote:FireAllClients('DomainExpansion',{Stage = "DomainGui"; Char = character, DomainName = DomainModule.DomainName, Action = "StopClashing" ; DomainRadius = DomainRadius, Winner = winner})

														group.Modules[OtherCharacter].StartDomain(Players:GetPlayerFromCharacter(OtherCharacter) or OtherCharacter)
													else
														group.Modules[OtherCharacter].CancelDomain(Players:GetPlayerFromCharacter(OtherCharacter) or OtherCharacter)
													end
												end
											end

											group.Ended = true
										end)
									end)
								else
									warn(character.Name, "CAN'T JOIN ANY GROUPS RIGHT NOW.")
									return false
								end
							end
						end
					end

				elseif EnemyChar:GetAttribute("DomainClashing") then
					warn("SOMEONE IS DOMAIN CLASHING")
					Hitbox:Destroy()
					return false

				elseif EnemyChar:GetAttribute("DomainActive") then
					warn("SOMEONE HAS HIS DOMAIN ACTIVE")
					Hitbox:Destroy()
					return false
				end
			else
				ReplicateRemote:FireClient(Players:GetPlayerFromCharacter(EnemyChar),'DomainExpansion',{Stage = "DomainGui"; Char = character, DomainName = DomainModule.DomainName, Action = "End" ; DomainRadius = DomainRadius})
			end
		end
	end
	Hitbox:Once()
	
	if not FoundAGroup then
		local newGroup = { [character] = true }
		character:SetAttribute("DomainExpanding", true)

		newGroup.Ended = false
		newGroup.Modules = { [character] = DomainModule }
		newGroup.Countdown = task.delay(2, function()
			warn("DOMAIN ACTIVATED IN A GROUP WITH ONLY 1 GUY IN :")
			print(newGroup)

			ReplicateRemote:FireAllClients('DomainExpansion',{Stage = "DomainGui"; Char = character, DomainName = DomainModule.DomainName, Action = "End" ; DomainRadius = DomainRadius})

			character:SetAttribute("DomainActive", true)
			character:SetAttribute("DomainExpanding", false)

			Hitbox:Destroy()

			newGroup.Modules[character].StartDomain(Players:GetPlayerFromCharacter(character) or character)
			newGroup.Ended = true
		end)

		table.insert(module.Groups, newGroup)
	end

	return true
end

local debounce = {}
RemotesFolder.DomainClashing.OnServerEvent:Connect(function(player)
	if debounce[player] then return end
	debounce[player] = true

	local character = player.Character

	for _, group in pairs(module.Groups) do
		if group[character] then
			if group.Clashing then
				if not group.Points[character] then
					group.Points[character] = 0
				end

				group.Points[character] += 1
			end
		end
	end

	task.delay(.1, function()
		debounce[player] = false
	end)
end)

return module