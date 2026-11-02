-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent.Parent)

	require(game:GetService("ReplicatedStorage").Library.Modules.Packages.t)

	local v2 = string.rep("-", 50)
	local v3 = require(game:GetService("ReplicatedStorage").Library.Modules.Packages.Log).new():Mute()

	v3:AtTrace():Log((("%*[Test Starting]%*"):format(v2, v2)))
	describe("testing the pipeline core features", function() --[[ Line: 9 | Upvalues: v1 (copy) ]]
		it("should be able to get and cerate sounds while still caching them and preloading them in hte background of hte game for future needs", function() --[[ Line: 12 | Upvalues: v1 (ref) ]]
			local loadedsound = v1:BuildSoundFromProps("rbxassetid://9058815929", {
				Props = {
					Volume = 2
				}
			})

			expect(loadedsound).to.be.a("userdata")
			expect(loadedsound.Volume).to.equal(2)
			print("loaded sound:", loadedsound)
		end)
	end)
	v3:AtTrace():Log((("%*[Test Complete]%*"):format(v2, v2)))
end