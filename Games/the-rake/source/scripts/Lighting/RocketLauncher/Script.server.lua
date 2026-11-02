local Tool = script.Parent

--Initialize
local lscon,rscon,rwcon,ncon
local lshoulder,rshoulder,neck,rootweld,char
local aimtorso
local joints = {}
local equipped = false
local scoped = false
Tool.UsingScope.Value = false

local maxAmmo = 4
local ammo = 4

local Animator = require(Tool.Animator)
local Projectile = require(370071622)

local projectiles = {}


--Welding
local welds = {}
function doWeld()
	for name,weld in pairs(welds) do weld:Destroy() end
	
	local handle = Tool.GunModel.MainPart
	
	for _,part in pairs(Tool.GunModel:children()) do
		if (part ~= handle and part:IsA("BasePart")) then
			local cfv = part:findFirstChild("RelCf")
			if (cfv) then
				local w = Instance.new("Weld")
				w.Part0 = handle
				w.Part1 = part
				w.C1 = cfv.Value:inverse()
				w.Parent = script.Welds
				table.insert(welds,w)
				
				joints[part.Name] = w
			end
		end
	end
	
	if (not equipped) then
		local w = Instance.new("Weld")
		w.Part0 = Tool.Handle
		w.Part1 = Tool.GunModel.MainPart
		w.Parent = Tool.Handle
		table.insert(welds,w)
	else
		local w = Instance.new("Weld")
		w.Part0 = Tool.Parent.Torso
		w.Part1 = Tool.GunModel.MainPart
		w.Parent = Tool.Handle
		table.insert(welds,w)
		
		joints.wepmain = w
	end
end

--Animating

--Values
local usingLeftArm = false
local usingRightArm = false

--Animation function
local animating = false
function animate(ani)
	--Initiate debounce
	if (animating) then return end
	animating = true
	
	--Abort any idle animations
	Animator.abort()
	
	--Play animations
	if (ani == "Fire") then
		Tool.GunModel.MainPart.Shot:play()
		Tool.GunModel.Muzzle.ParticleEmitter:Emit(128)
		Tool.GunModel.Exhaust.ParticleEmitter:Emit(128)
		Tool.GunModel.Muzzle.Smoke.Enabled = true
		Tool.GunModel.Exhaust.Smoke.Enabled = true
		
		Animator.runAnim(Tool.Animations.Fire,1)
	end
	
	if (ani == "Reload") then
		Tool.GunModel.Muzzle.Smoke.Enabled = false
		Tool.GunModel.Exhaust.Smoke.Enabled = false
		
		Animator.runAnim(Tool.Animations.Reload,1)
	end
	
	--End debounce
	animating = false
end

function pointAt(hit)
	local hrp = Tool.Parent.HumanoidRootPart
	
	local rpos = (hrp.CFrame*CFrame.new(0,0.5,0)):toObjectSpace(hit).p * Vector3.new(0,1,1)
	local lcf = CFrame.new(Vector3.new(),rpos)
	
	joints.lshoulder.C0 = lcf
	joints.rshoulder.C0 = lcf
	joints.wepmain.C0 = lcf
	joints.neck.C0 = lcf
	
	aimtorso.CFrame = CFrame.new(hrp.Position,hit.p)
end

--Receive input
function onInput(itype,enabled,hit,target)
	pointAt(hit)
	if (itype == "MouseL" and enabled and not animating) then
		local rocket = Tool.GunModel.Rocket:clone()
		rocket.Transparency = 0
		rocket.Parent = workspace
		rocket:SetNetworkOwner(nil)
		
		local bv = Instance.new("BodyVelocity")
		bv.Velocity = rocket.CFrame.lookVector * 500
		bv.Parent = rocket
		
		rocket.Velocity = rocket.CFrame.lookVector * 500
		
		local bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(40e3,40e3,40e3)
		bg.CFrame = rocket.CFrame
		bg.Parent = rocket
		
		local fire = Instance.new("Fire",rocket)
		local smoke = Instance.new("Smoke",rocket)
		
		local engine = Instance.new("Sound")
		engine.SoundId = "rbxassetid://388721711"
		engine.Parent = rocket
		engine:play()
		
		local explode = Instance.new("Sound")
		explode.SoundId = "rbxassetid://226196253"
		explode.Volume = 1
		explode.Parent = rocket
		
		local deb = game:GetService("Debris")
		deb:AddItem(bv,2.5)
		deb:AddItem(bg,2.5)
		deb:AddItem(fire,5)
		deb:AddItem(smoke,5)
		
		local connect
		connect = rocket.Touched:connect(function(hit)
			if (not hit:IsDescendantOf(Tool) and hit.CanCollide) then
				engine:stop()
				explode:play()
				
				rocket.Transparency = 1
				rocket.Anchored = true
				
				local e = Instance.new("Explosion")
				e.BlastPressure = e.BlastPressure * 4
				e.Position = rocket.Position
				e.Parent = workspace
				
				local dir = rocket.CFrame.lookVector
				local projectile,id = Projectile.new(rocket.Fire,rocket.Position,rocket.Position+dir*300,dir,15000,10,7500,30)
				projectiles[id] = projectile
				
				connect:disconnect()
				
				fire.Enabled = false
				smoke.Enabled = false
				
				wait(1)
				
				rocket:Destroy()
			end
		end)
		
		animate("Fire")
		animate("Reload")
	end
