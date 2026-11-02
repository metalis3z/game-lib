--  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗███████╗
-- ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██║   ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝ ██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║███████╗    ██║  ██║█████╗  ██║      ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║╚════██║    ██║  ██║██╔══╝  ██║      ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝███████║    ██████╔╝███████╗╚██████╗ ╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

-- @ Angelus Decompiles — @Chlorls & @imoRR
-- @ Discord : discord.gg/nDWm6PkFrT
-- @ Decompiled

-- https://lua.expert/
local v1 = script.Parent
local v2 = nil

local function UpdateIcon() --[[ UpdateIcon | Line: 10 | Upvalues: v2 (ref), v1 (copy) ]]
	if not v2 then
		return
	end

	v2.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

local function OnEquipped(p1) --[[ OnEquipped | Line: 16 | Upvalues: v2 (ref), v1 (copy) ]]
	v2 = p1

	if not p1 then
		return
	end

	p1.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

local function OnChanged(p1) --[[ OnChanged | Line: 21 | Upvalues: v2 (ref), v1 (copy) ]]
	if p1 ~= "Enabled" or not v2 then
		return
	end

	v2.Icon = if v1.Enabled then "rbxasset://textures/GunCursor.png" else "rbxasset://textures/GunWaitCursor.png"
end

v1.Equipped:Connect(OnEquipped)
v1.Changed:Connect(OnChanged)