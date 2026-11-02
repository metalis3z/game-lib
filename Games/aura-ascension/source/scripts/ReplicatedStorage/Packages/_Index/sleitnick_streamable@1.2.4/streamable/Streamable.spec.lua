-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Streamable);
    local v1 = nil;
    local v2 = nil;
    local function _(v3) --[[ Line: 7 ]] --[[ Name: CreateInstance ]]
        -- upvalues: v1 (ref)
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = v3;
        l_Folder_0.Archivable = false;
        l_Folder_0.Parent = v1;
        return l_Folder_0;
    end;
    local function _() --[[ Line: 15 ]] --[[ Name: CreatePrimary ]]
        -- upvalues: v2 (ref)
        local l_Part_0 = Instance.new("Part");
        l_Part_0.Anchored = true;
        l_Part_0.Parent = v2;
        v2.PrimaryPart = l_Part_0;
        return l_Part_0;
    end;
    beforeAll(function() --[[ Line: 23 ]]
        -- upvalues: v1 (ref), v2 (ref)
        v1 = Instance.new("Folder");
        v1.Name = "KnitTestFolder";
        v1.Archivable = false;
        v1.Parent = workspace;
        v2 = Instance.new("Model");
        v2.Name = "KnitTestModel";
        v2.Archivable = false;
        v2.Parent = workspace;
    end);
    afterEach(function() --[[ Line: 34 ]]
        -- upvalues: v1 (ref), v2 (ref)
        v1:ClearAllChildren();
        v2:ClearAllChildren();
    end);
    afterAll(function() --[[ Line: 39 ]]
        -- upvalues: v1 (ref), v2 (ref)
        v1:Destroy();
        v2:Destroy();
    end);
    describe("Streamable", function() --[[ Line: 44 ]]
        -- upvalues: v1 (ref), v0 (copy), v2 (ref)
        it("should detect instance that is immediately available", function() --[[ Line: 45 ]]
            -- upvalues: v1 (ref), v0 (ref)
            local l_Folder_1 = Instance.new("Folder");
            l_Folder_1.Name = "TestImmediate";
            l_Folder_1.Archivable = false;
            l_Folder_1.Parent = v1;
            local l_l_Folder_1_0 = l_Folder_1;
            l_Folder_1 = v0.new(v1, "TestImmediate");
            local v10 = 0;
            local v11 = 0;
            l_Folder_1:Observe(function(_, v13) --[[ Line: 50 ]]
                -- upvalues: v10 (ref), v11 (ref)
                v10 = v10 + 1;
                v13:Add(function() --[[ Line: 52 ]]
                    -- upvalues: v11 (ref)
                    v11 = v11 + 1;
                end);
            end);
            task.wait();
            l_l_Folder_1_0.Parent = nil;
            task.wait();
            l_l_Folder_1_0.Parent = v1;
            task.wait();
            l_Folder_1:Destroy();
            task.wait();
            expect(v10).to.equal(2);
            expect(v11).to.equal(2);
        end);
        it("should detect instance that is not immediately available", function() --[[ Line: 67 ]]
            -- upvalues: v0 (ref), v1 (ref)
            local v14 = v0.new(v1, "TestImmediate");
            local v15 = 0;
            local v16 = 0;
            v14:Observe(function(_, v18) --[[ Line: 71 ]]
                -- upvalues: v15 (ref), v16 (ref)
                v15 = v15 + 1;
                v18:Add(function() --[[ Line: 73 ]]
                    -- upvalues: v16 (ref)
                    v16 = v16 + 1;
                end);
            end);
            task.wait(0.1);
            local l_Folder_2 = Instance.new("Folder");
            l_Folder_2.Name = "TestImmediate";
            l_Folder_2.Archivable = false;
            l_Folder_2.Parent = v1;
            local l_l_Folder_2_0 = l_Folder_2;
            task.wait();
            l_l_Folder_2_0.Parent = nil;
            task.wait();
            l_l_Folder_2_0.Parent = v1;
            task.wait();
            v14:Destroy();
            task.wait();
            expect(v15).to.equal(2);
            expect(v16).to.equal(2);
        end);
        it("should detect primary part that is immediately available", function() --[[ Line: 90 ]]
            -- upvalues: v2 (ref), v0 (ref)
            local l_Part_1 = Instance.new("Part");
            l_Part_1.Anchored = true;
            l_Part_1.Parent = v2;
            v2.PrimaryPart = l_Part_1;
            local l_l_Part_1_0 = l_Part_1;
            l_Part_1 = v0.primary(v2);
            local v23 = 0;
            local v24 = 0;
            l_Part_1:Observe(function(_, v26) --[[ Line: 95 ]]
                -- upvalues: v23 (ref), v24 (ref)
                v23 = v23 + 1;
                v26:Add(function() --[[ Line: 97 ]]
                    -- upvalues: v24 (ref)
                    v24 = v24 + 1;
                end);
            end);
            task.wait();
            l_l_Part_1_0.Parent = nil;
            task.wait();
            l_l_Part_1_0.Parent = v2;
            v2.PrimaryPart = l_l_Part_1_0;
            task.wait();
            l_Part_1:Destroy();
            task.wait();
            expect(v23).to.equal(2);
            expect(v24).to.equal(2);
        end);
        it("should detect primary part that is not immediately available", function() --[[ Line: 113 ]]
            -- upvalues: v0 (ref), v2 (ref)
            local v27 = v0.primary(v2);
            local v28 = 0;
            local v29 = 0;
            v27:Observe(function(_, v31) --[[ Line: 117 ]]
                -- upvalues: v28 (ref), v29 (ref)
                v28 = v28 + 1;
                v31:Add(function() --[[ Line: 119 ]]
                    -- upvalues: v29 (ref)
                    v29 = v29 + 1;
                end);
            end);
            task.wait(0.1);
            local l_Part_2 = Instance.new("Part");
            l_Part_2.Anchored = true;
            l_Part_2.Parent = v2;
            v2.PrimaryPart = l_Part_2;
            local l_l_Part_2_0 = l_Part_2;
            task.wait();
            l_l_Part_2_0.Parent = nil;
            task.wait();
            l_l_Part_2_0.Parent = v2;
            v2.PrimaryPart = l_l_Part_2_0;
            task.wait();
            v27:Destroy();
            task.wait();
            expect(v28).to.equal(2);
            expect(v29).to.equal(2);
        end);
    end);
end;