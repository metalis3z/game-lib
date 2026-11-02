-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)

require(ReplicatedStorage.Directory.LimitedEgg.Types.Interface)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)

require(ReplicatedStorage.Library.Modules.Packages.Trove)
require(script.Parent.Types.Interface)

local Directory = Assets.Directory
local v1 = Log.new()
local t = {}

local function bindInfoFade(p1, p2, p3) --[[ bindInfoFade | Line: 31 | Upvalues: Tween (copy) ]]
	local v1 = nil
	local v2 = false
	local v3 = 0

	local function clearTween() --[[ clearTween | Line: 36 | Upvalues: v1 (ref) ]]
		local v12 = v1

		v1 = nil

		if v12 == nil then
			return
		end

		v12:Cancel()
		v12:Destroy()
	end

	local function fadeTo(p1) --[[ fadeTo | Line: 45 | Upvalues: v1 (ref), Tween (ref), p3 (copy) ]]
		local v12 = v1

		v1 = nil

		local v2

		if v12 ~= nil then
			v12:Cancel()
			v12:Destroy()
		end

		v2 = Tween(p3, {
			GroupTransparency = p1
		}, { 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
		v1 = v2
		v2.Completed:Once(function() --[[ Line: 53 | Upvalues: v1 (ref), v2 (copy) ]]
			if v1 == v2 then
				v1 = nil
				v2:Destroy()
			end
		end)
	end

	p3.GroupTransparency = 1
	p1:Add(p2.Activated:Connect(function() --[[ Line: 64 | Upvalues: v3 (ref), v2 (ref), fadeTo (copy) ]]
		v3 = v3 + 1

		local v1 = v3

		if v2 then
			v2 = false
			fadeTo(1)
		else
			v2 = true
			fadeTo(0)
			task.delay(8, function() --[[ Line: 74 | Upvalues: v1 (copy), v3 (ref), v2 (ref), fadeTo (ref) ]]
				if v1 ~= v3 then
					return
				end

				v2 = false
				fadeTo(1)
			end)
		end
	end))
	p1:Add(function() --[[ Line: 82 | Upvalues: v1 (ref), p3 (copy) ]]
		local v12 = v1

		v1 = nil

		if v12 ~= nil then
			v12:Cancel()
			v12:Destroy()
		end

		p3.GroupTransparency = 1
	end)
end

function t.Start(p1, p2, p3, p4, p5) --[[ Start | Line: 92 | Upvalues: Asserts (copy), Directory (copy), InfoOverlay (copy), bindInfoFade (copy), v1 (copy) ]]
	Asserts.table(p1)
	Asserts.GuiObject(p2)
	Asserts.GuiObject(p3)
	assert(#p4 == #p5, "Limited egg hover session requires one authored slot per entry")

	for i, v in ipairs(p5) do
		local v3 = Directory[v.AssetId]

		p1:Add(InfoOverlay.Hook(p4[i].Frame, {
			{ "Title", v3.DisplayName },
			{ "Rarity", v3.Rarity._id }
		}))
	end

	bindInfoFade(p1, p2, p3)
	v1:AtTrace():Log("Limited egg hover info session opened")
end

return t