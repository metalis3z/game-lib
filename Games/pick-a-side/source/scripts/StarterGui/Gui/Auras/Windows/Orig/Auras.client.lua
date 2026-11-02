-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:46
-- Luau version 6, Types version 3
-- Time taken: 0.007835 seconds

-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
-- KONSTANTERROR: [0] 1. Error Block 47 start (CF ANALYSIS FAILED)
while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local LocalPlayer_upvr = game.Players.LocalPlayer
local Signals_upvr = game.ReplicatedStorage.Signals
local List_upvr = script.Parent.List
local var9_upvw
local Rarity_2_upvr = require(game.ReplicatedStorage.Settings.Rarity)
local var11_upvw = false
local PolicyService_upvr = game:GetService("PolicyService")
pcall(function() -- Line 29
	--[[ Upvalues[3]:
		[1]: var11_upvw (read and write)
		[2]: PolicyService_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	var11_upvw = PolicyService_upvr:GetPolicyInfoForPlayerAsync(LocalPlayer_upvr).ArePaidRandomItemsRestricted
end)
if var11_upvw then
	Signals_upvr.IsRestricted:FireServer()
end
local Element_upvr = script.Parent.Element
local Auras_upvr_2 = require(game.ReplicatedStorage.Settings.Auras)
local Auras_upvr = game.ReplicatedStorage.Auras
local function Update() -- Line 41
	--[[ Upvalues[7]:
		[1]: List_upvr (readonly)
		[2]: CLIENT_DATA_upvr (readonly)
		[3]: Element_upvr (readonly)
		[4]: Auras_upvr_2 (readonly)
		[5]: Auras_upvr (readonly)
		[6]: Rarity_2_upvr (readonly)
		[7]: Signals_upvr (readonly)
	]]
	for _, v in List_upvr:GetChildren() do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
	local data = CLIENT_DATA_upvr.data
	for i_2_upvr, _ in data.auras do
		local clone = Element_upvr:Clone()
		clone.Name = i_2_upvr
		if data.aura == i_2_upvr then
			clone.Checkmark.Visible = true
		end
		local Title = clone.Title
		local var27 = Auras_upvr_2[i_2_upvr]
		local font = var27.font
		Title.TextColor3 = var27.color
		Title.FontFace = Font.new(font.family, font.weight, font.style)
		Title.UIGradient.Color = var27.gradient
		Title.UIGradient.Rotation = var27.rotation
		Title.UIStroke.Color = var27.stroke
		Title.UIStroke.Thickness = var27.thickness
		Title.Text = i_2_upvr
		local Rarity = Auras_upvr[i_2_upvr]:GetAttribute("Rarity")
		clone.LayoutOrder = -Rarity
		clone.Background.ImageColor3 = Rarity_2_upvr[Rarity].color
		clone.Visible = true
		clone.Parent = List_upvr
		clone.Activated:Connect(function() -- Line 75
			--[[ Upvalues[2]:
				[1]: Signals_upvr (copied, readonly)
				[2]: i_2_upvr (readonly)
			]]
			Signals_upvr.EquipAura:FireServer(i_2_upvr)
		end)
	end
end
Update()
CLIENT_DATA_upvr.change.Event:connect(Update)
if var9_upvw then
	var9_upvw.Visible = false
end
local data_3 = CLIENT_DATA_upvr.data
if not data_3.aura then
else
	var9_upvw = List_upvr[data_3.aura].Checkmark
	var9_upvw.Visible = true
end
CLIENT_DATA_upvr.change.Event:connect(function() -- Line 88, Named "UpdateEquipped"
	--[[ Upvalues[3]:
		[1]: var9_upvw (read and write)
		[2]: CLIENT_DATA_upvr (readonly)
		[3]: List_upvr (readonly)
	]]
	if var9_upvw then
		var9_upvw.Visible = false
	end
	local data_2 = CLIENT_DATA_upvr.data
	if not data_2.aura then
	else
		var9_upvw = List_upvr[data_2.aura].Checkmark
		var9_upvw.Visible = true
	end
end)
local children, NONE_2, NONE = workspace.Auras:GetChildren()
-- KONSTANTERROR: [0] 1. Error Block 47 end (CF ANALYSIS FAILED)
-- KONSTANTERROR: [201] 132. Error Block 39 start (CF ANALYSIS FAILED)
local var36_upvr = true
-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [203.19]
-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [206.21]
local ProximityPrompt = nil.ProximityPrompt
if var36_upvr then
	ProximityPrompt.ActionText = "Purchase "..nil:GetAttribute("Price").." Coins"
else
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	ProximityPrompt.ActionText = "Purchase "..nil:GetAttribute("Price")
end
-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [223.24]
local var39_upvr
-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [223.23]
local var40_upvr
-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [223.22]
local var41_upvr
ProximityPrompt.PromptShown:Connect(function() -- Line 130
	--[[ Upvalues[4]:
		[1]: var11_upvw (read and write)
		[2]: var39_upvr (readonly)
		[3]: var40_upvr (readonly)
		[4]: var41_upvr (readonly)
	]]
	if var11_upvw then
		var39_upvr.Enabled = true
	end
	var40_upvr.Enabled = true
	var41_upvr.Enabled = false
end)
ProximityPrompt.PromptHidden:Connect(function() -- Line 137
	--[[ Upvalues[3]:
		[1]: var39_upvr (readonly)
		[2]: var40_upvr (readonly)
		[3]: var41_upvr (readonly)
	]]
	var39_upvr.Enabled = false
	var40_upvr.Enabled = false
	var41_upvr.Enabled = true
end)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
ProximityPrompt.Triggered:Connect(function() -- Line 142
	--[[ Upvalues[4]:
		[1]: var36_upvr (readonly)
		[2]: Signals_upvr (readonly)
		[3]: MarketplaceService_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
	]]
	if var36_upvr then
		Signals_upvr.PurchaseAura:FireServer()
	else
		MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, 2659681036)
	end
end)
-- KONSTANTERROR: [201] 132. Error Block 39 end (CF ANALYSIS FAILED)
-- KONSTANTERROR: [149] 98. Error Block 33 start (CF ANALYSIS FAILED)
for _ in var36_upvr, nil:GetAttribute("Price"), ProximityPrompt do
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
end
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
if nil:GetAttribute("Price") ~= "Normal" then
	-- KONSTANTWARNING: GOTO [202] #133
end
-- KONSTANTERROR: [149] 98. Error Block 33 end (CF ANALYSIS FAILED)