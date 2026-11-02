-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Rain = require(ReplicatedStorage.Library.Client.GUIFX.Rain)
local t = {
	Volume = 1.3,
	RateScale = 2,
	DragOverride = -0.5,
	Assets = { "rbxassetid://78590382571227" },
	Pitch = { 0.9, 1.1 }
}

return {
	Play = function(p1) --[[ Play | Line: 26 | Upvalues: Asserts (copy), Rain (copy), t (copy) ]]
		Asserts.string(p1)
		Rain.Play({
			Duration = 1,
			Particles = {
				{
					SizeScalar = 3,
					Texture = p1
				}
			},
			SprinkleSounds = t
		})
	end
}