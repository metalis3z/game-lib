-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 6
    local HotbarImagePreloadPolicy = require(script.Parent.HotbarImagePreloadPolicy)
    describe("claim line distance", function() -- line 8 | captures: HotbarImagePreloadPolicy
        it("uses perpendicular distance instead of center distance", function() -- line 9 | captures: HotbarImagePreloadPolicy
            local Part = Instance.new("Part")
            Part.Size = Vector3.new(200, 1, 1)
            local v1 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(Part, (Vector3.new(80, 20, 30)))
            Part:Destroy()
            expect(v1).to.be.near(30)
        end)
        it("matches the claim boundary beyond the visible part", function() -- line 16 | captures: HotbarImagePreloadPolicy
            local Part = Instance.new("Part")
            Part.Size = Vector3.new(200, 1, 1)
            local v2 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(Part, (Vector3.new(1000, 0, 30)))
            Part:Destroy()
            expect(v2).to.be.near(30)
        end)
        it("ignores vertical separation", function() -- line 23 | captures: HotbarImagePreloadPolicy
            local Part = Instance.new("Part")
            local v3 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(Part, (Vector3.new(0, 500, 0)))
            Part:Destroy()
            expect(v3).to.equal(0)
        end)
        it("follows a rotated line part", function() -- line 29 | captures: HotbarImagePreloadPolicy
            local Part = Instance.new("Part")
            Part.Size = Vector3.new(200, 1, 1)
            Part.CFrame = CFrame.Angles(0, 1.5707963267948966, 0)
            local v4 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(Part, (Vector3.new(30, 100, -80)))
            Part:Destroy()
            expect(v4).to.be.near(30)
        end)
    end)
    describe("carry preload eligibility", function() -- line 38 | captures: HotbarImagePreloadPolicy
        it("accepts the exact required speed power", function() -- line 39 | captures: HotbarImagePreloadPolicy
            expect(HotbarImagePreloadPolicy.IsSpeedEligible(100, 100)).to.equal(true)
        end)
        it("fails closed without a speed requirement", function() -- line 42 | captures: HotbarImagePreloadPolicy
            expect(HotbarImagePreloadPolicy.IsSpeedEligible(100, nil)).to.equal(false)
        end)
        it("uses a strict fifty stud threshold", function() -- line 45 | captures: HotbarImagePreloadPolicy
            expect(HotbarImagePreloadPolicy.IsWithinClaimPreloadDistance(49.999)).to.equal(true)
            expect(HotbarImagePreloadPolicy.IsWithinClaimPreloadDistance(50)).to.equal(false)
        end)
        it("preloads for either speed or proximity", function() -- line 49 | captures: HotbarImagePreloadPolicy
            expect(HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg(100, 100, 500)).to.equal(true)
            expect(HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg(99, 100, 49)).to.equal(true)
            expect(HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg(99, 100, 50)).to.equal(false)
        end)
    end)
end
