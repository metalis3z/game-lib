-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferPage, time of decompilation: Sun May  3 10:12:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local XpTransferServiceClient = require(ReplicatedStorage.Source.Features.XpTransfer.XpTransferServiceClient)
local XpTransferServiceUtils = require(ReplicatedStorage.Source.Features.XpTransfer.XpTransferServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local XpTransferEquation = require(ReplicatedStorage.Source.Features.XpTransfer.UI.Components.XpTransferEquation)
local XpTransferPickerPanel = require(ReplicatedStorage.Source.Features.XpTransfer.UI.Components.XpTransferPickerPanel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local function toInputEntries(t1: {[any]: any}, s1: string?, s2: string?) -- line: 19
	-- upvalues: XpTransferServiceUtils (copy)
	local t2 = {}

	for v19, v20 in XpTransferServiceUtils.getTransferInputEntries(t1, s2) do
		t2[v20.uniqueId] = {
			amount = nil,
			showLevel = true,
			slimeData = v20.slimeData,
			layoutOrder = v19,
			isSelected = s1 == v20.uniqueId,
			accumulatedXp = v20.accumulatedXp
		}
	end

	return t2
end
local function toOutputEntries(t3: {[any]: any}, s3: string?, s4: string?) -- line: 39
	-- upvalues: XpTransferServiceUtils (copy)
	local v24 = if s3 ~= nil then { s3 } else {}
	local t4 = {}

	for v26, v27 in XpTransferServiceUtils.getTransferOutputEntries(t3, v24) do
		t4[v27.uniqueId] = {
			slimeData = v27.slimeData,
			amount = if not v27.stackable then nil else v27.ownedAmount,
			layoutOrder = v26,
			isSelected = s4 == v27.uniqueId,
			showLevel = not v27.stackable,
			accumulatedXp = v27.accumulatedXp
		}
	end

	return t4
end
local function getSlimeDataFromInventory(t5: {[any]: any}, s5: string?) -- line: 60
	-- upvalues: InventoryServiceUtils (copy)
	if s5 == nil then
		return nil
	end

	local v30 = t5[s5]

	if v30 == nil then
		return nil
	end

	return InventoryServiceUtils.getSlimeData(s5, v30)
end

return function() -- line: 73
	-- upvalues: getDataSource (copy), Vide (copy), toInputEntries (copy), toOutputEntries (copy), getSlimeDataFromInventory (copy), XpTransferServiceUtils (copy), XpTransferServiceClient (copy), Frame (copy), TextLabel (copy), XpTransferEquation (copy), XpTransferPickerPanel (copy), StylizedButton (copy)
	local v31 = getDataSource("inventory")
	local v32 = Vide.source(nil)
	local v33 = Vide.source(nil)
	local v34 = Vide.source("Input")
	local v35 = Vide.derive(function() -- line: 78
		-- upvalues: toInputEntries (copy), v31 (copy), v32 (copy), v33 (copy)
		return (toInputEntries(v31() or {}, v32(), v33()))
	end)
	local v36 = Vide.derive(function() -- line: 81
		-- upvalues: toOutputEntries (copy), v31 (copy), v32 (copy), v33 (copy)
		return (toOutputEntries(v31() or {}, v32(), v33()))
	end)
	local v37 = Vide.derive(function() -- line: 84
		-- upvalues: getSlimeDataFromInventory (copy), v31 (copy), v32 (copy)
		return getSlimeDataFromInventory(v31() or {}, v32())
	end)
	local v38 = Vide.derive(function() -- line: 87
		-- upvalues: getSlimeDataFromInventory (copy), v31 (copy), v33 (copy)
		return getSlimeDataFromInventory(v31() or {}, v33())
	end)
	local v39 = Vide.derive(function() -- line: 90
		-- upvalues: v37 (copy), XpTransferServiceUtils (copy)
		local v43 = v37()

		if v43 == nil then
			return 0
		end

		return XpTransferServiceUtils.getTransferableXp(v43)
	end)
	local v40 = Vide.derive(function() -- line: 98
		-- upvalues: XpTransferServiceUtils (copy), v37 (copy)
		return XpTransferServiceUtils.getDrainedInputPreview(v37())
	end)
	local v41 = Vide.derive(function() -- line: 101
		-- upvalues: XpTransferServiceUtils (copy), v38 (copy), v39 (copy)
		return XpTransferServiceUtils.getOutputPreview(v38(), v39())
	end)
	local v42 = Vide.derive(function() -- line: 104
		-- upvalues: v32 (copy), v38 (copy), v39 (copy)
		return v32() ~= nil and (v38() ~= nil and v39() > 0)
	end)

	return Frame({
		Name = "XpTransferPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		TextLabel({
			Text = "Transfer 75% of level/xp from one slime to another!",
			TextSize = 28,
			Size = UDim2.new(1, 0, 0, 28),
			Position = UDim2.fromOffset(0, 12),
			TextColor3 = Color3.fromRGB(132, 255, 153),
			Stroke = {},
			DropShadow = {}
		}),
		TextLabel({
			Text = "(Both slimes are kept)",
			TextSize = 20,
			Size = UDim2.new(1, 0, 0, 20),
			Position = UDim2.fromOffset(0, 40),
			TextColor3 = Color3.fromRGB(132, 255, 153),
			Stroke = {},
			DropShadow = {}
		}),
		XpTransferEquation({
			InputSlimeData = v37,
			OutputSlimeData = v38,
			DrainedInputSlimeData = v40,
			PreviewSlimeData = v41,
			InputSelected = function() --[[ InputSelected ]] -- line: 170
				-- upvalues: v34 (copy)
				return v34() == "Input"
			end,
			OutputSelected = function() --[[ OutputSelected ]] -- line: 173
				-- upvalues: v34 (copy)
				return v34() == "Output"
			end,
			OnSelectInput = function() --[[ OnSelectInput ]] -- line: 176
				-- upvalues: v34 (copy)
				v34("Input")
			end,
			OnSelectOutput = function() --[[ OnSelectOutput ]] -- line: 179
				-- upvalues: v34 (copy)
				v34("Output")
			end
		}),
		XpTransferPickerPanel({
			ActivePicker = v34,
			InputEntries = v35,
			OutputEntries = v36,
			OnSelectInput = function(s6: string) --[[ chooseInput ]] -- line: 108
				-- upvalues: v32 (copy), v33 (copy), v34 (copy)
				v32(s6)

				if s6 == v33() then
					v33(nil)
				end

				v34("Output")
			end,
			OnSelectOutput = function(s7: string) --[[ chooseOutput ]] -- line: 116
				-- upvalues: v32 (copy), v33 (copy), v34 (copy)
				if s7 == v32() then
					return
				end

				v33(s7)
				v34("Output")
			end
		}),
		StylizedButton({
			Text = "Transfer",
			ZIndex = 5,
			Theme = function() --[[ Theme ]] -- line: 193
				-- upvalues: v42 (copy)
				if v42() then
					return "Green"
				end

				return "Grey"
			end,
			Size = UDim2.fromOffset(190, 64),
			Position = UDim2.fromScale(0.5, 0.94),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ transfer ]] -- line: 125
				-- upvalues: v32 (copy), v33 (copy), v42 (copy), XpTransferServiceClient (copy), v34 (copy)
				local v46 = v32()
				local v47 = v33()

				if not v42() or (v46 == nil or v47 == nil) then
					return
				end

				if XpTransferServiceClient:transferXp(v46, v47) then
					v32(nil)
					v33(nil)
					v34("Input")
				end
			end
		})
	})
end
