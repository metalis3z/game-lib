-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Frustum = require(script.Parent:WaitForChild("Frustum"))

return function() --[[ Line: 3 | Upvalues: Frustum (copy) ]]
	local t = {
		FieldOfView = 70,
		CFrame = CFrame.identity,
		ViewportSize = Vector2.new(1920, 1080)
	}
	local t2 = {}

	describe("Generates CFrames", function() --[[ Line: 12 | Upvalues: t2 (ref), Frustum (ref), t (copy) ]]
		local v1 = os.clock()

		t2 = table.pack(Frustum.GetCFrames(t, 500))

		local v2 = os.clock()

		t2.n = nil
		print((("Solved view frustum in %*\206\188s"):format((string.format("%.2f", (v2 - v1) * 1000000)))))
	end)
	describe("Point In View", function() --[[ Line: 24 | Upvalues: Frustum (ref), t2 (ref) ]]
		it("Close In View Point", function() --[[ Line: 29 | Upvalues: Frustum (ref), t2 (ref) ]]
			expect(Frustum.InViewFrustum(Vector3.new(0, 0, -5), table.unpack(t2))).to.equal(true)
		end)
		it("Past FarPlane Point", function() --[[ Line: 33 | Upvalues: Frustum (ref), t2 (ref) ]]
			expect(Frustum.InViewFrustum(Vector3.new(0, 0, -550), table.unpack(t2))).to.equal(false)
		end)
		it("Out Of View Point", function() --[[ Line: 37 | Upvalues: Frustum (ref), t2 (ref) ]]
			expect(Frustum.InViewFrustum(Vector3.new(0, 0, 5), table.unpack(t2))).to.equal(false)
		end)
	end)
	describe("Object In View", function() --[[ Line: 42 | Upvalues: Frustum (ref), t2 (ref) ]]
		local t = {
			Size = Vector3.new(1, 1, 3),
			CFrame = CFrame.new(0, 0, -5)
		}
		local t3 = {
			Size = Vector3.new(1, 1, 3),
			CFrame = CFrame.new(0, 0, -550)
		}
		local t4 = {
			Size = Vector3.new(1, 1, 3),
			CFrame = CFrame.new(0, 0, 5)
		}

		it("Close In View Object", function() --[[ Line: 58 | Upvalues: Frustum (ref), t (copy), t2 (ref) ]]
			expect(Frustum.ObjectInFrustum(t, table.unpack(t2))).to.equal(true)
		end)
		it("Past FarPlane Object", function() --[[ Line: 62 | Upvalues: Frustum (ref), t3 (copy), t2 (ref) ]]
			expect(Frustum.ObjectInFrustum(t3, table.unpack(t2))).to.equal(false)
		end)
		it("Out Of View Object", function() --[[ Line: 66 | Upvalues: Frustum (ref), t4 (copy), t2 (ref) ]]
			expect(Frustum.ObjectInFrustum(t4, table.unpack(t2))).to.equal(false)
		end)
	end)
end