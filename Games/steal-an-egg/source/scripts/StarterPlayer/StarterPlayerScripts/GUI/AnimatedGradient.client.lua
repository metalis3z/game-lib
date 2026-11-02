-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EasyVisuals = require(ReplicatedStorage.Library.Client.GUIFX.EasyVisuals)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Player = require(ReplicatedStorage.Library.Player)
local t = {}

local function start(p1) --[[ start | Line: 25 | Upvalues: t (copy), Player (copy), EasyVisuals (copy), Asserts (copy) ]]
	if t[p1] ~= nil or not (p1:IsA("UIGradient") and (p1:IsDescendantOf(workspace) or p1:IsDescendantOf(Player.PlayerGui()))) then
		return
	end

	local v1 = p1.Parent

	if not (v1 and v1:IsA("GuiObject")) then
		return
	end

	local v2 = p1:GetAttribute("__gradient_style")
	local v3 = if typeof(v2) == "string" and v2 ~= "" then if v2 == "Wrapper" then false else true else false
	local v5 = if v3 then nil else p1.Color
	local v6 = p1:GetAttribute("__custom_rotation")
	local v7 = EasyVisuals.new(v1, if v3 and v2 then v2 else "Wrapper", 0.35, nil, nil, v5)

	if v6 then
		Asserts.number(v6)

		for v8, v9 in v7.EffectObjects do
			if v9.__class == "Gradient" then
				v9:SetRotation(v6, 1)
			end
		end
	end

	local t2 = {}

	local function f10() --[[ Line: 61 | Upvalues: v1 (copy), t (ref), p1 (copy) ]]
		if v1:IsDescendantOf(game) then
			return
		end

		local v12 = t[p1]

		if not v12 then
			return
		end

		v12.effect:Destroy()

		for v2, v3 in v12.conns do
			v3:Disconnect()
		end

		t[p1] = nil
	end

	table.insert(t2, v1.AncestryChanged:Connect(f10))
	t[p1] = {
		node = p1,
		target = v1,
		effect = v7,
		conns = t2
	}
end

local function stop(p1) --[[ stop | Line: 84 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	v1.effect:Destroy()

	for v2, v3 in v1.conns do
		v3:Disconnect()
	end

	t[p1] = nil
end

for v1, v2 in CollectionService:GetTagged("Rainbow_Gradient") do
	start(v2)
end

CollectionService:GetInstanceAddedSignal("Rainbow_Gradient"):Connect(start)
CollectionService:GetInstanceRemovedSignal("Rainbow_Gradient"):Connect(stop)