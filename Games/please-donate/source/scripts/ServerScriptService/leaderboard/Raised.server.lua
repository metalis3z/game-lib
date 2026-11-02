local ds = game:GetService("DataStoreService")

local TopRaisedODS = ds:GetOrderedDataStore("TopRaisedStats")

local timeUntilReset = 2
local nosaveplayer = {""}

while wait(1) do


	timeUntilReset = timeUntilReset - 1


	if timeUntilReset == 0 then

		timeUntilReset = 60


		for i, plr in pairs(game.Players:GetPlayers()) do
			if table.find(nosaveplayer,plr.Name) then
			else
				TopRaisedODS:SetAsync(plr.UserId, plr.leaderstats:WaitForChild("Raised", 10).Value)
			end

		end

		for i, leaderboardRank in pairs(workspace.MapUI.MostRaised.Leaderboard:GetChildren()) do

			if leaderboardRank.ClassName == "Frame" then
				leaderboardRank:Destroy()
			end
		end


		local success, errorMsg = pcall(function()

			local data = TopRaisedODS:GetSortedAsync(false, 50)
			local TopRaisedPage = data:GetCurrentPage()

			for rankInLB, dataStored in ipairs(TopRaisedPage) do
				
				local name
				local userid
				
				local success, errormsg = pcall(function()
					name = game.Players:GetNameFromUserIdAsync(tonumber(dataStored.key))
					userid = dataStored.key
				end)
				if not success then
					name = "Terminated User!"
					userid = 1
				end
				local RobuxRaised = dataStored.value


				local template = script.Template:Clone()

				--template.Name = name .. "Leaderboard"

				template.Info.Username.Text = "@" .. name
				
				if rankInLB == 1 then
					template.Info.Username.GoldGradient.Enabled = true
					template.Info.Username.SilverGradient.Enabled = false
					template.Info.Username.BronzeGradient.Enabled = false
				elseif rankInLB == 2 then
					template.Info.Username.GoldGradient.Enabled = false
					template.Info.Username.SilverGradient.Enabled = true
					template.Info.Username.BronzeGradient.Enabled = false
				elseif rankInLB == 3 then
					template.Info.Username.GoldGradient.Enabled = false
					template.Info.Username.SilverGradient.Enabled = false
					template.Info.Username.BronzeGradient.Enabled = true
				end
				
				template.Info.Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..userid.."&w=150&h=150" 

				template.Info.Rank.Text = rankInLB

				template.Stats.Raised.Text = "" .. require(game.ReplicatedStorage.Common.NumberHelpers).format(RobuxRaised)

				template.Parent = workspace.MapUI.MostRaised.Leaderboard
				
			end			
		end)
	end
end