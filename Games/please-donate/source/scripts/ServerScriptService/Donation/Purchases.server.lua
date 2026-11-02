--[[
     Made by arxx pls nooo
]]

local _MarketPlace = game:GetService("MarketplaceService")
local _Replicated = game:GetService("ReplicatedStorage")
local _NumbersHelper = require(_Replicated.Common:FindFirstChild("NumberHelpers"))
local _Physic = game:GetService("PhysicsService")
local _SFX = game:GetService("SoundService").SFXSounds
local _NumberHelpers = require(game.ReplicatedStorage.Common.NumberHelpers)

local liveboard = workspace.MapUI.LiveDonations.Leaderboard

local currentBooth

-- functions
local function CreateDonation(player, amount, donated)
	local onek = script.DonationTemplates["1k"]:Clone()
	local tenk = script.DonationTemplates["10k"]:Clone()
	local hunk = tenk
	local hund = script.DonationTemplates["100"]:Clone()

	if amount >= 100 then
		hund.Donator.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420")
		hund.Donator.Username.Text = "@" .. player.Name
		hund.Reciever.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donated.UserId .. "&w=420&h=420")
		hund.Reciever.Username.Text = "@" .. donated.Name
		hund.Robux.AmountFrame.Amount.Text = _NumbersHelper.format(amount)
		hund.Parent = liveboard
		
		local bar = game.TweenService:Create(hund.Duration.MainBar, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0,0, 5)
		})
		
		bar:Play()
		
		bar.Completed:Connect(function()
			hund:Destroy()
		end)
	elseif amount >= 1000 then
		onek.Donator.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420")
		onek.Donator.Username.Text = "@" .. player.Name
		onek.Reciever.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donated.UserId .. "&w=420&h=420")
		onek.Reciever.Username.Text = "@" .. donated.Name
		onek.Robux.AmountFrame.Amount.Text = _NumbersHelper.format(amount)
		onek.Parent = liveboard

		local bar = game.TweenService:Create(onek.Duration.MainBar, TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0,0, 5)
		})

		bar:Play()

		bar.Completed:Connect(function()
			onek:Destroy()
		end)
	elseif amount >= 10000 then
		tenk.Donator.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420")
		tenk.Donator.Username.Text = "@" .. player.Name
		tenk.Reciever.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donated.UserId .. "&w=420&h=420")
		tenk.Reciever.Username.Text = "@" .. donated.Name
		tenk.Robux.AmountFrame.Amount.Text = _NumbersHelper.format(amount)
		tenk.Parent = liveboard

		local bar = game.TweenService:Create(tenk.Duration.MainBar, TweenInfo.new(40, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0,0, 5)
		})

		bar:Play()

		bar.Completed:Connect(function()
			tenk:Destroy()
		end)
	elseif amount >= 100000 then
		hunk.Donator.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420")
		hunk.Donator.Username.Text = "@" .. player.Name
		hunk.Reciever.Icon.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donated.UserId .. "&w=420&h=420")
		hunk.Reciever.Username.Text = "@" .. donated.Name
		hunk.Robux.AmountFrame.Amount.Text = _NumbersHelper.format(amount)
		hunk.Parent = liveboard

		local bar = game.TweenService:Create(hunk.Duration.MainBar, TweenInfo.new(50, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0,0, 5)
		})

		bar:Play()

		bar.Completed:Connect(function()
			hunk:Destroy()
		end)
	end
end

local function CreateNormal(player, amount, donated)
	local frame = script.LiveDonationFrames.NormalDonation:Clone()
	
		frame.Donator.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420")
		frame.Donator.Username.Text = "@" .. player.Name
		frame.Raiser.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donated.UserId .. "&w=420&h=420")
		frame.Raiser.Username.Text = "@" .. donated.Name
		frame.AmountFrame.Main.Amount.Text = _NumbersHelper.format(amount)
		frame.Parent = liveboard
		wait(10)
		frame:Destroy()
	
end

local function GetBooth(slot)
	for i,v in pairs(workspace.BoothModels:GetChildren()) do
		if v:IsA("Model") then
			if v:GetAttribute("BoothID") == slot then
				currentBooth = v
			end
		end
	end
end

