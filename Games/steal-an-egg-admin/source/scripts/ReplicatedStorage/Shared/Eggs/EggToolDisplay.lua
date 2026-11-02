-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local EggRenderer = require(script.Parent.EggRenderer)
local Log = require(ReplicatedStorage.Packages.Log)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local Weld = require(ReplicatedStorage.Shared.Utils.Instances).Weld
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "EggToolDisplay"

function v2.new(v3, v4) -- line 19 | captures: EggRenderer, Trove, t, v1, v2
    t.strict(t.instanceIsA("Tool"))(v3)
    local v5 = {}
    local v6 = setmetatable(v5, v2)
    v6._trove = Trove.new()
    v6._tool = v3
    v6._renderResult = EggRenderer.RenderVisual(v4, v3)
    v6:_init()
    v1:AtDebug():Log((("Attached egg tool display for %*"):format(v4.UID)))
    return v6
end

local function getStringAttribute(v7, v8) -- line 30
    local v9 = v7:GetAttribute(v8)
    if typeof(v9) == "string" then
        if v9 == "" then
            return nil
        end
        return v9
    end
    return nil
end

local function positionModel(v10, v11) -- line 40 | captures: ModelBounds
    local Handle = v10:WaitForChild("Handle")
    local BasePart = Handle:IsA("BasePart")
    local v12 = ("Missing egg tool handle for %*"):format((v10:GetFullName()))
    assert(BasePart, v12)
    local Model = v11.Model
    local v13 = Model:GetPivot()
    local v14, v15 = ModelBounds(Model)
    Model:PivotTo(Handle.CFrame * (v14 * CFrame.new(0, v15.Y * -0.5, v15.Z * 0.1)):ToObjectSpace(v13))
    return Handle
end

function v2.IsEggTool(v16) -- line 51 | captures: t
    t.strict(t.instanceIsA("Tool"))(v16)
    return v16:GetAttribute("ItemType") == "AssetEgg"
end

function v2.GetToolUid(v17) -- line 57 | captures: t
    t.strict(t.instanceIsA("Tool"))(v17)
    local UID = v17:GetAttribute("UID")
    if typeof(UID) == "string" then
        if UID == "" then
            return nil
        end
        return UID
    end
    return nil
end

local function Destroy(v18) -- line 69
    v18._trove:Destroy()
end

v2.Destroy = Destroy

function v2.SyncParasite(v19, v20) -- line 72 | captures: ParasiteVisual
    ParasiteVisual.Attach(v19._renderResult.Model, v20)
end

function v2._init(v21) -- line 75 | captures: Weld, positionModel
    v21._trove:Add(v21._renderResult.Model)
    local v22 = positionModel(v21._tool, v21._renderResult)
    v21._trove:Add(Weld(v21._renderResult.VisibleParts[1], v22))
end

return v2
