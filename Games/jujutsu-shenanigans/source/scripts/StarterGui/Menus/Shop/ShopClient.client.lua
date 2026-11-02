local TS = game:GetService("TweenService")
local RS = game:GetService('ReplicatedStorage')
local MarketplaceService = game:GetService('MarketplaceService')
local SvSt = game:GetService("ServerStorage")

local Remotes = RS.Remotes
local ComRemotes = Remotes.Comunicator
local Comunicator = ComRemotes.Set
local EmotesFolder = RS.Assets.Emotes

local Player = game.Players.LocalPlayer

local shop = script.Parent
local Categories = script.Parent:WaitForChild("Categories", 5)
local Items = script.Parent:WaitForChild("Items", 5)

local function SoundTalk(Time2, Time3)
	local talk = script.Talk
	local Fun = false
	
	task.delay(Time3, function()
		Fun = true
	end)
	
	while task.wait(Time2) and Fun == false do
		talk:Play()
	end
end

shop.Keeper.Button.MouseButton1Down:Connect(function()
	local TextRNG = script.HurtTexts["Text"..math.random(1, 6)]
	shop.Text.TextLabel.Text = TextRNG.Value

	local boop = script.Boop
	boop:Play()
end)

local codeEvent = Remotes:WaitForChild("Code")

local codeInput = Items.Rewards.TextBox
local submitButton = Items.Rewards.TextBox.Redeem

local function onSubmitButtonClicked()
	local enteredCode = codeInput.Text
	codeEvent:FireServer(enteredCode)
end

codeEvent.OnClientEvent:Connect(function(response)
	print(response)
end)

submitButton.MouseButton1Click:Connect(onSubmitButtonClicked)

Categories.Gamepass.MouseButton1Down:Connect(function()
	local Selected = Categories.Gamepass.Select
	local serversel = Categories.Shop.Select
	local codeselect = Categories.Code.Select
	local PlayersSettings = Items.Gamepass
	local serverSettings = Items.Shop
	local codeSettings = Items.Rewards

	--print("gamepass")
	
	Selected.Visible = true
	PlayersSettings.Visible = true
	
	if serversel.Visible == true then
		serversel.Visible = false
	end
	
	if codeselect.Visible == true then
		codeselect.Visible = false
	end

	if codeSettings.Visible == true then
		codeSettings.Visible = false
	end

	if serverSettings.Visible == true then
		serverSettings.Visible = false
	end
end)

Categories.Shop.MouseButton1Down:Connect(function()
	local Selected = Categories.Shop.Select
	local serversel = Categories.Gamepass.Select
	local codeselect = Categories.Code.Select
	local PlayersSettings = Items.Shop
	local serverSettings = Items.Gamepass
	local codeSettings = Items.Rewards

	--print("shop")

	Selected.Visible = true
	PlayersSettings.Visible = true
	
	if serversel.Visible == true then
		serversel.Visible = false
	end
	
	if codeselect.Visible == true then
		codeselect.Visible = false
	end
	
	if codeSettings.Visible == true then
		codeSettings.Visible = false
	end

	if serverSettings.Visible == true then
		serverSettings.Visible = false
	end
end)

Categories.Code.MouseButton1Down:Connect(function()
	local Selected = Categories.Code.Select
	local serversel = Categories.Gamepass.Select
	local codeselect = Categories.Shop.Select
	local PlayersSettings = Items.Rewards
	local serverSettings = Items.Shop
	local codeSettings = Items.Gamepass

	--print("gamepass")

	Selected.Visible = true
	PlayersSettings.Visible = true

	if serversel.Visible == true then
		serversel.Visible = false
	end

	if codeselect.Visible == true then
		codeselect.Visible = false
	end

	if codeSettings.Visible == true then
		codeSettings.Visible = false
	end

	if serverSettings.Visible == true then
		serverSettings.Visible = false
	end
end)

local anim = false

Items.Shop.Emote.Purchase.Cash.MouseButton1Down:Connect(function()
	local money = Player:WaitForChild("leaderstats").Hidden.Money
	
	if money.Value >= 250 then
		Comunicator:FireServer('SpinEmote', Player) --{ Msg = 'You were kicked for trying to unmute yourself.' }
	else
		print("Noob >:(")
	end
end)

Items.Shop.Emote.Purchase.Robux.MouseButton1Down:Connect(function()-- ts (this) works it doenst pmo without a balkan crashout (808)
	local productId = 12345678 -- Replace this wit id

	-- Prompt the purchase for the player
	MarketplaceService:PromptProductPurchase(Player, productId)

	
	print("purchase has begun idk bro", productId)
end)

while task.wait(0.01) do
	if shop.Visible == true then
		local shoper = shop:WaitForChild("Keeper")
		
		local any = shoper.Skibidi.Model.Humanoid.Animator:LoadAnimation(shoper.Skibidi.Model.Anims["Anim"..math.random(1, 2)])
		
		if anim == false then
			any:Play()
			
			anim = true
			
			task.delay(any.Length - 0.1, function()
				any:AdjustSpeed(0)
			end)
		end
		
		task.delay(0.85, function()
			shop.Text.Visible = true
			if shop.Text.TextLabel.Text == "" then
				local TextRNG = script.Texts["Text"..math.random(1, 6)]
				shop.Text.TextLabel.Text = TextRNG.Value
			end
		end)
		
	else 
		if anim == true then
			anim = false
		end
		
		if shop.Text.Visible == true then
			shop.Text.Visible = false
			shop.Text.TextLabel.Text = ""
		end
	end
end





