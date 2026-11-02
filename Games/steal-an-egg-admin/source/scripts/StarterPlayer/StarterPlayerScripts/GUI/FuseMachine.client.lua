-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local Size = require(ReplicatedStorage.Shared.Utils.Collections).Size
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local FuseKernel = require(ReplicatedStorage.Shared.Util.FuseKernel)
local FuseMachineBackpackSelection = require(script.FuseMachineBackpackSelection)
local FuseMachineProgressPresentation = require(script.FuseMachineProgressPresentation)
local FuseMachineSelectedSlot = require(script.FuseMachineSelectedSlot)
local FuseMachineSignals = require(ReplicatedStorage.Client.FuseMachineSignals)
local FuseMachine = require(ReplicatedStorage.Shared.Types.FuseMachine)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = Color3.fromRGB(255, 0, 0)
local v2 = Log.new()
local v3 = TryLock()
local v4 = TryLock()
local v5 = TryLock()
local v6 = GUI.PetFuse()

v6.ResetOnSpawn = false

local FuseMain = v6.FuseMain
local GuiObject = FuseMain:IsA("GuiObject")
assert(GuiObject, "PetFuse.FuseMain must be a GuiObject")
local FuseInputs = FuseMain.FuseInputs
local Frame = FuseInputs:IsA("Frame")
assert(Frame, "PetFuse.FuseMain.FuseInputs must be a Frame")
local Fuse = FuseMain.Fuse
local ImageButton = Fuse:IsA("ImageButton")
assert(ImageButton, "PetFuse.FuseMain.Fuse must be an ImageButton")
local Price = Fuse.Price
local TextLabel = Price:IsA("TextLabel")
assert(TextLabel, "PetFuse.FuseMain.Fuse.Price must be a TextLabel")
local BackgroundColor3 = Fuse.BackgroundColor3
local v7 = BackgroundColor3:Lerp(Color3.new(0, 0, 0), 0.35)
local FusePetInventory = v6.FusePetInventory
local GuiObject_2 = FusePetInventory:IsA("GuiObject")
assert(GuiObject_2, "PetFuse.FusePetInventory must be a GuiObject")
local ScrollingFrame = FusePetInventory.ScrollingFrame
local ScrollingFrame_2 = ScrollingFrame:IsA("ScrollingFrame")
assert(ScrollingFrame_2, "PetFuse.FusePetInventory.ScrollingFrame must be a ScrollingFrame")
local Close = FusePetInventory:FindFirstChild("Close")
local Output = FuseMain.FuseOutput.Output
local Frame_2 = Output:IsA("Frame")
assert(Frame_2, "PetFuse.FuseMain.FuseOutput.Output must be a Frame")
local DesignBars = FuseMain.DesignBars
local Frame_3 = DesignBars:IsA("Frame")
assert(Frame_3, "PetFuse.FuseMain.DesignBars must be a Frame")
local Briefing = FuseMain:FindFirstChild("Briefing")
local v8

if Briefing == nil then
else
    v8 = Briefing:FindFirstChild("Ok")
end

