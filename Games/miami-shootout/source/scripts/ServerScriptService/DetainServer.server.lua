repeat wait() until game.ReplicatedStorage:FindFirstChild("DetainEvent")
print("load server")
local RemoteEvent = game.ReplicatedStorage.DetainEvent
local RunService = game:GetService("RunService")
local Enabled = {}
local CollectionService = game:GetService("CollectionService")

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

function loadCuffs(character)
	local hand = character:FindFirstChild("RightHand") or nil
	if not hand or hand == nil then return print("no") end
	if hand:FindFirstChild("HandcuffModel") then
		return
	end
	
	local e = game.ServerStorage.CUFFS:Clone()
	e.Name = "HandcuffModel"
	e.Parent = character.RightHand
	e.CLONE.CFrame = hand.CFrame
	local weld = Instance.new("Weld")
	weld.Part0 = hand
	weld.Part1 = e.CLONE
	weld.C0 = hand.CFrame:Inverse()
	weld.C1 = e.CLONE.CFrame:Inverse()
	weld.Parent = hand
end

local SERVEREVENT = game.ReplicatedStorage.server

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

RemoteEvent.OnServerEvent:Connect(function(plr,purpose,mousetarget,timer,charges)
	
	--if not plr:IsInGroup(15859128) then return end
	
	if plr.Team ~= game.Teams.Police then return end
	
	if plr ~= nil and purpose == "eject" then
		print("eject")
		if mousetarget.Parent == game.Workspace.CivCars then
			for i,seat in pairs(mousetarget:GetDescendants()) do
				if (seat:IsA("Seat") or seat:IsA("VehicleSeat")) and seat.Occupant ~= nil then
					seat.Occupant.Jump = true
				end
			end
		end
	end
	
	if plr ~= nil and purpose == "arrest" then
		if mousetarget.Parent:FindFirstChildOfClass("Humanoid") then
			if not mousetarget.Parent:FindFirstChild("Detain") then
				local plrArrest = game.Players:GetPlayerFromCharacter(mousetarget.Parent)
		
				game.ReplicatedStorage.ArrestHelp:Fire(plr,plrArrest,timer,charges)
				game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..plr.Name.."** has arrested **"..plrArrest.Name.."** for "..timer.." seconds!")
			end	
		end
	end
	
	if plr ~= nil and purpose == "cuffs" then
		
		if mousetarget.Parent:FindFirstChildOfClass("Humanoid") then
			if not mousetarget.Parent:FindFirstChild("Detain") then
				local sound, animation = game.ReplicatedStorage.assets_imp.hc.noise, game.ReplicatedStorage.assets_imp.hc.animation

				spawn(function()
					local char = mousetarget.Parent
					repeat wait() until not char:FindFirstChild("RightHand"):FindFirstChild("HandcuffModel")
					local anim = mousetarget.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(animation)
					anim:Play()
					loadCuffs(char) 
					
					local gamePlayer = game.Players:GetPlayerFromCharacter(char)
					if not CollectionService:HasTag(gamePlayer,"cuffed") then CollectionService:AddTag(gamePlayer,"cuffed") end
					if not gamePlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
						game.ReplicatedStorage.HANDCUFF_LEAVE:Clone().Parent = gamePlayer.PlayerGui
					end
					
					SERVEREVENT:FireClient(gamePlayer,"backpack",false)
					SERVEREVENT:FireClient(gamePlayer,"reset",false)
					mousetarget.Parent:FindFirstChildOfClass("Humanoid"):UnequipTools()
					mousetarget.Parent:FindFirstChildOfClass("Humanoid").WalkSpeed = 3
					if not CollectionService:HasTag(gamePlayer,"det") then CollectionService:AddTag(gamePlayer,"det") end
					game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..plr.Name.."** has detained **"..gamePlayer.Name.."**!")
				end)
			end
		end
		
	end
		
	if plr ~= nil and purpose == "detain" then
		if mousetarget.Parent:FindFirstChildOfClass("Humanoid") then
			if not mousetarget.Parent:FindFirstChild("Detain") then
				Enabled[plr.Name] = true
				spawn(function() plr.Character:FindFirstChild("Handcuffs").Detaining.Value = true end)
				local sound, animation = game.ReplicatedStorage.assets_imp.hc.noise, game.ReplicatedStorage.assets_imp.hc.animation
								
				--local hcAnim = mousetarget.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(game.ReplicatedStorage.cuffed)
				--hcAnim:Play()

				--local sound = game.ReplicatedStorage.handcuffs:Clone()
				--sound.Parent = mousetarget.Parent
				
				--sound:Play()
				
				--game.Debris:AddItem(sound,sound.TimeLength)
				local nv = Instance.new("NumberValue",mousetarget.Parent)
				nv.Name = "HANDCUFFED"
				nv.Value = 1

				spawn(function()
					if mousetarget.Parent:FindFirstChild("Humanoid").Sit == true then
						mousetarget.Parent:FindFirstChild("Humanoid").Jump = true
					end
				end)
				
				spawn(function()
					local gamePlayer = game.Players:GetPlayerFromCharacter(mousetarget.Parent)
					if not CollectionService:HasTag(gamePlayer,"cuffed") then CollectionService:AddTag(gamePlayer,"cuffed") end
					SERVEREVENT:FireClient(gamePlayer,"backpack",false)
					SERVEREVENT:FireClient(gamePlayer,"reset",false)
					mousetarget.Parent:FindFirstChildOfClass("Humanoid"):UnequipTools()
				end)
				
				spawn(function()
					
					local char = mousetarget.Parent
					
					local xsound = sound:Clone()
					xsound.Parent = char.PrimaryPart
					xsound:Play()
					game.Debris:AddItem(xsound,5)

					local anim = mousetarget.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(animation)
					anim:Play()

					loadCuffs(char)
					
					local gamePlayer = game.Players:GetPlayerFromCharacter(char)
					if not gamePlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
						game.ReplicatedStorage.HANDCUFF_LEAVE:Clone().Parent = gamePlayer.PlayerGui
					end
					
					repeat 
						mousetarget.Parent:FindFirstChildOfClass("Humanoid"):UnequipTools()
						if mousetarget.Parent:FindFirstChild("UpperTorso") then
							mousetarget.Parent.UpperTorso.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new( 0, 0, -5 )
						else
							mousetarget.Parent.Torso.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new( 0, 0, -5 )
						end
						RunService.Heartbeat:Wait()
					until Enabled[plr.Name] == false
					
					if mousetarget.Parent:FindFirstChild("HANDCUFFED") then
						mousetarget.Parent:FindFirstChild("HANDCUFFED"):Destroy()
					end
					
					anim:Stop()
					if char:FindFirstChild("RightHand"):FindFirstChild("HandcuffModel") then
						char:FindFirstChild("RightHand"):FindFirstChild("HandcuffModel"):Destroy()
					end
					
					if gamePlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
						gamePlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE"):Destroy()
					end
					
					spawn(function() plr.Character:FindFirstChild("Handcuffs").Detaining.Value = false end)
					spawn(function()
						SERVEREVENT:FireClient(gamePlayer,"reset",true)
						SERVEREVENT:FireClient(gamePlayer,"backpack",true)
						if CollectionService:HasTag(gamePlayer,"cuffed") then CollectionService:RemoveTag(gamePlayer,"cuffed") end
					end)
					
					if CollectionService:HasTag(gamePlayer,"det") then
						CollectionService:RemoveTag(gamePlayer,"det")
						game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..plr.Name.."** has undetained **"..gamePlayer.Name.."**!")
					end
				end)
				--hcAnim:Stop()
			end
		else
			Enabled[plr.Name] = false
			RemoteEvent:FireClient(plr,"noOneToDetain")
		end
	elseif purpose == "undetain" then
		Enabled[plr.Name] = false
	end
end)