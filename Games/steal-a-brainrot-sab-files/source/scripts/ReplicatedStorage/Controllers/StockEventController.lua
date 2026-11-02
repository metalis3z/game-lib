local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)
local l_Players_0 = game:GetService("Players");
local v10 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v13 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v14 = require(l_ReplicatedStorage_0.Packages.Observers);
local v17 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v18 = require(l_ReplicatedStorage_0.Packages.Timer);
local v19 = require(l_ReplicatedStorage_0.Packages.Trove);
local v21 = require(l_ReplicatedStorage_0.Packages.Net);
local v24 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v26 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v28 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local v31 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v34 = require(l_ReplicatedStorage_0.Shared.Animals);
local v36 = require(l_ReplicatedStorage_0.Datas.StockMachine);
local v38 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v39 = require(l_ReplicatedStorage_0.Datas.Animals);
local v40 = v21:RemoteEvent("StockEventService/SetFocused");
local v41 = v21:RemoteEvent("StockEventService/Return");
local v42 = v21:RemoteEvent("StockEventService/Redeem");
local v43 = v21:RemoteFunction("StockEventService/Delivery");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_StockMachine_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("SingleStockMachine").SingleStockMachine;
local doublecontent = l_LocalPlayer_0.PlayerGui:WaitForChild("StockMachine").StockMachine;
local l_Content_0 = l_StockMachine_0.Content;
local l_Close_0 = l_StockMachine_0.Header.Close;
local l_DoubleClose_0 = doublecontent.Header.Close;
local v48 = nil;
local v48Double = nil;

local GRADIENT_PRESET_MAP = {
	rainbow    = "Rainbow",
	zebra      = "Zebra",
	og         = "OG",
	yellowred  = "YellowRed",
	greenred   = "GreenRed",
	slowgreenred = "SlowGreenRed",
	pink       = "Pink",
}

local PRESET_TO_TAG = {}
for tag, preset in pairs(GRADIENT_PRESET_MAP) do
	PRESET_TO_TAG[preset] = tag
end

local RICHTEXT_SUPPORTED_TAGS = {
	rainbow      = true,
	og           = true,
	yellowred    = true,
	zebra        = true,
	greenred     = true,
	slowgreenred = true,
}

local function applyNameGradient(label: TextLabel, displayName: string, rarityData: table, contentTrove)
	if not label then return end

	CustomRichTextController.cleanup(label)

	label.Text = displayName

	if rarityData and rarityData.GradientPreset then
		local tag = PRESET_TO_TAG[rarityData.GradientPreset]

		if tag and RICHTEXT_SUPPORTED_TAGS[tag] then
			label.RichText = false
			label.TextColor3 = Color3.new(1, 1, 1)
			local taggedText = string.format("<%s>%s</%s>", tag, displayName, tag)
			local trove = CustomRichTextController.apply(label, taggedText, { attachToInstance = true })
			if trove and contentTrove then contentTrove:Add(trove) end
		else
			label.RichText = false
			label.TextColor3 = Color3.new(1, 1, 1)
			local cleanup = v13.apply(label, rarityData.GradientPreset)
			if cleanup and contentTrove then contentTrove:Add(cleanup) end
		end


	elseif rarityData and rarityData.Color then
		label.RichText = false
		label.TextColor3 = rarityData.Color

	else
		label.RichText = false
	end
end
local function renderBrainrotAtFrame(v53, v54, contentTrove)
	local v55 = v39[v54]
	if not v55 then
		warn("[renderBrainrotAtFrame] FAILED - animal not found in AnimalsDB for key:", v54)
		return
	end

	local v56 = v38[v55.Rarity]

	local displayName = v55.DisplayName or v54

	local displayLabel = v53:FindFirstChild("Title", true)
	if displayLabel and displayLabel:IsA("TextLabel") then
		applyNameGradient(displayLabel, displayName, v56, contentTrove)
	else
		warn("[renderBrainrotAtFrame] No Title TextLabel found in frame:", v53.Name)
	end


	v53.Visible = true

	local viewport = v53:FindFirstChild("ViewportFrame", true)
	if viewport then
		local cleanup = v34:AttachOnViewportWithOptimizations(v54, viewport, true)
		if cleanup and contentTrove then
			contentTrove:Add(cleanup)
		elseif not cleanup then
			warn("[renderBrainrotAtFrame] AttachOnViewportWithOptimizations returned nil, falling back for:", v54)
			v34:AttachOnViewport(v54, viewport, true)
		end
	else
		warn("[renderBrainrotAtFrame] No ViewportFrame found in frame:", v53.Name)
	end
