local player = game.Players.LocalPlayer

local ArrestRemote = game.ReplicatedStorage:WaitForChild("Arrest")

local Gui = script:WaitForChild("ArrestGui")

local mouseicon = "http://www.roblox.com/asset/?id=289707987"
local canArrest = true

local Bullet=Instance.new("Part")
Bullet.Name="Bullet"
Bullet.BrickColor=BrickColor.Yellow()
Bullet.Anchored=true
Bullet.CanCollide=false
Bullet.Locked=true
Bullet.Transparency = 0.5
Bullet.FormFactor = Enum.FormFactor.Custom
Bullet.Size=Vector3.new(0.2, 0.2, 0.2)
Bullet.formFactor=0
Bullet.TopSurface=0
Bullet.BottomSurface=0
Bullet.Material = Enum.Material.Neon

local Mesh = Instance.new("BlockMesh")
Mesh.Parent = Bullet
Mesh.Name="Mesh"
Mesh.Scale=Vector3.new(0.5, 0.5, 1)


function ingoreList()	
	local newTable = {}
	
	for i,v in pairs(player.Character:GetChildren()) do
		table.insert(newTable, v)
	end
	
	--print(newTable)
	
	return newTable
end

script.Parent.Equipped:Connect(function(mouse)
	Gui.Parent = player.PlayerGui
	
	mouse.Icon = mouseicon

	mouse.Button1Down:Connect(function()
		if canArrest == true then
			local startPos = script.Parent.Handle.Position

			local ray = Ray.new(startPos, (mouse.Hit.Position- startPos).Unit * 5)

			local hit, pos = game.Workspace:FindPartOnRayWithIgnoreList(ray, ingoreList())

			--local distance = (startPos - pos).Magnitude


		--[[spawn(function()
			local newBullet = Bullet:Clone()
			newBullet.Parent = game.Workspace
			newBullet.CFrame = CFrame.new(startPos, pos) * CFrame.new(0,0,-distance/2)
			newBullet.Size = Vector3.new(0.2, 0.2, distance)
			wait(0.2)
			
			newBullet:Destroy()
		end)]]--


			--print(hit)

			if hit ~= nil then
				if hit.Parent:FindFirstChild("Humanoid") then
					local EnemyPlayer = game.Players:GetPlayerFromCharacter(hit.Parent)

					local toArrest = ArrestRemote:InvokeServer(EnemyPlayer)
					
					if toArrest == true then
						canArrest = false
						--spawn(function()
							Gui.Backpack.Magazine.Text = "Successful to arrest "..EnemyPlayer.Name
							wait(2)
							
							Gui.Backpack.Magazine.Text = "Click to arrest"

							
							wait(3)
							
							canArrest = true
						--end)
					else
						Gui.Backpack.Magazine.Text = EnemyPlayer.Name.." cannot be arested"
							
						wait(1)
							
						Gui.Backpack.Magazine.Text = "Click to arrest"
					end
				end
			else
				Gui.Backpack.Magazine.Text = "That not a player"

				wait(2)

				Gui.Backpack.Magazine.Text = "Click to arrest"
			end
		else
			Gui.Backpack.Magazine.Text = "Wait 5 seconds"

			wait(2)

			Gui.Backpack.Magazine.Text = "Click to arrest"
		end
	end)
end)

script.Parent.Unequipped:Connect(function()
	Gui.Parent = script
end)