-- Made by KCC_Mega
-- Only change what I put above the things you can change (unless you know what you're doing)!

--\\FUNCTIONS
local marketPlace = game:GetService("MarketplaceService")

local rs = game:GetService("ReplicatedStorage")
local folder = rs:WaitForChild("Items")

-- if couldn't find folder (was intended to be placed in lighting when inside KIT)
if not folder then return end

local gamepasses
local success, Error = pcall(function()
	-- HERE YOU CAN CHANGE WHAT'S BELOW THIS COMMENT:
	gamepasses = {
		-- If you want to add more gamepasses, add more arrays for each 'new' gamepass

		-- (example from a existent gamepass)
		{
			Id = 1840658308,
			Tool = folder["Cupid's Wings"],
		},
	}
	--]]
	-- Don't change anymore..
end)

if not success then warn(Error) return end

--\\LOGIC (FUNCTIONS)
local function plrAdded(plr:Player)
	local function charAdded(char:Model)
		for _, gamepass in pairs(gamepasses) do
			local id = gamepass.Id or 0
			local tool = gamepass.Tool

			if id == 0 then continue end
			if not tool then continue end
			if not tool:IsA("Tool") then continue end
			if marketPlace:UserOwnsGamePassAsync(plr.UserId, id) then
				local ItemClone = tool:Clone()
				ItemClone.Parent = plr.Backpack
			end
		end
	end
	plr.CharacterAdded:Connect(charAdded)
end
local function purchaseFinalized(plr:Player, t_id:number, purchased:boolean)
	for _, gamepass in pairs(gamepasses) do
		local id = gamepass.Id or 0
		if id == 0 then continue end
		if t_id ~= id then continue end

		local tool = gamepass.Tool
		if not tool then continue end
		if not tool:IsA("Tool") then continue end
		if purchased then
			local clone = tool:Clone()
			clone.Parent = plr.Backpack
		end
	end
end

marketPlace.PromptGamePassPurchaseFinished:Connect(purchaseFinalized)
game.Players.PlayerAdded:Connect(plrAdded)