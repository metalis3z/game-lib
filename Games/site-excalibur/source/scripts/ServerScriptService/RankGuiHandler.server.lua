--// Variables

Players = game:GetService("Players")
Teams = game:GetService("Teams")

game:GetService("Players").PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)

		local Nametag = script.Rank:Clone()
		Nametag.Parent = Player.Character.Head
		Nametag.Adornee = Player.Character.Head
		local PlayerName = Nametag.Background.UserN
		local PlayerRank = Nametag.Background.Rank

		PlayerName.Text = Player.Name
		
--// Groups/Teams		

		local MainGroups = {
			
			["Department of External Affairs"] = 15457226,
			["Ethics Committee"] = 15457447,
			["Medical Department"] = 15457312,
			["Foundation Personnel"] = 15349810,
			["GRU-P"] = 10432357,
			["Global Occult Coalition"] = 13331770,
			["Mobile Task Forces"] = 15408252,
			["Scientific Department"] = 15457335,
			["Security Department"] = 15451980,
			["Engineering And Technical Service"] = 15457384,
			
			--["Intelligence Agency"] = 15457281
		}
		local SpecialGroups = {
		--	["Anomaly Actors"] = "",
		["Intelligence Agency"] = "[REDACTED]",
		--	["Internal Affairs Department"] = "[REDACTED]"
		 	["sususu"] = "[Naval Special Operations Strike Group 12]",
		}
		local GuestRank = {
		--	["Administrative Department"] = "Administrative Department",
			["Department of External Affairs"] = "DEA",
			["Ethics Committee"] = "EC",
			["Medical Department"] = "MD",
			["Foundation Personnel"] = "FP",
			["GRU-P"] = "GRU-P",
			["Global Occult Coalition"] = "GOC",
			["Mobile Task Forces"] = "MTF",
			["Scientific Department"] = "SCD",
			["Security Department"] = "SD",
			["Engineering And Technical Service"] = "E&T",
		}
		
--// Main

		Character:WaitForChild("Humanoid").NameDisplayDistance = 0
		Character:WaitForChild("Humanoid").HealthDisplayDistance = 0

		if SpecialGroups[Player.Team.Name] then
			PlayerName.Text = SpecialGroups[Player.Team.Name]
			PlayerName.TextColor3 = Player.TeamColor.Color
			PlayerRank.Text = ""
		end

		if MainGroups[Player.Team.Name] then
			if Player:GetRankInGroup(MainGroups[Player.Team.Name]) ~= 0 then
				PlayerRank.Text = Player:GetRoleInGroup(MainGroups[Player.Team.Name])
				PlayerRank.TextColor3 = Player.TeamColor.Color
			else
				PlayerRank.Text = GuestRank[Player.Team.Name]
				PlayerRank.TextColor3 = Player.TeamColor.Color
			end
		else
			if Player.Team == Teams["Class D"]
			then 
				PlayerRank.Text = "Class D"
				PlayerRank.TextColor3 = Player.TeamColor.Color
			end
		end
	end)
end)