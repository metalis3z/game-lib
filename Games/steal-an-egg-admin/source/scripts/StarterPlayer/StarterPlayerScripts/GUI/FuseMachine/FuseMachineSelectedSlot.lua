-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1
v1.__class = "FuseMachineSelectedSlot"

function v1.new(v2, v3, v4, v5) -- line 16 | captures: Directory, ButtonFX, Trove, v1
    local v6 = {}
    local v7 = setmetatable(v6, v1)
    v7._slot = v2
    v7._trove = Trove.new()
    v7._uid = v3
    local Full = v2.Full
    v2.Empty.Visible = false
    Full.Visible = true
    v7._trove:Add(function() -- line 24 | captures: v2, Full
        Full.Visible = false
        v2.Empty.Visible = true
    end)
    local v8 = Directory[v4.Category]
    local v9 = v8 ~= nil
    local v10 = ("Missing asset config %*"):format(v4.Category)
    assert(v9, v10)
    local Name = Full:FindFirstChild("Name")
    local v11
    if Name == nil then
        v11 = false
    else
        v11 = Name:IsA("TextLabel")
    end
    assert(v11, "Fuse input Full.Name must be a TextLabel")
    Name.Text = v8.DisplayName
    local Pet = Full.Pet
    local ImageLabel = Pet:IsA("ImageLabel")
    assert(ImageLabel, "Fuse input Full.Pet must be an ImageLabel")
    Pet.Image = v8.Icon or ""
    v7:_applyMutation(v4)
    v7:_applyRarity(v4)
    local Add = Full.Add
    local ImageButton = Add:IsA("ImageButton")
    assert(ImageButton, "Fuse input Full.Add must be an ImageButton")
    v7._trove:Add(Add.Activated:Connect(function() -- line 44 | captures: v3, v5
        v5(v3)
    end))
    ButtonFX(Add, 1.08)
    return v7
end

function v1._applyMutation(v12, v13) -- line 50 | captures: Mutations
    local v14 = v13.BaseMutation or v13.Mutations[1]
    if v14 == nil or v14 == Mutations.NO_MUTATION then
        return
    end
    local Name = v12._slot.Full:FindFirstChild("Name")
    local v15
    if Name == nil then
        v15 = false
    else
        v15 = Name:IsA("TextLabel")
    end
    assert(v15, "Fuse input Full.Name must be a TextLabel")
    local v16 = Mutations.Get(v14)
    Name.Text = ("%* %*"):format(Mutations.LabelOf(v14), Name.Text)
    if v16 then
        Name.TextColor3 = v16.Tint
    end
end

function v1._applyRarity(v17, v18) -- line 68 | captures: Directory
    local Rarity = v17._slot.Full.Rarity
    local TextLabel = Rarity:IsA("TextLabel")
    assert(TextLabel, "Fuse input Full.Rarity must be a TextLabel")
    local v19 = Directory[v18.Category]
    local v20 = v19 ~= nil
    local v21 = ("Missing asset config %*"):format(v18.Category)
    assert(v20, v21)
    for v22, v23 in ipairs(Rarity:GetChildren()) do
        if v23:IsA("UIGradient") then
            v23:Destroy()
        end
    end
    Rarity.Text = v19.Rarity.DisplayName
    Rarity.TextColor3 = v19.Rarity.Color
    if v19.Rarity.RarityGradient then
        v19.Rarity.RarityGradient:Clone().Parent = Rarity
    end
end

local function GetUid(v24) -- line 86
    return v24._uid
end

v1.GetUid = GetUid

local function Destroy(v25) -- line 89
    v25._trove:Destroy()
end

v1.Destroy = Destroy
return v1
