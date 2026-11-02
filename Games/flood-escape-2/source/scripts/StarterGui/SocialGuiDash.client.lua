-- Ensure that "Lobby" and "_NonChina" exist
local lobby = game.Workspace:WaitForChild("Lobby")
local nonChina = lobby:WaitForChild("_NonChina")
if nonChina then
	local socialGuiContent = nonChina:WaitForChild("SocialMedia"):WaitForChild("SocialGui"):WaitForChild("Content")

	-- AddMapKit button click handler
	socialGuiContent.Pages.Page3.AddMapKit.MouseButton1Click:Connect(function()
		game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, 688694610)
	end)

	-- Function to handle page transitions
	local function handlePageTransitions()
		local pages = socialGuiContent.Pages:GetChildren()
		local pageCount = #pages
		local currentPageIndex = pageCount

		while true do
			local currentPage = pages[currentPageIndex]
			currentPage.Visible = true
			currentPage.Position = UDim2.new(-1, 0, 0, 0)

			for _, descendant in pairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiBase") then
					descendant.ZIndex = descendant.ZIndex + 3
				end
			end

			currentPage.ZIndex = currentPage.ZIndex + 3
			currentPage:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 1)

			local previousPageIndex = currentPageIndex == 1 and pageCount or currentPageIndex - 1
			local previousPage = pages[previousPageIndex]
			previousPage:TweenPosition(UDim2.new(0.2, 0, 0, 0), "Out", "Sine", 1)

			for transparency = 1, 0, -0.033 do
				previousPage.Overlay.BackgroundTransparency = transparency
				wait()
			end

			previousPage.Overlay.BackgroundTransparency = 1
			previousPage.Visible = false

			for _, descendant in pairs(currentPage:GetDescendants()) do
				if descendant:IsA("GuiBase") then
					descendant.ZIndex = descendant.ZIndex - 3
				end
			end

			currentPage.ZIndex = currentPage.ZIndex - 3
			currentPageIndex = currentPageIndex == pageCount and 1 or currentPageIndex + 1

			wait(9)
		end
	end

	spawn(handlePageTransitions)
end