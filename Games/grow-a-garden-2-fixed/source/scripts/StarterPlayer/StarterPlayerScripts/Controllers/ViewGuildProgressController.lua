--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PetData = require(ReplicatedStorage.SharedData.PetData)
local PetSizes = require(ReplicatedStorage.SharedData.PetSizes)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)
local AnimatedGradient = require(ReplicatedStorage.SharedModules.AnimatedGradient)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local MailboxItemCatalog = require(LocalPlayer.PlayerScripts.Controllers.MailboxController.MailboxItemCatalog)
local t = {
	StartOrder = 9
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local t2 = {}
local v9 = nil
local v10 = false
local v11 = "ViewGuildPage"

local function abbreviateNumber(p1) --[[ abbreviateNumber | Line: 55 ]]
	if not (p1 >= 1000) then
		return tostring(p1)
	end

	local v1 = string.format("%.1f", p1 / 1000)

	if v1:sub(-2) == ".0" then
		return v1:sub(1, -3) .. "K"
	end

	return v1 .. "K"
end

local function parseRange(p1) --[[ parseRange | Line: 69 | Upvalues: abbreviateNumber (copy) ]]
	local v1 = tonumber(p1)

	if v1 then
		return v1, v1, "#" .. abbreviateNumber(v1)
	end

	local v2, v3 = string.match(p1, "^(%d+)%-(%d+)$")

	if v2 and v3 then
		return tonumber(v2), tonumber(v3), "#" .. abbreviateNumber((tonumber(v2))) .. "-" .. abbreviateNumber((tonumber(v3)))
	end

	local v4 = string.match(p1, "^(%d+)%-$")

	if v4 then
		return tonumber(v4), (1 / 0), "#" .. abbreviateNumber((tonumber(v4))) .. "+"
	end

	return (1 / 0), (1 / 0), p1
end

local function resolvePetReward(p1) --[[ resolvePetReward | Line: 84 | Upvalues: PetSizes (copy), PetTypes (copy), PetData (copy) ]]
	local item = p1.item

	if typeof(item) ~= "string" or item == "" then
		return "", ""
	end

	local v1 = PetSizes.Normalize(p1.size)
	local v2 = if PetTypes.IsValid(p1.type) then p1.type else nil
	local t = {}

	if v1 then
		table.insert(t, v1)
	end

	if v2 then
		table.insert(t, v2)
	end

	table.insert(t, PetData.GetSpeciesDisplayName(item))

	return table.concat(t, " "), PetData.GetImage(item, v1)
end

local function formatRewardName(p1) --[[ formatRewardName | Line: 100 | Upvalues: resolvePetReward (copy), MailboxItemCatalog (copy) ]]
	if typeof(p1) ~= "table" then
		return nil
	end

	if typeof(p1.display) == "string" and p1.display ~= "" then
		return p1.display
	end

	local item = p1.item

	if typeof(item) ~= "string" or item == "" then
		return nil
	end

	local v1 = tonumber(p1.count) or 1

	if p1.category == "Pets" then
		local v2 = resolvePetReward(p1)

		if v2 ~= "" then
			return string.format("%dx %s", v1, v2)
		end
	end

	local ok, result = pcall(MailboxItemCatalog.Resolve, if typeof(p1.category) == "string" then p1.category else "", item, p1)

	return string.format("%dx %s", v1, if ok and typeof(result) == "string" then if result == "" then item else result else item)
end

local function resolveRewardIcon(p1) --[[ resolveRewardIcon | Line: 121 | Upvalues: resolvePetReward (copy), MailboxItemCatalog (copy) ]]
	if typeof(p1) ~= "table" then
		return ""
	end

	local item = p1.item

	if typeof(item) ~= "string" or item == "" then
		return ""
	end

	if p1.category == "Pets" then
		local _, v1 = resolvePetReward(p1)

		return v1
	end

	local ok, _, result = pcall(MailboxItemCatalog.Resolve, if typeof(p1.category) == "string" then p1.category else "", item, p1)

	if ok and typeof(result) == "string" then
		return result
	end

	return ""
end

local function firstEntry(p1) --[[ firstEntry | Line: 136 | Upvalues: formatRewardName (copy) ]]
	if typeof(p1) ~= "table" then
		return nil
	end

	for v1, v2 in p1 do
		if formatRewardName(v2) then
			return v2
		end
	end

	return nil
end

local function setChain(p1, p2) --[[ setChain | Line: 144 ]]
	if not p1 then
		return
	end

	p1.Text = p2

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.Text = p2
end

local function isRainbowPet(p1) --[[ isRainbowPet | Line: 152 | Upvalues: PetTypes (copy) ]]
	return if typeof(p1) == "table" and p1.category == "Pets" then p1.type == PetTypes.Rainbow else false
end

local function getButtonImage(p1) --[[ getButtonImage | Line: 157 ]]
	local RewardDisplay = p1:FindFirstChild("RewardDisplay")
	local v1 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay

	if v1 and v1:IsA("ImageLabel") then
		return v1
	end

	return nil
end

local function applyBracket(p1, p2, p3) --[[ applyBracket | Line: 169 | Upvalues: formatRewardName (copy), AnimatedGradient (copy), resolveRewardIcon (copy), PetTypes (copy) ]]
	local Place = p1:FindFirstChild("Place")

	if Place and (Place:IsA("TextLabel") and Place) then
		Place.Text = p2

		local TextLabel = Place:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			TextLabel.Text = p2
		end
	end

	local RewardName = p1:FindFirstChild("RewardName")

	if RewardName and RewardName:IsA("TextLabel") then
		local v1 = formatRewardName(p3) or ""

		if RewardName then
			RewardName.Text = v1

			local TextLabel = RewardName:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = v1
			end
		end
	end

	local RewardDisplay = p1:FindFirstChild("RewardDisplay")
	local v2 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay
	local v3 = if v2 and v2:IsA("ImageLabel") then v2 else nil

	if v3 then
		AnimatedGradient:Remove(v3)
		v3.Image = resolveRewardIcon(p3)

		if if typeof(p3) == "table" and p3.category == "Pets" then p3.type == PetTypes.Rainbow else false then
			AnimatedGradient:AddRainbowColor(v3, "ImageColor3")
		end
	end

	p1.Visible = true
end

local function hideButton(p1) --[[ hideButton | Line: 187 | Upvalues: AnimatedGradient (copy) ]]
	if not p1 then
		return
	end

	local RewardDisplay = p1:FindFirstChild("RewardDisplay")
	local v1 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay
	local v2 = if v1 and v1:IsA("ImageLabel") then v1 else nil

	if v2 then
		AnimatedGradient:Remove(v2)
	end

	p1.Visible = false
end

local function clearClones() --[[ clearClones | Line: 194 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		v2:Destroy()
	end

	table.clear(t2)
end

local function renderRewards(p1) --[[ renderRewards | Line: 201 | Upvalues: t2 (copy), v5 (ref), AnimatedGradient (copy), v6 (ref), v7 (ref), v8 (ref), v4 (ref), parseRange (copy), formatRewardName (copy), applyBracket (copy) ]]
	for v1, v2 in t2 do
		v2:Destroy()
	end

	table.clear(t2)

	local v3 = v5

	if v3 then
		local RewardDisplay = v3:FindFirstChild("RewardDisplay")
		local v42 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay
		local v52 = if v42 and v42:IsA("ImageLabel") then v42 else nil

		if v52 then
			AnimatedGradient:Remove(v52)
		end

		v3.Visible = false
	end

	local v62 = v6

	if v62 then
		local RewardDisplay = v62:FindFirstChild("RewardDisplay")
		local v72 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay
		local v82 = if v72 and v72:IsA("ImageLabel") then v72 else nil

		if v82 then
			AnimatedGradient:Remove(v82)
		end

		v62.Visible = false
	end

	local v9 = v7

	if v9 then
		local RewardDisplay = v9:FindFirstChild("RewardDisplay")
		local v10 = if RewardDisplay then RewardDisplay:FindFirstChild("Image") else RewardDisplay
		local v11 = if v10 and v10:IsA("ImageLabel") then v10 else nil

		if v11 then
			AnimatedGradient:Remove(v11)
		end

		v9.Visible = false
	end

	if v8 then
		v8.Visible = false
	end

	if not v4 or typeof(p1) ~= "table" then
		return
	end

	local t = {}

	for v12 in p1 do
		if typeof(v12) == "string" then
			table.insert(t, v12)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 213 | Upvalues: parseRange (ref) ]]
		local v1, v2 = parseRange(p1)
		local v3, v4 = parseRange(p2)

		if v1 == v3 then
			if v2 == v4 then
				return p1 < p2
			end

			return v2 < v4
		end

		return v1 < v3
	end)

	local count = 0

	for v14, v15 in t do
		local v13
		local v16 = p1[v15]

		if typeof(v16) == "table" then
			v13 = nil

			for v17, v18 in v16 do
				if formatRewardName(v18) then
					v13 = v18

					break
				end
			end
		else
			v13 = nil
		end

		if v13 then
			count = count + 1

			local _, _2, v19 = parseRange(v15)

			if count == 1 and v5 then
				v5.LayoutOrder = 1
				applyBracket(v5, v19, v13)

				continue
			end

			if count == 2 and v6 then
				v6.LayoutOrder = 2
				applyBracket(v6, v19, v13)

				continue
			end

			if count == 3 and v7 then
				v7.LayoutOrder = 3
				applyBracket(v7, v19, v13)

				continue
			end

			if count >= 4 and v8 then
				local v20 = v8:Clone()

				v20.Name = "RewardClone" .. tostring(count)
				v20.LayoutOrder = count
				v20.Parent = v4
				table.insert(t2, v20)
				applyBracket(v20, v19, v13)
			end
		end
	end
