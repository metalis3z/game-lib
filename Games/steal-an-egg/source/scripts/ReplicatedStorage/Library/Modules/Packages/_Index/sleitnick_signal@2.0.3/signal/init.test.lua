-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ServerScriptService = game:GetService("ServerScriptService")

require(ServerScriptService.TestRunner.Test)

local function AwaitCondition(p1, p2) --[[ AwaitCondition | Line: 5 ]]
	local v1 = os.clock()
	local v2 = p2 or 10

	while not p1() do
		if v2 < os.clock() - v1 then
			return false
		end

		task.wait()
	end

	return true
end

return function(p1) --[[ Line: 19 | Upvalues: AwaitCondition (copy) ]]
	local v1 = require(script.Parent)
	local v2 = nil

	local function NumConns(p1) --[[ NumConns | Line: 24 | Upvalues: v2 (ref) ]]
		return #(if p1 then p1 else v2):GetConnections()
	end

	p1:BeforeEach(function() --[[ Line: 29 | Upvalues: v2 (ref), v1 (copy) ]]
		v2 = v1.new()
	end)
	p1:AfterEach(function() --[[ Line: 33 | Upvalues: v2 (ref) ]]
		v2:Destroy()
	end)
	p1:Describe("Constructor", function() --[[ Line: 37 | Upvalues: p1 (copy), v1 (copy), v2 (ref), AwaitCondition (ref) ]]
		p1:Test("should create a new signal and fire it", function() --[[ Line: 38 | Upvalues: p1 (ref), v1 (ref), v2 (ref) ]]
			p1:Expect(v1.Is(v2)):ToBe(true)
			task.defer(function() --[[ Line: 40 | Upvalues: v2 (ref) ]]
				v2:Fire(10, 20)
			end)

			local v12, v22 = v2:Wait()

			p1:Expect(v12):ToBe(10)
			p1:Expect(v22):ToBe(20)
		end)
		p1:Test("should create a proxy signal and connect to it", function() --[[ Line: 48 | Upvalues: v1 (ref), p1 (ref), AwaitCondition (ref) ]]
			local v12 = v1.Wrap(game:GetService("RunService").Heartbeat)

			p1:Expect(v1.Is(v12)):ToBe(true)

			local v2 = false

			v12:Connect(function() --[[ Line: 52 | Upvalues: v2 (ref) ]]
				v2 = true
			end)
			p1:Expect(AwaitCondition(function() --[[ Line: 55 | Upvalues: v2 (ref) ]]
				return v2
			end, 2)):ToBe(true)
			v12:Destroy()
		end)
	end)
	p1:Describe("FireDeferred", function() --[[ Line: 62 | Upvalues: p1 (copy), v2 (ref), AwaitCondition (ref) ]]
		p1:Test("should be able to fire primitive argument", function() --[[ Line: 63 | Upvalues: v2 (ref), p1 (ref), AwaitCondition (ref) ]]
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 66 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:FireDeferred(10)
			p1:Expect(AwaitCondition(function() --[[ Line: 70 | Upvalues: v1 (ref) ]]
				return v1 == 10
			end, 1)):ToBe(true)
		end)
		p1:Test("should be able to fire a reference based argument", function() --[[ Line: 75 | Upvalues: v2 (ref), p1 (ref), AwaitCondition (ref) ]]
			local t = { 10, 20 }
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 78 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:FireDeferred(t)
			p1:Expect(AwaitCondition(function() --[[ Line: 82 | Upvalues: t (copy), v1 (ref) ]]
				return t == v1
			end, 1)):ToBe(true)
		end)
	end)
	p1:Describe("Fire", function() --[[ Line: 88 | Upvalues: p1 (copy), v2 (ref) ]]
		p1:Test("should be able to fire primitive argument", function() --[[ Line: 89 | Upvalues: v2 (ref), p1 (ref) ]]
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 92 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:Fire(10)
			p1:Expect(v1):ToBe(10)
		end)
		p1:Test("should be able to fire a reference based argument", function() --[[ Line: 99 | Upvalues: v2 (ref), p1 (ref) ]]
			local t = { 10, 20 }
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 102 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:Fire(t)
			p1:Expect(v1):ToBe(t)
		end)
	end)
	p1:Describe("ConnectOnce", function() --[[ Line: 110 | Upvalues: p1 (copy), v2 (ref) ]]
		p1:Test("should only capture first fire", function() --[[ Line: 111 | Upvalues: v2 (ref), p1 (ref) ]]
			local v1 = nil
			local v22 = v2:ConnectOnce(function(p1) --[[ Line: 113 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)

			p1:Expect(v22.Connected):ToBe(true)
			v2:Fire(10)
			p1:Expect(v22.Connected):ToBe(false)
			v2:Fire(20)
			p1:Expect(v1):ToBe(10)
		end)
	end)
	p1:Describe("Wait", function() --[[ Line: 124 | Upvalues: p1 (copy), v2 (ref) ]]
		p1:Test("should be able to wait for a signal to fire", function() --[[ Line: 125 | Upvalues: v2 (ref), p1 (ref) ]]
			task.defer(function() --[[ Line: 126 | Upvalues: v2 (ref) ]]
				v2:Fire(10, 20, 30)
			end)

			local v1, v22, v3 = v2:Wait()

			p1:Expect(v1):ToBe(10)
			p1:Expect(v22):ToBe(20)
			p1:Expect(v3):ToBe(30)
		end)
	end)
	p1:Describe("DisconnectAll", function() --[[ Line: 136 | Upvalues: p1 (copy), v2 (ref) ]]
		p1:Test("should disconnect all connections", function() --[[ Line: 137 | Upvalues: v2 (ref), p1 (ref) ]]
			v2:Connect(function() --[[ Line: 138 ]] end)
			v2:Connect(function() --[[ Line: 139 ]] end)

			local v22 = nil

			p1:Expect(#(if v22 then v22 else v2):GetConnections()):ToBe(2)
			v2:DisconnectAll()

			local v5 = nil

			p1:Expect(#(if v5 then v5 else v2):GetConnections()):ToBe(0)
		end)
	end)
	p1:Describe("Disconnect", function() --[[ Line: 146 | Upvalues: p1 (copy), v2 (ref), AwaitCondition (ref) ]]
		p1:Test("should disconnect connection", function() --[[ Line: 147 | Upvalues: v2 (ref), p1 (ref) ]]
			local v1 = v2:Connect(function() --[[ Line: 148 ]] end)
			local v3 = nil

			p1:Expect(#(if v3 then v3 else v2):GetConnections()):ToBe(1)
			v1:Disconnect()

			local v6 = nil

			p1:Expect(#(if v6 then v6 else v2):GetConnections()):ToBe(0)
		end)
		p1:Test("should still work if connections disconnected while firing", function() --[[ Line: 154 | Upvalues: v2 (ref), p1 (ref) ]]
			local v1 = 0
			local v22 = nil

			v2:Connect(function() --[[ Line: 157 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v22 = v2:Connect(function() --[[ Line: 160 | Upvalues: v22 (ref), v1 (ref) ]]
				v22:Disconnect()
				v1 = v1 + 1
			end)
			v2:Connect(function() --[[ Line: 164 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v2:Fire()
			p1:Expect(v1):ToBe(3)
		end)
		p1:Test("should still work if connections disconnected while firing deferred", function() --[[ Line: 171 | Upvalues: v2 (ref), p1 (ref), AwaitCondition (ref) ]]
			local v1 = 0
			local v22 = nil

			v2:Connect(function() --[[ Line: 174 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v22 = v2:Connect(function() --[[ Line: 177 | Upvalues: v22 (ref), v1 (ref) ]]
				v22:Disconnect()
				v1 = v1 + 1
			end)
			v2:Connect(function() --[[ Line: 181 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v2:FireDeferred()
			p1:Expect(AwaitCondition(function() --[[ Line: 185 | Upvalues: v1 (ref) ]]
				return v1 == 3
			end)):ToBe(true)
		end)
	end)
end