end

local function applySubtitle(subtitleLabel, inputCount, outputKey, gradients, contentTrove)
	if not subtitleLabel then
		warn("[applySubtitle] subtitleLabel is NIL")
		return
	end

	local outputData = v39[outputKey]
	local displayName = (outputData and outputData.DisplayName) or outputKey

	subtitleLabel.Visible = true
	subtitleLabel.RichText = true
	subtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	subtitleLabel.Text = ('Collect all %d brainrots to spawn <font color="#6FFFF8">%s</font>'):format(inputCount, displayName)

	local existingOverlay = subtitleLabel:FindFirstChild("SubtitleGradientOverlay")
	if existingOverlay then
		existingOverlay:Destroy()
	end
end

local function renderSingleStock(v52, machineType, recipe, contentTrove)
	for i, inp in ipairs(recipe.Inputs) do
	end

	local uiOutput = l_StockMachine_0:FindFirstChild("Output")
	local outputDisplay = uiOutput and uiOutput:FindFirstChild("Brainrot")
	if outputDisplay then
		renderBrainrotAtFrame(outputDisplay, recipe.Output, contentTrove)
	end

	if l_StockMachine_0:FindFirstChild("Subtitle") then
		applySubtitle(l_StockMachine_0.Subtitle, #recipe.Inputs, recipe.Output, v13, contentTrove)
	else
		warn("[renderSingleStock] No Subtitle child found")
	end

	local spawnBtn = l_StockMachine_0:FindFirstChild("Spawn")
	local spawnAnimated = nil
	if spawnBtn and not spawnAnimated then
		spawnAnimated = v31.new(spawnBtn)
		spawnAnimated:Animate()
		spawnAnimated.OnActivated:Connect(function()
			if spawnBtn.Interactable then
				v42:FireServer(machineType, recipe.Output)
				v24:SetState("StockMachine", false)
			else
				warn("[renderSingleStock] Spawn button not interactable - requirements not met")
			end
		end)
		contentTrove:Add(spawnAnimated)
	end

	local v61 = {}
	for v62, v63 in ipairs(recipe.Inputs) do
		local v64 = v39[v63]
		if v64 then
			local v65 = v38[v64.Rarity]
			local v66 = l_Content_0.Template:Clone()
			v66.Name = "ActiveTemplate"
			v66.LayoutOrder = (v65 and v65.Weight or 1) * 100 + v62
			v66.Visible = true
			v66.Parent = l_Content_0

			renderBrainrotAtFrame(v66, v63, contentTrove)

			local vp = v66:FindFirstChild("ViewportFrame", true)
			if vp then vp.ImageColor3 = Color3.new(0, 0, 0) end

			local returnBtn = v66:FindFirstChild("Return", true)
			if returnBtn then
				returnBtn.Visible = false
				local v67 = v31.new(returnBtn)
				v67:Animate()
				contentTrove:Add(v67)
				v67.OnActivated:Connect(function()
					for v68, v69 in (v52:Get("AnimalPodiums")) do
						if type(v69) == "table" and v69.Index == v63
							and v69.Machine and v69.Machine.Type == machineType
							and not v69.Machine.Active then
							v41:FireServer(v68)
							return
						end
					end
					warn("[renderSingleStock] Return button clicked but no matching podium found for:", v63)
				end)
			else
				warn("[renderSingleStock] No Return button found in template for:", v63)
			end

			if not v61[v63] then v61[v63] = {} end
			table.insert(v61[v63], v66)
		else
			warn("[renderSingleStock] Skipping ingredient - not in AnimalsDB:", v63)
		end
	end

	local function v81()
		local v70 = v52:Get("AnimalPodiums") or {}
		local v71 = {}

		if spawnBtn then
			spawnBtn.Interactable = false
			spawnBtn.BackgroundColor3 = Color3.fromRGB(127, 127, 127)
		end

		for i, podiumData in pairs(v70) do
			if type(podiumData) == "table" and podiumData.Machine
				and podiumData.Machine.Type == machineType
				and not podiumData.Machine.Active then
				local cleanName = tostring(podiumData.Index):match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
				v71[cleanName] = (v71[cleanName] or 0) + 1
			end
		end
		for k, v in pairs(v71) do
		end

		local allRequirementsMet = true
		local atLeastOneRequirement = false

		for reqName, templateList in pairs(v61) do
			atLeastOneRequirement = true
			local cleanReqName = tostring(reqName):match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
			local ownedCount = v71[cleanReqName] or 0

			for i, templateClone in ipairs(templateList) do
				local isMet = (i <= ownedCount)
				local ret = templateClone:FindFirstChild("Return", true)
				if ret then ret.Visible = isMet end
				local vp = templateClone:FindFirstChild("ViewportFrame", true)
				if vp then vp.ImageColor3 = isMet and Color3.new(1, 1, 1) or Color3.new(0, 0, 0) end
				if not isMet then
					allRequirementsMet = false
				end
			end
		end

		if allRequirementsMet and atLeastOneRequirement then
			if spawnBtn then
				spawnBtn.Interactable = true
				spawnBtn.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
			end
		else
		end
	end

	contentTrove:Add(v52:OnChanged("AnimalAddedOrRemoved", v81))
	task.spawn(v81)

	local uiQuantity = uiOutput and uiOutput:FindFirstChild("Quantity", true)
	if uiQuantity then
		local v84 = "StockEvent_Chipso_and_Queso"

		local function v88()
			local stockValue = l_ReplicatedStorage_0:GetAttribute(v84)
			uiQuantity.TextColor3 = Color3.fromRGB(255, 255, 255)
			if stockValue == nil or stockValue > 0 then
				local displayText = stockValue and ("%s Left"):format(v28:Comma(tonumber(stockValue))) or "Loading..."
				CustomRichTextController.apply(uiQuantity, "<rainbow>" .. displayText .. "</rainbow>")
			else
				CustomRichTextController.cleanup(uiQuantity)
				uiQuantity.TextColor3 = Color3.fromRGB(255, 0, 0)
				uiQuantity.Text = "SOLD OUT"
			end
		end

		contentTrove:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal(v84):Connect(v88))
		contentTrove:Add(function()
			CustomRichTextController.cleanup(uiQuantity)
		end)
		task.spawn(v88)
	end
