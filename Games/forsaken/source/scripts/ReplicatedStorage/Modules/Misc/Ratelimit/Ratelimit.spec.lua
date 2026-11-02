-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function()
	local v_u_1 = require(script.Parent.Ratelimit)
	describe("new", function()
		-- upvalues: (copy) v_u_1
		it("should create a new Ratelimiter", function()
			-- upvalues: (ref) v_u_1
			local v2 = v_u_1.new()
			expect(v2).to.be.ok()
		end)
		it("should check the player reference correctly", function()
			-- upvalues: (ref) v_u_1
			local v3 = v_u_1.new()
			expect(v3:Check(game.Players:GetPlayers()[1])).to.be.equal("OK")
		end)
		it("should properly create and try out the leaky algorithm", function()
			-- upvalues: (ref) v_u_1
			local v4 = v_u_1.new("LEAKY")
			expect(v4:Check(game.Players:GetPlayers()[1])).to.be.equal("OK")
		end)
		it("should properly create and try out the token algorithm", function()
			-- upvalues: (ref) v_u_1
			local v5 = v_u_1.new("TOKEN")
			expect(v5:Check(game.Players:GetPlayers()[1])).to.be.equal("OK")
		end)
		it("should properly create and try out the sliding window algorithm", function()
			-- upvalues: (ref) v_u_1
			local v6 = v_u_1.new("SLIDING_WINDOW")
			expect(v6:Check(game.Players:GetPlayers()[1])).to.be.equal("OK")
		end)
	end)
end
