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

local unpassable = {"Box","Package","BOX"}

local ChatFunctions = {
	["passto"] = function(Words,Player)
			for _,Target in pairs(game.Players:GetPlayers()) do
				if string.find(string.lower(Target.Name),string.lower(Words[2])) then
					local Tool = Player.Character:FindFirstChildOfClass("Tool")
					local Human = Player.Character:FindFirstChildOfClass("Humanoid")
					if Tool and Human and Human.Health ~= 0 and not Tool:FindFirstChild("Rank") and not table.find(unpassable,Tool.Name) then
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