end

local function renderSnapshot(p1) --[[ renderSnapshot | Line: 247 | Upvalues: v2 (ref), v3 (ref), renderRewards (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	local phase = p1.phase

	if phase == "running" and typeof(p1.config) == "table" then
		local config2 = p1.config
		local v1 = v2
		local v22 = if typeof(config2.displayName) == "string" then config2.displayName else "Competition"

		if v1 then
			v1.Text = v22

			local TextLabel = v1:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = v22
			end
		end

		if v3 then
			local t = {}

			if typeof(config2.description) == "table" then
				for v32, v4 in config2.description do
					if typeof(v4) == "string" and v4 ~= "" then
						table.insert(t, v4)
					end
				end
			end

			local v5 = v3
			local v6 = if #t > 0 then table.concat(t, "\n") else "Score points for your guild while the competition is live!"

			if v5 then
				v5.Text = v6

				local TextLabel = v5:FindFirstChild("TextLabel")

				if TextLabel and TextLabel:IsA("TextLabel") then
					TextLabel.Text = v6
				end
			end
		end

		renderRewards(config2.rewards)

		return
	end

	if phase == "pending" then
		local v7 = v2

		if v7 then
			v7.Text = "Competition Starting Soon"

			local TextLabel = v7:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = "Competition Starting Soon"
			end
		end

		if v3 then
			local v8 = v3

			if v8 then
				v8.Text = "A new guild competition is about to begin. Check back when it starts!"

				local TextLabel = v8:FindFirstChild("TextLabel")

				if TextLabel and TextLabel:IsA("TextLabel") then
					TextLabel.Text = "A new guild competition is about to begin. Check back when it starts!"
				end
			end
		end
	else
		local v9 = v2

		if v9 then
			v9.Text = "No Active Competition"

			local TextLabel = v9:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = "No Active Competition"
			end
		end

		if v3 then
			local v10 = v3

			if v10 then
				v10.Text = "There is no guild competition running right now."

				local TextLabel = v10:FindFirstChild("TextLabel")

				if TextLabel and TextLabel:IsA("TextLabel") then
					TextLabel.Text = "There is no guild competition running right now."
				end
			end
		end
	end

	renderRewards(nil)
end

local function fetchAndRender() --[[ fetchAndRender | Line: 276 | Upvalues: Networking (copy), v10 (ref), renderSnapshot (copy) ]]
	task.spawn(function() --[[ Line: 277 | Upvalues: Networking (ref), v10 (ref), renderSnapshot (ref) ]]
		local ok, result = pcall(function() --[[ Line: 278 | Upvalues: Networking (ref) ]]
			return Networking.Guild.GetCompetition:Fire()
		end)

		if not (ok and v10) then
			return
		end

		renderSnapshot(result)
	end)
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 287 | Upvalues: v2 (ref), v9 (ref), v3 (ref), v5 (ref), v4 (ref), v6 (ref), v7 (ref), v8 (ref) ]]
	local GuildProgress = p1:FindFirstChild("GuildProgress")

	if not GuildProgress then
		return
	end

	local Header = GuildProgress:FindFirstChild("Header")

	if Header then
		local TextLabel = Header:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			v2 = TextLabel
		end

		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v9 = ExitButton
		end
	end

	local v1 = GuildProgress:FindFirstChild("Content")

	if not v1 then
		return
	end

	local Info = v1:FindFirstChild("Info")
	local v22 = if Info then Info:FindFirstChild("Description") else Info

	if v22 and v22:IsA("TextLabel") then
		v3 = v22
	end

	local v32 = v1:FindFirstChild("1", true)

	if not (v32 and v32:IsA("ImageButton")) then
		return
	end

	v5 = v32

	local v42 = v32.Parent

	if not (v42 and v42:IsA("ScrollingFrame")) then
		return
	end

	v4 = v42

	local v52 = v42:FindFirstChild("2")

	if v52 and v52:IsA("ImageButton") then
		v6 = v52
	end

	local v62 = v42:FindFirstChild("3")

	if v62 and v62:IsA("ImageButton") then
		v7 = v62
	end

	local v72 = v42:FindFirstChild("4")

	if not (v72 and v72:IsA("ImageButton")) then
		return
	end

	v8 = v72
	v72.Visible = false
end

local function BindButtons() --[[ BindButtons | Line: 326 | Upvalues: v9 (ref), v11 (ref), GuiController (copy) ]]
	if not v9 then
		return
	end

	v9.MouseButton1Click:Connect(function() --[[ Line: 328 | Upvalues: v11 (ref), GuiController (ref) ]]
		if v11 then
			GuiController:Open(v11, nil, { "HUD" })
		end

		if not GuiController:IsOpen("ViewGuildProgress") then
			return
		end

		GuiController:Close()
	end)
end

function t.SetReturnGui(p1, p2) --[[ SetReturnGui | Line: 340 | Upvalues: v11 (ref) ]]
	v11 = if typeof(p2) == "string" and p2 ~= "" then p2 else "ViewGuildPage"
end
function t.SetNoReturn(p1) --[[ SetNoReturn | Line: 348 | Upvalues: v11 (ref) ]]
	v11 = nil
end
function t.SetTargetGuildId(p1, p2) --[[ SetTargetGuildId | Line: 352 ]] end
function t.Init(p1) --[[ Init | Line: 354 ]] end
function t.Start(p1) --[[ Start | Line: 356 | Upvalues: PlayerGui (copy), v1 (ref), ResolveRefs (copy), v9 (ref), v11 (ref), GuiController (copy), v10 (ref), v4 (ref), Networking (copy), renderSnapshot (copy) ]]
	task.spawn(function() --[[ Line: 357 | Upvalues: PlayerGui (ref), v1 (ref), ResolveRefs (ref), v9 (ref), v11 (ref), GuiController (ref), v10 (ref), v4 (ref), Networking (ref), renderSnapshot (ref) ]]
		local ViewGuildProgress = PlayerGui:WaitForChild("ViewGuildProgress", 30)

		if not (ViewGuildProgress and ViewGuildProgress:IsA("ScreenGui")) then
			return
		end

		v1 = ViewGuildProgress
		ViewGuildProgress.Enabled = false
		ResolveRefs(ViewGuildProgress)

		if v9 then
			v9.MouseButton1Click:Connect(function() --[[ Line: 328 | Upvalues: v11 (ref), GuiController (ref) ]]
				if v11 then
					GuiController:Open(v11, nil, { "HUD" })
				end

				if not GuiController:IsOpen("ViewGuildProgress") then
					return
				end

				GuiController:Close()
			end)
		end

		GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 364 | Upvalues: ViewGuildProgress (copy), v10 (ref), v4 (ref), Networking (ref), renderSnapshot (ref) ]]
			if p1 ~= ViewGuildProgress then
				return
			end

			v10 = true

			if v4 then
				v4.CanvasPosition = Vector2.zero
			end

			task.spawn(function() --[[ Line: 277 | Upvalues: Networking (ref), v10 (ref), renderSnapshot (ref) ]]
				local ok, result = pcall(function() --[[ Line: 278 | Upvalues: Networking (ref) ]]
					return Networking.Guild.GetCompetition:Fire()
				end)

				if not (ok and v10) then
					return
				end

				renderSnapshot(result)
			end)
		end)
		GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 371 | Upvalues: ViewGuildProgress (copy), v10 (ref), v11 (ref) ]]
			if p1 ~= ViewGuildProgress then
				return
			end

			v10 = false
			v11 = "ViewGuildPage"
		end)
	end)
end

return t