end

Tool.Input.OnServerEvent:connect(function(p,itype,enabled,hit,target)
	if (p and p.Character == Tool.Parent) then
		onInput(itype,enabled,hit,target)
	end
end)

Tool.Equipped:connect(function()
	equipped = true
	doWeld()
	
	--Character
	char = Tool.Parent
	local lshoulderm = char.Torso["Left Shoulder"]
	local rshoulderm = char.Torso["Right Shoulder"]
	lshoulderm.Archivable = true
	rshoulderm.Archivable = true
	lscon = lshoulderm:clone()
	rscon = rshoulderm:clone()
	
	lshoulderm:Destroy()
	rshoulderm:Destroy()
	
	lshoulder = Instance.new("Weld")
	lshoulder.Name = "Left Shoulder"
	lshoulder.Part0 = char.Torso
	lshoulder.Part1 = char["Left Arm"]
	lshoulder.C0 = lshoulderm.C0
	lshoulder.C1 = lshoulderm.C1
	lshoulder.Parent = char.Torso
	
	rshoulder = Instance.new("Weld")
	rshoulder.Name = "Right Shoulder"
	rshoulder.Part0 = char.Torso
	rshoulder.Part1 = char["Right Arm"]
	rshoulder.C0 = rshoulderm.C0
	rshoulder.C1 = rshoulderm.C1
	rshoulder.Parent = char.Torso
	
	aimtorso = Instance.new("BodyGyro")
	aimtorso.Name = "AimTorso"
	aimtorso.D = 50
	aimtorso.MaxTorque = Vector3.new(0,1,0) * 4e3
	aimtorso.Parent = char.HumanoidRootPart
	
	rootweld = char.HumanoidRootPart.RootJoint
	rootweld.Archivable = true
	rwcon = rootweld:clone()
	rootweld.C0 = CFrame.new()
	rootweld.C1 = CFrame.new()
	
	neck = char.Torso.Neck
	neck.Archivable = true
	ncon = neck:clone()
	
	joints.lshoulder = lshoulder
	joints.rshoulder = rshoulder
	joints.neck = neck
	joints.rootweld = rootweld
	
	Animator.abort()
	Animator.setJoints(joints)
	while equipped do
		if (not scoped and not animating) then
			Animator.runAnim(Tool.Animations.Idle.Breathe,1)
		else 
			wait()
		end
	end
end)
Tool.Unequipped:connect(function()
	equipped = false
	doWeld()
	
	--Character reset
	lshoulder:Destroy()
	rshoulder:Destroy()
	lshoulder = lscon:clone()
	rshoulder = rscon:clone()
	lshoulder.Part0 = char.Torso
	lshoulder.Part1 = char["Left Arm"]
	lshoulder.Parent = char.Torso
	rshoulder.Part0 = char.Torso
	rshoulder.Part1 = char["Right Arm"]
	rshoulder.Parent = char.Torso
	
	rootweld:Destroy()
	rootweld = rwcon:clone()
	rootweld.Parent = char.HumanoidRootPart
	rootweld.Part0 = char.HumanoidRootPart
	rootweld.Part1 = char.Torso
	
	neck:Destroy()
	neck = ncon:clone()
	neck.Parent = char.Torso
	neck.Part0 = char.Torso
	neck.Part1 = char.Head
	
	aimtorso:Destroy()
	
	Tool.UsingScope.Value = false
	scoped = false
end)

doWeld()

while true do
	local delta = wait()
	for index,prj in pairs(projectiles) do
		if (not prj:step(delta)) then
			projectiles[index] = nil
			prj:Destroy()
		end
	end
end