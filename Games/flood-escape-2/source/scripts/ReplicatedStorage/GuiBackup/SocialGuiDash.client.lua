local died = false

if game.Workspace:FindFirstChild("Lobby") and game.Workspace.Lobby:FindFirstChild("_NonChina") then
	local socialGui = game.Workspace.Lobby._NonChina:WaitForChild("SocialMedia"):WaitForChild("SocialGui"):WaitForChild("Content")
	socialGui.Pages.Page3.AddMapKit.MouseButton1Click:Connect(function()
		game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, 688694610)
	end)

	spawn(function()
		local pages = socialGui.Pages:GetChildren()
		local pageCount = #pages
		local currentIndex = pageCount
		local previousIndex = pageCount - 1

		while true do
			if not (game.Workspace:FindFirstChild("Lobby") and game.Workspace.Lobby:FindFirstChild("_NonChina")) then
				died = true
			end
			local currentPage = pages[currentIndex]
			currentPage.Visible = true
			currentPage.Position = UDim2.new(-1, 0, 0, 0)

			for _, descendant in ipairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					descendant.ZIndex = descendant.ZIndex + 3
				end
			end

			local s, e = pcall(function()
				currentPage.ZIndex = currentPage.ZIndex + 3
				currentPage:TweenPosition(UDim2.new(), "Out", "Sine", 1)

				local previousPage = pages[previousIndex]
				previousPage:TweenPosition(UDim2.new(0.2, 0, 0, 0), "Out", "Sine", 1)
				
				for transparency = 1, 0, -0.033333333333333 do
					previousPage.Overlay.BackgroundTransparency = transparency
					wait()
				end

				previousPage.Overlay.BackgroundTransparency = 1
				previousPage.Visible = false	
			end)
	
			if e then
				died = true
				break
			end
			
			for _, descendant in ipairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					descendant.ZIndex = descendant.ZIndex - 3
				end
			end

			currentPage.ZIndex = currentPage.ZIndex - 3

			currentIndex = (currentIndex % pageCount) + 1
			previousIndex = (previousIndex % pageCount) + 1

			wait(9)
		end
	end)
end

repeat task.wait() until died == true
if died then
	repeat task.wait() until game.Workspace:FindFirstChild("Lobby") and game.Workspace.Lobby:FindFirstChild("_NonChina") and game.Workspace.Lobby:FindFirstChild("_NonChina"):FindFirstChild("SocialMedia") and game.Workspace.Lobby:FindFirstChild("_NonChina"):FindFirstChild("SocialMedia"):FindFirstChild("Content")
	local socialGui = game.Workspace.Lobby._NonChina:WaitForChild("SocialMedia"):WaitForChild("SocialGui"):WaitForChild("Content")
	socialGui.Pages.Page3.AddMapKit.MouseButton1Click:Connect(function()
		game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, 688694610)
	end)

	spawn(function()
		local pages = socialGui.Pages:GetChildren()
		local pageCount = #pages
		local currentIndex = pageCount
		local previousIndex = pageCount - 1

		while true do
			if not (game.Workspace:FindFirstChild("Lobby") and game.Workspace.Lobby:FindFirstChild("_NonChina")) then
				died = true
			end
			local currentPage = pages[currentIndex]
			currentPage.Visible = true
			currentPage.Position = UDim2.new(-1, 0, 0, 0)

			for _, descendant in ipairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					descendant.ZIndex = descendant.ZIndex + 3
				end
			end

			currentPage.ZIndex = currentPage.ZIndex + 3
			currentPage:TweenPosition(UDim2.new(), "Out", "Sine", 1)

			local previousPage = pages[previousIndex]
			previousPage:TweenPosition(UDim2.new(0.2, 0, 0, 0), "Out", "Sine", 1)

			for transparency = 1, 0, -0.033333333333333 do
				previousPage.Overlay.BackgroundTransparency = transparency
				wait()
			end

			previousPage.Overlay.BackgroundTransparency = 1
			previousPage.Visible = false

			for _, descendant in ipairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					descendant.ZIndex = descendant.ZIndex - 3
				end
			end

			currentPage.ZIndex = currentPage.ZIndex - 3

			currentIndex = (currentIndex % pageCount) + 1
			previousIndex = (previousIndex % pageCount) + 1

			wait(9)
		end
	end)	
end