arrow = script.Parent


debris = game:GetService("Debris")



local hitsounds = {"190133707", }
--local flakes = {"19003948", "19003957", "19003971", "19003978", "19003982", "19003990", "19003998"}
--local globs = {"19323823", "19323854"}

local HitSound = Instance.new("Sound")
HitSound.SoundId = "http://www.roblox.com/asset/?id=" .. hitsounds[math.random(1,#hitsounds)]
HitSound.Parent = arrow
HitSound.Volume = 2

--[[function Snowface(p)
	

	local guiMain = Instance.new("GuiMain") 
	guiMain.Parent = p.PlayerGui 
	local mainFrame = Instance.new("Frame") 
	mainFrame.Name = "SnowfaceEffect"
	mainFrame.Position = UDim2.new(0, 0, 0, 0) 
	mainFrame.Size = UDim2.new(1, 0, 1, 0) 
	mainFrame.BackgroundColor = BrickColor.new(1,1,1)
	mainFrame.Transparency = 1
	mainFrame.BorderColor = BrickColor.new(1,1,1)
	mainFrame.Parent = guiMain

	debris:AddItem(guiMain, 10)

	--- big glob
	local s = Instance.new("ImageLabel")
	local size = (math.random() * .2) + .5
	s.Size = UDim2.new(size,0,size,0)
	s.Position = UDim2.new(math.random() - (size/2),0, math.random() - (size/2),0)
	s.SizeConstraint = Enum.SizeConstraint.RelativeXX
	s.Transparency = 1
	s.Image = "http://www.roblox.com/asset/?id=" .. globs[math.random(1, #globs)]
	s.Parent = mainFrame

	debris:AddItem(s, 5 + (math.random() * 2))

	--flakes
	for i=1,5 do

		local s = Instance.new("ImageLabel")
		local size = (math.random() * .05) + .05
		s.Size = UDim2.new(size,0,size,0)
		s.Position = UDim2.new(math.random() - (size/2),0, math.random() - (size/2),0)
		s.SizeConstraint = Enum.SizeConstraint.RelativeXX
		s.Transparency = 1
		s.Image = "http://www.roblox.com/asset/?id=" .. flakes[math.random(1, #flakes)]
		s.Parent = mainFrame
		debris:AddItem(s, 3 + (math.random() * 6))
	end


	

end]]

function Explode()

	local count = 5

	script.Parent.CanCollide = false
	for i=1,count do
		local p = Instance.new("Part")
		p.BrickColor = BrickColor.new("White")
		p.formFactor = "Custom"
		p.Size = Vector3.new(.4,.4,.4)
		p.Material = Enum.Material.Sand
		p.TopSurface = 0
		p.BottomSurface = 0
		p.Friction = 1
		p.Velocity = Vector3.new(math.random(-30,30),math.random(20,40),math.random(-30,30))--arrow.Velocity * (.5+(math.random() *1))
		p.RotVelocity = Vector3.new(math.random(-20,20), math.random(-20,20), math.random(-20,20))
		p.Position = arrow.Position + (arrow.Velocity * math.random() * .05) + Vector3.new(0,math.random() * 3, 0)
		p.Parent = game.Workspace
		
		debris:AddItem(p, 2)
	end

end




function onTouched(hit)

	connection:disconnect()
	script.Parent.Anchored = true
	

	HitSound:Play()

	if hit.Parent ~= nil then
		local humanoid = hit.Parent:findFirstChild("Humanoid")
		if hit.Parent:IsA("Accessory") or hit.Parent:IsA("Hat") or hit.Parent:IsA("Tool") then
			humanoid = hit.Parent.Parent:findFirstChild("Humanoid")
		end
		if humanoid~=nil then
			local p = game.Players:GetPlayerFromCharacter(humanoid.Parent)
			if (p ~= nil) then
				print("Start trip")
				game.Workspace.Main.TripPlayer:FireClient(p,script.Parent.Velocity /5)
				
				--Snowface(p)

				
			end
			humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
				
			humanoid.Parent.Head.Velocity = script.Parent.Velocity /5
		end
	end

	Explode()

	arrow:Remove()

	
end



connection = arrow.Touched:connect(onTouched)

wait(10)

arrow.Parent = nil