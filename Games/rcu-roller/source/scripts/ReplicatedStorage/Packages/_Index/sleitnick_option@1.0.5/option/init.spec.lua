-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:16:02

-- Luau version 6, Types version 3

-- Time taken: 0.008553 seconds


return function() -- Line 1

	local Parent_upvr = require(script.Parent)

	describe("Some", function() -- Line 4

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should create some option", function() -- Line 5

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(true):IsSome()).to.equal(true)

		end)

		it("should fail to create some option with nil", function() -- Line 10

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(function() -- Line 11

				--[[ Upvalues[1]:

					[1]: Parent_upvr (copied, readonly)

				]]

				Parent_upvr.Some(nil)

			end).to.throw()

		end)

		it("should not be none", function() -- Line 16

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(10):IsNone()).to.equal(false)

		end)

	end)

	describe("None", function() -- Line 22

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should be able to reference none", function() -- Line 23

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(function() -- Line 24

				--[[ Upvalues[1]:

					[1]: Parent_upvr (copied, readonly)

				]]

			end).never.to.throw()

		end)

		it("should be able to check if none", function() -- Line 29

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:IsNone()).to.equal(true)

		end)

		it("should be able to check if not some", function() -- Line 34

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:IsSome()).to.equal(false)

		end)

	end)

	describe("Equality", function() -- Line 40

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should equal the same some from same options", function() -- Line 41

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_3 = Parent_upvr.Some(32)

			expect(any_Some_result1_3).to.equal(any_Some_result1_3)

		end)

		it("should equal the same some from different options", function() -- Line 46

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(32)).to.equal(Parent_upvr.Some(32))

		end)

	end)

	describe("Assert", function() -- Line 53

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should assert that a some option is an option", function() -- Line 54

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Is(Parent_upvr.Some(10))).to.equal(true)

		end)

		it("should assert that a none option is an option", function() -- Line 58

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Is(Parent_upvr.None)).to.equal(true)

		end)

		it("should assert that a non-option is not an option", function() -- Line 62

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Is(10)).to.equal(false)

			expect(Parent_upvr.Is(true)).to.equal(false)

			expect(Parent_upvr.Is(false)).to.equal(false)

			expect(Parent_upvr.Is("Test")).to.equal(false)

			expect(Parent_upvr.Is({})).to.equal(false)

			expect(Parent_upvr.Is(function() -- Line 68

			end)).to.equal(false)

			expect(Parent_upvr.Is(coroutine.create(function() -- Line 69

			end))).to.equal(false)

			expect(Parent_upvr.Is(Parent_upvr)).to.equal(false)

		end)

	end)

	describe("Unwrap", function() -- Line 74

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should unwrap a some option", function() -- Line 75

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_5_upvr = Parent_upvr.Some(10)

			expect(function() -- Line 77

				--[[ Upvalues[1]:

					[1]: any_Some_result1_5_upvr (readonly)

				]]

				any_Some_result1_5_upvr:Unwrap()

			end).never.to.throw()

			expect(any_Some_result1_5_upvr:Unwrap()).to.equal(10)

		end)

		it("should fail to unwrap a none option", function() -- Line 83

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local None_upvr = Parent_upvr.None

			expect(function() -- Line 85

				--[[ Upvalues[1]:

					[1]: None_upvr (readonly)

				]]

				None_upvr:Unwrap()

			end).to.throw()

		end)

	end)

	describe("Expect", function() -- Line 91

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should expect a some option", function() -- Line 92

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_13_upvr = Parent_upvr.Some(10)

			expect(function() -- Line 94

				--[[ Upvalues[1]:

					[1]: any_Some_result1_13_upvr (readonly)

				]]

				any_Some_result1_13_upvr:Expect("Expecting some value")

			end).never.to.throw()

			expect(any_Some_result1_13_upvr:Unwrap()).to.equal(10)

		end)

		it("should fail when expecting on a none option", function() -- Line 100

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local None_upvr_3 = Parent_upvr.None

			expect(function() -- Line 102

				--[[ Upvalues[1]:

					[1]: None_upvr_3 (readonly)

				]]

				None_upvr_3:Expect("Expecting some value")

			end).to.throw()

		end)

	end)

	describe("ExpectNone", function() -- Line 108

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should fail to expect a none option", function() -- Line 109

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_9_upvr = Parent_upvr.Some(10)

			expect(function() -- Line 111

				--[[ Upvalues[1]:

					[1]: any_Some_result1_9_upvr (readonly)

				]]

				any_Some_result1_9_upvr:ExpectNone("Expecting some value")

			end).to.throw()

		end)

		it("should expect a none option", function() -- Line 116

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local None_upvr_4 = Parent_upvr.None

			expect(function() -- Line 118

				--[[ Upvalues[1]:

					[1]: None_upvr_4 (readonly)

				]]

				None_upvr_4:ExpectNone("Expecting some value")

			end).never.to.throw()

		end)

	end)

	describe("UnwrapOr", function() -- Line 124

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should unwrap a some option", function() -- Line 125

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(10):UnwrapOr(20)).to.equal(10)

		end)

		it("should unwrap a none option", function() -- Line 130

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:UnwrapOr(20)).to.equal(20)

		end)

	end)

	describe("UnwrapOrElse", function() -- Line 136

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should unwrap a some option", function() -- Line 137

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(10):UnwrapOrElse(function() -- Line 139

				return 30

			end)).to.equal(10)

		end)

		it("should unwrap a none option", function() -- Line 145

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:UnwrapOrElse(function() -- Line 147

				return 30

			end)).to.equal(30)

		end)

	end)

	describe("And", function() -- Line 154

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return the second option with and when both are some", function() -- Line 155

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_12 = Parent_upvr.Some(2)

			expect(Parent_upvr.Some(1):And(any_Some_result1_12)).to.equal(any_Some_result1_12)

		end)

		it("should return none when first option is some and second option is none", function() -- Line 161

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(1):And(Parent_upvr.None):IsNone()).to.equal(true)

		end)

		it("should return none when first option is none and second option is some", function() -- Line 167

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:And(Parent_upvr.Some(2)):IsNone()).to.equal(true)

		end)

		it("should return none when both options are none", function() -- Line 173

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:And(Parent_upvr.None):IsNone()).to.equal(true)

		end)

	end)

	describe("AndThen", function() -- Line 180

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should pass the some value to the predicate", function() -- Line 181

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			Parent_upvr.Some(32):AndThen(function(arg1) -- Line 183

				--[[ Upvalues[1]:

					[1]: Parent_upvr (copied, readonly)

				]]

				expect(arg1).to.equal(32)

				return Parent_upvr.None

			end)

		end)

		it("should throw if an option is not returned from predicate", function() -- Line 189

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_upvr = Parent_upvr.Some(32)

			expect(function() -- Line 191

				--[[ Upvalues[1]:

					[1]: any_Some_result1_upvr (readonly)

				]]

				any_Some_result1_upvr:AndThen(function() -- Line 192

				end)

			end).to.throw()

		end)

		it("should return none if the option is none", function() -- Line 196

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:AndThen(function() -- Line 198

				--[[ Upvalues[1]:

					[1]: Parent_upvr (copied, readonly)

				]]

				return Parent_upvr.Some(10)

			end):IsNone()).to.equal(true)

		end)

		it("should return option of predicate if option is some", function() -- Line 203

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_AndThen_result1 = Parent_upvr.Some(32):AndThen(function() -- Line 205

				--[[ Upvalues[1]:

					[1]: Parent_upvr (copied, readonly)

				]]

				return Parent_upvr.Some(10)

			end)

			expect(any_AndThen_result1:IsSome()).to.equal(true)

			expect(any_AndThen_result1:Unwrap()).to.equal(10)

		end)

	end)

	describe("Or", function() -- Line 213

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return the first option if it is some", function() -- Line 214

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_8 = Parent_upvr.Some(10)

			expect(any_Some_result1_8:Or(Parent_upvr.Some(20))).to.equal(any_Some_result1_8)

		end)

		it("should return the second option if the first one is none", function() -- Line 220

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_11 = Parent_upvr.Some(20)

			expect(Parent_upvr.None:Or(any_Some_result1_11)).to.equal(any_Some_result1_11)

		end)

	end)

	describe("OrElse", function() -- Line 227

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return the first option if it is some", function() -- Line 228

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1 = Parent_upvr.Some(10)

			local any_Some_result1_7_upvr = Parent_upvr.Some(20)

			expect(any_Some_result1:OrElse(function() -- Line 231

				--[[ Upvalues[1]:

					[1]: any_Some_result1_7_upvr (readonly)

				]]

				return any_Some_result1_7_upvr

			end)).to.equal(any_Some_result1)

		end)

		it("should return the second option if the first one is none", function() -- Line 236

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_10_upvr = Parent_upvr.Some(20)

			expect(Parent_upvr.None:OrElse(function() -- Line 239

				--[[ Upvalues[1]:

					[1]: any_Some_result1_10_upvr (readonly)

				]]

				return any_Some_result1_10_upvr

			end)).to.equal(any_Some_result1_10_upvr)

		end)

		it("should throw if the predicate does not return an option", function() -- Line 244

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local None_upvr_2 = Parent_upvr.None

			expect(function() -- Line 246

				--[[ Upvalues[1]:

					[1]: None_upvr_2 (readonly)

				]]

				None_upvr_2:OrElse(function() -- Line 247

				end)

			end).to.throw()

		end)

	end)

	describe("XOr", function() -- Line 252

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return first option if first option is some and second option is none", function() -- Line 253

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_6 = Parent_upvr.Some(1)

			expect(any_Some_result1_6:XOr(Parent_upvr.None)).to.equal(any_Some_result1_6)

		end)

		it("should return second option if first option is none and second option is some", function() -- Line 259

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_4 = Parent_upvr.Some(2)

			expect(Parent_upvr.None:XOr(any_Some_result1_4)).to.equal(any_Some_result1_4)

		end)

		it("should return none if first and second option are some", function() -- Line 265

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(1):XOr(Parent_upvr.Some(2))).to.equal(Parent_upvr.None)

		end)

		it("should return none if first and second option are none", function() -- Line 271

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:XOr(Parent_upvr.None)).to.equal(Parent_upvr.None)

		end)

	end)

	describe("Filter", function() -- Line 278

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return none if option is none", function() -- Line 279

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:Filter(function() -- Line 281

			end)).to.equal(Parent_upvr.None)

		end)

		it("should return none if option is some but fails predicate", function() -- Line 284

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(10):Filter(function(arg1) -- Line 286

				return false

			end)).to.equal(Parent_upvr.None)

		end)

		it("should return self if option is some and passes predicate", function() -- Line 291

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			local any_Some_result1_2 = Parent_upvr.Some(10)

			expect(any_Some_result1_2:Filter(function(arg1) -- Line 293

				return true

			end)).to.equal(any_Some_result1_2)

		end)

	end)

	describe("Contains", function() -- Line 299

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return true if some option contains the given value", function() -- Line 300

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(32):Contains(32)).to.equal(true)

		end)

		it("should return false if some option does not contain the given value", function() -- Line 305

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.Some(32):Contains(64)).to.equal(false)

		end)

		it("should return false if option is none", function() -- Line 310

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(Parent_upvr.None:Contains(64)).to.equal(false)

		end)

	end)

	describe("ToString", function() -- Line 316

		--[[ Upvalues[1]:

			[1]: Parent_upvr (readonly)

		]]

		it("should return string of none option", function() -- Line 317

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			expect(tostring(Parent_upvr.None)).to.equal("Option<None>")

		end)

		it("should return string of some option with type", function() -- Line 322

			--[[ Upvalues[1]:

				[1]: Parent_upvr (copied, readonly)

			]]

			for _, v in ipairs({10, true, false, "test", {}, function() -- Line 323

			end, coroutine.create(function() -- Line 323

			end), workspace}) do

				expect(tostring(Parent_upvr.Some(v))).to.equal(string.format("Option<%s>", typeof(v)))

			end

		end)

	end)

end
