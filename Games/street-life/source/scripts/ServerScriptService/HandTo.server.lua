local Settings = {
	Prefix = "/",
	Group = 0,
	Rank = 0,
}

function GetWords(Msg,Pattern)
	local Words = {}
	for w in string.gmatch(Msg, Pattern) do
		table.insert(Words,w)
	end
	return Words
end

local unpassable = {'Fist', 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool', 'Box'}

local ChatFunctions = {
	["handto"] = function(Words,Player)
			for _,Target in pairs(game.Players:GetPlayers()) do
				if string.find(string.lower(Target.Name),string.lower(Words[2])) then
					local Tool = Player.Character:FindFirstChildOfClass("Tool")
					local Human = Player.Character:FindFirstChildOfClass("Humanoid")
					if Tool and Human and Human.Health ~= 0 and not Tool:FindFirstChild("Rank") and not table.find(unpassable,Tool.Name) and not Tool:FindFirstChild('POLICE') then
						Human:UnequipTools()
						wait()
						Tool.Parent = Target.Backpack
					end
				end
				wait()
			end
	end,
}

game.Players.PlayerAdded:Connect(function(Player)
	if Player:GetRankInGroup(Settings.Group) >= Settings.Rank then
		Player.Chatted:Connect(function(Message)
			if string.sub(Message,1,1) == Settings.Prefix then
				local Command = GetWords(string.sub(Message,2),"[%w_]+")
				if ChatFunctions[Command[1]] then
					ChatFunctions[Command[1]](Command,Player)
				end
			end
		end)
	end
end)


game:FindService('ReplicatedStorage'):FindFirstChild('HAA').OnServerEvent:Connect(function(plr,who,from,tool)
	local character = plr.Character
	local head = plr.Character:WaitForChild("HumanoidRootPart")
	local origin = head.Position
	local lookDirection = head.CFrame.lookVector
	local ray = Ray.new(origin, lookDirection * 50)

	local part, hitPosition = workspace:FindPartOnRay(ray, character)

	if not part then return end 
	local partparent = part.Parent

	if part.Parent:FindFirstChild("Humanoid") then
		if plr ~= who then
			if tool:IsA("Tool") and tool.Parent == plr.Backpack then
				if tool:FindFirstChild('POLICE') then return end
				if plr.Character.Humanoid.Health <= 0 then return end	
				wait(.4)
				local Char = plr.Character:FindFirstChild("HumanoidRootPart")
				if (Char.Position - who.HumanoidRootPart.Position).magnitude < 5 then			
					local plrer = game.Players:GetPlayerFromCharacter(who)
					tool.Parent = plrer.Backpack
				end
			end
		end
	end
end)