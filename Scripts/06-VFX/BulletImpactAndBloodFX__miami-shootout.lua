-- Reference copy for study. Game: miami-shootout
-- Original: StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript.client.lua  (LocalScript, 453 lines)
-- What it does: Impact effects for a gun system: an Attachment at the hit point oriented to the surface normal, per-material particle sets (tinted to the hit part's color), random impact sound, plus blood particles on characters.
-- Excerpt of lines 27-181 (of 453)

function MakeImpactFX(Hit, Position, Normal, HitEffectData, BulletHoleData)
	
   local surfaceCF = CFrame.new(Position, Position + Normal)
			
   if HitEffectData[1] then		
		local Attachment = Instance.new("Attachment")
		Attachment.CFrame = surfaceCF
	    Attachment.Parent = workspace.Terrain
		local Sound = Instance.new("Sound",Attachment)
		Sound.SoundId = "rbxassetid://"..HitEffectData[2][math.random(1,#HitEffectData[2])]
		Sound.PlaybackSpeed = Random.new():NextNumber(HitEffectData[3], HitEffectData[4])
		Sound.Volume = HitEffectData[5]
			
		local function spawner2(material)
	        local C = HitEffectData[6][material.Name]:GetChildren()
	        for i=1,#C do
		        if C[i].className == "ParticleEmitter" then
			        local count = 1
			        local Particle = C[i]:Clone()
			        Particle.Parent = Attachment
		            if Particle:FindFirstChild("EmitCount") then
			            count = Particle.EmitCount.Value
		            end
				    if Particle.PartColor.Value then
			            Particle.Color = ColorSequence.new(Hit.Color,Hit.Color)
		            end
			        delay(0.01,function()
			            Particle:Emit(count)
			            game.Debris:AddItem(Particle,Particle.Lifetime.Max)
		            end)
		        end
	        end
	        Sound:Play()
		end
		
        if not HitEffectData[7] then
            if Hit.Material==Enum.Material.Plastic then spawner2(Hit.Material) end
            if Hit.Material==Enum.Material.Slate then spawner2(Hit.Material) end
	        if Hit.Material==Enum.Material.Concrete then spawner2(Hit.Material) end
	        if Hit.Material==Enum.Material.CorrodedMetal then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.DiamondPlate then spawner2(Hit.Material) end
            if Hit.Material==Enum.Material.Foil then spawner2(Hit.Material) end
            if Hit.Material==Enum.Material.Marble then spawner2(Hit.Material) end
	        if Hit.Material==Enum.Material.Granite then	spawner2(Hit.Material) end        
		    if Hit.Material==Enum.Material.Brick then spawner2(Hit.Material) end          
	        if Hit.Material==Enum.Material.Pebble then spawner2(Hit.Material) end          
		    if Hit.Material==Enum.Material.SmoothPlastic then spawner2(Hit.Material) end          
	        if Hit.Material==Enum.Material.Metal then spawner2(Hit.Material) end         
	        if Hit.Material==Enum.Material.Cobblestone then spawner2(Hit.Material) end
	        if Hit.Material==Enum.Material.Neon then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.Wood then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.WoodPlanks then spawner2(Hit.Material) end
	        if Hit.Material==Enum.Material.Glass then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.Grass then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.Sand then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.Fabric then spawner2(Hit.Material) end
		    if Hit.Material==Enum.Material.Ice then spawner2(Hit.Material) end
        else
	        spawner2(HitEffectData[6].Custom)
        end

		game.Debris:AddItem(Attachment,10)				
	end
			
	if BulletHoleData[1] then
		
		if Hit.Parent and Hit.Parent.Parent and Hit.Parent.Parent.Parent and getRoot(Hit) == game.Workspace.CivCars then
			return
		end
		if Hit.Parent and Hit.Parent.Parent and Hit.Parent.Parent.Parent and getRoot(Hit) == game.Workspace.PoliceCars then
			return
		end
		
		local Hole = Instance.new("Part")
		Hole.Name = "BulletHole"
		Hole.Transparency = 1
		Hole.Anchored = true
		Hole.CanCollide = false
		Hole.FormFactor = "Custom"
		Hole.Size = Vector3.new(1, 1, 0.2)
		Hole.TopSurface = 0
		Hole.BottomSurface = 0
		local Mesh = Instance.new("BlockMesh")
		Mesh.Offset = Vector3.new(0, 0, 0)
		Mesh.Scale = Vector3.new(BulletHoleData[2], BulletHoleData[2], 0)
		Mesh.Parent = Hole
		local Decal = Instance.new("Decal")
		Decal.Face = Enum.NormalId.Front
		Decal.Texture = "rbxassetid://"..BulletHoleData[3][math.random(1,#BulletHoleData[3])]
	    if BulletHoleData[4] then
		    Decal.Color3 = Hit.Color
		end
		Decal.Parent = Hole
		Hole.Parent = workspace.CurrentCamera
		Hole.CFrame = surfaceCF * CFrame.Angles(0, 0, math.random(0, 360))
		if (not Hit.Anchored) then
			local Weld = Instance.new("Weld", Hole)
			Weld.Part0 = Hit
			Weld.Part1 = Hole
		    Weld.C0 = Hit.CFrame:toObjectSpace(surfaceCF * CFrame.Angles(0, 0, math.random(0, 360)))
			Hole.Anchored = false
	    end
		delay(BulletHoleData[5], function()
			if BulletHoleData[5] > 0 then
				local t0 = tick()
				while true do
					local Alpha = math.min((tick() - t0) / BulletHoleData[6], 1)
					Decal.Transparency = numLerp(0, 1, Alpha)
				    if Alpha == 1 then break end
			      	game:GetService("RunService").Heartbeat:wait()
				end
			    Hole:Destroy()
			else
			    Hole:Destroy()
		    end
		end)
    end
end

function MakeBloodFX(Hit, Position, Normal, BloodEffectData)
	
	local surfaceCF = CFrame.new(Position, Position + Normal)
	
    if BloodEffectData[1] then
		local Attachment = Instance.new("Attachment")
		Attachment.CFrame = surfaceCF
	    Attachment.Parent = workspace.Terrain
		local Sound = Instance.new("Sound",Attachment)
		Sound.SoundId = "rbxassetid://"..BloodEffectData[2][math.random(1,#BloodEffectData[2])]
		Sound.PlaybackSpeed = Random.new():NextNumber(BloodEffectData[3], BloodEffectData[4])
		Sound.Volume = BloodEffectData[5]
	
		local function spawner3()
	        local C = BloodEffectData[6]:GetChildren()
	        for i=1,#C do
		        if C[i].className == "ParticleEmitter" then
			        local count = 1
			        local Particle = C[i]:Clone()
			        Particle.Parent = Attachment
		            if Particle:FindFirstChild("EmitCount") then
			            count = Particle.EmitCount.Value
		            end
			        delay(0.01,function()
			            Particle:Emit(count)
			            game.Debris:AddItem(Particle,Particle.Lifetime.Max)
		            end)
		        end
	        end
	        Sound:Play()
		end
		
	    spawn(spawner3)
	    game.Debris:AddItem(Attachment,10)
    end	
end
