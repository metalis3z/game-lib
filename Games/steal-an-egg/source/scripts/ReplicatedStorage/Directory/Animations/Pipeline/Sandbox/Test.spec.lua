-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent.Parent)
	local t = require(game:GetService("ReplicatedStorage").Library.Modules.Packages.t)
	local v2 = string.rep("-", 50)
	local v3 = require(game:GetService("ReplicatedStorage").Library.Modules.Packages.Log).new():Mute()
	local v4 = t.interface({
		_animationInstance = t.instanceIsA("Animation"),
		_assetId = t.string,
		_flags = t.table,
		_deferredStack = t.interface({
			resolve = t.callback,
			reject = t.callback,
			onCancel = t.callback
		})
	})

	v3:AtTrace():Log((("%*[Test Starting]%*"):format(v2, v2)))
	describe("testing the pipeline core features", function() --[[ Line: 20 | Upvalues: v1 (copy), v3 (copy), v4 (copy) ]]
		it("should retrieve the animation instance and setup the animation file format", function() --[[ Line: 21 | Upvalues: v1 (ref), v3 (ref) ]]
			local v12 = v1:GetAndSerializeAnimation("73620620715331")

			expect(v12).to.be.a("table")
			v3:AtTrace():Log("Animation Package Retrieved:", v12)
		end)
		it("should get the cache and return a promise with cache data", function() --[[ Line: 27 | Upvalues: v3 (ref), v1 (ref), v4 (ref) ]]
			task.spawn(function() --[[ Line: 28 | Upvalues: v3 (ref), v1 (ref) ]]
				v3:AtTrace():Log("Attempting to acquire cache on parallel thread (testing lock mechanism):", v1:GetPromisePacketFromId("73620620715331"))
			end)

			local v12 = os.clock()
			local v2, v32 = v1:GetPromisePacketFromId("73620620715331")

			v3:AtTrace():Log("Cache Access Result:", v2, v32, (("| Cache Lock Release Time: %*ms"):format((os.clock() - v12) * 1000)))
			expect(function() --[[ Line: 45 | Upvalues: v4 (ref), v32 (copy) ]]
				v4(v32)
			end).never.to.throw()
			expect(v2).to.be.a("table")
			v2:andThen(function(...) --[[ Line: 50 ]]
				warn("Animation Loading Promise Completed:", ...)
			end)
		end)
		it("Should return animation from cache instantly without waiting", function() --[[ Line: 55 | Upvalues: v1 (ref), v3 (ref) ]]
			local v12 = v1:RushGetAnimationInstance("120563575220856")

			v3:AtTrace():Log("Quick-Retrieved Single Animation:", v12)
			expect(v12).to.be.a("userdata")

			local v2 = v1:RushGetAnimationInstance({ "120563575220856" })

			v3:AtTrace():Log("Quick-Retrieved Multiple Animations:", v2)
			expect(v2).to.be.a("table")
		end)
		it("Should wait for the animations to preload", function() --[[ Line: 65 | Upvalues: v1 (ref), v3 (ref) ]]
			local v12 = v1:GetAnimationPackageAfterPreload("88656460312521")

			v3:AtTrace():Log("Animation Preload Started:", v12)

			local v2 = os.clock()

			v12:andThen(function(...) --[[ Line: 70 ]]
				warn("Animation Preload Successful:", ...)
			end):catch(function(...) --[[ Line: 73 ]]
				warn("Animation Preload Failed:", ...)
			end):finally(function(...) --[[ Line: 76 | Upvalues: v2 (copy) ]]
				warn(("Animation Preload Completed in %*ms:"):format((os.clock() - v2) * 1000), ...)
			end)
		end)
	end)
	v3:AtTrace():Log((("%*[Test Complete]%*"):format(v2, v2)))
end