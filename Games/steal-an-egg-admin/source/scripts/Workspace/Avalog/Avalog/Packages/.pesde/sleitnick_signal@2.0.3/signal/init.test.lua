-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ServerScriptService = game:GetService("ServerScriptService")
require(ServerScriptService.TestRunner.Test)

local function AwaitCondition(v1, v2) -- line 5
    local v3 = os.clock()
    local v4 = v2 or 10
    while not v1() do
        if v4 < os.clock() - v3 then
            return false
        end
        task.wait()
    end
    return true
end

return function(v5) -- line 19 | captures: AwaitCondition
    local Parent = require(script.Parent)
    local v6

    local function NumConns(v7) -- line 24 | captures: v6
        return #(v7 or v6):GetConnections()
    end

    v5:BeforeEach(function() -- line 29 | captures: v6, Parent
        v6 = Parent.new()
    end)
    v5:AfterEach(function() -- line 33 | captures: v6
        v6:Destroy()
    end)
    v5:Describe("Constructor", function() -- line 37 | captures: v6, v5, Parent, AwaitCondition
        v5:Test("should create a new signal and fire it", function() -- line 38 | captures: v6, v5, Parent
            v5:Expect(Parent.Is(v6)):ToBe(true)
            task.defer(function() -- line 40 | captures: v6
                v6:Fire(10, 20)
            end)
            local v8, v9 = v6:Wait()
            v5:Expect(v8):ToBe(10)
            v5:Expect(v9):ToBe(20)
        end)
        v5:Test("should create a proxy signal and connect to it", function() -- line 48 | captures: v5, Parent, AwaitCondition
            local v10 = Parent.Wrap(game:GetService("RunService").Heartbeat)
            v5:Expect(Parent.Is(v10)):ToBe(true)
            local v11 = false
            v10:Connect(function() -- line 52 | captures: v11
                v11 = true
            end)
            v5:Expect(AwaitCondition(function() -- line 55 | captures: v11
                return v11
            end, 2)):ToBe(true)
            v10:Destroy()
        end)
    end)
    v5:Describe("FireDeferred", function() -- line 62 | captures: v6, v5, AwaitCondition
        v5:Test("should be able to fire primitive argument", function() -- line 63 | captures: v6, v5, AwaitCondition
            local v12
            v6:Connect(function(v13) -- line 66 | captures: v12
                v12 = v13
            end)
            v6:FireDeferred(10)
            v5:Expect(AwaitCondition(function() -- line 70 | captures: v12
                return v12 == 10
            end, 1)):ToBe(true)
        end)
        v5:Test("should be able to fire a reference based argument", function() -- line 75 | captures: v6, v5, AwaitCondition
            local v14 = { 10, 20 }
            local v15
            v6:Connect(function(v16) -- line 78 | captures: v15
                v15 = v16
            end)
            v6:FireDeferred(v14)
            v5:Expect(AwaitCondition(function() -- line 82 | captures: v15, v14
                return v14 == v15
            end, 1)):ToBe(true)
        end)
    end)
    v5:Describe("Fire", function() -- line 88 | captures: v6, v5
        v5:Test("should be able to fire primitive argument", function() -- line 89 | captures: v6, v5
            local v17
            v6:Connect(function(v18) -- line 92 | captures: v17
                v17 = v18
            end)
            v6:Fire(10)
            v5:Expect(v17):ToBe(10)
        end)
        v5:Test("should be able to fire a reference based argument", function() -- line 99 | captures: v6, v5
            local v19 = { 10, 20 }
            local v20
            v6:Connect(function(v21) -- line 102 | captures: v20
                v20 = v21
            end)
            v6:Fire(v19)
            v5:Expect(v20):ToBe(v19)
        end)
    end)
    v5:Describe("ConnectOnce", function() -- line 110 | captures: v6, v5
        v5:Test("should only capture first fire", function() -- line 111 | captures: v6, v5
            local v22
            local v23 = v6:ConnectOnce(function(v24) -- line 113 | captures: v22
                v22 = v24
            end)
            v5:Expect(v23.Connected):ToBe(true)
            v6:Fire(10)
            v5:Expect(v23.Connected):ToBe(false)
            v6:Fire(20)
            v5:Expect(v22):ToBe(10)
        end)
    end)
    v5:Describe("Wait", function() -- line 124 | captures: v6, v5
        v5:Test("should be able to wait for a signal to fire", function() -- line 125 | captures: v6, v5
            task.defer(function() -- line 126 | captures: v6
                v6:Fire(10, 20, 30)
            end)
            local v25, v26, v27 = v6:Wait()
            v5:Expect(v25):ToBe(10)
            v5:Expect(v26):ToBe(20)
            v5:Expect(v27):ToBe(30)
        end)
    end)
    v5:Describe("DisconnectAll", function() -- line 136 | captures: v6, v5
        v5:Test("should disconnect all connections", function() -- line 137 | captures: v6, v5
            v6:Connect(function() -- line 138
            end)
            v6:Connect(function() -- line 139
            end)
            v5:Expect(#v6:GetConnections()):ToBe(2)
            v6:DisconnectAll()
            v5:Expect(#v6:GetConnections()):ToBe(0)
        end)
    end)
    v5:Describe("Disconnect", function() -- line 146 | captures: v6, v5, AwaitCondition
        v5:Test("should disconnect connection", function() -- line 147 | captures: v6, v5
            local v28 = v6:Connect(function() -- line 148
            end)
            v5:Expect(#v6:GetConnections()):ToBe(1)
            v28:Disconnect()
            v5:Expect(#v6:GetConnections()):ToBe(0)
        end)
        v5:Test("should still work if connections disconnected while firing", function() -- line 154 | captures: v6, v5
            local v29 = 0
            local v30
            v6:Connect(function() -- line 157 | captures: v29
                v29 += 1
            end)
            v30 = v6:Connect(function() -- line 160 | captures: v29, v30
                v30:Disconnect()
                v29 += 1
            end)
            v6:Connect(function() -- line 164 | captures: v29
                v29 += 1
            end)
            v6:Fire()
            v5:Expect(v29):ToBe(3)
        end)
        v5:Test("should still work if connections disconnected while firing deferred", function() -- line 171 | captures: v6, v5, AwaitCondition
            local v31 = 0
            local v32
            v6:Connect(function() -- line 174 | captures: v31
                v31 += 1
            end)
            v32 = v6:Connect(function() -- line 177 | captures: v31, v32
                v32:Disconnect()
                v31 += 1
            end)
            v6:Connect(function() -- line 181 | captures: v31
                v31 += 1
            end)
            v6:FireDeferred()
            v5:Expect(AwaitCondition(function() -- line 185 | captures: v31
                return v31 == 3
            end)):ToBe(true)
        end)
    end)
end
