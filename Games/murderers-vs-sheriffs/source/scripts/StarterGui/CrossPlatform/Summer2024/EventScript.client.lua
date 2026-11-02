local v_u_1 = script.Parent
local Container = v_u_1:WaitForChild("Container")
local v3 = require(script.Button)
local v4 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local v_u_5 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService")):GetCurrentEvent()
if v_u_5 then
	if v_u_5.Active and v_u_5.Name == "Summer" then
		local v_u_6 = v_u_5.Remotes

		local Button = require(script:WaitForChild("Button"))
		
		local EventFrames = Container:WaitForChild("EventFrames")
		local MainRewards = EventFrames:WaitForChild("MainRewards")
		local ExtraRewards = EventFrames:WaitForChild("ExtraRewards")
		local RareEggs = EventFrames:WaitForChild("RareEggs")
		
		local EggList = RareEggs:WaitForChild("Content_Eggs"):WaitForChild("EggList")
		local Amount = MainRewards:WaitForChild("Content_Rewards"):WaitForChild("Info"):WaitForChild("Currency"):WaitForChild("Amount")
		local Amount2 = ExtraRewards:WaitForChild("MysteryBox"):WaitForChild("Info"):WaitForChild("Currency"):WaitForChild("Container"):WaitForChild("Amount")
		local ExtraContainerButton = Button.createButton(MainRewards:WaitForChild("Content_Shop"):WaitForChild("ExtraContainer"):WaitForChild("ButtonFrame"))
		
		Button.createButton(ExtraRewards:WaitForChild("MysteryBox"):WaitForChild("Info"):WaitForChild("Back"))
		
		require(script:WaitForChild("GodlyShop"))
		
		local v_u_12 = v3.createButton(Container:WaitForChild("Title"):WaitForChild("Close"))
		--local v_u_13 = v3.createButton(MainRewards:WaitForChild("Content_Shop"):WaitForChild("RareEggContainer"):WaitForChild("RareEggs"))
		local v_u_14 = v3.createButton(RareEggs:WaitForChild("Content_Eggs"):WaitForChild("Back"))
		local v_u_15 = RareEggs:WaitForChild("Content_Rewards"):WaitForChild("Rewards"):WaitForChild("Container")
		local v_u_16 = MainRewards:WaitForChild("Content_Rewards"):WaitForChild("Rewards"):WaitForChild("Container")
		local CoinCollected = v4:WaitForChild("Gameplay"):WaitForChild("CoinCollected")
		
		local ProfileData = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
		local Sync = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
		local WindowService = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService01"))
		
		local MysteryBox = require(script:WaitForChild("MysteryBox"))
		local PurchaseCurrency = require(script:WaitForChild("PurchaseCurrency"))
		local GuiService = game:GetService("GuiService")
		local Weapons = Sync.Weapons
		local Effects = Sync.Effects
		local Toys = Sync.Toys
		local Rarity = Sync.Rarity
        local v_u_21 = v_u_5.RewardTracks
        local function v_u_28(p22, p23)
            local v24 = 1
            for v25, v26 in p22.Rewards do
                if v26.Cost > p23 then
                    break
                end
				local v27 = p22.Rewards[v25 + 1]
                if v27 == nil then
                    v24 = v25 + 1
                elseif p23 < v27.Cost then
                    return v25 + 1
                end
            end
            return v24
        end
        local function v_u_40(p29, p30)
            local v31 = v_u_21[p29].Rewards[p30]
			local RewardFrame = script:WaitForChild("RewardFrame"):Clone()
			local ItemName = v31.ItemName
			local v34 = Sync.Weapons[ItemName] or (Sync.Effects[ItemName] or Sync.Toys[ItemName])
			
            if v34 == nil then
                print(p29, p30)
			end
			
			if p29 == "Rare" then
				RewardFrame.Required.Icon:Destroy()
				RewardFrame.Required.IconMover:Destroy()
				RewardFrame.Required.Amount.Position = UDim2.new(0, 0, 1, 0)
			end
			
			RewardFrame.Reward.ItemName.Text = v34.ItemName or v34.Name
			RewardFrame.Reward.ItemName.TextColor3 = Rarity[v34.Rarity or "Common"]
			RewardFrame.Reward.IconContainer.Icon.Image = v34.Image
			RewardFrame.Required.Amount.Text = v31.Cost
			RewardFrame:SetAttribute("Cost", v31.Cost)
			RewardFrame:SetAttribute("Track", p29)
			RewardFrame:SetAttribute("Index", p30)
			RewardFrame:SetAttribute("ItemID", ItemName)
			RewardFrame.Reward.Claim.Activated:Connect(function() --[[ Line: 80 | Upvalues: v2 (copy), v4 (ref), ItemName (copy), ProfileData (ref), Title (ref) ]]
				local Index = RewardFrame:GetAttribute("Index")

				v4.ClaimTrackReward:FireServer("Common", Index)
				RewardFrame.Reward.Completed.Visible = true
				RewardFrame.Reward.Claim.Visible = false
				ProfileData[v_u_5.Title].Claimed[ItemName .. Index] = true
			end)
			
			return RewardFrame
		end
		
        local function v_u_48(p41, p42)
            p41:GetAttribute("Track")
            local v43 = p41:GetAttribute("Index")
            local v44 = p41:GetAttribute("ItemID") .. v43
			local v45 = ProfileData[v_u_5.Title].Claimed[v44] == true
            p41.Reward.Locked.Visible = p42 <= v43
            p41.Reward.Locked.TextLabel.Visible = v43 > 1
            local v46 = p41.Reward.Claim
            local v47
            if v43 < p42 then
                v47 = not v45
            else
                v47 = false
            end
            v46.Visible = v47
            p41.Reward.Completed.Visible = v45
		end
		
        local function v_u_51(p49)
            for _, v50 in pairs(p49:GetChildren()) do
                if v50:IsA("Frame") then
                    v50:Destroy()
                end
            end
		end
		
        local function v_u_60(p52, p53)
            v_u_51(p53)
            local v54 = v_u_28
            local v55 = v_u_21[p52]
            local v56 = v_u_21[p52].RequiredMaterial
			local v57 = v54(v55, ProfileData.Summer2024[v56] or 0)
            for v58, _ in v_u_21[p52].Rewards do
                local v59 = v_u_40(p52, v58)
                v_u_48(v59, v57)
                v59.Parent = p53
            end
		end
		
        local function v_u_62()
			for v61, _ in ProfileData[v_u_5.Title].RareEggs do
				if EggList:FindFirstChild(v61) then
					EggList[v61].Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
        local function v_u_73()
			local v2 = v_u_28(v_u_21.Common, ProfileData.Materials.Owned.BeachBalls2024 or 0)

			for v3, v4 in v_u_16:GetChildren() do
				if v4:IsA("Frame") then
					v_u_48(v4, v2)
				end
			end

			Amount2.Text = ProfileData.Materials.Owned.BeachBalls2024_Box or 0
			Amount.Text = "You\'ve collected: " .. (ProfileData.Materials.Owned.BeachBalls2024 or 0)
		end
		
        function onEventOpened()
            v_u_73()
		end
		
		local function v_u_76(p74, _, _, p75)
			if not v_u_1.Visible or p74 ~= "BeachBall" then
				return
			end
			v_u_73()
		end
		
		v_u_1.Visible = false
		function v_u_12.clickEnd()
			WindowService:Back()
		end
		v_u_60("Common", v_u_16)
		function ExtraContainerButton.clickEnd()
			MainRewards.Visible = false
			ExtraRewards.Visible = true
		end
		CoinCollected.OnClientEvent:Connect(v_u_76)
		
		if v_u_1.Visible then
			onEventOpened()
		end
		
		if GuiService:IsTenFootInterface() then
			Container.UIScale.Scale = 1.5
		end
		
		PurchaseCurrency.Initialize(v_u_5.Title, "SummerKey2024")
		MysteryBox.Initialize(v_u_5.Title, 2024, "BeachBalls2024_Box", "BeachBalls2024", "SummerKey2024")
		WindowService:RegisterFrame(v_u_1, "CurrentEvent", onEventOpened)
		Amount.Parent:WaitForChild("Frame"):WaitForChild("Icon").Image = Sync.Materials[v_u_5.Currency].Image
    end
else
    return
end