-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlideFrame, time of decompilation: Sun May  3 10:11:01 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local AutoScaledFrame = require(script.Parent.AutoScaledFrame)
local t1 = {
	"Shown",
	"ShownPosition",
	"HiddenPosition",
	"UnmountWhenHidden",
	"CanStartShown"
}

return function(p1) -- line: 17
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), AutoScaledFrame (copy)
	local u7 = nil
	local v8 = RemoveKeys(p1, t1)
	local v9 = Vide.source(p1.Shown())
	local v10 = Vide.source(if not p1.Shown() or not p1.CanStartShown then p1.HiddenPosition else p1.ShownPosition)
	local v11 = Vide.spring(v10, 0.25, 0.7)

	Vide.effect(function() -- line: 26
		-- upvalues: p1 (copy), v10 (copy), v9 (copy), u7 (ref), Vide (copy)
		if p1.Shown() then
			v10(p1.ShownPosition)
			v9(true)

			if u7 then
				task.cancel(u7)
				u7 = nil
			end

			return
		end

		v10(p1.HiddenPosition)

		if not v9() then
			return
		end

		u7 = task.delay(0.3, function() -- line: 42
			-- upvalues: u7 (ref), v9 (copy)
			u7 = nil
			v9(false)
		end)
		Vide.cleanup(function() -- line: 47
			-- upvalues: u7 (ref)
			if u7 then
				task.cancel(u7)
				u7 = nil
			end
		end)
	end)
	v8.Position = v11
	v8.Visible = v9

	return AutoScaledFrame(v8)
end
