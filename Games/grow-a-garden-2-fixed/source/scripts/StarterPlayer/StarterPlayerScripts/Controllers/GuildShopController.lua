--credit to leon games studio
local t = {}
local GuildShop = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GuildShop")
local v1 = GuildShop:WaitForChild("MainFrame"):WaitForChild("Content")
local CurrentFrame = v1:WaitForChild("CurrentFrame")
local PayoutFrame = v1:WaitForChild("PayoutFrame")
local Prizes = PayoutFrame:WaitForChild("Prizes")
local TemplateFrame = Prizes:WaitForChild("TemplateFrame")
local Prizes2 = CurrentFrame:WaitForChild("Prizes")
local TemplateFrame2 = Prizes2:WaitForChild("TemplateFrame")
local ReplicatedStorage = game.ReplicatedStorage
local SeedPackData = require(ReplicatedStorage.SharedModules.SeedPackData)
local GearShopData = require(ReplicatedStorage.SharedModules.GearShopData)
local EggData = require(ReplicatedStorage.SharedModules.EggData)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local Gradients = ReplicatedStorage.SharedModules.RarityData.Gradients
local RefreshIn = PayoutFrame:WaitForChild("RefreshIn")
local RefreshIn2 = CurrentFrame:WaitForChild("RefreshIn")

local function abbreviate(p1) --[[ abbreviate | Line: 41 ]]
	local v1 = tonumber(p1)

	if not v1 then
		return tostring(p1)
	end

	local t = { "", "K", "M", "B", "T" }
	local count = 1

	while math.abs(v1) >= 1000 and count < #t do
		v1 = v1 / 1000
		count = count + 1
	end

	return string.format("%.3f", v1):gsub("%.?0+$", "") .. t[count]
end

local v2 = 0
local v3 = false

function ToggleUpdate(p1) --[[ ToggleUpdate | Line: 62 | Upvalues: v2 (ref), v3 (ref), t (copy) ]]
	task.spawn(function() --[[ Line: 64 | Upvalues: v2 (ref), p1 (copy), v3 (ref), t (ref) ]]
		v2 = v2 + 1

		if p1 == true and v3 == false then
			v3 = true

			while v2 == v2 do
				t:SetProjectedTimer()
				t:SetThisWeekTimer()
				task.wait(0.5)
			end
		end

		v3 = p1
	end)
end
function t.Init(p1) --[[ Init | Line: 82 | Upvalues: t (copy), GuildShop (copy) ]]
	t:SetProjectedPayoutFrame({
		{
			Name = "Jump Mushroom",
			Cost = 20
		},
		{
			Name = "Uncommon Seed Pack",
			Cost = 80
		},
		{
			Name = "Legendary Sprinkler",
			Cost = 500
		},
		{
			Name = "Epic Egg",
			Cost = 2000
		},
		{
			Name = "Super Seed Pack",
			Cost = 4000
		}
	}, 2, 1200)
	t:SetLastWeekFrame({
		{
			Name = "Jump Mushroom",
			Cost = 20
		},
		{
			Name = "Uncommon Seed Pack",
			Cost = 80
		},
		{
			Name = "Legendary Sprinkler",
			Cost = 500
		},
		{
			Name = "Epic Egg",
			Cost = 2000
		},
		{
			Name = "Super Seed Pack",
			Cost = 4000
		}
	}, 1, 1200)

	if GuildShop.Enabled == true then
		ToggleUpdate(true)
	end

	GuildShop:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 138 | Upvalues: GuildShop (ref) ]]
		if GuildShop.Enabled == true then
			ToggleUpdate(true)
		else
			ToggleUpdate(false)
		end
	end)
end

local function formatCountdown(p1) --[[ formatCountdown | Line: 154 ]]
	local v1 = math.floor(p1 / 86400)
	local v2 = math.floor(p1 % 86400 / 3600)
	local v3 = math.floor(p1 % 3600 / 60)

	if v1 > 0 then
		return string.format("%dd %dh", v1, v2)
	end

	if v2 > 0 then
		return string.format("%dh %dm", v2, v3)
	end

	return string.format("%dm %ds", v3, p1 % 60)
end

local function timeUntilFriday(p1) --[[ timeUntilFriday | Line: 169 ]]
	local v3 = os.date("!*t", os.time() + -18000)
	local sum = (6 - v3.wday) % 7 * 86400 + (50400 - (v3.hour * 3600 + v3.min * 60 + v3.sec))

	if sum <= 0 then
		sum = sum + 604800
	end

	return sum + (p1 or 0) * 7 * 86400
end

function t.SetProjectedTimer(p1) --[[ SetProjectedTimer | Line: 185 | Upvalues: RefreshIn (copy), formatCountdown (copy), timeUntilFriday (copy) ]]
	RefreshIn.Timer.Text = "Opens in: " .. formatCountdown((timeUntilFriday(0)))
end
function t.SetThisWeekTimer(p1) --[[ SetThisWeekTimer | Line: 189 | Upvalues: RefreshIn2 (copy), formatCountdown (copy), timeUntilFriday (copy) ]]
	RefreshIn2.Timer.Text = "Expires in: " .. formatCountdown((timeUntilFriday(0)))