end

local function renderDoubleStock(v52, machineType, recipe1, recipe2, contentTrove)



	local doubleRoot = doublecontent:FindFirstChild("Content")
	if not doubleRoot then
		warn("[renderDoubleStock] FATAL: Missing 'Content' in StockMachine!")
		return
	end

	local recipes = {recipe1, recipe2}
	local stockKeys = {
		"StockEvent_Chipso_and_Queso",
		"StockEvent_Chipso_and_Queso_2"
	}

	for slotIndex, recipe in ipairs(recipes) do

		local templateSource = doubleRoot:FindFirstChild("Template")
		if not templateSource then
			warn("[renderDoubleStock] FATAL: Missing Template in Content for slot", slotIndex)
			continue
		end

		local slotFrame = templateSource:Clone()
		slotFrame.Name = "ActiveSlot" .. slotIndex
		slotFrame.Visible = true
		slotFrame.LayoutOrder = slotIndex
		slotFrame.Parent = doubleRoot

		local uiOutput = slotFrame:FindFirstChild("Output")
		local uiInput   = slotFrame:FindFirstChild("Input")
		local spawnBtn  = uiOutput and uiOutput:FindFirstChild("Spawn")

		if uiInput then uiInput.LayoutOrder = 1 end
		if uiOutput then
			uiOutput.LayoutOrder = 9999
			renderBrainrotAtFrame(uiOutput, recipe.Output, contentTrove)
		end

		if spawnBtn then
			local spawnAnim = v31.new(spawnBtn)
			spawnAnim:Animate()
			contentTrove:Add(spawnAnim)
			spawnAnim.OnActivated:Connect(function()
				if spawnBtn.Interactable then
					v42:FireServer(machineType, recipe.Output)
					v24:SetState("DoubleStockMachine", false)
				else
					warn("[renderDoubleStock] Spawn button not interactable for slot", slotIndex)
				end
			end)
		end

		local v61 = {}
		for v62, v63 in ipairs(recipe.Inputs) do
			local v64 = v39[v63]
			if v64 then
				local ingredientFrame
				if v62 == 1 and uiInput then
					ingredientFrame = uiInput
					ingredientFrame.LayoutOrder = 1
				else
					ingredientFrame = uiInput and uiInput:Clone()
					if not ingredientFrame then
						warn("[renderDoubleStock] Could not clone uiInput for ingredient", v62)
						continue
					end
					ingredientFrame.LayoutOrder = v62
					ingredientFrame.Visible = true
					ingredientFrame.Parent = slotFrame
				end

				renderBrainrotAtFrame(ingredientFrame, v63, contentTrove)

				local vp = ingredientFrame:FindFirstChild("ViewportFrame", true)
				if vp then vp.ImageColor3 = Color3.new(0, 0, 0) end

				local returnBtn = ingredientFrame:FindFirstChild("Return", true)
				if returnBtn then
					returnBtn.Visible = false
					local retAnim = v31.new(returnBtn)
					retAnim:Animate()
					contentTrove:Add(retAnim)

					local slotRecipeOutput = recipe.Output
					retAnim.OnActivated:Connect(function()
						for v68, v69 in (v52:Get("AnimalPodiums")) do
							if type(v69) == "table" and v69.Index == v63
								and v69.Machine and v69.Machine.Type == machineType
								and v69.Machine.RecipeKey == slotRecipeOutput
								and not v69.Machine.Active then
								v41:FireServer(v68)
								return
							end
						end
						warn("[renderDoubleStock] Return: no matching podium for animal:", v63, "recipeKey:", slotRecipeOutput)
					end)
				else
					warn("[renderDoubleStock] No Return button in ingredient frame for:", v63)
				end

				if not v61[v63] then v61[v63] = {} end
				table.insert(v61[v63], ingredientFrame)
			else
				warn("[renderDoubleStock] Ingredient not in AnimalsDB, skipping:", v63)
			end
		end

		local function validateSlot()
			local v70 = v52:Get("AnimalPodiums") or {}
			local v71 = {}

			if spawnBtn then
				spawnBtn.Interactable = false
				spawnBtn.BackgroundColor3 = Color3.fromRGB(127, 127, 127)
			end

			local slotRecipeOutput = recipe.Output

			for _, podiumData in pairs(v70) do
				if type(podiumData) == "table" and podiumData.Machine
					and podiumData.Machine.Type == machineType
					and podiumData.Machine.RecipeKey == slotRecipeOutput
					and not podiumData.Machine.Active then
					local cleanName = tostring(podiumData.Index):match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
					v71[cleanName] = (v71[cleanName] or 0) + 1
				end
			end
			for idx, pd in pairs(v70) do
				if type(pd) == "table" and pd.Machine then
				end
			end

			local allMet = true
			local anyReq = false
			for reqName, templateList in pairs(v61) do
				anyReq = true
				local cleanReqName = tostring(reqName):match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
				local ownedCount = v71[cleanReqName] or 0
				for i, templateClone in ipairs(templateList) do
					local isMet = (i <= ownedCount)
					local ret = templateClone:FindFirstChild("Return", true)
					if ret then ret.Visible = isMet end
					local vp = templateClone:FindFirstChild("ViewportFrame", true)
					if vp then vp.ImageColor3 = isMet and Color3.new(1, 1, 1) or Color3.new(0, 0, 0) end
					if not isMet then
						allMet = false
					end
				end
			end

			if allMet and anyReq and spawnBtn then
				spawnBtn.Interactable = true
				spawnBtn.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
			else
			end
		end

		contentTrove:Add(v52:OnChanged("AnimalAddedOrRemoved", validateSlot))
		task.spawn(validateSlot)

		local uiQuantity = uiOutput and uiOutput:FindFirstChild("Quantity", true)
		if uiQuantity then
			local stockKey = stockKeys[slotIndex]

			local function updateStock()
				local stockValue = l_ReplicatedStorage_0:GetAttribute(stockKey)
				uiQuantity.TextColor3 = Color3.fromRGB(255, 255, 255)
				if stockValue == nil or stockValue > 0 then
					local displayText = stockValue and ("%s Left"):format(v28:Comma(stockValue)) or "Loading..."
					CustomRichTextController.apply(uiQuantity, "<rainbow>" .. displayText .. "</rainbow>")
				else
					CustomRichTextController.cleanup(uiQuantity)
					uiQuantity.TextColor3 = Color3.fromRGB(255, 0, 0)
					uiQuantity.Text = "SOLD OUT"
				end
			end

			contentTrove:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal(stockKey):Connect(updateStock))
			contentTrove:Add(function()
				CustomRichTextController.cleanup(uiQuantity)
			end)
			task.spawn(updateStock)
		end
	end
