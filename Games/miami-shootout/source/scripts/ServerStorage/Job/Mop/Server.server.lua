local db = false
local anim = nil

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end


script.Parent.RemoteEvent.OnServerEvent:Connect(function(p,pile)
	if script.Parent.Parent.Name == p.Name and not db then
		
		if not anim then
			anim = p.Character.Humanoid:LoadAnimation(script.Parent.Mop)
			anim.Looped = false
		end
		
		print("Authorized.")
		
		if GetDistance(p.Character.PrimaryPart,pile) > 10 then
			print("PLAYER IS TOO FAR TO HIT")
			return
		end
		
		if pile.Name == "TrashPile" and pile:IsA("Part") and pile:FindFirstChild("Decal") and pile.Parent == game.Workspace.Trashpiles.Rest then
			db = true
			print("Correct!")
			local decal = pile.Decal
			if decal.Transparency == 0 then
				
				anim:Play()
				
				p.Character.HumanoidRootPart.Anchored = true
				print("Working")
				decal.Transparency = 0.05
				repeat wait(1) 
					decal.Transparency = decal.Transparency + 0.3	
				until decal.Transparency >= 1
				print("Done!")
				p.Character.HumanoidRootPart.Anchored = false

				local randomVal = math.random(7,14)
				local badChance = math.random(1,3)
				local valueOf = math.random(1,5)
				
				local exact = randomVal-valueOf
				
				if badChance == 2 then
					exact = randomVal+valueOf
				end
				
				if badChance == 3 then
					exact = randomVal
				end
				
				p:FindFirstChild("stored"):FindFirstChild("Money").Value += exact
				game.ReplicatedStorage.server:FireClient(p,"money","+$"..exact)
				
				wait(2)
				db = false
			end
		else
			print("Incorrect.")
		end
		
	else
		print(script.Parent.Parent.Name)
	end
end)