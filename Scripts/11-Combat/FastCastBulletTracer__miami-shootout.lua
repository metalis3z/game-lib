-- Reference copy for study. Game: miami-shootout
-- Original: StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript.client.lua  (LocalScript, 453 lines)
-- What it does: Client bullet visualizer on an older FastCast: builds the cosmetic bullet, fires the caster with gravity and extra force from the gun's settings, and moves the cosmetic bullet on LengthChanged.
-- Excerpt of lines 1-25, 341-449 (of 453)

local BE = script:WaitForChild("Visualize")
local FastCast = require(script:WaitForChild("FastCast"))

local Caster = FastCast.new() --Set the caster values

function numLerp(A, B, Alpha)
	return A + (B - A) * Alpha
end

local function findFirstByClass(dir,class) --Utility function to find the first child of a given class
	for _,i in pairs(dir:children()) do
		if (i:IsA(class)) then return i end
	end
	return nil
end


function getRoot(child)
	local parent = child.Parent

	while parent.Parent.Parent  ~= game do
		parent = parent.Parent
	end
	return parent
end

-- ... (original lines 26-340 omitted) ...

function VisualizeBullet(Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,DamageData,BulletLightData,Misc,Critical,GoreData)
	if _G.playEffect then _G.playEffect("fire") end

	if Handle then		
		Caster.Gravity = BulletData[9]
        Caster.ExtraForce = Vector3.new(BulletData[10].X, BulletData[10].Y, BulletData[10].Z)

	    --UPDATE V6: Proper bullet velocity!
	    --Requested by https://www.roblox.com/users/898618/profile/
	    --We need to make sure the bullet inherits the velocity of the gun as it fires, just like in real life.
	    local HumanoidRootPart = Tool.Parent:WaitForChild("HumanoidRootPart", 1)	--Add a timeout to this.
	    local MyMovementSpeed = HumanoidRootPart.Velocity							--To do: It may be better to get this value on the clientside since the server will see this value differently due to ping and such.
	    local ModifiedBulletSpeed = (Direction * BulletData[8]) + MyMovementSpeed	--We multiply our direction unit by the bullet speed. This creates a Vector3 version of the bullet's velocity at the given speed. We then add MyMovementSpeed to add our body's motion to the velocity.
			
		--Make a base cosmetic bullet object. This will be cloned every time we fire off a ray
        local CosmeticBullet = Instance.new("Part")
        CosmeticBullet.Name = "Bullet"
        CosmeticBullet.Material = BulletData[14]
        CosmeticBullet.Color = BulletData[12]
        CosmeticBullet.CanCollide = false
        CosmeticBullet.Anchored = true
        CosmeticBullet.Size = Vector3.new(BulletData[11].X, BulletData[11].Y, BulletData[11].Z)
        CosmeticBullet.Transparency = BulletData[13]
        CosmeticBullet.Shape = BulletData[15]

        if BulletData[16] then
	        local BulletMesh = Instance.new("SpecialMesh")
	        BulletMesh.Scale = Vector3.new(BulletData[19].X, BulletData[19].Y, BulletData[19].Z)
	        BulletMesh.MeshId = "rbxassetid://"..BulletData[17]
	        BulletMesh.TextureId = "rbxassetid://"..BulletData[18]
	        BulletMesh.MeshType = "FileMesh"
	        BulletMesh.Parent = CosmeticBullet
        end
           
	    --Prepare a new cosmetic bullet
	    local Bullet = CosmeticBullet:Clone()
	    Bullet.CFrame = CFrame.new(FirePointObject.WorldPosition, FirePointObject.WorldPosition + Direction)
	    Bullet.Parent = workspace.CurrentCamera

        if BulletLightData[1] then
	        local Light = Instance.new("PointLight")
	        Light.Brightness = BulletLightData[2]
	        Light.Color = BulletLightData[3]
	        Light.Enabled = true
	        Light.Range = BulletLightData[4]
	        Light.Shadows = BulletLightData[5]
	        Light.Parent = Bullet
        end
	
	    if BulletData[1] then
	        local A0 = Instance.new("Attachment", Bullet)
	        A0.Position = Vector3.new(BulletData[2].X, BulletData[2].Y, BulletData[2].Z)
	        A0.Name = "Attachment0"
	        local A1 = Instance.new("Attachment", Bullet)
	        A1.Position = Vector3.new(BulletData[3].X, BulletData[3].Y, BulletData[3].Z)
	        A1.Name = "Attachment1"
	
	        local C = BulletData[4]:GetChildren()
	        for i=1,#C do
		        if C[i].className == "Trail" then
		            local count = 1
		            local Tracer = C[i]:Clone()
		            Tracer.Attachment0 = A0
		            Tracer.Attachment1 = A1
		            Tracer.Parent = Bullet
		        end
	        end
	    end
	
	    if BulletData[5] then
	        local C = BulletData[6]:GetChildren()
	        for i=1,#C do
		        if C[i].className == "ParticleEmitter" then
		            local Particle = C[i]:Clone()
		            Particle.Parent = Bullet
                    Particle.Enabled = true
		        end
	        end
	    end	
	
	    Caster:FireWithBlacklist(FirePointObject.WorldPosition, Direction * BulletData[7], ModifiedBulletSpeed, {Handle, Tool.Parent, workspace.CurrentCamera}, Bullet)

        function OnRayHit_Sub(HitPart, HitPoint, Normal, Material, CosmeticBulletObject)
            OnRayHit_Sub2(HitPart,
	                HitPoint,
	                Normal,
	                Material,
	                CosmeticBulletObject,
	                Tool,
	                {ExplosiveData[1], ExplosiveData[2], ExplosiveData[3], ExplosiveData[4], ExplosiveData[5], ExplosiveData[6], ExplosiveData[7], ExplosiveData[8], ExplosiveData[9]},
	                {DamageData[1], DamageData[2], DamageData[3]},
	                {HitEffectData[1], HitEffectData[2], HitEffectData[3], HitEffectData[4], HitEffectData[5], HitEffectData[6], HitEffectData[7]},
	                {BulletHoleData[1], BulletHoleData[2], BulletHoleData[3], BulletHoleData[4], BulletHoleData[5], BulletHoleData[6]},
	                {BloodEffectData[1], BloodEffectData[2], BloodEffectData[3], BloodEffectData[4], BloodEffectData[5], BloodEffectData[6]},
	                {Misc[1],Misc[2],Misc[3],Misc[4],Misc[5],Misc[6],Misc[7],Misc[8]},
	                {Critical[1],Critical[2],Critical[3]},
	                {GoreData[1], GoreData[2], GoreData[3], GoreData[4], GoreData[5]})
        end
	end
end

function OnRayHit(HitPart, HitPoint, Normal, Material, CosmeticBulletObject)
	OnRayHit_Sub(HitPart, HitPoint, Normal, Material, CosmeticBulletObject)
end

function OnRayUpdated(CastOrigin, SegmentOrigin, SegmentDirection, Length, CosmeticBulletObject)
    local BulletLength = CosmeticBulletObject.Size.Z / 2 --This is used to move the bullet to the right spot based on a CFrame offset
	CosmeticBulletObject.CFrame = CFrame.new(SegmentOrigin, SegmentOrigin + SegmentDirection) * CFrame.new(0, 0, -(Length - BulletLength))
end