end

local v89 = {
	IsEnabled = function(_)
		return true
	end,

	Setup = function(_)
		local v52 = v10:Wait(l_LocalPlayer_0)
		if not v52 then
			warn("[Setup] FATAL: v52 (Synchronizer data) is nil for LocalPlayer!")
			return
		end

		local machineType = "Taco2"
		local contentTrove = v19.new()
		local isDoubleMode = false

		local function ClearCurrentUI()
			for _, child in ipairs(l_Content_0:GetChildren()) do
				if child.Name == "ActiveTemplate" then child:Destroy() end
			end

			local doubleRoot = doublecontent:FindFirstChild("Content")
			if doubleRoot then
				for _, child in ipairs(doubleRoot:GetChildren()) do
					if child.Name == "ActiveSlot1" or child.Name == "ActiveSlot2" then
						child:Destroy()
					end
				end
			end

			if l_StockMachine_0:FindFirstChild("Subtitle") then
				l_StockMachine_0.Subtitle.Visible = true
			end
		end

		local function RenderMachineContent()
			contentTrove:Clean()
			ClearCurrentUI()

			local key1 = l_ReplicatedStorage_0:GetAttribute("LockedRecipe_"       .. machineType)
			local key2 = l_ReplicatedStorage_0:GetAttribute("LockedRecipe2_"      .. machineType)
			local ing1 = l_ReplicatedStorage_0:GetAttribute("LockedIngredients_"  .. machineType)
			local ing2 = l_ReplicatedStorage_0:GetAttribute("LockedIngredients2_" .. machineType)



			if not key1 then
				return
			end

			local function parseIngredients(raw)
				if not raw then return nil end
				local result = {}
				for _, name in ipairs(string.split(raw, ",")) do
					local clean = name:match("^%s*(.-)%s*$"):gsub("[\n\r]", "")
					if clean ~= "" then table.insert(result, clean) end
				end
				return #result > 0 and result or nil
			end

			local inputs1 = parseIngredients(ing1)
			if not inputs1 then
				warn("[RenderMachineContent] inputs1 is nil after parsing - aborting")
				return
			end

			local recipe1 = { Output = key1, Inputs = inputs1 }

			if key2 and ing2 then
				local inputs2 = parseIngredients(ing2)
				if inputs2 then
					local recipe2 = { Output = key2, Inputs = inputs2 }
					isDoubleMode = true
					renderDoubleStock(v52, machineType, recipe1, recipe2, contentTrove)
					return
				else
					warn("[RenderMachineContent] key2 exists but inputs2 failed to parse - falling back to single")
				end
			end
			isDoubleMode = false
			renderSingleStock(v52, machineType, recipe1, contentTrove)
		end

		RenderMachineContent()

		l_ReplicatedStorage_0:GetAttributeChangedSignal("RecipeUpdateTick_Taco2"):Connect(function()
			RenderMachineContent()
		end)

		l_ReplicatedStorage_0:GetAttributeChangedSignal("LockedRecipe2_Taco2"):Connect(function()
			RenderMachineContent()
		end)
	end
}

