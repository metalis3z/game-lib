local db = {}
local anim = {}

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

game.ReplicatedStorage.SPONGE.OnServerEvent:Connect(function(p,dirtyTable)
	if p.Character:FindFirstChild("Sponge") and not db[p] then
		
		local TOOL = p.Character:FindFirstChild("Sponge")
		
		if not anim[p.Character.Humanoid] then
			anim[p.Character.Humanoid] = p.Character.Humanoid:LoadAnimation(TOOL.Scrub)
			anim.Looped = false
		end
		
		if GetDistance(p.Character.PrimaryPart,dirtyTable) > 10 then
			print("PLAYER IS TOO FAR TO HIT")
			return
		end
		
		if dirtyTable and dirtyTable:FindFirstChild("Bubbles") and dirtyTable:FindFirstChild("Decal") then
			local decal,bubbles = dirtyTable:FindFirstChild("Decal"), dirtyTable:FindFirstChild("Bubbles")
			local success = pcall(function()
				if decal.Transparency == 0 then
					db[p] = true
					anim[p.Character.Humanoid]:Play()

					bubbles.Enabled = true

					p.Character.HumanoidRootPart.Anchored = true
					print("Working")
					decal.Transparency = 0.05
					repeat wait(1) 
						decal.Transparency = decal.Transparency + 0.3	
					until decal.Transparency >= 1
					print("Done!")
					p.Character.HumanoidRootPart.Anchored = false

					bubbles.Enabled = false

					local randomVal = math.random(5,28)
					local badChance = math.random(0,5)

					local repChance = math.random(1,3)

					local giving = randomVal+badChance

					if repChance == 1 then
						giving = randomVal-badChance
					end
					if repChance == 2 then
						giving = randomVal
					end

					p:FindFirstChild("stored"):FindFirstChild("Money").Value += giving
					game.ReplicatedStorage.server:FireClient(p,"money","+$"..giving)

					wait(1.5)
					db[p] = false

					wait(math.random(10,25))
					decal.Transparency = 0
				end
			end)
			if not success then
				bubbles.Enabled = false
				decal.Transparency = 1
				wait(10)
				decal.Transparency = 0
			end
		end
		
	end
end)	