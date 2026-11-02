-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Some", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		it("should create some option", function() --[[ Line: 5 | Upvalues: v1 (ref) ]]
			expect(v1.Some(true):IsSome()).to.equal(true)
		end)
		it("should fail to create some option with nil", function() --[[ Line: 10 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 11 | Upvalues: v1 (ref) ]]
				v1.Some(nil)
			end).to.throw()
		end)
		it("should not be none", function() --[[ Line: 16 | Upvalues: v1 (ref) ]]
			expect(v1.Some(10):IsNone()).to.equal(false)
		end)
	end)
	describe("None", function() --[[ Line: 22 | Upvalues: v1 (copy) ]]
		it("should be able to reference none", function() --[[ Line: 23 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 24 | Upvalues: v1 (ref) ]]
				local None = v1.None
			end).never.to.throw()
		end)
		it("should be able to check if none", function() --[[ Line: 29 | Upvalues: v1 (ref) ]]
			expect(v1.None:IsNone()).to.equal(true)
		end)
		it("should be able to check if not some", function() --[[ Line: 34 | Upvalues: v1 (ref) ]]
			expect(v1.None:IsSome()).to.equal(false)
		end)
	end)
	describe("Equality", function() --[[ Line: 40 | Upvalues: v1 (copy) ]]
		it("should equal the same some from same options", function() --[[ Line: 41 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(32)

			expect(v12).to.equal(v12)
		end)
		it("should equal the same some from different options", function() --[[ Line: 46 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(32)
			local v2 = v1.Some(32)

			expect(v12).to.equal(v2)
		end)
	end)
	describe("Assert", function() --[[ Line: 53 | Upvalues: v1 (copy) ]]
		it("should assert that a some option is an option", function() --[[ Line: 54 | Upvalues: v1 (ref) ]]
			expect(v1.Is(v1.Some(10))).to.equal(true)
		end)
		it("should assert that a none option is an option", function() --[[ Line: 58 | Upvalues: v1 (ref) ]]
			expect(v1.Is(v1.None)).to.equal(true)
		end)
		it("should assert that a non-option is not an option", function() --[[ Line: 62 | Upvalues: v1 (ref) ]]
			expect(v1.Is(10)).to.equal(false)
			expect(v1.Is(true)).to.equal(false)
			expect(v1.Is(false)).to.equal(false)
			expect(v1.Is("Test")).to.equal(false)
			expect(v1.Is({})).to.equal(false)
			expect(v1.Is(function() --[[ Line: 68 ]] end)).to.equal(false)
			expect(v1.Is(coroutine.create(function() --[[ Line: 69 ]] end))).to.equal(false)
			expect(v1.Is(v1)).to.equal(false)
		end)
	end)
	describe("Unwrap", function() --[[ Line: 74 | Upvalues: v1 (copy) ]]
		it("should unwrap a some option", function() --[[ Line: 75 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)

			expect(function() --[[ Line: 77 | Upvalues: v12 (copy) ]]
				v12:Unwrap()
			end).never.to.throw()
			expect(v12:Unwrap()).to.equal(10)
		end)
		it("should fail to unwrap a none option", function() --[[ Line: 83 | Upvalues: v1 (ref) ]]
			local None = v1.None

			expect(function() --[[ Line: 85 | Upvalues: None (copy) ]]
				None:Unwrap()
			end).to.throw()
		end)
	end)
	describe("Expect", function() --[[ Line: 91 | Upvalues: v1 (copy) ]]
		it("should expect a some option", function() --[[ Line: 92 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)

			expect(function() --[[ Line: 94 | Upvalues: v12 (copy) ]]
				v12:Expect("Expecting some value")
			end).never.to.throw()
			expect(v12:Unwrap()).to.equal(10)
		end)
		it("should fail when expecting on a none option", function() --[[ Line: 100 | Upvalues: v1 (ref) ]]
			local None = v1.None

			expect(function() --[[ Line: 102 | Upvalues: None (copy) ]]
				None:Expect("Expecting some value")
			end).to.throw()
		end)
	end)
	describe("ExpectNone", function() --[[ Line: 108 | Upvalues: v1 (copy) ]]
		it("should fail to expect a none option", function() --[[ Line: 109 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)

			expect(function() --[[ Line: 111 | Upvalues: v12 (copy) ]]
				v12:ExpectNone("Expecting some value")
			end).to.throw()
		end)
		it("should expect a none option", function() --[[ Line: 116 | Upvalues: v1 (ref) ]]
			local None = v1.None

			expect(function() --[[ Line: 118 | Upvalues: None (copy) ]]
				None:ExpectNone("Expecting some value")
			end).never.to.throw()
		end)
	end)
	describe("UnwrapOr", function() --[[ Line: 124 | Upvalues: v1 (copy) ]]
		it("should unwrap a some option", function() --[[ Line: 125 | Upvalues: v1 (ref) ]]
			expect(v1.Some(10):UnwrapOr(20)).to.equal(10)
		end)
		it("should unwrap a none option", function() --[[ Line: 130 | Upvalues: v1 (ref) ]]
			expect(v1.None:UnwrapOr(20)).to.equal(20)
		end)
	end)
	describe("UnwrapOrElse", function() --[[ Line: 136 | Upvalues: v1 (copy) ]]
		it("should unwrap a some option", function() --[[ Line: 137 | Upvalues: v1 (ref) ]]
			expect((v1.Some(10):UnwrapOrElse(function() --[[ Line: 139 ]]
				return 30
			end))).to.equal(10)
		end)
		it("should unwrap a none option", function() --[[ Line: 145 | Upvalues: v1 (ref) ]]
			expect((v1.None:UnwrapOrElse(function() --[[ Line: 147 ]]
				return 30
			end))).to.equal(30)
		end)
	end)
	describe("And", function() --[[ Line: 154 | Upvalues: v1 (copy) ]]
		it("should return the second option with and when both are some", function() --[[ Line: 155 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(1)
			local v2 = v1.Some(2)

			expect(v12:And(v2)).to.equal(v2)
		end)
		it("should return none when first option is some and second option is none", function() --[[ Line: 161 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(1)

			expect(v12:And(v1.None):IsNone()).to.equal(true)
		end)
		it("should return none when first option is none and second option is some", function() --[[ Line: 167 | Upvalues: v1 (ref) ]]
			expect(v1.None:And((v1.Some(2))):IsNone()).to.equal(true)
		end)
		it("should return none when both options are none", function() --[[ Line: 173 | Upvalues: v1 (ref) ]]
			expect(v1.None:And(v1.None):IsNone()).to.equal(true)
		end)
	end)
	describe("AndThen", function() --[[ Line: 180 | Upvalues: v1 (copy) ]]
		it("should pass the some value to the predicate", function() --[[ Line: 181 | Upvalues: v1 (ref) ]]
			v1.Some(32):AndThen(function(p1) --[[ Line: 183 | Upvalues: v1 (ref) ]]
				expect(p1).to.equal(32)

				return v1.None
			end)
		end)
		it("should throw if an option is not returned from predicate", function() --[[ Line: 189 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(32)

			expect(function() --[[ Line: 191 | Upvalues: v12 (copy) ]]
				v12:AndThen(function() --[[ Line: 192 ]] end)
			end).to.throw()
		end)
		it("should return none if the option is none", function() --[[ Line: 196 | Upvalues: v1 (ref) ]]
			local None = v1.None

			expect(None:AndThen(function() --[[ Line: 198 | Upvalues: v1 (ref) ]]
				return v1.Some(10)
			end):IsNone()).to.equal(true)
		end)
		it("should return option of predicate if option is some", function() --[[ Line: 203 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(32):AndThen(function() --[[ Line: 205 | Upvalues: v1 (ref) ]]
				return v1.Some(10)
			end)

			expect(v12:IsSome()).to.equal(true)
			expect(v12:Unwrap()).to.equal(10)
		end)
	end)
	describe("Or", function() --[[ Line: 213 | Upvalues: v1 (copy) ]]
		it("should return the first option if it is some", function() --[[ Line: 214 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)

			expect(v12:Or((v1.Some(20)))).to.equal(v12)
		end)
		it("should return the second option if the first one is none", function() --[[ Line: 220 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(20)

			expect(v1.None:Or(v12)).to.equal(v12)
		end)
	end)
	describe("OrElse", function() --[[ Line: 227 | Upvalues: v1 (copy) ]]
		it("should return the first option if it is some", function() --[[ Line: 228 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)
			local v2 = v1.Some(20)

			expect(v12:OrElse(function() --[[ Line: 231 | Upvalues: v2 (copy) ]]
				return v2
			end)).to.equal(v12)
		end)
		it("should return the second option if the first one is none", function() --[[ Line: 236 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(20)

			expect(v1.None:OrElse(function() --[[ Line: 239 | Upvalues: v12 (copy) ]]
				return v12
			end)).to.equal(v12)
		end)
		it("should throw if the predicate does not return an option", function() --[[ Line: 244 | Upvalues: v1 (ref) ]]
			local None = v1.None

			expect(function() --[[ Line: 246 | Upvalues: None (copy) ]]
				None:OrElse(function() --[[ Line: 247 ]] end)
			end).to.throw()
		end)
	end)
	describe("XOr", function() --[[ Line: 252 | Upvalues: v1 (copy) ]]
		it("should return first option if first option is some and second option is none", function() --[[ Line: 253 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(1)

			expect(v12:XOr(v1.None)).to.equal(v12)
		end)
		it("should return second option if first option is none and second option is some", function() --[[ Line: 259 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(2)

			expect(v1.None:XOr(v12)).to.equal(v12)
		end)
		it("should return none if first and second option are some", function() --[[ Line: 265 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(1)

			expect(v12:XOr((v1.Some(2)))).to.equal(v1.None)
		end)
		it("should return none if first and second option are none", function() --[[ Line: 271 | Upvalues: v1 (ref) ]]
			expect(v1.None:XOr(v1.None)).to.equal(v1.None)
		end)
	end)
	describe("Filter", function() --[[ Line: 278 | Upvalues: v1 (copy) ]]
		it("should return none if option is none", function() --[[ Line: 279 | Upvalues: v1 (ref) ]]
			expect(v1.None:Filter(function() --[[ Line: 281 ]] end)).to.equal(v1.None)
		end)
		it("should return none if option is some but fails predicate", function() --[[ Line: 284 | Upvalues: v1 (ref) ]]
			expect(v1.Some(10):Filter(function(p1) --[[ Line: 286 ]]
				return false
			end)).to.equal(v1.None)
		end)
		it("should return self if option is some and passes predicate", function() --[[ Line: 291 | Upvalues: v1 (ref) ]]
			local v12 = v1.Some(10)

			expect(v12:Filter(function(p1) --[[ Line: 293 ]]
				return true
			end)).to.equal(v12)
		end)
	end)
	describe("Contains", function() --[[ Line: 299 | Upvalues: v1 (copy) ]]
		it("should return true if some option contains the given value", function() --[[ Line: 300 | Upvalues: v1 (ref) ]]
			expect(v1.Some(32):Contains(32)).to.equal(true)
		end)
		it("should return false if some option does not contain the given value", function() --[[ Line: 305 | Upvalues: v1 (ref) ]]
			expect(v1.Some(32):Contains(64)).to.equal(false)
		end)
		it("should return false if option is none", function() --[[ Line: 310 | Upvalues: v1 (ref) ]]
			expect(v1.None:Contains(64)).to.equal(false)
		end)
	end)
	describe("ToString", function() --[[ Line: 316 | Upvalues: v1 (copy) ]]
		it("should return string of none option", function() --[[ Line: 317 | Upvalues: v1 (ref) ]]
			expect((tostring(v1.None))).to.equal("Option<None>")
		end)
		it("should return string of some option with type", function() --[[ Line: 322 | Upvalues: v1 (ref) ]]
			for i, v in ipairs({
				10,
				true,
				false,
				"test",
				{},
				function() --[[ Line: 323 ]] end,
				coroutine.create(function() --[[ Line: 323 ]] end),
				workspace
			}) do
				local v12 = ("Option<%s>"):format((typeof(v)))
				local v2 = expect

				v2((tostring(v1.Some(v)))).to.equal(v12)
			end
		end)
	end)
end