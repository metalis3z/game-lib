-------- OMG HAX

r = game:service("RunService")


local damage = 5


local slash_damage = 10
local lunge_damage = 30

sword = script.Parent.Handle
Tool = script.Parent


local SlashSound = Instance.new("Sound")
SlashSound.SoundId = "rbxasset://sounds\\swordslash.wav"
SlashSound.Parent = sword
SlashSound.Volume = .7

local LungeSound = Instance.new("Sound")
LungeSound.SoundId = "rbxasset://sounds\\swordlunge.wav"
LungeSound.Parent = sword
LungeSound.Volume = .6

local UnsheathSound = Instance.new("Sound")
UnsheathSound.SoundId = "rbxasset://sounds\\unsheath.wav"
UnsheathSound.Parent = sword
UnsheathSound.Volume = 1

damage_threads = {}

debounce = false
function blow(hit)

	if (hit.Parent == nil) or debounce then return end -- happens when bullet hits sword
	debounce = true
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	local vCharacter = Tool.Parent
	local vPlayer = game.Players:playerFromCharacter(vCharacter)
	local hum = vCharacter:findFirstChild("Humanoid") -- non-nil if tool held by a character
	if humanoid~=nil and humanoid ~= hum and hum ~= nil and hum.Health ~= 1 then
		-- final check, make sure sword is in-hand

		local right_arm = vCharacter:FindFirstChild("Right Arm")
		if (right_arm ~= nil) then
			local joint = right_arm:FindFirstChild("RightGrip")
			if (joint ~= nil and (joint.Part0 == sword or joint.Part1 == sword)) then
				
				--[[if damage >= humanoid.Health then
					humanoid.Health = 1
					if not damage_threads[humanoid] then
						damage_threads[humanoid] =  true
						
						delay(4,function()
							if humanoid ~= nil and humanoid.Health < 100 then
								humanoid.Health = 100
							end
							damage_threads[humanoid] =  false				
						end)
						
					end
				else
					humanoid:TakeDamage(damage)
				end]]
				
				
			
			end
		end


	end
	debounce = false
end


function tagHumanoid(humanoid, player)
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = player
	creator_tag.Name = "creator"
	creator_tag.Parent = humanoid
end

function untagHumanoid(humanoid)
	if humanoid ~= nil then
		local tag = humanoid:findFirstChild("creator")
		if tag ~= nil then
			tag.Parent = nil
		end
	end
end


function attack()
	damage = slash_damage
	SlashSound:play()
	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Slash"
	anim.Parent = Tool
end

function lunge()
	damage = lunge_damage

	LungeSound:play()

	local anim = Instance.new("StringValue")
	anim.Name = "toolanim"
	anim.Value = "Lunge"
	anim.Parent = Tool
	
	
	force = Instance.new("BodyVelocity")
	force.velocity = Vector3.new(0,10,0) --Tool.Parent.Torso.CFrame.lookVector * 80
	force.Parent = Tool.Parent.HumanoidRootPart
	wait(.25)
	swordOut()
	wait(.25)
	force.Parent = nil
	wait(.5)
	swordUp()

	damage = slash_damage
end

function swordUp()
	Tool.GripForward = Vector3.new(-1,0,0)
	Tool.GripRight = Vector3.new(0,1,0)
	Tool.GripUp = Vector3.new(0,0,1)
end

function swordOut()
	Tool.GripForward = Vector3.new(0,0,1)
	Tool.GripRight = Vector3.new(0,-1,0)
	Tool.GripUp = Vector3.new(-1,0,0)
end

function swordAcross()
	-- parry
end


Tool.Enabled = true
local last_attack = 0
function onActivated()

	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		return 
	end

	t = r.Stepped:wait()

	if (t - last_attack < .2) then
		lunge()
	else
		attack()
	end

	last_attack = t

	--wait(.5)

	Tool.Enabled = true
end

health_checker = nil
function onEquipped()
	UnsheathSound:play()
	local health = script.Parent.Parent:FindFirstChild("Humanoid")
	if health ~= nil then
		health_checker = health.HealthChanged:connect(function()
			wait()
			if health.Health == 1 then
				script.Parent.Parent = game.Workspace
			end
		end)
	end
end
function Unequipped()
	health_checker:disconnect()
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)
script.Parent.Unequipped:connect(Unequipped)


connection = sword.Touched:connect(blow)


