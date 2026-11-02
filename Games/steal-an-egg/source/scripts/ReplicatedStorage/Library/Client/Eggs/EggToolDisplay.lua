-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local EggRenderer = require(script.Parent.EggRenderer)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Parent.Types)

local Weld = require(ReplicatedStorage.Library.Functions.Weld)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "EggToolDisplay"
function t.new(p1, p2) --[[ new | Line: 40 | Upvalues: Asserts (copy), t (copy), Trove (copy), EggRenderer (copy), v1 (copy) ]]
	Asserts.Tool(p1)

	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._tool = p1
	v2._renderResult = EggRenderer.RenderVisual(p2, p1)
	v2:_init()
	v1:AtDebug():Log((("Attached egg tool display for %*"):format(p2.UID)))

	return v2
end

local function getStringAttribute(p1, p2) --[[ getStringAttribute | Line: 57 ]]
	local v1 = p1:GetAttribute(p2)

	if typeof(v1) == "string" and v1 ~= "" then
		return v1
	end

	return nil
end

local function positionModel(p1, p2) --[[ positionModel | Line: 62 | Upvalues: BBFromModelVisibleOnly (copy) ]]
	local Handle = p1:WaitForChild("Handle")
	local v1 = Handle:IsA("BasePart")

	assert(v1, (("Missing egg tool handle for %*"):format((p1:GetFullName()))))

	local Model = p2.Model
	local v3 = Model:GetPivot()
	local v4, v5 = BBFromModelVisibleOnly(Model)

	Model:PivotTo(Handle.CFrame * (v4 * CFrame.new(0, v5.Y * -0.5, v5.Z * 0.1)):ToObjectSpace(v3))

	return Handle
end

function t.IsEggTool(p1) --[[ IsEggTool | Line: 81 | Upvalues: Asserts (copy) ]]
	Asserts.Tool(p1)

	return p1:GetAttribute("ItemType") == "AssetEgg"
end
function t.GetToolUid(p1) --[[ GetToolUid | Line: 86 | Upvalues: Asserts (copy) ]]
	Asserts.Tool(p1)

	local v1 = p1:GetAttribute("UID")

	if typeof(v1) == "string" and v1 ~= "" then
		return v1
	end

	return nil
end
function t.Destroy(p1) --[[ Destroy | Line: 91 ]]
	p1._trove:Destroy()
end
function t._init(p1) --[[ _init | Line: 99 | Upvalues: positionModel (copy), Weld (copy) ]]
	p1._trove:Add(p1._renderResult.Model)

	local v1 = positionModel(p1._tool, p1._renderResult)

	p1._trove:Add(Weld(p1._renderResult.VisibleParts[1], v1))
end

return t