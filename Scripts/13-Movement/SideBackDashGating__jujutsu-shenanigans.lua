-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerScriptService/Main/Combat.server.lua  (Script, 1503 lines)
-- What it does: Server checks for side and back dashes: tag-based cooldowns (SideDashCD, DashCD), mutual blocking (CantDash / CantSideDash), dash out of ragdoll once every 30 s, then tells all clients to play the dash.
-- Excerpt of lines 157-283 (of 1503)

local DashGetFunctions = {
	CheckSideDash = function(Character: Model, currDirection: string)
		local Humanoid: Humanoid = Character.Humanoid
		
		
		local returnValue
		
		if not Character:HasTag('Ragdolled') then
			if Character:HasTag('SideDashCD') or Character:HasTag('CantSideDash') or Character:HasTag('Stunned') then
				returnValue = false
			else
				returnValue = true
			end
		else
			if Character:HasTag('CantRagdollCancel') or not Character:HasTag('RagdollCancel') then
				returnValue = false
			else
				if Character:HasTag('RagdollCancel') then
					returnValue = true

					RagdollHandler.cancelRagdoll(Humanoid, true, false, nil)

					Character:RemoveTag('RagdollCancel')
					task.delay(30, function()
						Character:AddTag('RagdollCancel')
					end)
				else
					returnValue = false
				end
			end
		end
		
		if returnValue then
			local HumRP: BasePart = Character.HumanoidRootPart
			local Animator: Animator = Character.Humanoid.Animator
			
			
			ReplicateSet:FireAllClients('DashCharacter', { Type = 'Side'; Character = Character; Right = currDirection == 'Right'; })			
			AnimationService:playAnimation(Character, Assets.Animations.Combat.Dashes['Dash'..currDirection])
			
			
			local SFX = CombatSounds.Dashing.SideDash:Clone()
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)
			
			
			RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = false })
			Character:AddTag('CantDash')
			Character:AddTag('SideDashCD')
			task.delay(2,function()
				Character:RemoveTag('SideDashCD')
			end)
			task.delay(.6, function()
				RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = true })
				Character:RemoveTag('CantDash')
			end)
		end
		
		return returnValue
	end,
	
	CheckBackDash = function(Character: Model)
		local Humanoid: Humanoid = Character.Humanoid


		local returnValue

		if not Character:HasTag('Ragdolled') then
			if Character:HasTag('DashCD') or Character:HasTag('CantDash') or Character:HasTag('Stunned') then
				returnValue = false
			else
				if not Character:HasTag('DashCD') and not Character:HasTag('CantDash') then
					returnValue = true
				else
					returnValue = false
				end
			end
		else
			if Character:HasTag('CantRagdollCancel') or not Character:HasTag('RagdollCancel') then
				returnValue = false
			else
				if Character:HasTag('RagdollCancel') and not Character:HasTag('CantRagdollCancel') then
					returnValue = true

					RagdollHandler.cancelRagdoll(Humanoid, true, false, nil)

					Character:RemoveTag('RagdollCancel')
					task.delay(30, function()
						Character:AddTag('RagdollCancel')
					end)
				else
					returnValue = false
				end
			end
		end

		if returnValue then
			local HumRP: BasePart = Character.HumanoidRootPart
			local Animator: Animator = Character.Humanoid.Animator
			
			
			ReplicateSet:FireAllClients('DashCharacter', { Type = 'Back'; Character = Character; })
			AnimationService:playAnimation(Character, Assets.Animations.Combat.Dashes.DashBack)


			local SFX = CombatSounds.Dashing.BackDash:Clone()
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)



			RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = false })
			Character:AddTag('CantSideDash')
			Character:AddTag('DashCD')
			task.delay(4,function()
				Character:RemoveTag('DashCD')
			end)
			task.delay(1.051, function()
				RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = true })
				Character:RemoveTag('CantSideDash')
			end)
		end

		return returnValue
	end,