end
function t.SetProjectedPayoutFrame(p1, p2, p3, p4) --[[ SetProjectedPayoutFrame | Line: 193 | Upvalues: Prizes (copy), PayoutFrame (copy), abbreviate (copy), GearShopData (copy), SeedPackData (copy), EggData (copy), SeedData (copy), TemplateFrame (copy), Gradients (copy) ]]
	for k, v in pairs(Prizes:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "TemplateFrame" then
			v:Destroy()
		end
	end

	if p4 then
		PayoutFrame.BeanstalkFrame.Amount.Text = abbreviate(p4)
		PayoutFrame.BeanstalkFrame.Amount.TextLabel.Text = PayoutFrame.BeanstalkFrame.Amount.Text
	end

	for k, v in pairs(p2) do
		local v1 = nil
		local v2 = nil

		for k2, v3 in pairs(GearShopData.Data) do
			if v3.ItemName == v.Name then
				v1 = v3.IMG.Value
				v2 = v3.Rarity

				break
			end
		end

		if v1 == nil and string.find(v.Name, "Seed Pack") then
			local v3 = SeedPackData.GetData(v.Name)

			v1 = v3.IMG
			v2 = v3.Rarity
		end

		if v1 == nil then
			local v4 = EggData.GetData(v.Name)

			if v4 then
				v1 = v4.IMG
				v2 = v4.Rarity
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(SeedData) do
				if v3.SeedName == v then
					v1 = v3.SeedImage.Value
					v2 = v3.Rarity

					break
				end
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(game.ReplicatedStorage.SharedModules:GetDescendants()) do
				if v3.Name == v.Name and v3:IsA("StringValue") then
					v1 = v3.Value

					break
				end
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(game.ReplicatedStorage.SharedModules.GuildCrateData.GuildCrateImages:GetChildren()) do
				if v3.Name == v.Name then
					v1 = v3.Value
				end
			end
		end

		local v5 = TemplateFrame:Clone()

		if v1 then
			v5.Vector.Image = v1
		end

		v5.BuyButton.HolderFrame.TextLabel.TextLabel.Text = abbreviate(v.Cost) .. "\194\162"
		v5.BuyButton.HolderFrame.TextLabel.Text = abbreviate(v.Cost) .. "\194\162"
		v5.LayoutOrder = tonumber(v.Cost)

		local v7 = Gradients:FindFirstChild(v2)

		if v7 then
			local v8 = v7:Clone()

			v8.Parent = v5

			if v7.Name == "Super" or v7.Name == "Secret" then
				v8:AddTag("InfiniteGradient")
			end
		end

		v5.Parent = Prizes
		v5.Visible = true

		continue
	end

	PayoutFrame.Description.Text = "Week " .. tostring(p3)
end
function t.SetLastWeekFrame(p1, p2, p3, p4) --[[ SetLastWeekFrame | Line: 321 | Upvalues: Prizes2 (copy), CurrentFrame (copy), abbreviate (copy), GearShopData (copy), SeedPackData (copy), EggData (copy), SeedData (copy), TemplateFrame2 (copy), Gradients (copy) ]]
	for k, v in pairs(Prizes2:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "TemplateFrame" then
			v:Destroy()
		end
	end

	if p4 then
		CurrentFrame.BeanstalkFrame.Amount.Text = abbreviate(p4)
		CurrentFrame.BeanstalkFrame.Amount.TextLabel.Text = CurrentFrame.BeanstalkFrame.Amount.Text
	end

	for k, v in pairs(p2) do
		local v1 = nil
		local v2 = nil

		for k2, v3 in pairs(GearShopData.Data) do
			if v3.ItemName == v.Name then
				v1 = v3.IMG.Value
				v2 = v3.Rarity

				break
			end
		end

		if v1 == nil and string.find(v.Name, "Seed Pack") then
			local v3 = SeedPackData.GetData(v.Name)

			v1 = v3.IMG
			v2 = v3.Rarity
		end

		if v1 == nil then
			local v4 = EggData.GetData(v.Name)

			if v4 then
				v1 = v4.IMG
				v2 = v4.Rarity
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(SeedData) do
				if v3.SeedName == v then
					v1 = v3.SeedImage.Value
					v2 = v3.Rarity

					break
				end
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(game.ReplicatedStorage.SharedModules:GetDescendants()) do
				if v3.Name == v.Name and v3:IsA("StringValue") then
					v1 = v3.Value

					break
				end
			end
		end

		if v1 == nil then
			for k2, v3 in pairs(game.ReplicatedStorage.SharedModules.GuildCrateData.GuildCrateImages:GetChildren()) do
				if v3.Name == v.Name then
					v1 = v3.Value
				end
			end
		end

		local v5 = TemplateFrame2:Clone()

		if v1 then
			v5.Vector.Image = v1
		end

		v5.BuyButton.HolderFrame.TextLabel.TextLabel.Text = abbreviate(v.Cost) .. "\194\162"
		v5.BuyButton.HolderFrame.TextLabel.Text = abbreviate(v.Cost) .. "\194\162"
		v5.LayoutOrder = tonumber(v.Cost)

		local v7 = Gradients:FindFirstChild(v2)

		if v7 then
			local v8 = v7:Clone()

			v8.Parent = v5

			if v7.Name == "Super" or v7.Name == "Secret" then
				v8:AddTag("InfiniteGradient")
			end
		end

		v5.Parent = Prizes2
		v5.Visible = true

		continue
	end

	CurrentFrame.Description.Text = "Week " .. tostring(p3)
end

return t