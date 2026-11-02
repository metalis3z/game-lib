local Tool = script.Parent
local Time = 0
local C0 = script.Parent.Combo.C0
local C1 = script.Parent.Combo.C1
local Debris = game:GetService("Debris")
local players = game:GetService("Players")

C0.OnServerEvent:Connect(function(plr,Part,d)
	Enable = true
	Time = 0
		Part.Touched:Connect(function(hit)
		if Time == 0 and Enable == true then
			if hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Parent:WaitForChild("Humanoid").Health ~= 0 and not hit.Parent:FindFirstChild("AlreadyHit") then
				local Check = Instance.new("IntValue", hit.Parent)
				Check.Name = "AlreadyHit"
				game.Debris:AddItem(Check ,0.625)
				local vCharacter = Tool.Parent
				local vPlayer = game.Players:GetPlayerFromCharacter(vCharacter)
				local Humanoid = hit.Parent:WaitForChild("Humanoid")
				local sound = script.Hit:Clone()
				sound.Parent = hit.Parent
				sound:Play()
				TagHumanoid(Humanoid, vPlayer)
				Humanoid:TakeDamage(script.Parent.Damage.Value)
				wait(0.25)
				UntagHumanoid(Humanoid)
			end
	   end
	end)
end)
C1.OnServerEvent:Connect(function(plr,Part,d)
	Enable = true
	Time = 0
		Part.Touched:Connect(function(hit)
		if Time == 0 and Enable == true then
			if hit.Parent:FindFirstChild("Humanoid") ~= nil and hit.Parent:WaitForChild("Humanoid").Health ~= 0 and not hit.Parent:FindFirstChild("AlreadyHit") then
				local Check = Instance.new("IntValue", hit.Parent)
				Check.Name = "AlreadyHit"
				game.Debris:AddItem(Check ,0.625)
				local vCharacter = Tool.Parent
				local vPlayer = game.Players:GetPlayerFromCharacter(vCharacter)
				local Humanoid = hit.Parent:WaitForChild("Humanoid")
				local sound = script.Hit:Clone()
				sound.Parent = hit.Parent
				sound:Play()
				TagHumanoid(Humanoid, vPlayer)
				Humanoid:TakeDamage(script.Parent.Damage.Value)
				wait(0.25)
				UntagHumanoid(Humanoid)
			end
	   end
	 end)
end)

function TagHumanoid(humanoid, player)
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = player
	creator_tag.Name = "creator"
	creator_tag.Parent = humanoid
end

function UntagHumanoid(humanoid)
	if humanoid ~= nil then
		local tag = humanoid:findFirstChild("creator")
		if tag ~= nil then
			tag.Parent = nil
		end
	end
end

while wait(1) do
	Time = Time + 1
	if Time == 0 then
		Time = 1
	end
end

