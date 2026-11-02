-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Button, time of decompilation: Sun May  3 10:10:59 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local create = Vide.create
local t1 = {
	"HoverScale",
	"OnEnter",
	"OnLeave",
	"OnDown",
	"OnUp"
}

return function(p1) -- line: 22
	-- upvalues: Vide (copy), RemoveKeys (copy), t1 (copy), create (copy), SoundController (copy), Sounds (copy)
	local v9 = p1.HoverScale or 1.1
	local v10 = Vide.source(1)
	local v11 = Vide.spring(v10, 0.2, 0.7)
	local v12 = RemoveKeys(p1, t1)
	local SelectionGained = v12.SelectionGained
	local SelectionLost = v12.SelectionLost

	v12.BackgroundTransparency = v12.BackgroundTransparency or 1
	table.insert(v12, create("UIScale")({
		Scale = v11
	}))

	function v12.MouseEnter() -- line: 38
		-- upvalues: SoundController (copy), Sounds (copy), v10 (copy), v9 (copy), p1 (copy)
		SoundController:Play(Sounds.ui.hover)
		v10(v9)

		if p1.OnEnter then
			p1.OnEnter()
		end
	end
	function v12.MouseLeave() -- line: 46
		-- upvalues: v10 (copy), p1 (copy)
		v10(1)

		if p1.OnLeave then
			p1.OnLeave()
		end
	end
	function v12.SelectionGained() -- line: 55
		-- upvalues: SoundController (copy), Sounds (copy), v10 (copy), v9 (copy), p1 (copy), SelectionGained (copy)
		SoundController:Play(Sounds.ui.hover)
		v10(v9)

		if p1.OnEnter then
			p1.OnEnter()
		end

		if SelectionGained then
			SelectionGained()
		end
	end
	function v12.SelectionLost() -- line: 61
		-- upvalues: v10 (copy), p1 (copy), SelectionLost (copy)
		v10(1)

		if p1.OnLeave then
			p1.OnLeave()
		end

		if SelectionLost then
			SelectionLost()
		end
	end
	function v12.MouseButton1Down() -- line: 68
		-- upvalues: SoundController (copy), Sounds (copy), p1 (copy)
		SoundController:Play(Sounds.ui.mouseDown)

		if p1.OnDown then
			p1.OnDown()
		end
	end
	function v12.MouseButton1Up() -- line: 75
		-- upvalues: SoundController (copy), Sounds (copy), p1 (copy)
		SoundController:Play(Sounds.ui.mouseUp)

		if p1.OnUp then
			p1.OnUp()
		end
	end

	return create("ImageButton")(v12)
end
