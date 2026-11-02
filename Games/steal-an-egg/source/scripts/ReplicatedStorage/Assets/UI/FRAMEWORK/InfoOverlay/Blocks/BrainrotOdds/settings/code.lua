-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemUI = require(ReplicatedStorage.Library.Client.UI.ItemUI)
local BrainrotItem = require(ReplicatedStorage.Library.Items.BrainrotItem)
local Rainbow = require(ReplicatedStorage.Library.Client.GUIFX.Rainbow)
local FormatFigures = require(ReplicatedStorage.Library.Functions.FormatFigures)

require(ReplicatedStorage.Library.Items.BrainrotEggItem)

local BrainrotEggChanceUtil = require(ReplicatedStorage.Library.Util.BrainrotEggChanceUtil)
local BrainrotEggIconScaleUtil = require(ReplicatedStorage.Library.Util.BrainrotEggIconScaleUtil)
local Assets = ReplicatedStorage:WaitForChild("Assets")

return function(p1, p2, p3) --[[ Line: 15 | Upvalues: BrainrotEggChanceUtil (copy), BrainrotItem (copy), Assets (copy), ItemUI (copy), BrainrotEggIconScaleUtil (copy), Rainbow (copy), FormatFigures (copy) ]]
	local v1 = p3:Directory()
	local v2 = v1.RarityData and v1.RarityData.TotalOdds or 0
	local v3 = p3:GetData()
	local v4 = if v3 then v3.Mutations else nil
	local v6 = BrainrotEggChanceUtil.ComputeRewardChance(BrainrotEggChanceUtil.GetBaseRewardChance(v1), v4)

	for i, v in ipairs(v1.DropTable) do
		local v10 = v6 * (if v2 > 0 then v[2] / v2 else 0) * 100
		local v11 = BrainrotItem(v[1])
		local v12 = Assets.UI.Eggs.Brainrot:Clone()
		local v13 = ItemUI.Create(v11, {
			NoActionMenu = true,
			NoOverlay = true,
			NoButtonFX = true,
			HideQuantity = true,
			HideStrength = true
		})
		local Icon = v13:FindFirstChild("Icon")

		if Icon and Icon:IsA("ImageLabel") then
			BrainrotEggIconScaleUtil.ApplyIconScaleToImageLabel(Icon, if v3 then v3.Scale else v3)
		end

		v12.LayoutOrder = 9999 - v10 * 20

		if v10 < 0.1 then
			v12.Chance.Text = "??"
			Rainbow(v12.Chance, "TextColor3")
		else
			local v16 = math.clamp(math.pow(0.9315, v10) * 94.2467 / 100, 0, 1)
			local v17, v18, v19 = Color3.fromRGB(49, 255, 39):Lerp(Color3.fromRGB(255, 75, 39), v16):ToHSV()

			v12.Chance.TextColor3 = Color3.fromHSV(v17, v18, v19 * 2)
			v12.Chance.Text = ("%*%%"):format((FormatFigures(v10, 3, 5)))
		end

		v13.Parent = v12
		v12.Parent = p1
	end
end