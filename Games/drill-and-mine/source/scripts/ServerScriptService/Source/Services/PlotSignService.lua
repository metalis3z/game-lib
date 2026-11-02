local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local PlotSignService = {}

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")
local AVAILABLE_TEXT = "Available Base"
local DEFAULT_ICON = ""

local function setLabel(label, text)
	if not label then
		return
	end
	label.Text = text
	local inner = label:FindFirstChild("Amount")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

local function getSignParts(plot)
	local sign = plot:FindFirstChild("BaseSign")
	if not sign then
		return nil
	end
	local uiPart = sign:FindFirstChild("UIPart")
	local gui = uiPart and uiPart:FindFirstChild("PlayerBase")
	if not gui then
		return nil
	end
	return {
		NameLabel = gui:FindFirstChild("Name"),
		IconImage = gui:FindFirstChild("PlayerIcon"),
	}
end

local function fetchThumbnail(userId)
	local ok, content = pcall(function()
		return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if ok and content then
		return content
	end
	return DEFAULT_ICON
end

local function updateSign(plot)
	local parts = getSignParts(plot)
	if not parts then
		return
	end

	local ownerId = plot:GetAttribute("OwnerUserId")
	if not ownerId or ownerId == 0 then
		setLabel(parts.NameLabel, AVAILABLE_TEXT)
		if parts.IconImage then
			parts.IconImage.Image = DEFAULT_ICON
		end
		return
	end

	local plr = Players:GetPlayerByUserId(ownerId)
	local name
	if plr then
		name = plr.DisplayName
	else
		local ok, fetched = pcall(function()
			return Players:GetNameFromUserIdAsync(ownerId)
		end)
		name = ok and fetched or "Player"
	end
	setLabel(parts.NameLabel, name .. "'s Base")

	if parts.IconImage then
		task.spawn(function()
			local thumb = fetchThumbnail(ownerId)
			if plot:GetAttribute("OwnerUserId") == ownerId then
				parts.IconImage.Image = thumb
			end
		end)
	end
end

function PlotSignService.Init()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:IsA("Model") then
			updateSign(plot)
			plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
				updateSign(plot)
			end)
		end
	end
end

return PlotSignService
