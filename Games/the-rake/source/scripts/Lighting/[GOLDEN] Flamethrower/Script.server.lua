local Tool = script.Parent

--Initialize
local lscon,rscon,rwcon,ncon
local lshoulder,rshoulder,neck,rootweld,char
local aimtorso
local joints = {}
local equipped = false

local maxAmmo = 100
local ammo = maxAmmo

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
		local snd = Tool.GunModel.MainPart.Shot:clone()
		snd.Parent = Tool.GunModel.MainPart
		snd:play()
		
		local deb = game:GetService("Debris")
		deb:AddItem(snd,1)
		
		Tool.GunModel.MainPart.Handle.Start.Fire:Emit(20)
		Tool.GunModel.Muzzle.Smoke.Enabled = true
		
		Animator.runAnim(Tool.Animations.Fire,3)
		Tool.GunModel.ShellInChamber.Transparency = 0
	end
	
	if (ani == "Reload") then
		Animator.runAnim(Tool.Animations.Reload,1)
		Tool.GunModel.ShellInChamber.Transparency = 0
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

local active = false

--Receive input
local pos = Vector3.new()
local recoil = 0
function onInput(itype,enabled,hit,target)
	pos = hit.p
	pointAt(hit)
	if (itype == "MouseL") then
		if (enabled and not animating) then
			active = true
			local spread = 0.025
			while active and ammo > 0 do
				local pos1 = Tool.GunModel.Muzzle.Position
				local pos2 = pos
				local cf = CFrame.new(pos1,pos2) * CFrame.Angles(spread*(recoil+0.05)*(0.5-math.random()),spread*(recoil+0.05)*(0.5-math.random()),0)
				local dir = cf.lookVector
				pos2 = pos1+dir*100
				
				local projectile,id = Projectile.new(Tool,pos1,pos2,dir,1800,10,25,2)
				projectiles[id] = projectile
				
				animate("Fire")
				ammo = ammo - 1
				
				local bulletId = 14 - ammo
				local bulletMdl = Tool.GunModel:findFirstChild("Bullet" .. bulletId)
				if (bulletMdl) then bulletMdl.Transparency = 1 end
				
				Tool.GunModel.Bullet14.Transparency = 1
				recoil = recoil + 1
			end
		elseif (not enabled) then
			active = false
		end
	end
	if (itype == "KeyR" and enabled and not animating) then
		animate("Reload")
		ammo = maxAmmo
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
	aimtorso.Parent = Tool.Parent.HumanoidRootPart
	
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
		if (not animating) then
			Animator.runAnim(Tool.Animations.Idle.Breathe,1)
			wait()
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
	
	recoil = recoil / 2
	if (recoil < 1e-12) then
		Tool.GunModel.Muzzle.Smoke.Enabled = false
	end
end