local function inputSlot(v9) -- line 72 | captures: FuseInputs
    local v10 = FuseInputs:FindFirstChild((("Input%*"):format(v9)))
    local v11
    if v10 == nil then
        v11 = false
    else
        v11 = v10:IsA("Frame")
    end
    local v12 = ("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(v9)
    assert(v11, v12)
    return v10
end

local Machines = Workspace:WaitForChild("__OBJECTS").Machines
local Folder = Machines:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS.Machines must be a Folder")
local FuseMachine_2 = Machines.FuseMachine
local Model = FuseMachine_2:IsA("Model")
assert(Model, "Workspace FuseMachine must be a Model")
local Overhead = FuseMachine_2.Overhead
local BasePart = Overhead:IsA("BasePart")
assert(BasePart, "FuseMachine.Overhead must be a BasePart")
local BillboardGui = Overhead.BillboardGui
local BillboardGui_2 = BillboardGui:IsA("BillboardGui")
assert(BillboardGui_2, "FuseMachine.Overhead.BillboardGui must be a BillboardGui")
local Countdown = BillboardGui.Countdown
local TextLabel_2 = Countdown:IsA("TextLabel")
assert(TextLabel_2, "FuseMachine overhead Countdown must be a TextLabel")
local v13 = FuseMachineBackpackSelection.new(ScrollingFrame)
local v14 = FuseMachineProgressPresentation.new(Output, DesignBars)
local v15 = {}
local v16 = false

local function notifyError(v17) -- line 97 | captures: Message, v1
    Message.Bottom({
        Time = 3,
        Message = v17,
        Color = v1
    })
end

local function getSelectedCategory(v18) -- line 100
    local v19 = v18.FusionSlots[1]
    if v19 ~= nil then
        local v20 = v18.Inventory[v19]
        if v20 then
            return v20.Category
        end
    end
    return nil
end

local function getNoMatchMessage(v21) -- line 111 | captures: Directory
    local v22 = Directory[v21]
    local v23 = v22 ~= nil
    local v24 = ("Missing asset config %*"):format(v21)
    assert(v23, v24)
    return (("You have no other <font color=\"#%*\">%*</font> to add!"):format(v22.Rarity.Color:ToHex(), v22.DisplayName))
end

local function updateOverheadInputCount(v25) -- line 118 | captures: Countdown
    local v26
    if v25 == nil then
        v26 = 0
    else
        local v27 = v25.FusionSlots[1]
        local v28 = if v27 == nil or v25.Inventory[v27] == nil then 0 else 0 + 1
        local v29 = v25.FusionSlots[2]
        if v29 == nil or v25.Inventory[v29] == nil then
            v26 = v28
        else
            v26 = v28 + 1
        end
        local v30 = v25.FusionSlots[3]
        if v30 ~= nil and v25.Inventory[v30] ~= nil then
            v26 += 1
        end
    end
    Countdown.Text = ("%*/%*"):format(v26, 3)
end

local function destroySlot(v31) -- line 136 | captures: v15
    local v32 = v15[v31]
    if v32 then
        v32:Destroy()
        v15[v31] = nil
    end
end

local function requestReturn(v33) -- line 143 | captures: Message, Remotes, v1, v4
    v4(function() -- line 144 | captures: v33, Message, Remotes, v1
        local v34, v35 = Remotes.Fusery.EjectPet:InvokeServer(v33)
        if not v34 then
            local v36 = if typeof(v35) == "string" then v35 else "Failed to return pet"
            Message.Bottom({
                Time = 3,
                Message = v36,
                Color = v1
            })
        end
    end)
end

local function render() -- line 158 | captures: AssetItems, Directory, FuseKernel, FuseMachineSelectedSlot, Save, Simple, FuseInputs, Fuse, Price, BackgroundColor3, v7, Briefing, v14, v15, updateOverheadInputCount, requestReturn
    local function v37(v38, ...)
        table.insert(v38, ...)
    end

    local v39 = Save.Get()
    local v40 = table.create(3, false)
    if Briefing ~= nil then
        local v41 = if v39 == nil then false else not v39.FusionInfoAcknowledged
        Briefing.Visible = v41
    end
    updateOverheadInputCount(v39)
    if v39 == nil then
        Fuse.Visible = true
        Fuse.Active = false
        Fuse.BackgroundColor3 = v7
        Price.Text = ("%* Pet Left"):format(3)
        v14:Update(v40, nil)
    else
        local v42 = {}
        local v43
        for v44 = 1, 3 do
            local v45 = v39.FusionSlots[v44]
            local v46 = if v45 then v39.Inventory[v45] else nil
            local v47 = FuseInputs:FindFirstChild((("Input%*"):format(v44)))
            local v48
            if v47 == nil then
                v48 = false
            else
                v48 = v47:IsA("Frame")
            end
            local v49 = ("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(v44)
            assert(v48, v49)
            local v50
            if v45 == nil then
                local v51 = v15[v44]
                if v51 then
                    v51:Destroy()
                    v15[v44] = nil
                end
                v47.Full.Visible = false
                v47.Empty.Visible = true
                v50 = v43
            elseif v46 == nil then
                v50 = v43
            else
                v40[v44] = true
                v50 = v43 or v46.Category
                local v52 = v15[v44]
                if v52 == nil then
                    local v53 = v15[v44]
                    if v53 then
                        v53:Destroy()
                        v15[v44] = nil
                    end
                    v15[v44] = FuseMachineSelectedSlot.new(v47, v45, v46, requestReturn)
                elseif v52:GetUid() == v45 then
                end
                v37(v42, AssetItems.Decode(v46))
            end
            v43 = v50
        end
        local v54 = if #v42 == 3 then not v39.FusionLocked and v39.FusionEggReward == false else false
        local Icon
        if v43 == nil then
        else
            local v55 = Directory[v43]
            local v56 = v55 ~= nil
            local v57 = ("Missing asset config %*"):format(v43)
            assert(v56, v57)
            Icon = v55.Egg.Icon
        end
        v14:Update(v40, Icon)
        if v54 then
            for v58, v59 in ipairs(v42) do
                if v59.Category ~= v43 then
                    v54 = false
                    break
                end
            end
        end
        Fuse.Visible = true
        Fuse.Active = v54
        if v54 then
            Fuse.BackgroundColor3 = BackgroundColor3
            Price.Text = "$ " .. Simple.FormatCompact(FuseKernel.PriceFor(v42))
        else
            Fuse.BackgroundColor3 = v7
            Price.Text = ("%* Pet Left"):format(3 - #v42)
        end
    end
end

local function scheduleRender() -- line 251 | captures: v16, render
    if not v16 then
        v16 = true
        task.defer(function() -- line 256 | captures: v16, render
            v16 = false
            render()
        end)
    end
end

local function requestAcknowledgeInfo() -- line 261 | captures: v16, Message, Remotes, v1, v5, Briefing, render
    v5(function() -- line 262 | captures: v16, Message, Remotes, v1, Briefing, render
        if Briefing ~= nil and Briefing.Visible then
            if Remotes.Fusery.ConfirmBriefing:InvokeServer() == true then
                Briefing.Visible = false
            else
                Message.Bottom({
                    Message = "Failed to save Fuse Machine info acknowledgement",
                    Time = 3,
                    Color = v1
                })
                if not v16 then
                    v16 = true
                    task.defer(function() -- line 275 | captures: v16, render
                        v16 = false
                        render()
                    end)
                end
            end
        end
    end)
end

local function requestInsert(v60) -- line 281 | captures: v16, Message, Remotes, v1, v4, FusePetInventory, v13, render
    v4(function() -- line 282 | captures: v60, v16, Message, Remotes, v1, FusePetInventory, v13, render
        local v61, v62 = Remotes.Fusery.LoadPet:InvokeServer(v60)
        if v61 then
            v13:Close()
            FusePetInventory.Visible = false
            if not v16 then
                v16 = true
                task.defer(function() -- line 301 | captures: v16, render
                    v16 = false
                    render()
                end)
            end
        else
            if typeof(v62) ~= "string" then
                v62 = "Failed to insert pet"
            end
            Message.Bottom({
                Time = 3,
                Message = v62,
                Color = v1
            })
        end
    end)
end

local function startSelection() -- line 307 | captures: Directory, Message, Save, v1, FusePetInventory, v13, requestInsert
    if not v13:IsOpen() then
        local v63 = Save.Get()
        if v63 ~= nil then
            local v64 = v63.FusionSlots[1]
            local Category
            if v64 == nil then
            else
                local v65 = v63.Inventory[v64]
                if v65 then
                    Category = v65.Category
                end
            end
            if v13:Open(v63, Category, requestInsert) > 0 then
                FusePetInventory.Visible = true
                v13:RefreshGridLayout()
            elseif Category then
                local v66 = Directory[Category]
                local v67 = v66 ~= nil
                local v68 = ("Missing asset config %*"):format(Category)
                assert(v67, v68)
                local v69 = ("You have no other <font color=\"#%*\">%*</font> to add!"):format(v66.Rarity.Color:ToHex(), v66.DisplayName)
                Message.Bottom({
                    Time = 3,
                    Message = v69,
                    Color = v1
                })
            else
                Message.Bottom({
                    Message = "You do not have any pets to add!",
                    Time = 3,
                    Color = v1
                })
            end
        end
    end
end

local function requestFuse() -- line 344 | captures: v16, Audio, Size, Eggs, FuseMachineSignals, FuseMachine, Message, Remotes, Save, v1, v2, v3, render
    v3(function() -- line 345 | captures: v16, Audio, Size, Eggs, FuseMachineSignals, FuseMachine, Message, Remotes, Save, v1, v2, render
        local v70 = Save.Get()
        if v70 ~= nil then
            local v71 = Size(v70.EggInventory)
            if Eggs.MAX_INVENTORY <= v71 then
                Message.Bottom({
                    Message = "Your egg inventory is full!",
                    Time = 3,
                    Color = v1
                })
            else
                local v72, v73, v74 = Remotes.Fusery.BeginFuse:InvokeServer()
                if v72 then
                    if FuseMachine.FuseResult(v74) then
                        Audio.Play(83520877125467, script, { Volume = 1.5 })
                        FuseMachineSignals.FuseStarted:Fire(v74)
                        if not v16 then
                            v16 = true
                            task.defer(function() -- line 377 | captures: v16, render
                                v16 = false
                                render()
                            end)
                        end
                    else
                        v2:AtError():Log("Fuse server returned an invalid reward")
                    end
                else
                    if typeof(v73) ~= "string" then
                        v73 = "Failed to start fuse"
                    end
                    Message.Bottom({
                        Time = 3,
                        Message = v73,
                        Color = v1
                    })
                end
            end
        end
    end)
end

Output.Visible = true
FusePetInventory.Visible = false

if Briefing ~= nil then
    Briefing.Visible = false
end
for v75 = 1, 3 do
    local v76 = FuseInputs:FindFirstChild((("Input%*"):format(v75)))
    local v77
    if v76 == nil then
        v77 = false
    else
        v77 = v76:IsA("Frame")
    end
    local v78 = ("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(v75)
    assert(v77, v78)
    v76.Full.Visible = false
    v76.Empty.Visible = true
    local Add = v76.Empty.Add
    local ImageButton = Add:IsA("ImageButton")
    local v79 = ("PetFuse.FuseMain.FuseInputs.Input%*.Empty.Add must be an ImageButton"):format(v75)
    assert(ImageButton, v79)
    Add.Activated:Connect(startSelection)
    ButtonFX(Add, 1.08)
end
Fuse.Activated:Connect(requestFuse)
ButtonFX(Fuse, 1.08)

if Close ~= nil then
    Close.Activated:Connect(function() -- line 406 | captures: FusePetInventory, v13
        v13:Close()
        FusePetInventory.Visible = false
    end)
    ButtonFX(Close, 1.08)
end

if v8 ~= nil then
    v8.Activated:Connect(requestAcknowledgeInfo)
    ButtonFX(v8)
end
Save.WatchFields({ "FusionSlots", "FusionLocked", "FusionEggReward", "FusionInfoAcknowledged", "Inventory", "EggInventory" }, function() -- line 423 | captures: v16, Tabs, render
    if Tabs.IsShowing("PetFuse") and not v16 then
        v16 = true
        task.defer(function() -- line 428 | captures: v16, render
            v16 = false
            render()
        end)
    end
end)
Tabs.Shown:Connect(function(v80) -- line 433 | captures: v16, render
    if not (v80 ~= "PetFuse" or v16) then
        v16 = true
        task.defer(function() -- line 438 | captures: v16, render
            v16 = false
            render()
        end)
    end
end)
Tabs.Hidden:Connect(function(v81) -- line 443 | captures: FusePetInventory, v13
    if v81 == "PetFuse" then
        v13:Close()
        FusePetInventory.Visible = false
    end
end)
render()
