-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerScriptService/Main/Combat.server.lua  (Script, 1503 lines)
-- What it does: Two parts of the main combat script: the combo counter (4 hits, reset after 1.5 s without punching, uppercut/downslam finisher variants) and the block action (slows you, adds Cant* tags, 0.25 s perfect-block window detected from the incoming hit log).
-- Excerpt of lines 85-154, 1148-1233 (of 1503)


local ThrowableCs = {}
local LastPunch = {}
local MaxCombo = 4



--// Functions \\--

function ChangeCombo(Char: Model)
	if not Char:GetAttribute('Combo') then
		Char:SetAttribute('Combo', 0)
	end
	
	
	if LastPunch[Char] then
		if (time() - LastPunch[Char]) >= 1.5 then
			Char:SetAttribute('Combo', 1)
		else
			if Char:GetAttribute('Combo') >= MaxCombo then
				Char:SetAttribute('Combo', 1)
			else
				Char:SetAttribute('Combo', Char:GetAttribute('Combo') + 1)
			end
		end
	else
		Char:SetAttribute('Combo', Char:GetAttribute('Combo') + 1)
	end
	
	LastPunch[Char] = time()
	
	return Char:GetAttribute('Combo')
end

function GetPunchAnim(Char: Model, Uppercut, Downslam)
	local CurrentCombo = Char:GetAttribute('Combo')


	local PunchesFolder = CombatAnims.Punches.Default
	local Player = Players:GetPlayerFromCharacter(Char)
	if Player and CombatAnims.Punches:FindFirstChild(Player.Configuration.Moveset.Value) then
		PunchesFolder = CombatAnims.Punches[Player.Configuration.Moveset.Value]
	end
	
	local Hum: Humanoid = Char.Humanoid
	local Animator: Animator = Hum.Animator
	local Animation
	
	if CurrentCombo < MaxCombo then
		Animation = PunchesFolder[tostring(CurrentCombo)]
	else
		if not Uppercut and not Downslam then
			Animation = PunchesFolder[tostring(MaxCombo)]
		else
			if Downslam then
				Animation = CombatAnims.Punches.Downslam
			else
				if Uppercut then
					if Char:HasTag('HasSword') then
						Animation = CombatAnims.Punches.SwordUppercut
					else
						Animation = CombatAnims.Punches.Uppercut
					end
				end
			end
		end
	end
	
	return Animation
end

-- ... (original lines 155-1147 omitted) ...

	elseif Action == 'Block' then
		if Params.Stage == true then
			if Character:HasTag('CantBlock') or Character:HasTag('Stunned') or Character:HasTag('Blocking') or Character:HasTag('Punching') or Character:HasTag('ThrowableGrabbed') then return end

			local Actions = {
				'CantPunch',
				'CantDash',
				'CantSideDash',
				'CantBlock',
				'Blocking',
				'CantRun'
			}
			
			local Anim
			
			local FigGui = game.Players:GetPlayerFromCharacter(Character)
			
			if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
				Anim = Animations.Combat.BlockSword
			--elseif Player.Configuration.Moveset.Value == 'Secret Flame' then
			--	Anim = Animations.Combat.BlockMahito
			--elseif Player.Configuration.Moveset.Value == "Restless Gambler" then
			--	Anim = Animations.Combat.BlockHakari	
			else
				Anim = Animations.Combat.Block
			end
			
			local BlockAnimTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
			
			BlockAnimTrack.Stopped:Once(function()
				Character:SetAttribute('DefaultRunSpeed', 25)
				Character:SetAttribute('DefaultWalkSpeed', 16)
				Character:SetAttribute('DefaultJumpPower', 50)
				
				Humanoid.WalkSpeed = 16
				Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
				
				for _, Action in Actions do
					Character:RemoveTag(Action)
				end
			end)
			
			AnimationService:playAnimation(Character, Anim)
			
			
			Character:SetAttribute('DefaultRunSpeed', 8)
			Character:SetAttribute('DefaultWalkSpeed', 8)
			
			Humanoid.WalkSpeed = 8
			Comunicator:FireClient(Player, 'TriggerJump', { Value = false })
			

			for _, Action in Actions do
				Character:AddTag(Action)
			end
			
			
			local Perfect = true
			local PC: RBXScriptConnection
			PC = Character.ChildAdded:Connect(function(Child)
				if Child.Name == 'DamagedLog' and Child:HasTag('IsM1') and Perfect == true then
					if PC then
						PC:Disconnect()
						PC = nil
					end
					
					Character:AddTag('PerfectBlock')
					task.delay(1, function()
						Character:RemoveTag('PerfectBlock')
					end)
				end
			end)
			
			task.delay(.25, function()
				if PC then
					PC:Disconnect()
					PC = nil
				end
				
				Perfect = false
			end)
		else
			AnimationService:stopAnimation(Character, Animations.Combat.Block)
			--AnimationService:stopAnimation(Character, Animations.Combat.Block)
			--AnimationService:stopAnimation(Character, Animations.Combat.bl)
		end
