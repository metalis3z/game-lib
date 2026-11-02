local FakePurchase = {}


local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PurchasePromptApp

task.spawn(function()
	PurchasePromptApp = script:WaitForChild("PurchasePromptApp")
	PurchasePromptApp.Name = "ㅤ"

	local assetsToPreload = {}

	for _, item in pairs(script:GetDescendants()) do
		if (item:IsA("ImageLabel") or item:IsA("TextButton")) and item.Image ~= "" then
			table.insert(assetsToPreload, item)
		end
	end	

	ContentProvider:PreloadAsync(assetsToPreload)
end)

local ClientSet = ReplicatedStorage:WaitForChild("ClientSet")

local Animator = require(script.Animator)

local robux = math.random(100000, 1000000)
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function formatNumber(num)
	local formatted = tostring(num)
	local k
	repeat
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
	until k == 0
	local finalformatted = "" .. formatted
	return finalformatted
end

ClientSet:Fire(robux)

function FakePurchase:AlreadyExists()
	local mainPrompt = PlayerGui:FindFirstChild("PurchasePromptApp")

	if not mainPrompt then
		return false
	end

	return mainPrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt")
end

function FakePurchase:SetRobux(amount)
	ClientSet:Fire(amount)
	robux = amount
end

function FakePurchase:GetRobux()
	return tostring(robux)
end

