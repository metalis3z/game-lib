-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)
	local v2 = nil
	local v3 = nil
	local v4 = nil

	beforeEach(function() --[[ Line: 6 | Upvalues: v2 (ref), v1 (copy), v3 (ref), v4 (ref) ]]
		v2 = v1.new({
			Kills = 0,
			Deaths = 0
		}, {
			SetKills = function(p1, p2) --[[ SetKills | Line: 11 ]]
				p1.Kills = p2
			end,
			IncrementDeaths = function(p1, p2) --[[ IncrementDeaths | Line: 14 ]]
				p1.Deaths = p1.Deaths + p2
			end
		})
		v3 = v1.new({
			Money = 0
		}, {
			AddMoney = function(p1, p2) --[[ AddMoney | Line: 21 ]]
				p1.Money = p1.Money + p2
			end
		})
		v4 = v1.combine({
			Stats = v2,
			Econ = v3
		})
	end)
	describe("State", function() --[[ Line: 31 | Upvalues: v1 (copy), v4 (ref), v2 (ref), v3 (ref) ]]
		it("should get state properly", function() --[[ Line: 32 | Upvalues: v1 (ref) ]]
			local v12 = v1.new({
				ABC = 10
			}):GetState()

			expect(v12).to.be.a("table")
			expect(v12.ABC).to.equal(10)
		end)
		it("should get state from combined silos", function() --[[ Line: 41 | Upvalues: v4 (ref) ]]
			local v1 = v4:GetState()

			expect(v1).to.be.a("table")
			expect(v1.Stats).to.be.a("table")
			expect(v1.Econ).to.be.a("table")
			expect(v1.Stats.Kills).to.be.a("number")
			expect(v1.Stats.Deaths).to.be.a("number")
			expect(v1.Econ.Money).to.be.a("number")
		end)
		it("should not allow getting state from sub-silo", function() --[[ Line: 51 | Upvalues: v2 (ref), v3 (ref) ]]
			expect(function() --[[ Line: 52 | Upvalues: v2 (ref) ]]
				v2:GetState()
			end).to.throw()
			expect(function() --[[ Line: 55 | Upvalues: v3 (ref) ]]
				v3:GetState()
			end).to.throw()
		end)
		it("should throw error if attempting to modify state directly", function() --[[ Line: 60 | Upvalues: v4 (ref) ]]
			expect(function() --[[ Line: 61 | Upvalues: v4 (ref) ]]
				v4:GetState().Stats.Kills = 10
			end).to.throw()
			expect(function() --[[ Line: 64 | Upvalues: v4 (ref) ]]
				v4:GetState().Stats.SomethingNew = 100
			end).to.throw()
			expect(function() --[[ Line: 67 | Upvalues: v4 (ref) ]]
				v4:GetState().Stats = {}
			end).to.throw()
			expect(function() --[[ Line: 70 | Upvalues: v4 (ref) ]]
				v4:GetState().SomethingElse = {}
			end).to.throw()
		end)
	end)
	describe("Dispatch", function() --[[ Line: 76 | Upvalues: v4 (ref), v2 (ref), v3 (ref), v1 (copy) ]]
		it("should dispatch", function() --[[ Line: 77 | Upvalues: v4 (ref), v2 (ref), v3 (ref) ]]
			expect(v4:GetState().Stats.Kills).to.equal(0)
			v4:Dispatch(v2.Actions.SetKills(10))
			expect(v4:GetState().Stats.Kills).to.equal(10)
			v4:Dispatch(v3.Actions.AddMoney(10))
			v4:Dispatch(v3.Actions.AddMoney(20))
			expect(v4:GetState().Econ.Money).to.equal(30)
		end)
		it("should not allow dispatching from a sub-silo", function() --[[ Line: 86 | Upvalues: v2 (ref), v3 (ref) ]]
			expect(function() --[[ Line: 87 | Upvalues: v2 (ref) ]]
				v2:Dispatch(v2.Action.SetKills(0))
			end).to.throw()
			expect(function() --[[ Line: 90 | Upvalues: v3 (ref) ]]
				v3:Dispatch(v3.Action.AddMoney(0))
			end).to.throw()
		end)
		it("should not allow dispatching from within a modifier", function() --[[ Line: 95 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 96 | Upvalues: v1 (ref) ]]
				local v12 = nil

				v12 = v1.new({
					Data = 0
				}, {
					SetData = function(p1, p2) --[[ SetData | Line: 101 | Upvalues: v12 (ref) ]]
						p1.Data = p2
						v12:Dispatch({
							Name = "",
							Payload = 0
						})
					end
				})
				v12:Dispatch(v12.Actions.SetData(0))
			end).to.throw()
		end)
	end)
	describe("Subscribe", function() --[[ Line: 111 | Upvalues: v4 (ref), v2 (ref), v1 (copy) ]]
		it("should subscribe to a silo", function() --[[ Line: 112 | Upvalues: v4 (ref), v2 (ref) ]]
			local v1 = nil
			local v22 = nil
			local v3 = 0
			local v42 = v4:Subscribe(function(p1, p2) --[[ Line: 115 | Upvalues: v3 (ref), v1 (ref), v22 (ref) ]]
				v3 = v3 + 1
				v1 = p1
				v22 = p2
			end)

			expect(v3).to.equal(0)
			v4:Dispatch(v2.Actions.SetKills(10))
			expect(v3).to.equal(1)
			expect(v1).to.be.a("table")
			expect(v22).to.be.a("table")
			expect(v1.Stats.Kills).to.equal(10)
			expect(v22.Stats.Kills).to.equal(0)
			v4:Dispatch(v2.Actions.SetKills(20))
			expect(v3).to.equal(2)
			expect(v1.Stats.Kills).to.equal(20)
			expect(v22.Stats.Kills).to.equal(10)
			v42()
			v4:Dispatch(v2.Actions.SetKills(30))
			expect(v3).to.equal(2)
		end)
		it("should not allow subscribing same function more than once", function() --[[ Line: 135 | Upvalues: v4 (ref) ]]
			local function sub() --[[ sub | Line: 136 ]] end

			expect(function() --[[ Line: 137 | Upvalues: v4 (ref), sub (copy) ]]
				v4:Subscribe(sub)
			end).never.to.throw()
			expect(function() --[[ Line: 140 | Upvalues: v4 (ref), sub (copy) ]]
				v4:Subscribe(sub)
			end).to.throw()
		end)
		it("should not allow subscribing to a sub-silo", function() --[[ Line: 145 | Upvalues: v2 (ref) ]]
			expect(function() --[[ Line: 146 | Upvalues: v2 (ref) ]]
				v2:Subscribe(function() --[[ Line: 147 ]] end)
			end).to.throw()
		end)
		it("should not allow subscribing from within a modifier", function() --[[ Line: 151 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 152 | Upvalues: v1 (ref) ]]
				local v12 = nil

				v12 = v1.new({
					Data = 0
				}, {
					SetData = function(p1, p2) --[[ SetData | Line: 157 | Upvalues: v12 (ref) ]]
						p1.Data = p2
						v12:Subscribe(function() --[[ Line: 159 ]] end)
					end
				})
				v12:Dispatch(v12.Actions.SetData(0))
			end).to.throw()
		end)
	end)
	describe("Watch", function() --[[ Line: 167 | Upvalues: v4 (ref), v3 (ref), v2 (ref) ]]
		it("should watch value changes", function() --[[ Line: 168 | Upvalues: v4 (ref), v3 (ref), v2 (ref) ]]
			local function SelectMoney(p1) --[[ SelectMoney | Line: 169 ]]
				return p1.Econ.Money
			end

			local v1 = 0
			local v22 = 0
			local v32 = v4:Watch(SelectMoney, function(p1) --[[ Line: 174 | Upvalues: v1 (ref), v22 (ref) ]]
				v1 = v1 + 1
				v22 = p1
			end)

			expect(v1).to.equal(1)
			v4:Dispatch(v3.Actions.AddMoney(10))
			expect(v1).to.equal(2)
			expect(v22).to.equal(10)
			v4:Dispatch(v3.Actions.AddMoney(20))
			expect(v1).to.equal(3)
			expect(v22).to.equal(30)
			v4:Dispatch(v3.Actions.AddMoney(0))
			expect(v1).to.equal(3)
			expect(v22).to.equal(30)
			v4:Dispatch(v2.Actions.SetKills(10))
			expect(v1).to.equal(3)
			expect(v22).to.equal(30)
			v32()
			v4:Dispatch(v3.Actions.AddMoney(10))
			expect(v1).to.equal(3)
			expect(v22).to.equal(30)
		end)
	end)
	describe("ResetToDefaultState", function() --[[ Line: 198 | Upvalues: v4 (ref), v2 (ref), v3 (ref) ]]
		it("should reset the silo to it\'s default state", function() --[[ Line: 199 | Upvalues: v4 (ref), v2 (ref), v3 (ref) ]]
			v4:Dispatch(v2.Actions.SetKills(10))
			v4:Dispatch(v3.Actions.AddMoney(30))
			expect(v4:GetState().Stats.Kills).to.equal(10)
			expect(v4:GetState().Econ.Money).to.equal(30)
			v4:ResetToDefaultState()
			expect(v4:GetState().Stats.Kills).to.equal(0)
			expect(v4:GetState().Econ.Money).to.equal(0)
		end)
	end)
end