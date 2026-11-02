local tutorialPages = {
    {
        Title = "Welcome to Zombie Survival!",
		Description = "Fight waves of zombies, survive with your friends, and earn rewards!.Each round has a random gamemode. Some are classic and others are special!",
        Image = "rbxassetid://123095251924186",
    },
    {
        Title = "How to Play",
		Description = "Use WASD to move, click to shoot, and buy weapons in the shop.To start playing the game, buy Classic Sword in the shop!",
        Image = "rbxassetid://5107159153",
    },
    {
        Title = "Shop & Upgrades",
        Description = "Visit the shop between rounds to buy new weapons and upgrades.",
        Image = "rbxassetid://14736132184",
    },
    {
        Title = "Teamwork",
        Description = "Work together with other players to survive longer!.",
        Image = "rbxassetid://4728092758",
    },
    {
        Title = "Good Luck!",
        Description = "Survive as long as you can. Have fun and enjoy the game!",
        Image = "rbxassetid://123095251924186",
    },
}

-- Get references to UI elements
local frame = script.Parent
local titleLabel = frame:FindFirstChild("Title")
local descriptionLabel = frame:FindFirstChild("TextLabel")
local imageLabel = frame:FindFirstChild("ImageLabel")
local nextButton = frame:FindFirstChild("Next")
local prevButton = frame:FindFirstChild("Previous")
local pageLabel = frame:FindFirstChild("Page")

local currentPage = 1
local totalPages = #tutorialPages

-- Function to update the tutorial UI
local function updateTutorialPage()
    local page = tutorialPages[currentPage]
    if titleLabel then
        titleLabel.Text = page.Title or ""
    end
    if descriptionLabel then
        descriptionLabel.Text = page.Description or ""
    end
    if imageLabel then
        imageLabel.Image = page.Image or ""
    end
    if pageLabel then
        pageLabel.Text = tostring(currentPage) .. " / " .. tostring(totalPages)
    end
    -- Previous button logic
    if prevButton then
        prevButton.Visible = currentPage > 1
        prevButton.Active = currentPage > 1
        prevButton.AutoButtonColor = currentPage > 1
    end
    -- Next button logic
    if nextButton then
        nextButton.Visible = currentPage < totalPages
        nextButton.Active = currentPage < totalPages
        nextButton.AutoButtonColor = currentPage < totalPages
    end
end

-- Button click handlers
if nextButton then
    nextButton.MouseButton1Click:Connect(function()
        if currentPage < totalPages then
            currentPage = currentPage + 1
            updateTutorialPage()
        end
    end)
end

if prevButton then
    prevButton.MouseButton1Click:Connect(function()
        if currentPage > 1 then
            currentPage = currentPage - 1
            updateTutorialPage()
        end
    end)
end

-- Keyboard navigation support
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
    if processed or not frame.Visible then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Right then
            if currentPage < totalPages then
                currentPage = currentPage + 1
                updateTutorialPage()
            end
        elseif input.KeyCode == Enum.KeyCode.Left then
            if currentPage > 1 then
                currentPage = currentPage - 1
                updateTutorialPage()
            end
        end
    end
end)

-- Initialize the tutorial UI
updateTutorialPage()