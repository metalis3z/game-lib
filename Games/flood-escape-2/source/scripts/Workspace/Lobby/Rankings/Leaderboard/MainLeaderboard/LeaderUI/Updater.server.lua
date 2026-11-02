local DataStoreService = game:GetService("DataStoreService")
local MonthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local UI = script.Parent
local Leaderboard = UI.Content.Leaderboards.PrevMonth
local Ranks = Leaderboard.Ranks
local PhysicsService = game:GetService("PhysicsService")
PhysicsService:RegisterCollisionGroup("Bob")
PhysicsService:CollisionGroupSetCollidable("Bob","Bold",false)

local function SetNewLeader()
	--gets current month
	local dateValue = os.date("!*t")
	local CurrentMonth = MonthNames[dateValue["month"]-1]
	local CurrentYear = dateValue["year"]
	--Main stuff
	local CurrentMonthLeaderStats
	local s, e = pcall(function()
		CurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
	end)
	if s then
		local s_pages, pages = pcall(function()
			return CurrentMonthLeaderStats:GetSortedAsync(false, 20)
		end)
		if s_pages and pages then
			--print("Loaded Last Month LeaderStats!")
			local data = pages:GetCurrentPage()
			local a = 1
			for _, item	in pairs(data) do
				if a == 1 then
					local id = game.Players:GetUserIdFromNameAsync(item.key)
					local firstPlaceChar = game.Players:GetHumanoidDescriptionFromUserId(id)
					firstPlaceChar.BodyTypeScale = 0
					firstPlaceChar.DepthScale = 1
					firstPlaceChar.HeadScale = 1
					firstPlaceChar.HeightScale = 1
					firstPlaceChar.ProportionScale = 0
					firstPlaceChar.WidthScale = 1
					firstPlaceChar = game.Players:CreateHumanoidModelFromDescription(firstPlaceChar, Enum.HumanoidRigType.R6)
					local p = CFrame.new(-13.1937904, -128.300095, -49.0791092, -0.906296492, 0, 0.422642022, 0, 1, 0, -0.422642022, 0, -0.906296490) + Vector3.new(0, 3, 0)
					local humanoid_rank1 = workspace.Lobby.Rankings.Podium.TopPlayers.Rank1.Humanoid:Clone()
					workspace.Lobby.Rankings.Podium.TopPlayers.Rank1:Destroy()
					local h = firstPlaceChar:FindFirstChild("Humanoid") :: Humanoid
					if h ~= nil then
						h:Destroy()
						humanoid_rank1.Parent = firstPlaceChar
					end
					for i, v in pairs(firstPlaceChar:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CollisionGroup = "Bob"
							v.CanCollide = true
						end
					end
					firstPlaceChar.Name = "Rank1"
					firstPlaceChar.PrimaryPart = firstPlaceChar.HumanoidRootPart
					firstPlaceChar.PrimaryPart.CFrame = p
					firstPlaceChar.Parent = workspace.Lobby.Rankings.Podium.TopPlayers
				elseif a == 2 then
					local id = game.Players:GetUserIdFromNameAsync(item.key)
					local secPlaceChar = game.Players:GetHumanoidDescriptionFromUserId(id)
					secPlaceChar.BodyTypeScale = 0
					secPlaceChar.DepthScale = 1
					secPlaceChar.HeadScale = 1
					secPlaceChar.HeightScale = 1
					secPlaceChar.ProportionScale = 0
					secPlaceChar.WidthScale = 1
					secPlaceChar = game.Players:CreateHumanoidModelFromDescription(secPlaceChar, Enum.HumanoidRigType.R6)
					local p = workspace.Lobby.Rankings.Podium.TopPlayers.Rank2.PrimaryPart.CFrame
					local humanoid_rank1 = workspace.Lobby.Rankings.Podium.TopPlayers.Rank3.Humanoid:Clone()
					workspace.Lobby.Rankings.Podium.TopPlayers.Rank2:Destroy()
					local h = secPlaceChar:FindFirstChild("Humanoid") :: Humanoid
					if h ~= nil then
						h:Destroy()
						humanoid_rank1.Parent = secPlaceChar
					end
					for i, v in pairs(secPlaceChar:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CollisionGroup = "Bob"
						end
					end
					secPlaceChar.Name = "Rank2"
					secPlaceChar.PrimaryPart = secPlaceChar.HumanoidRootPart
					secPlaceChar.PrimaryPart.CFrame = p
					secPlaceChar.Parent = workspace.Lobby.Rankings.Podium.TopPlayers
				elseif a == 3 then
					local id = game.Players:GetUserIdFromNameAsync(item.key)
					local secPlaceChar = game.Players:GetHumanoidDescriptionFromUserId(id)
					secPlaceChar.BodyTypeScale = 0
					secPlaceChar.DepthScale = 1
					secPlaceChar.HeadScale = 1
					secPlaceChar.HeightScale = 1
					secPlaceChar.ProportionScale = 0
					secPlaceChar.WidthScale = 1
					secPlaceChar = game.Players:CreateHumanoidModelFromDescription(secPlaceChar, Enum.HumanoidRigType.R6)
					local p = workspace.Lobby.Rankings.Podium.TopPlayers.Rank3.PrimaryPart.CFrame
					local humanoid_rank1 = workspace.Lobby.Rankings.Podium.TopPlayers.Rank3.Humanoid:Clone()
					workspace.Lobby.Rankings.Podium.TopPlayers.Rank3:Destroy()
					local h = secPlaceChar:FindFirstChild("Humanoid") :: Humanoid
					if h ~= nil then
						h:Destroy()
						humanoid_rank1.Parent = secPlaceChar
					end
					for i, v in pairs(secPlaceChar:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CollisionGroup = "Bob"
						end
					end
					secPlaceChar.Name = "Rank3"
					secPlaceChar.PrimaryPart = secPlaceChar.HumanoidRootPart
					secPlaceChar.PrimaryPart.CFrame = p
					secPlaceChar.Parent = workspace.Lobby.Rankings.Podium.TopPlayers
				end
				Ranks[`Rank{tostring(a)}`].PlayerName.Text = item.key
				Ranks[`Rank{tostring(a)}`].XPEarned.Text = item.value
				a += 1
			end
		end
	else
		error(e)
		return
	end
end

SetNewLeader()
while wait(60) do
	SetNewLeader()
end