function SpawnBlimp(donater, raiser, RobuxAmount)



	if workspace:GetAttribute('TotalBlimps') >= 100 then

		return

	end

	workspace:SetAttribute('TotalBlimps', workspace:GetAttribute('TotalBlimps') + 1) 

	local Blimp = _Replicated:WaitForChild('Templates'):WaitForChild('Blimp'):Clone()

	_Physic:SetPartCollisionGroup(Blimp, 'Blimp')

	for _, BlimpMesh in pairs(Blimp:GetChildren()) do

		if BlimpMesh:IsA('MeshPart') then

			if BlimpMesh.CanCollide then

				_Physic:SetPartCollisionGroup(BlimpMesh, 'Blimp')

			end

		end

	end

	Blimp.A.DonationFrame.Donator.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donater.UserId .. "&w=420&h=420")
	Blimp.A.DonationFrame.Donator.Username.Text = string.format('@%s', donater.Name)
	Blimp.A.DonationFrame.BoothOwner.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. raiser.UserId .. "&w=420&h=420")
	Blimp.A.DonationFrame.BoothOwner.Username.Text = string.format('@%s', raiser.Name)
	Blimp.A.DonationFrame.Robux.RobuxAmount.Price.Text = _NumbersHelper.formatCommas(RobuxAmount)
	Blimp.B.DonationFrame.Donator.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. donater.UserId .. "&w=420&h=420")
	Blimp.B.DonationFrame.Donator.Username.Text = string.format('@%s', donater.Name)
	Blimp.B.DonationFrame.BoothOwner.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=" .. raiser.UserId .. "&w=420&h=420")
	Blimp.B.DonationFrame.BoothOwner.Username.Text = string.format('@%s', raiser.Name)
	Blimp.B.DonationFrame.Robux.RobuxAmount.Price.Text = _NumbersHelper.formatCommas(RobuxAmount)
	Blimp.Parent = game:GetService('Workspace')

end

-- main ahh

_MarketPlace.PromptGamePassPurchaseFinished:Connect(function(player, assetid, ispurchased)
	if ispurchased then
		local success, responce = pcall(function()
			local data = _MarketPlace:GetProductInfo(assetid, Enum.InfoType.GamePass)
			if data then
				player:FindFirstChild("leaderstats").Donated.Value += data.PriceInRobux
				player:FindFirstChild("Cashbux").Value += math.floor(math.sqrt(tonumber(data.PriceInRobux)) * 5)
				-- Now we will be getting the booth's owner
				local DonatedUser = data.Creator.Name
				local User = game:GetService("Players")[DonatedUser]
				local truraised = _NumberHelpers.format(User:FindFirstChild("leaderstats").Raised.Value)
				User:FindFirstChild("leaderstats").Raised.Value += data.PriceInRobux
				local slot = User:GetAttribute("OwnedBooth")
				GetBooth(slot)
				currentBooth.BoothUI.Details.Raised.Text = string.format("" .. truraised .. " raised")
				-- Server donation messages
				if data.PriceInRobux <= 50 then
					_Replicated.Events.DonationMessages.Tip:FireAllClients(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup["50"]:FireClient(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup2["50"]:FireClient(User, player.Name, data.PriceInRobux)
					script.Parent.CreateDonationSFX:Fire(currentBooth.Base,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveCurrency", currentBooth.Base.Position,User.Character,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveGiftbux", currentBooth.Base.Position, player.Character, data.PriceInRobux)
					_SFX.DonationLevel1:Play()
					CreateNormal(player, data.PriceInRobux, User)
					SpawnBlimp(player, User, data.PriceInRobux)
				elseif data.PriceInRobux <= 999 then
					_Replicated.Events.DonationMessages.Grateful:FireAllClients(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup["100"]:FireClient(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup2["100"]:FireClient(User, player.Name, data.PriceInRobux)
					script.Parent.CreateDonationSFX:Fire(currentBooth.Base,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveCurrency", currentBooth.Base.Position,User.Character,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveGiftbux", currentBooth.Base.Position, player.Character, data.PriceInRobux)
					_SFX.DonationLevel2:Play()
					CreateDonation(player, data.PriceInRobux, User)
					game.ReplicatedStorage.Nukew:FireAllClients(player, User, data.PriceInRobux)
				elseif data.PriceInRobux <= 9999 then
					_Replicated.Events.DonationMessages.thousand:FireAllClients(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup["1000"]:FireClient(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup2["1000"]:FireClient(User, player.Name, data.PriceInRobux)
					script.Parent.CreateDonationSFX:Fire(currentBooth.Base,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveCurrency", currentBooth.Base.Position,User.Character,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveGiftbux", currentBooth.Base.Position, player.Character, data.PriceInRobux)
					_SFX.DonationLevel3:Play()
					CreateDonation(player, data.PriceInRobux, User)
					game.ReplicatedStorage.smiteasf:FireAllClients(player.UserId, player, User, data.PriceInRobux)
				elseif data.PriceInRobux <= 99999 then
					_Replicated.Events.DonationMessages.tenThousand:FireAllClients(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup["10000"]:FireClient(player, DonatedUser, data.PriceInRobux)
					_Replicated.Events.DonationMessages.Popup2["10000"]:FireClient(User, player.Name, data.PriceInRobux)
					script.Parent.CreateDonationSFX:Fire(currentBooth.Base,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveCurrency", currentBooth.Base.Position,User.Character,data.PriceInRobux)
					_Replicated.Templates.VFXObjects.CreateVfx:FireAllClients("GiveGiftbux", currentBooth.Base.Position, player.Character, data.PriceInRobux)
					_SFX.DonationLevel4:Play()
					CreateDonation(player, data.PriceInRobux, User)
				end
			end
		end)
		if responce then
			warn(responce)
		end
	end
end)