function FakePurchase:Create(productId, isGamepass, isNew, alreadyOwns)
	if FakePurchase:AlreadyExists() then
		return false
	end

	local connections = {}
	local purchaseResult = Instance.new("BindableEvent")
	local hasResult = false

	local purchaseGui = PlayerGui:FindFirstChild("PurchasePromptApp")
	if not purchaseGui then
		purchaseGui = PurchasePromptApp:Clone()
		purchaseGui.Name = "PurchasePromptApp"
		purchaseGui.Parent = PlayerGui
	end

	local animator = purchaseGui.ProductPurchaseContainer.Animator
	animator.Position = UDim2.fromScale(0, -1)

	local overlay = Instance.new("Frame")
	overlay.Name = "DarkOverlay"
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.Position = UDim2.fromScale(0, 0)
	overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	overlay.BackgroundTransparency = 1
	overlay.BorderSizePixel = 0
	overlay.ZIndex = purchaseGui.ProductPurchaseContainer.ZIndex - 1
	overlay.Parent = purchaseGui

	task.delay(0.2, function()
		TweenService:Create(overlay, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.4
		}):Play()
	end)
	local ModalFix = script.ModalFix:Clone()
	ModalFix.Parent = animator
	ModalFix.Visible = true
	

	local function cleanup(animator)
		if overlay and overlay.Parent then
			local fadeTween = TweenService:Create(overlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 1
			})
			fadeTween:Play()
			fadeTween.Completed:Once(function()
				if overlay and overlay.Parent then
					overlay:Destroy()
				end
			end)
		end

		Animator(animator, {
			startValue = 0,
			endValue = -1,
			property = "Position",
			springConfig = {
				dampingRatio = 1,
				frequency = 1.6,
			},
			map = function(value)
				return UDim2.new(0, 0, value, 0)
			end
		})

		repeat
			task.wait()
		until animator.Position == UDim2.fromScale(0, -1)

		for _, connection in ipairs(connections) do
			connection:Disconnect()
		end

		connections = {}

		if ModalFix then
			ModalFix:Destroy()
		end

		local Prompt = purchaseGui.ProductPurchaseContainer.Animator:FindFirstChild("Prompt")
		if Prompt then
			Prompt:Destroy()
		end
	end

	local function isPositionInsideGui(guiObject, position)
		if not guiObject or not guiObject:IsA("GuiObject") or not guiObject.Parent then
			return false
		end

		if GuiService.SelectedObject then
			return true
		end

		local guiPos = guiObject.AbsolutePosition
		local guiSize = guiObject.AbsoluteSize
		return position.X >= guiPos.X and position.X <= guiPos.X + guiSize.X and
			position.Y >= guiPos.Y and position.Y <= guiPos.Y + guiSize.Y
	end

	if alreadyOwns then
		if purchaseGui and purchaseGui.ProductPurchaseContainer then
			purchaseResult:Destroy()

			task.delay(0.2, function()
				Animator(animator, {
					startValue = 1,
					endValue = 0,
					property = "Position",
					springConfig = {
						dampingRatio = 1,
						frequency = 1.6,
					},
					map = function(value)
						return UDim2.new(0, 0, -1 * value, 0)
					end
				})
			end)

			local Finish = script.Finish:Clone()
			Finish.Name = "Prompt"
			Finish.Parent = animator
			Finish.Visible = true
			Finish.AlertContents.TitleContainer.TitleArea.Title.Text = "Error"
			Finish.AlertContents.MiddleContent.Content.BodyText.Text = "You already own this item. Your account has not been charged."
			local successButton = Finish.AlertContents.Footer.Buttons["1"]
			local isMouseDownOnSuccess = false

			task.delay(1, function()
				if GuiService.SelectedObject then
					GuiService.SelectedObject = successButton
				end
			end)

			if UserInputService.TouchEnabled then
				local isTouchingSuccess = false

				table.insert(connections, successButton.InputBegan:Connect(function(successInput)
					if successInput.UserInputType == Enum.UserInputType.Touch then
						isTouchingSuccess = true
						successButton.ImageTransparency = 0.5
						successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0.5
					end
				end))

				local successConnections = {}
				table.insert(successConnections, UserInputService.InputEnded:Connect(function(successInput)
					if successInput.UserInputType == Enum.UserInputType.Touch and isTouchingSuccess then
						isTouchingSuccess = false
						successButton.ImageTransparency = 0
						successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0

						if isPositionInsideGui(successButton, successInput.Position) then
							cleanup(animator)
							for _, conn in ipairs(successConnections) do
								conn:Disconnect()
							end
						end
					end
				end))
			else
				table.insert(connections, successButton.MouseButton1Down:Connect(function()
					isMouseDownOnSuccess = true
					successButton.ImageTransparency = 0.5
					successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0.5
				end))

				local successEndedConn
				successEndedConn = UserInputService.InputEnded:Connect(function(endedInput)
					if endedInput.UserInputType ~= Enum.UserInputType.MouseButton1 and not GuiService.SelectedObject then return end

					if isMouseDownOnSuccess then
						isMouseDownOnSuccess = false
						successButton.ImageTransparency = 0
						successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0

						if isPositionInsideGui(successButton, endedInput.Position) then
							cleanup(animator)
						end
					end
				end)
				table.insert(connections, successEndedConn)
			end

			table.insert(connections, GuiService.MenuOpened:Once(function()
				if not purchaseGui then return end

				local activeAnimator = purchaseGui.ProductPurchaseContainer:FindFirstChild("Animator")
				if not activeAnimator then return end

				local currentPrompt = activeAnimator:FindFirstChild("Prompt")
				if not currentPrompt then return end

				task.wait(0.012)

				cleanup(activeAnimator)
			end))
		end

		return false
	end

	local Start
	if isNew then
		Start = script.StartNew:Clone()
	else
		Start = script.Start:Clone()
	end

	Start.Name = "Prompt"
	Start.Parent = animator
	Start.Visible = true

	if not isNew then
		animator.Prompt.AlertContents.Footer.FooterContent.Content.Amount.Text = string.format("Your balance after this transaction will be %s", FakePurchase:GetRobux())
	end

	local productType = Enum.InfoType.Product
	if isGamepass then
		productType = Enum.InfoType.GamePass
	end

	local FALLBACK_PRICE = 199
	local okInfo, fetched = pcall(function()
		return MarketplaceService:GetProductInfo(productId, productType)
	end)
	local productInfo = (okInfo and fetched) or {}
	if type(productInfo) ~= "table" then
		productInfo = {}
	end
	if productInfo.PriceInRobux == nil then
		productInfo.PriceInRobux = FALLBACK_PRICE
	end
	if productInfo.Name == nil then
		productInfo.Name = "Craft Now"
	end
	if productInfo.IconImageAssetId == nil then
		productInfo.IconImageAssetId = 0
	end

	local FirstButton = animator.Prompt.AlertContents.Footer.Buttons["1"]
	local SecondButton = animator.Prompt.AlertContents.Footer.Buttons["2"]

	if isNew then
		local buttonText = SecondButton.ButtonContent.ButtonMiddleContent.Buy
		buttonText.Text = "Buy"
	else
		local buttonText = SecondButton.ButtonContent.ButtonMiddleContent.Text
		buttonText.Text = formatNumber(productInfo.PriceInRobux)
	end

	if isNew then
		local itemNameText = animator.Prompt.AlertContents.MiddleContent.Content.ItemDetailsFrame.ItemName
		itemNameText.Text = productInfo.Name

		local priceText = animator.Prompt.AlertContents.MiddleContent.Content.ItemDetailsFrame.Price
		priceText.Text = formatNumber(productInfo.PriceInRobux)

		local titleItemName = animator.Prompt.AlertContents.TitleContainer.TitleArea.Title.RobuxBalance
		titleItemName.Text = formatNumber(robux)
	else
		local itemNameText = animator.Prompt.AlertContents.MiddleContent.Content.ItemName
		itemNameText.Text = string.format('Would you like to buy "%s"?', productInfo.Name)
	end

	local itemIcon = animator.Prompt.AlertContents.MiddleContent.Content.ItemIcon
	itemIcon.Image = "rbxassetid://" .. productInfo.IconImageAssetId

	ContentProvider:PreloadAsync({
		itemIcon
	})

	task.delay(0.2, function()
		Animator(animator, {
			startValue = 1,
			endValue = 0,
			property = "Position",
			springConfig = {
				dampingRatio = 1,
				frequency = 1.6,
			},
			map = function(value)
				return UDim2.new(0, 0, -1 * value, 0)
			end
		})
	end)

	local canPressSecondButton = false
	local isPurchaseArmed = false
	local isSecondButtonPressed = false
	local isMouseDownOnFirst = false
	local isMouseDownOnSecond = false

	if UserInputService.TouchEnabled then
		table.insert(connections, FirstButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				isMouseDownOnFirst = true
				FirstButton.ImageTransparency = 0.65
				FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.65
			end
		end))

		table.insert(connections, SecondButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch and canPressSecondButton then
				isMouseDownOnSecond = true

				if isNew and isPurchaseArmed then
					return
				end

				SecondButton.ImageTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
			end
		end))

		table.insert(connections, UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.Touch then return end
			if isSecondButtonPressed then return end

			if isMouseDownOnFirst then
				isMouseDownOnFirst = false

				FirstButton.ImageTransparency = 0.3
				FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.3

				if isPositionInsideGui(FirstButton, input.Position) then
					if not hasResult then
						hasResult = true
						purchaseResult:Fire(false)
						cleanup(animator)
					end
				end
			end

			if isMouseDownOnSecond and SecondButton then
				isMouseDownOnSecond = false

				SecondButton.ImageTransparency = 0
				SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0
				SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0

				if isPositionInsideGui(SecondButton, input.Position) and isPurchaseArmed then
					isSecondButtonPressed = true

					SecondButton.ImageTransparency = 0.5
					SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.5
					SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
					FirstButton.ImageTransparency = 0.65
					FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.65

					task.wait(1)

					if purchaseGui and purchaseGui.ProductPurchaseContainer then
						local Finish = script.Finish:Clone()
						Finish.Name = "Prompt"
						Finish.Parent = animator
						Finish.Visible = true
						Start:Destroy()

						Finish.AlertContents.MiddleContent.Content.BodyText.Text = string.format("Your purchase of %s succeeded!", productInfo.Name)
						local successButton = Finish.AlertContents.Footer.Buttons["1"]
						local isTouchingSuccess = false

						table.insert(connections, successButton.InputBegan:Connect(function(successInput)
							if successInput.UserInputType == Enum.UserInputType.Touch then
								isTouchingSuccess = true
								successButton.ImageTransparency = 0.5
								successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0.5
							end
						end))

						local successConnections = {}
						table.insert(successConnections, UserInputService.InputEnded:Connect(function(successInput)
							if successInput.UserInputType == Enum.UserInputType.Touch and isTouchingSuccess then
								isTouchingSuccess = false
								successButton.ImageTransparency = 0
								successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0

								if isPositionInsideGui(successButton, successInput.Position) then
									robux -= productInfo.PriceInRobux
									ClientSet:Fire(robux)
									if not hasResult then
										hasResult = true
										purchaseResult:Fire(true)
										cleanup(animator)
									end
									for _, conn in ipairs(successConnections) do
										conn:Disconnect()
									end
								end
							end
						end))
					end
				end
			end
		end))
	else
		table.insert(connections, FirstButton.MouseEnter:Connect(function()
			if isMouseDownOnFirst then
				FirstButton.ImageTransparency = 0.65
			else
				FirstButton.ImageTransparency = 0
				FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0
			end
		end))

		table.insert(connections, FirstButton.MouseLeave:Connect(function()
			if isMouseDownOnFirst then
				FirstButton.ImageTransparency = 0.65
				FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.65
			else
				FirstButton.ImageTransparency = 0.3
				FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.3
			end
		end))

		table.insert(connections, FirstButton.MouseButton1Down:Connect(function()
			isMouseDownOnFirst = true
			FirstButton.ImageTransparency = 0.65
			FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.65
		end))

		table.insert(connections, SecondButton.MouseButton1Down:Connect(function()
			if isNew and not isPurchaseArmed and canPressSecondButton then
				SecondButton.ImageTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
			end

			if isSecondButtonPressed or not canPressSecondButton then
				return
			end

			isMouseDownOnSecond = true
			
			if not isNew then
				SecondButton.ImageTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
			else
				SecondButton.ImageTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.5
				SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
			end
		end))

		table.insert(connections, UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and not GuiService.SelectedObject then return end

			if isMouseDownOnFirst then
				isMouseDownOnFirst = false

				if not isSecondButtonPressed then
					if isPositionInsideGui(FirstButton, input.Position) then
						isSecondButtonPressed = true
						if not hasResult then
							hasResult = true
							purchaseResult:Fire(false)
							cleanup(animator)
						end
					else
						FirstButton.ImageTransparency = 0.3
						FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.3
					end
				end
			end

			if isMouseDownOnSecond then
				isMouseDownOnSecond = false

				if isSecondButtonPressed then 
					return 
				end

				if isPositionInsideGui(SecondButton, input.Position) and canPressSecondButton and isPurchaseArmed then
					isSecondButtonPressed = true

					SecondButton.ImageTransparency = 0.5
					SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.5
					SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0.5
					FirstButton.ImageTransparency = 0.65
					FirstButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0.65

					task.wait(1)

					if purchaseGui and purchaseGui.ProductPurchaseContainer then
						local Finish = script.Finish:Clone()
						Finish.Name = "Prompt"
						Finish.Parent = animator
						Finish.Visible = true
						Start:Destroy()

						Finish.AlertContents.MiddleContent.Content.BodyText.Text = string.format("Your purchase of %s succeeded!", productInfo.Name)
						local successButton = Finish.AlertContents.Footer.Buttons["1"]
						local isMouseDownOnSuccess = false

						if GuiService.SelectedObject then
							GuiService.SelectedObject = successButton
						end

						table.insert(connections, successButton.MouseButton1Down:Connect(function()
							isMouseDownOnSuccess = true
							successButton.ImageTransparency = 0.5
							successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0.5
						end))

						local successEndedConn
						successEndedConn = UserInputService.InputEnded:Connect(function(endedInput)
							if endedInput.UserInputType ~= Enum.UserInputType.MouseButton1 and not GuiService.SelectedObject then return end

							if isMouseDownOnSuccess then
								isMouseDownOnSuccess = false
								successButton.ImageTransparency = 0
								successButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0

								if isPositionInsideGui(successButton, endedInput.Position) then
									robux -= productInfo.PriceInRobux
									ClientSet:Fire(robux)
									if not hasResult then
										hasResult = true
										purchaseResult:Fire(true)
										cleanup(animator)
									end
									if successEndedConn then
										successEndedConn:Disconnect()
									end
								end
							end
						end)
						table.insert(connections, successEndedConn)
					end
				else
					if isNew then
						SecondButton.ImageTransparency = 0
						SecondButton.ButtonContent.ButtonMiddleContent.Buy.TextTransparency = 0
						SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0
					else
						SecondButton.ImageTransparency = 0
						SecondButton.ButtonContent.ButtonMiddleContent.Text.TextTransparency = 0
						SecondButton.ButtonContent.ButtonMiddleContent.Icon.ImageTransparency = 0
					end
				end
			end
		end))
	end

	if isNew then
		table.insert(connections, animator.Prompt.AlertContents.TitleContainer.TitleArea.Title.CloseButton.Activated:Once(function()
			if not purchaseGui then return end

			local activeAnimator = purchaseGui.ProductPurchaseContainer:FindFirstChild("Animator")
			if not activeAnimator then return end

			local currentPrompt = activeAnimator:FindFirstChild("Prompt")
			if not currentPrompt then return end

			task.wait(0.012)

			local isOnFinishScreen = currentPrompt.AlertContents.MiddleContent.Content:FindFirstChild("BodyText")

			if not hasResult then
				hasResult = true
				purchaseResult:Fire(isOnFinishScreen)
			end

			cleanup(activeAnimator)
		end))
	end

	table.insert(connections, GuiService.MenuOpened:Once(function()
		if not purchaseGui then return end

		local activeAnimator = purchaseGui.ProductPurchaseContainer:FindFirstChild("Animator")
		if not activeAnimator then return end

		local currentPrompt = activeAnimator:FindFirstChild("Prompt")
		if not currentPrompt then return end

		task.wait(0.012)

		local isOnFinishScreen = currentPrompt.AlertContents.MiddleContent.Content:FindFirstChild("BodyText")

		if not hasResult then
			hasResult = true
			purchaseResult:Fire(isOnFinishScreen)
		end

		cleanup(activeAnimator)
	end))

	task.delay(1, function()
		local tweenInfo = TweenInfo.new(2.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local loadingTween

		if isNew then
			loadingTween = TweenService:Create(SecondButton.LoadingImage, tweenInfo, {
				Size = UDim2.new(0, 0, 1, 0)
			})
		else
			loadingTween = TweenService:Create(SecondButton.LoadingImage, tweenInfo, {
				Position = UDim2.new(2, 0, 0.5, 0)
			})
		end

		loadingTween:Play()
		loadingTween.Completed:Wait()

		canPressSecondButton = true

		if GuiService.SelectedObject then
			GuiService.SelectedObject = isNew and SecondButton or FirstButton
		end

		task.wait(Random.new():NextNumber(0.5, 0.7))

		isPurchaseArmed = true
	end)

	local wasFired, result = pcall(function()
		return purchaseResult.Event:Wait()
	end)

	purchaseResult:Destroy()

	task.wait(Random.new():NextNumber(0.5, 1))

	return wasFired and result or false
end

return table.freeze(FakePurchase)