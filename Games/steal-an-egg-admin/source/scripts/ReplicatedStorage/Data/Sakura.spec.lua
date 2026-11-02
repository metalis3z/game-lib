-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 6
    local Sakura = require(script.Parent.Sakura)
    describe("incubator luck access", function() -- line 8 | captures: Sakura
        it("rejects luck purchases before incubator unlock", function() -- line 9 | captures: Sakura
            local v1, v2 = Sakura.CanBuyLuckBoost({
                Unlocked = false,
                LuckBoost = 0,
                Egg = {}
            }, 1)
            expect(v1).to.equal(false)
            expect(v2).to.equal("The Sakura Incubator is still sealed")
        end)
        it("rejects luck purchases without an incubator egg", function() -- line 15 | captures: Sakura
            local v3 = Sakura.CanBuyLuckBoost({
                Unlocked = true,
                Egg = false,
                LuckBoost = 0
            }, 1)
            expect(v3).to.equal(false)
        end)
        it("allows the next luck tier after incubator unlock", function() -- line 19 | captures: Sakura
            local v4 = Sakura.CanBuyLuckBoost({
                Unlocked = true,
                LuckBoost = 0,
                Egg = {}
            }, 1)
            expect(v4).to.equal(true)
        end)
    end)
end
