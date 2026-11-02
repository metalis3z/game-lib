local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local AnimalsShared = require(ReplicatedStorage.Shared.Animals)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ButtonFX = require(script.ButtonFX)
local AutoCanvasSize = require(script.AutomaticCanvasSizeModule)
local SearchBox = script.Parent.Parent.Parent.Parent.Search.TextBox

local ScrollFrame = script.Parent

local buttonViewportMap = {}
local buttonKeyMap     = {}
local cullingTrove     = Trove.new()
local CULL_PADDING     = 1

local function IsButtonInView(button)
	if not button or not button.Parent then return false end
	local scrollY = ScrollFrame.CanvasPosition.Y
	local frameH  = ScrollFrame.AbsoluteSize.Y
	local btnTop  = button.AbsolutePosition.Y - ScrollFrame.AbsolutePosition.Y + scrollY
	local btnBot  = btnTop + button.AbsoluteSize.Y
	return btnBot >= (scrollY - CULL_PADDING) and btnTop <= (scrollY + frameH + CULL_PADDING)
end

local function AttachViewport(button, itemKey)
	if buttonViewportMap[button] then return end
	local handle = AnimalsShared:AttachOnViewport(itemKey, button.ViewportFrame, true, nil)
	if handle then
		buttonViewportMap[button] = handle
	end
end

local function DetachViewport(button)
	local handle = buttonViewportMap[button]
	if not handle then return end
	if typeof(handle) == "Instance" then
		handle:Destroy()
	elseif type(handle) == "table" and handle.Destroy then
		handle:Destroy()
	elseif type(handle) == "function" then
		handle()
	end
	buttonViewportMap[button] = nil
	if button.ViewportFrame then
		button.ViewportFrame:ClearAllChildren()
	end
end

local function RunCullPass()
	for button, itemKey in pairs(buttonKeyMap) do
		if not button.Parent then
			DetachViewport(button)
			buttonKeyMap[button] = nil
		elseif button.Visible and IsButtonInView(button) then
			AttachViewport(button, itemKey)
		else
			DetachViewport(button)
		end
	end
end

local function StartCulling()
	cullingTrove:Clean()
	cullingTrove:Add(ScrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(RunCullPass))
	local tick = 0
	cullingTrove:Add(RunService.Heartbeat:Connect(function()
		tick += 1
		if tick >= 12 then
			tick = 0
			RunCullPass()
		end
	end))
end

local function StopCulling()
	cullingTrove:Clean()
	buttonViewportMap = {}
	buttonKeyMap = {}
end

local function FilterButtons(query)
	local lowerQuery = string.lower(query or "")
	for _, button in pairs(script.Parent:GetChildren()) do
		if button:IsA("TextButton") and button.Name ~= "Template" then
			local label = button.TextLabel.Text
			button.Visible = lowerQuery == "" or string.find(string.lower(label), lowerQuery, 1, true) ~= nil
		end
	end
	script.Parent.CanvasPosition = Vector2.new(0, 0)
	AutoCanvasSize(script.Parent)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	FilterButtons(SearchBox.Text)
end)

local lastContent = nil
local lastCallback = nil
local lastMode = nil
local lastExistingSelections = nil
local lastDuplicatesAllowed = nil

local selectionMode = nil
local selectedItems = {}
local populateThread = nil
local allowDuplicates = false

local buttonTrove = Trove.new()

local function CancelPopulate()
	if populateThread then
		task.cancel(populateThread)
		populateThread = nil
	end
end