v89.Start = function(v90)
	l_StockMachine_0.Visible = false
	doublecontent.Visible = false

	v48 = v24:Register("StockMachine",       l_StockMachine_0, "TopQuint")
	v48Double = v24:Register("DoubleStockMachine", doublecontent,    "TopQuint")

	v48:AttachCloseButton(l_Close_0)
	v48Double:AttachCloseButton(l_DoubleClose_0)

	v48:Close()
	v48Double:Close()

	v48.OnOpen:Connect(function()
		v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "Taco2", true)
	end)
	v48.OnClose:Connect(function()
		v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "Taco2", false)
	end)
	v48Double.OnOpen:Connect(function()
		v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "Taco2", true)
	end)
	v48Double.OnClose:Connect(function()
		v40:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "Taco2", false)
	end)

	task.spawn(v90.Setup, v90)

	v14.observeTag("StockMachinePrompt", function(v91)
		local v92 = v19.new()
		local function v93()
			if not v10:Wait(l_LocalPlayer_0) then return end
			v91.Enabled = v89:IsEnabled()
		end
		v92:Add(task.spawn(function()
			if not v10:Wait(l_LocalPlayer_0) then return end
			v92:Add(v18.Simple(1, v93))
			task.spawn(v93)
		end))
		v92:Add(v91.Triggered:Connect(function()
			if not v10:Get(l_LocalPlayer_0) then
				warn("[Prompt] v10:Get returned nil - player data not ready?")
				return
			end
			local key2 = l_ReplicatedStorage_0:GetAttribute("LockedRecipe2_Taco2")
			local ing2  = l_ReplicatedStorage_0:GetAttribute("LockedIngredients2_Taco2")
			if key2 and ing2 then
				v24:Toggle("DoubleStockMachine")
			else
				v24:Toggle("StockMachine")
			end
		end))
		return function() v92:Destroy() end
	end)

	local isProcessing = false

	v14.observeTag("StockMachine", function(v94)
		local v_u_135 = v19.new()

		local hitboxesFolder = v94:FindFirstChild("Hitboxes")
		if not hitboxesFolder then
			warn("[StockMachine tag] FATAL: Missing 'Hitboxes' folder on tagged object:", v94.Name)
			return
		end

		for _, v_u_136 in hitboxesFolder:GetChildren() do
			v_u_135:Add(v_u_136.Touched:Connect(function(p137)
				if isProcessing then
					return
				end
				if p137.Name == "HumanoidRootPart" then
					local v138 = l_Players_0:GetPlayerFromCharacter(p137.Parent)
					if v138 and v138 == l_LocalPlayer_0 then
						local currentStealIndex = v138:GetAttribute("StealingIndex")

						if currentStealIndex then
							isProcessing = true
							v138:SetAttribute("StealingIndex", nil)

							local mType = v94:GetAttribute("MachineType") or "Taco2"
							local recipeKey = l_ReplicatedStorage_0:GetAttribute("LockedRecipe_" .. mType)
								or v94:GetAttribute("RecipeKey") or "La Romantic Grande"




							local success = v43:InvokeServer(v_u_136, mType, recipeKey)

							if success then
								task.spawn(function()
									v26:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit)
								end)
							else
								warn("[Touched] Delivery FAILED - restoring StealingIndex:", currentStealIndex)
								v138:SetAttribute("StealingIndex", currentStealIndex)
							end

							task.wait(0.5)
							isProcessing = false
						else
						end
					end
				end
			end))
		end

		return function()
			v_u_135:Destroy()
		end
	end)
end

return v89