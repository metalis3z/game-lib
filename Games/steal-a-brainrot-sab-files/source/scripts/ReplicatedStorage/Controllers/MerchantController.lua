-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local ServerStorage = game:GetService("ServerStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Serialization = require(ReplicatedStorage.Packages.Serialization)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Mutations = require(ReplicatedStorage.Shared.Mutations)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local Marketplace = require(ReplicatedStorage.Shared.Marketplace)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local CharacterController = require(ReplicatedStorage.Controllers.CharacterController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local PlotController = require(ReplicatedStorage.Controllers.PlotController)
local ShopController = require(ReplicatedStorage.Controllers.ShopController)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Updates = require(ReplicatedStorage.Shared.Updates)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Index = require(ReplicatedStorage.Shared.Index)
local Mutations_2 = require(ReplicatedStorage.Datas.Mutations)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals_2 = require(ReplicatedStorage.Datas.Animals)
local MerchantData = require(ReplicatedStorage.Datas.MerchantData)

local LocalPlayer = Players.LocalPlayer

local Merchant = LocalPlayer.PlayerGui:WaitForChild("Merchant").Merchant

local Frame = Merchant.Frame

local List = Frame.List
local Close = Frame.Header.Close

local merchantServiceSetFocused = Net:RemoteEvent("MerchantService/SetFocused")
local merchantServiceAnimation = Net:RemoteEvent("MerchantService/Animation")
local shopServicePurchase = Net:RemoteEvent("ShopService/Purchase")
local merchantServiceBuy = Net:RemoteFunction("MerchantService/Buy")

local registerResult = nil

local flag_4 = RunService:IsStudio() and false

local data = {}

local function _(val5)

    return (("StockEvent_%*"):format((string.gsub(val5, "%s", "_"))))
end

local function _(loadAnimationObj, val6, addObj_2)
    local v57Track = loadAnimationObj:LoadAnimation(val6)
    addObj_2:Add(function()

        v57Track:Stop(0)
        v57Track:Destroy()
    end)

    return v57Track
end

local function getIntervalInSeconds(val7)

    local serverTimeNow = os.date("!*t", (val7 or workspace:GetServerTimeNow()) // 1).wday
    if serverTimeNow == 1 or serverTimeNow == 7 then

        return (FFlags:GetInstant("WeekendMerchantRefreshTime", 1800))
    else

        return (FFlags:GetInstant("WeekdayMerchantRefreshTime", 1800))
    end
end

local function _(val8)

    local serverTimeNow_2 = val8 or workspace:GetServerTimeNow()
    local val9 = getIntervalInSeconds(serverTimeNow_2)

    return serverTimeNow_2 + (val9 - serverTimeNow_2 % val9)
end

data.Start = function(_)
    if true then return end
    Merchant.Visible = false
    registerResult = InterfaceController:Register("Merchant", Merchant, "TopQuint")
    registerResult:AttachCloseButton(Close)
    registerResult.OnOpen:Connect(function()

        merchantServiceSetFocused:FireServer("7ba6d59b-1832-466e-bf4e-f0988adec9d0", true)
    end)
    registerResult.OnClose:Connect(function()

        merchantServiceSetFocused:FireServer("7ba6d59b-1832-466e-bf4e-f0988adec9d0", false)
    end)
    registerResult:Close()

    local function renderBrainrotAtFrame(ref1, titleText)

        local animals_2Data = Animals_2[titleText]
        if not animals_2Data then
            return
        else
            local rarityData = Rarities[animals_2Data.Rarity]
            ref1.Title.Text = titleText
            if rarityData.GradientPreset then
                ref1.UIStroke.Color = Color3.new(1, 1, 1)
                ref1.Title.TextColor3 = Color3.new(1, 1, 1)
                Gradients.apply(ref1.UIStroke, rarityData.GradientPreset)
                Gradients.apply(ref1.Title, rarityData.GradientPreset)
            else
                ref1.UIStroke.Color = rarityData.Color
                ref1.Title.TextColor3 = rarityData.Color
            end
            ref1.Visible = true
            Animals:AttachOnViewportWithOptimizations(titleText, ref1.ViewportFrame)
            return
        end
    end
    local val10 = table.create(#MerchantData.Brainrots)
    local displayText = nil
    local remoteObj = Signal.new()
    local remoteObj_2 = Signal.new()
    for brainrotId, brainrot in MerchantData.Brainrots do
        local Brainrot = brainrot.Brainrot
        local animals_2Data_2 = Animals_2[Brainrot]
        local layoutOrder = List.UIListLayout[brainrot.Template or "Normal"]:Clone()
        val10[brainrotId] = layoutOrder
        layoutOrder.Visible = true
        layoutOrder.LayoutOrder = (brainrotId - 1) * 2
        local ref2 = if brainrot.ProductId then List.UIListLayout.DropdownFull:Clone() else List.UIListLayout.DropdownCoins:Clone()
        ref2.LayoutOrder = layoutOrder.LayoutOrder + 1
        ref2.Size = UDim2.fromScale(0.973, 0)
        ref2.Visible = false
        ref2.Parent = List
        renderBrainrotAtFrame(layoutOrder.Spacer.Brainrot, Brainrot)

        local function updateStock()

            local serverTimeNow_3 = DateTime.fromUnixTimestamp(workspace:GetServerTimeNow())
            local val11 = serverTimeNow_3:FormatUniversalTime("YYYY", "en-us")
            local val12 = serverTimeNow_3:FormatUniversalTime("MM", "en-us")
            local val13 = serverTimeNow_3:FormatUniversalTime("DD", "en-us")
            local val14 = serverTimeNow_3:FormatUniversalTime("HH", "en-us")
            local val15 = (tonumber((serverTimeNow_3:FormatUniversalTime("mm", "en-us"))) or 0) < 30 and "00" or "30"
            local val16 = ("%*-%*%*%*-%*%*"):format(brainrot.StockKey, val11, val12, val13, val14, val15)
            local attribute = ReplicatedStorage:GetAttribute((("StockEvent_%*"):format((string.gsub(val16, "%s", "_"))))) or 0
            if flag_4 then
                attribute = 1
            end
            layoutOrder.Spacer.Left.Txt.Text = if attribute > 0 then ("%* Left"):format((NumberUtils:Comma(attribute))) else "SOLD OUT"
            layoutOrder.Spacer.Left.BackgroundColor3 = if attribute > 0 then Color3.fromRGB(33, 135, 40) else Color3.fromRGB(185, 52, 52)
            ref2.Spacer.Cash.BackgroundColor3 = if attribute > 0 then Color3.fromRGB(81, 158, 86) else Color3.fromRGB(127, 127, 127)
            ref2.Spacer.Cash.Interactable = attribute > 0
        end
        updateStock()
        remoteObj_2:Connect(updateStock)
        ReplicatedStorage.AttributeChanged:Connect(function(val17)

            if string.find(val17, "StockEvent_", 1, true) then
                updateStock()
            end
        end)
        layoutOrder.Spacer.DropRate.Text = ("$%*/s"):format((NumberUtils:ToString(Animals:GetGeneration(Brainrot))))
        if animals_2Data_2 then
            ref2.Spacer.Cash.Txt.Text = ("$%*"):format((NumberUtils:ToString(animals_2Data_2.Price or 0)))
        else
            ref2.Spacer.Cash.Txt.Text = "$???"
        end

        if brainrot.ProductId then
            ref2.Spacer.Robux.Txt.Text = "\238\128\130???"
            task.spawn(function()

                local function _(flag_5)

                    if flag_5 == 999999999 then

                        return "???"
                    else

                        return (NumberUtils:Comma(flag_5))
                    end
                end
                local l_v22_ProductInfo_0 = Marketplace:GetProductInfo(brainrot.ProductId, "Product")
                local Txt = ref2.Spacer.Robux.Txt
                local text = "\238\128\130%*"
                local val18 = l_v22_ProductInfo_0.PriceInRobux or 999999999
                Txt.Text = text:format(val18 == 999999999 and "???" or NumberUtils:Comma(val18))
            end)
        end
        layoutOrder.Spacer.Txt.Text = Brainrot
        if animals_2Data_2 then
            local rarityData_2 = Rarities[animals_2Data_2.Rarity]
            if rarityData_2.GradientPreset then
                layoutOrder.Spacer.Txt.TextColor3 = Color3.new(1, 1, 1)
                Gradients.apply(layoutOrder.Spacer.Txt, rarityData_2.GradientPreset)
            else
                layoutOrder.Spacer.Txt.TextColor3 = rarityData_2.Color
            end
        end
        layoutOrder.Parent = List
        remoteObj:Connect(function(flag_2, flag_3)

            if flag_2 == layoutOrder then
                ref2.Visible = true
                Spr.target(ref2, 0.9, 6, {
                    Size = UDim2.fromScale(0.973, 0.192)
                })
                local val1 = layoutOrder.AbsolutePosition.Y - List.AbsolutePosition.Y + List.CanvasPosition.Y
                if flag_3 ~= nil and flag_3 ~= flag_2 and table.find(val10, flag_3) < brainrotId then
                    val1 = val1 - 0.192 * List.AbsoluteSize.Y
                end
                Spr.target(List, 1, 4, {
                    CanvasPosition = Vector2.new(0, val1)
                })
                return
            else
                Spr.target(ref2, 1, 6, {
                    Size = UDim2.fromScale(0.973, 0)
                })
                Spr.completed(ref2, function()

                    if ref2.Size.Y.Scale < 0.01 then
                        ref2.Visible = false
                    end
                end)
                return
            end
        end)
        AnimatedButton.new(layoutOrder.Spacer).OnActivated:Connect(function()

            SoundController:PlaySound("Sounds.Sfx.Activated")
            local v75 = displayText
            displayText = if displayText == layoutOrder then nil else layoutOrder
            remoteObj:Fire(displayText, v75)
        end)
        local animateObj = AnimatedButton.new(ref2.Spacer.Cash)
        animateObj:Animate()
        animateObj.OnActivated:Connect(function()

            if merchantServiceBuy:InvokeServer("ecc73d8c-17e6-4b24-9848-2fb6bfa162b0", brainrotId) then
                SoundController:PlaySound("Sounds.Sfx.Success")
                InterfaceController:SetState("Merchant", false)
            end
        end)

        if brainrot.ProductId then
            local animateObj_2 = AnimatedButton.new(ref2.Spacer.Robux)
            animateObj_2:Animate()
            animateObj_2.OnActivated:Connect(function()

                shopServicePurchase:FireServer(brainrot.ProductId)
            end)
            local animateObj_3 = AnimatedButton.new(ref2.Spacer.Gift)
            animateObj_3:Animate()
            animateObj_3.OnActivated:Connect(function()

                if ShopController.GiftFrame.Visible then
                    return
                else
                    ShopController:RemoveGiftingTarget()
                    ShopController:OpenGiftingScreen()
                    ShopController.GiftFrame:GetPropertyChangedSignal("Visible"):Wait()
                    if not registerResult:IsOpened() then
                        return
                    else
                        local l_v29_GiftingTarget_0 = ShopController:GetGiftingTarget()
                        if l_v29_GiftingTarget_0 then
                            shopServicePurchase:FireServer(brainrot.ProductId, l_v29_GiftingTarget_0)
                        end
                        ShopController:RemoveGiftingTarget()
                        return
                    end
                end
            end)
        end
    end

    local function updateMutation()

        local mutationVisible = Mutations.get()
        Frame.Mutation.Visible = mutationVisible ~= nil
        if mutationVisible ~= nil then
            Spr.target(Frame.Mutation, 1, 4, {
                Position = UDim2.fromScale(0.5, 1.01)
            })
            Spr.target(Frame, 1, 4, {
                Position = UDim2.fromScale(0.5, 0.44)
            })
        else
            Spr.target(Frame.Mutation, 1, 4, {
                Position = UDim2.fromScale(0.5, 0.9)
            })
            Spr.target(Frame, 1, 4, {
                Position = UDim2.fromScale(0.5, 0.5)
            })
        end

        if mutationVisible then
            local mutations_2Data = Mutations_2[mutationVisible]
            assert(mutations_2Data)
            Frame.Mutation.Frame.Icon.Image = mutations_2Data.Icon
            Frame.Mutation.Frame.Txt.Text = ("10%% Chance of buying %*"):format(mutations_2Data.DisplayText)
            if mutationVisible == "YinYang" then
                Frame.Mutation.UIStroke.UIGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.49, Color3.new(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.51, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
                })
                return
            else
                Frame.Mutation.UIStroke.UIGradient.Color = ColorSequence.new(mutations_2Data.MainColor)
            end
        end
    end
    Mutations.watch(updateMutation)
    updateMutation()

    local function _(val2)
        if (tonumber((DateTime.fromUnixTimestamp(val2 or workspace:GetServerTimeNow()):FormatUniversalTime("mm", "en-us"))) or 0) < 30 then

            return "00"
        else

            return "30"
        end
    end
    local serverTimeNow_4 = (tonumber((DateTime.fromUnixTimestamp((workspace:GetServerTimeNow())):FormatUniversalTime("mm", "en-us"))) or 0) < 30 and "00" or "30"
    Timer.Simple(1, function()

        local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
        local formatObj = "Restocking in %*"
        local v31 = TimeUtils
        local serverTimeNow_5 = l_workspace_ServerTimeNow_0 or workspace:GetServerTimeNow()
        local val3 = getIntervalInSeconds(serverTimeNow_5)
        local txt1Text = formatObj:format((v31:E(serverTimeNow_5 + (val3 - serverTimeNow_5 % val3) - l_workspace_ServerTimeNow_0)))
        formatObj = (tonumber((DateTime.fromUnixTimestamp(l_workspace_ServerTimeNow_0 or workspace:GetServerTimeNow()):FormatUniversalTime("mm", "en-us"))) or 0) < 30 and "00" or "30"
        if serverTimeNow_4 ~= formatObj then
            serverTimeNow_4 = formatObj
            remoteObj_2:Fire()
        end
        Frame.Header.Txt1.Text = txt1Text
        local Merchant_2 = workspace:FindFirstChild("Merchant")
        if Merchant_2 then
            Merchant_2.Overhead.BillboardGui.Countdown.Text = txt1Text
        end
    end)
    Observers.observeTag("MerchantNPC", function(getPivotObj)

        local addObj = Trove.new()
        local Animator = getPivotObj.Humanoid.Animator
        local tweenObj = Animator:LoadAnimation(script.Idle)
        local v125 = tweenObj
        addObj:Add(function()

            v125:Stop(0)
            v125:Destroy()
        end)
        local v125_2 = tweenObj
        v125_2.Priority = Enum.AnimationPriority.Idle
        v125_2.Looped = true
        v125_2:Play()
        local tweenObj_2 = Animator:LoadAnimation(script.IdleToAction)
        local v128 = tweenObj_2
        addObj:Add(function()

            v128:Stop(0)
            v128:Destroy()
        end)
        local v128_2 = tweenObj_2
        v128_2.Priority = Enum.AnimationPriority.Action
        local managedObj = Animator:LoadAnimation(script.ActionIdle)
        addObj:Add(function()

            managedObj:Stop(0)
            managedObj:Destroy()
        end)
        tweenObj = managedObj
        tweenObj.Priority = Enum.AnimationPriority.Movement
        tweenObj.Looped = true
        local managedObj_2 = Animator:LoadAnimation(script.ActionToIdle)
        addObj:Add(function()

            managedObj_2:Stop(0)
            managedObj_2:Destroy()
        end)
        tweenObj_2 = managedObj_2
        tweenObj_2.Priority = Enum.AnimationPriority.Action
        addObj:Add(v128_2.Stopped:Connect(function()

            tweenObj:Play()
        end))
        addObj:Add(tweenObj.Stopped:Connect(function()

            tweenObj_2:Play()
        end))
        addObj:Add(merchantServiceAnimation.OnClientEvent:Connect(function(_, val4)

            local cloneObj = script.SpawnEffects:FindFirstChild(val4) or script.SpawnEffects.Rare
            if not cloneObj then
                return
            else
                v128_2:Play()
                task.wait(0.5)
                local pivot = getPivotObj:GetPivot() * CFrame.new(0, 3.5, -3)
                task.spawn(function()

                    local flag = ReplicatedStorage.Sounds.Sfx.Merchant:FindFirstChild(val4)
                    if flag then
                        SoundController:PlaySound(flag, pivot.Position)
                    end
                end)
                local pivotToObj = cloneObj:Clone()
                pivotToObj:PivotTo(pivot)
                pivotToObj.Parent = workspace
                VFX.emit(pivotToObj)
                task.wait(2.5)
                tweenObj:Stop()
                return
            end
        end))

        return addObj:WrapClean()
    end, {
        workspace
    })
    Observers.observeTag("MerchantPrompt", function(triggeredObj)

        local managedObj_3 = Trove.new()

        local function updatePrompt()

            if not Synchronizer:Wait(LocalPlayer) then
                return
            else
                triggeredObj.ObjectText = "Brainrot Dealer"
                triggeredObj.ActionText = "View"
                return
            end
        end
        managedObj_3:Add(task.spawn(function()

            if not Synchronizer:Wait(LocalPlayer) then
                return
            else
                managedObj_3:Add(Timer.Simple(1, updatePrompt))
                task.spawn(updatePrompt)
                return
            end
        end))
        managedObj_3:Add(triggeredObj.Triggered:Connect(function()

            if not Synchronizer:Get(LocalPlayer) then
                return
            else
                InterfaceController:Toggle("Merchant")
                return
            end
        end))

        return function()

            managedObj_3:Destroy()
        end
    end)
end

return data