local function PopulateButtons(content, callback, mode, existingSelections, duplicatesAllowed)
	CancelPopulate()
	buttonTrove:Clean()

	selectionMode = mode or "single"
	allowDuplicates = duplicatesAllowed == true

	if selectionMode == "multiple" and existingSelections and existingSelections ~= "None" and existingSelections ~= "" then
		selectedItems = {}
		for entry in string.gmatch(existingSelections, "[^,]+") do
			local trimmed = entry:match("^%s*(.-)%s*$")
			if trimmed ~= "" then
				table.insert(selectedItems, trimmed)
			end
		end
	else
		selectedItems = {}
	end

	script.Parent.CanvasPosition = Vector2.new(0, 0)

	local itemKeyCache = {}
	for key, val in pairs(AnimalsData) do
		itemKeyCache[val] = key
	end

	populateThread = task.spawn(function()
		local currentQuery = string.lower(SearchBox.Text or "")
		local BATCH_SIZE = 20

		local count = 0
		for _, item in pairs(content) do
			if buttonTrove._cleaning then break end

			local button = script.Parent.Template:Clone()
			button.Name = "Brotinho"
			button.TextLabel.Text = item.DisplayName or ""
			button.ImageLabel.Image = item.Icon or ""

			local itemKey = not item.Icon and itemKeyCache[item] or nil
			local identifier = itemKey or item.DisplayName
			local isSelected = selectionMode == "multiple" and table.find(selectedItems, identifier) ~= nil
			local baseColor = item.Color or Color3.fromRGB(20, 20, 20)

			if isSelected then
				button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			elseif item.GradientPreset then
				button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
				Gradients.apply(button, item.GradientPreset, 0.5)
			else
				button.BackgroundColor3 = baseColor
			end

			button.Visible = currentQuery == "" or string.find(string.lower(item.DisplayName or ""), currentQuery, 1, true) ~= nil
			button.Parent = script.Parent

			if not buttonTrove._cleaning then
				buttonTrove:Add(button)
			end

			local capturedButton = button
			local capturedKey = itemKey
			local capturedIdentifier = identifier
			local capturedBase = baseColor

			task.defer(function()
				if not capturedButton.Parent or buttonTrove._cleaning then return end

				ButtonFX(capturedButton)

				if capturedKey then
					buttonKeyMap[capturedButton] = capturedKey
				end

				local animBtn = AnimatedButton.new(capturedButton)
				animBtn:Animate()

				if not buttonTrove._cleaning then
					buttonTrove:Add(animBtn)
					buttonTrove:Add(animBtn.OnActivated:Connect(function()
						if selectionMode == "multiple" then
							local foundIndex = table.find(selectedItems, capturedIdentifier)
							if allowDuplicates then
								if foundIndex and #selectedItems == 1 then
									table.remove(selectedItems, foundIndex)
									if item.GradientPreset then
										capturedButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
										Gradients.apply(capturedButton, item.GradientPreset, 0.5)
									else
										capturedButton.BackgroundColor3 = capturedBase
									end
								else
									table.insert(selectedItems, capturedIdentifier)
									capturedButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
								end
							else
								if foundIndex then
									table.remove(selectedItems, foundIndex)
									if item.GradientPreset then
										capturedButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
										Gradients.apply(capturedButton, item.GradientPreset, 0.5)
									else
										capturedButton.BackgroundColor3 = capturedBase
									end
								else
									table.insert(selectedItems, capturedIdentifier)
									capturedButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
								end
							end
							callback(#selectedItems > 0 and table.concat(selectedItems, ", ") or "None")
						else
							_G.AdminSelectionToggle(false)
							callback(capturedIdentifier)
						end
					end))
				end
			end)

			count = count + 1
			if count % BATCH_SIZE == 0 then
				RunService.Heartbeat:Wait()
				currentQuery = string.lower(SearchBox.Text or "")
			end
		end

		task.wait()
		AutoCanvasSize(script.Parent)
		RunCullPass()
		populateThread = nil
	end)
end

_G.AdminCleanupButtons = function()
	CancelPopulate()
	StopCulling()
	buttonTrove:Clean()
end

_G.AdminRepopulate = function()
	if lastContent then
		PopulateButtons(lastContent, lastCallback, lastMode, lastExistingSelections, lastDuplicatesAllowed)
	end
end

function _G.SetAdminContent(content, callback, mode, existingSelections, _, duplicatesAllowed)
	lastContent = content
	lastCallback = callback
	lastMode = mode
	lastExistingSelections = existingSelections
	lastDuplicatesAllowed = duplicatesAllowed

	SearchBox.Text = ""
	FilterButtons("")
	_G.AdminSelectionToggle(true)
	StartCulling()

	PopulateButtons(content, callback, mode, existingSelections, duplicatesAllowed)
end