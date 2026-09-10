-- leaked by rwaldev
print('leaked by rwaldev')
local Env = getfenv();
local r = {};
local v1 = game;

local v2 = loadstring(v1.HttpGet(v1, "https://raw.githubusercontent.com/odhier/Flooxa-LibGui/refs/heads/main/main.lua"))();
local v3 = game;

local r24 = v3.GetService(v3, "Players");
local v4 = game.ReplicatedStorage;
local v5 = v4.WaitForChild(v4, "Util");
local v6 = v5.WaitForChild(v5, "Net");
local r25 = v6.WaitForChild(v6, "RE/HeartbeatMinigameComplete");
local v7 = v2;
local r26 = v7.CreateWindow(v7, {
    ["Name"] = "Flooxa-X",
    ["Logo"] = "rbxassetid://94744502801462",
    ["Discord"] = "discord.gg/----------",
    ["Version"] = "Flooxa Exploits v1.1.0"
});
local v8 = game;
local r27 = v8.GetService(v8, "RunService");

local function r28(arg1_2, arg2_2, arg3_2, ...)
    M = arg3_2;
    
    if M == nil then
        M = 5;
    end;
    
    D = "\x0c\x14N8{";
    Z = r26;
    
    Z.MakeNotification(Z, {
        [r16[r15(D, 22393563490491)]] = arg1_2,
        ["Content"] = arg2_2,
        ["Duration"] = M
    });
    
    return; 
end;

local v9 = game;
local r29 = v9.GetService(v9, "Players").LocalPlayer;
local v10 = workspace;

local r30 = v10.WaitForChild(v10, "NPCs");
local r31 = false;
local r32 = true;
local r33 = false;
local v11 = false;
local r34 = true;
local r35 = false;
local r38 = true;
local v12 = false;
local r40 = false;
local r41 = {};
local r42 = true;
local r43 = true;
local r44 = {};
local r45 = false;
local r46 = {};
local r48 = 16;
local r49 = true;
local r50 = false;
local r51 = {};
local r52 = false;
local r53 = true;
local r54 = true;
local r57 = false;
local r59 = false;
local r60 = false;
local v13 = false;
local v14 = nil;
local r61 = {
    ["npc"] = nil,
    ["step"] = "",
    ["checkInFolder"] = nil,
    ["counterCF"] = nil,
    ["registerCF"] = nil,
    ["roomName"] = nil,
    ["medQueue"] = {},
    ["medIndex"] = 1
};
local v15 = {
    ["IV Drops"] = CFrame.new(-151.743423, 3.45753074, -59.0375519, -0.0261747427, 1.10497478e-09, .999657393, -1.62515477e-08, 1, -1.53087931e-09, -0.999657393, -1.62860498e-08, -0.0261747427),
    ["Eye Drops"] = CFrame.new(-151.743423, 3.45753074, -59.0375519, -0.0261747427, 1.10497478e-09, .999657393, -1.62515477e-08, 1, -1.53087931e-09, -0.999657393, -1.62860498e-08, -0.0261747427),
    ["Medkit"] = CFrame.new(-152.269913, 3.45753074, -70.1591873, .182232723, -1.56868722e-08, .983255446, 9.11667968e-08, 1, -9.42482536e-10, -0.983255446, 8.98119978e-08, .182232723),
    ["Thermo"] = CFrame.new(-152.269913, 3.45753074, -70.1591873, .182232723, -1.56868722e-08, .983255446, 9.11667968e-08, 1, -9.42482536e-10, -0.983255446, 8.98119978e-08, .182232723),
    ["Bandages"] = CFrame.new(-152.988007, 3.45753074, -82.170166, -0.0087249903, -4.52036686e-10, .999961913, 1.256525e-09, 1, 4.63017485e-10, -0.999961913, 1.26051691e-09, -0.0087249903),
    ["Ointment"] = CFrame.new(-152.988007, 3.45753074, -82.170166, -0.0087249903, -4.52036686e-10, .999961913, 1.256525e-09, 1, 4.63017485e-10, -0.999961913, 1.26051691e-09, -0.0087249903),
    ["Cough Syrup"] = CFrame.new(-137.147812, 3.45753074, -80.2512589, .061048165, -1.36755292e-08, -0.998134792, -1.38432741e-08, 1, -1.45477701e-08, .998134792, 1.47055692e-08, .061048165),
    ["Maple Syrup"] = CFrame.new(-137.147812, 3.45753074, -80.2512589, .061048165, -1.36755292e-08, -0.998134792, -1.38432741e-08, 1, -1.45477701e-08, .998134792, 1.47055692e-08, .061048165),
    ["Medicine"] = CFrame.new(-136.466766, 3.45753074, -60.5426674, .0523359329, 2.30517133e-11, -0.99862951, 5.36240172e-08, 1, 2.83339774e-09, .99862951, -5.36988161e-08, .0523359329),
    ["Herbs"] = CFrame.new(-136.466766, 3.45753074, -60.5426674, .0523359329, 2.30517133e-11, -0.99862951, 5.36240172e-08, 1, 2.83339774e-09, .99862951, -5.36988161e-08, .0523359329)
};
local v16 = game;
local r62 = v16.GetService(v16, "ReplicatedStorage").Util.Net["RE/ExtinguisherBubbleHitGrime"];
local v17 = game;
local r63 = v17.GetService(v17, "ReplicatedStorage").Util.Net["RE/ExtinguisherBubbleHitFireNPC"];
local v18 = game;
local r64 = v18.GetService(v18, "ReplicatedStorage").Util.Net["RE/ExtinguisherBubbleHit"];
local v19 = game;
local r65 = v19.GetService(v19, "ReplicatedStorage").Util.Net["RE/ExtinguisherBubbleHitHider"];
local v20 = r29.Character;

if v20 then
    v20 = r29.Character;
    
    YE = v20.FindFirstChild(v20, "Humanoid");
end;

if v20 then
    r48 = r29.Character.Humanoid.WalkSpeed;
end;

local function r66(arg1_3, ...)
    v = workspace;
    I = v[2];
    v = v[1];
    
    for M, v6 in ipairs(v.GetDescendants(v)) do
        v3 = M;
        
        if v6.Name == arg1_3 and (v6.Parent and v6.Parent.Name == "Items") then
            return v6.FindFirstChild(v6, "PP");
        else
            
        end; 
    end;
    
    return nil; 
end;

local r67 = r48;

local function r68(arg1_4, ...)
    Z = game;
    
    if arg1_4 then
        L = game;
        
        r69 = L.GetService(L, "VirtualUser");
        L = Z.GetService(Z, "Players").LocalPlayer.Idled;
        r55 = L.Connect(L, function(...)
            L = r69;
            v = r16;
            
            L.Button2Down(L, Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
            task.wait(1);
            
            L = r69;
            
            L.Button2Up(L, Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
            
            print("[ANTI-AFK] Berhasil mencegah kick AFK!");
            
            return; 
        end);
        
        r28("Automation", "Anti-AFK ON: Aman ditinggal tidur!", 3);
    else
        if r55 then
            L = r55;
            
            L.Disconnect(L);
        end;
        
        r28("Automation", "Anti-AFK OFF", 3);
        
        return;
    end; 
end;

local function r70(arg1_5, ...)
    r31 = arg1_5;
    
    if r31 then
        r28("Sukses", "Toggle ON: Instant Prompt Aktif (Background Task)!", 3);
        
        v3 = workspace;
        v6 = {
            v3.GetDescendants(v3)
        };
        M = v3[2];
        v = v3[3];
        
        for v, v6 in ipairs(S(v6)) do
            v3 = v;
            
            if v6.IsA(v6, "ProximityPrompt") then
                if not r41[v6] then
                    r41[v6] = v6.HoldDuration;
                end;
                
                v6.HoldDuration = 0;
            end; 
        end;
        
        r56 = task.spawn(function(...)
            while r31 do
                M = r15;
                
                task.wait(2);
                
                M = workspace;
                j = M[2];
                M = M[1];
                
                for I, v3 in ipairs(M.GetDescendants(M)) do
                    v = I;
                    
                    if not r31 then
                        
                    else
                        if v3.IsA(v3, "ProximityPrompt") then
                            if v3.HoldDuration ~= 0 then
                                if not r41[v3] then
                                    r41[v3] = v3.HoldDuration;
                                end;
                                
                                v3.HoldDuration = 0;
                            end;
                        end;
                    end; 
                end; 
            end;
            
            return; 
        end);
    else
        r28("Sukses", "Toggle OFF: Prompt balik normal!", 3);
        
        r31 = false;
        v8 = r41;
        
        for v7, v8 in ("\x9a\x98_7\x08\xe2:\x13\xdd\xc1\x1dx\xd6\x81\xcd\x96V\x94\xc9\x8f\xd8\xbf\xdd\xf5>\xc2W\x85#\xe9\x9a\xce")[1], pairs(v8) do
            if v7 then
                m = v7.Parent;
            end;
            
            L = j;
            
            if v7 then
                v7.HoldDuration = v8;
            end; 
        end;
        
        r41 = {};
        
        return;
    end; 
end;

local function r71(...)
    if not r30 then
        return;
    end;
    
    M = r30;
    I = M[3];
    M = M[1];
    
    for I, v3 in M, ipairs(M.GetChildren(M)) do
        v = I;
        
        if v3.IsA(v3, "Model") then
            L = ipairs;
            v9 = v3.GetDescendants;
            m = v9[3];
            
            for m, v9 in v9[1], L(v9(v3)) do
                v10 = m;
                
                if v9.IsA(v9, "ProximityPrompt") and v9.Name == "FaintedPP" then
                    v6 = v9;
                end; 
            end;
            
            if nil then
                v7 = nil.Enabled and nil.ActionText;
                L = ipairs;
            end;
            
            L = L;
            
            if nil then
                v8 = workspace;
                
                m = v8.FindFirstChild(v8, game.Players.LocalPlayer.Name);
                
                if m then
                    
                    v8 = m.FindFirstChild(m, "HumanoidRootPart");
                end;
                
                if m then
                    print("[AUTO CARRY] Nemu pasien pingsan:", v3.Name);
                    
                    v10 = m.CFrame;
                    
                    m.CFrame = v3.GetPivot(v3) * CFrame.new(0, 0, -3);
                    
                    task.wait(.2);
                    
                    nil.RequiresLineOfSight = false;
                    
                    fireproximityprompt(nil);
                    
                    k = nil.RequiresLineOfSight;
                    
                    nil.RequiresLineOfSight = k;
                    
                    task.wait(0.5);
                    
                    k = "Medical";
                    t = v10;
                    R = string.find(v3.GetAttribute(v3, "DesignatedRoom"), "Room6");
                    
                    if R then
                        if R then
                            k = "Emergency";
                        end;
                        
                        Q = R.FindFirstChild(R, "Medical") and R.FindFirstChild(R, O);
                        v12 = r16;
                        R = workspace.Rooms;
                        t = R.FindFirstChild(R, "Medical") and R.FindFirstChild(R, O);
                        
                        if t then
                            
                            v12 = t.FindFirstChild(t, "Minigame");
                            Q = v12 and v12.FindFirstChild(v12, "Bed");
                            L = Q;
                        end;
                        
                        L = Q;
                        
                        if t then
                            
                            R = t.GetPivot(t);
                            W = R;
                            W = CFrame.new(R.Position.X, v8.FindFirstChild(v8, v7[v9]).HumanoidRootPart.Position.v3, R.Position.Z) * CFrame.new(0, 0, -4);
                            W = CFrame.new(W.Position, Vector3.new(R.Position.X, W.Position.v3, R.Position.Z));
                            P = CFrame.new(W.Position, Vector3.new(R.Position.X, W.Position.v3, R.Position.Z));
                            
                            m.CFrame = P;
                            
                            H = 27387029664209;
                            LE = t.GetDescendants;
                            
                            task[r16[r15("\xee\xc6\x87\xdb", H)]](0.5);
                            
                            u = {
                                LE(t)
                            };
                            o = LE[3];
                            K = LE[2];
                            
                            for o, u in ipairs(S(u)) do
                                P = o;
                                L = R;
                                
                                if u.Name == "FaintedPP" and u.IsA(u, "ProximityPrompt") then
                                    v12 = u;
                                end; 
                            end;
                            
                            if not nil then
                                H = t.GetDescendants;
                                u = {
                                    H(t)
                                };
                                o = H[3];
                                K = H[2];
                                
                                for o, u in ipairs(S(u)) do
                                    P = o;
                                    L = R;
                                    
                                    if u.IsA(u, "ProximityPrompt") and u.Enabled then
                                        v12 = u;
                                    end; 
                                end;
                            end;
                            
                            if nil then
                                P = nil.Enabled;
                            end;
                            
                            L = R;
                            
                            if nil then
                                nil.RequiresLineOfSight = false;
                                
                                fireproximityprompt(nil);
                                
                                task.wait(2);
                                
                                K = nil.RequiresLineOfSight;
                                
                                nil.RequiresLineOfSight = K;
                                
                                print("[AUTO CARRY] Berhasil menaruh pasien ke kasur:", O);
                            end;
                        end;
                        
                        m.CFrame = v8.CFrame;
                        
                        break;
                    end;
                else
                    
                end;
            end;
        end; 
    end;
    
    return; 
end;

local function r72(...)
    if not r30 then
        return;
    end;
    
    M = r30;
    I = M[3];
    M = M[1];
    
    for I, v3 in M, ipairs(M.GetChildren(M)) do
        
        v7 = v3.IsA(v3, "Model");
        v = I;
        
        if v7 then
            L = ipairs;
            v6 = v3.Name ~= "Hider" or v3.Name ~= "TallMonster";
        end;
        
        if v7 then
            if not v3.FindFirstChild(v3, "HumanoidRootPart") then
                
            end;
        else
            
        end; 
    end;
    
    return; 
end;

local function r73(...)
    j = workspace.Rooms.Medical;
    v3 = j.GetDescendants;
    v = {
        v3(j)
    };
    I = v3[2];
    v = v3[1];
    
    for M, v6 in ipairs(S(v)) do
        v3 = M;
        v7 = v6.IsA(v6, "Model") and v6.Name == "Candles";
        
        if v7 then
            k = 18748990677530;
            
            print("CANDLES TERDETEKSI");
            
            m = r16;
            v8 = m[r15("\x92L\xa5~oU\x02\x87j", k)];
            
            v7 = r66(v8);
            
            if v7 then
                v8 = game.Players.LocalPlayer;
                m = workspace[v8.Name];
                v10 = m;
                
                if m then
                    
                    v10 = m.FindFirstChild(m, "HumanoidRootPart");
                end;
                
                O = v7.Parent;
                
                m.HumanoidRootPart.CFrame = O.GetPivot(O);
                
                task.wait(0.5);
                
                fireproximityprompt(v7);
                
                v9 = m;
                
                if m then
                    
                    v9 = m.FindFirstChild(m, "Humanoid");
                end;
                
                k = v8.Backpack;
                
                v11 = k.FindFirstChild(k, "Eye Drops");
                O = v11;
                
                if v11 then
                    R = v6.GetDescendants;
                    v11 = R[2];
                    t = R[3];
                    
                    for t, R in ipairs(R(v6)) do
                        Q = t;
                        
                        if v11 then
                            if m then
                                a = not m.FindFirstChild(m, "Eye Drops");
                            end;
                            
                            L = Env[k];
                            W = v9;
                        end;
                        
                        if O then
                            m.EquipTool(m, v11);
                        end;
                        
                        m.HumanoidRootPart.CFrame = R.GetPivot(R);
                        
                        fireproximityprompt(R.FindFirstChild(R, "PP", true));
                        
                        task.wait(.2); 
                    end;
                else
                    
                    O = m.FindFirstChild(m, "Eye Drops");
                end;
            end;
        end; 
    end;
    
    return; 
end;

task.spawn(function(...)
    while task.wait(1) do
        if r49 then
            r71();
        end;
        
        if r53 then
            r72();
        end;
        
        if r54 then
            r73();
        end; 
    end;
    
    return; 
end);

local function r74(arg1_6, ...)
    j = arg1_6;
    L = task.wait;
    
    L(2);
    
    Z = j;
    
    while not j do
        if Z then
            L = r63;
            
            L.FireServer(L, arg1_6);
            task.wait(.1);
        end;
        
        r28("Success", "Extinguished Patient on fire", 3);
        
        return; 
    end;
    
    v = L;
    Z = (j.GetAttribute(j, "FireCharges") or 0) > 0; 
end;

local function r75(arg1_7, ...)
    L = task.wait;
    
    L(1);
    
    for I = 1, 5 do
        L = r62;
        
        L.FireServer(L, arg1_7);
        
        v6 = I; 
    end;
    
    r28("Success", "Clean Slime", 3);
    
    return; 
end;

local function r76(arg1_8, ...)
    j = arg1_8;
    Z = j;
    
    while not j do
        if j then
            L = r64;
            
            L.FireServer(L, j.GetChildren(j)[1]);
            task.wait(.1);
        end;
        
        r28("Success", "Extinguished the fire", 3);
        
        return; 
    end;
    
    Z = j.Parent; 
end;

local function r77(arg1_9, arg2_9, ...)
    r78 = arg1_9;
    r79 = arg2_9;
    L = r78;
    
    Z = L.GetPropertyChangedSignal(L, "Playing");
    
    table.insert(r46, Z.Connect(Z, function(...)
        if not r43 then
            return;
        end;
        
        M = r15;
        
        if r78.Playing then
            if r45 then
                return;
            end;
            
            table.insert(r44, r79);
            
            if #r44 == 4 then
                r45 = true;
                
                task.spawn(function(...)
                    I = r16;
                    
                    v = r15("\x0e\xcd\xc1\xad", 5172577192296);
                    
                    task[I[v]](2);
                    
                    M = r44;
                    j = v[2];
                    M = v[1];
                    
                    for I, v3 in ipairs(M) do
                        v = I;
                        
                        if v3 then
                            v6 = v3.Parent;
                        end;
                        
                        if v3 then
                            fireclickdetector(v3);
                        end;
                        
                        task.wait(1); 
                    end;
                    
                    I = "task";
                    
                    Env[I].wait(1);
                    table.clear(r44);
                    
                    r45 = false;
                    
                    return; 
                end);
            end;
        end;
        
        return; 
    end));
    
    return; 
end;

local function r80(...)
    M = r46;
    j = 112[2];
    M = 112[1];
    
    for I, v3 in ipairs(M) do
        v = I;
        
        v3.Disconnect(v3); 
    end;
    
    table.clear(r46);
    table.clear(r44);
    
    r45 = false;
    j = game.Workspace.Rooms.Emergency.Room6.Minigame.xrayMonitor.Screen["computer log out"];
    I = j.GetPropertyChangedSignal(j, "Playing");
    
    I.Connect(I, function(...)
        M = r15;
        
        table.clear(r44);
        
        r45 = false;
        
        return; 
    end);
    
    v3 = workspace;
    v = v3[3];
    
    for v, v3 in v3[1], ipairs(v3.GetDescendants(v3)) do
        j = v;
        L = false;
        
        if v3.Name == "Model" and (v3.Parent and v3.Parent.Name == "Colors") then
            
            v6 = v3.FindFirstChild(v3, "Button");
            
            if v6 then
                
                v7 = v6.FindFirstChild(v6, "boop");
                v8 = v6.FindFirstChild(v6, "ClickDetector");
                
                if v7 then
                    
                    m = v6.FindFirstChild(v6, r[I][O]);
                end;
                
                L = v7;
                
                if v7 then
                    r77(v7, v8);
                end;
            end;
        end; 
    end;
    
    return; 
end;

local function r81(...)
    Z = game;
    L = Z.GetService(Z, "Players").LocalPlayer.Character;
    M = L and L.FindFirstChild(L, "HumanoidRootPart");
    
    if M then
        v6 = workspace;
        v6 = "ipairs";
        
        for v3, v8 in ipairs(v6.GetDescendants(v6)) do
            v7 = v3;
            m = v8.Name == "MainLook" and v8.IsA(v8, "BasePart");
            
            if m then
                
                m = v8.FindFirstChild(v8, "PP");
                
                if m then
                    v10 = m.Enabled;
                end;
                
                if m then
                    M.CFrame = v8.CFrame * CFrame.new(0, 0, -2.5);
                    
                    task.wait(.2);
                    
                    m.RequiresLineOfSight = false;
                    
                    fireproximityprompt(m);
                    
                    O = m.RequiresLineOfSight;
                    
                    m.RequiresLineOfSight = O;
                    
                    task.wait(.2);
                    
                    M.CFrame = M.CFrame;
                else
                    
                end;
            end; 
        end;
    end;
    
    return; 
end;

task.spawn(function(...)
    while task.wait(1) do
        if r40 then
            r81();
        end;
        
        L = r42;
        
        if L then
            L = workspace;
            v3 = "\xe3\x05\x8f\xcd";
            
            v = r15(v3, 11872431248792);
            
            j = L.FindFirstChild(L, r16[v]);
            
            if j then
                v3 = j.GetChildren;
                v = {
                    v3(j)
                };
                I = v3[2];
                v = v3[1];
                
                for M, v6 in ipairs(S(v)) do
                    v3 = M;
                    
                    if v6.IsA(v6, "Model") then
                        
                        v7 = v6.GetAttribute(v6, "FireCharges");
                        
                        if v7 then
                            v8 = v7 > 0;
                        end;
                        
                        if v7 then
                            task.spawn(r74, v6);
                        end;
                    end; 
                end;
            end;
        end; 
    end;
    
    return; 
end);

(function(...)
    L = game;
    L = game;
    
    L.GetService(L, "ReplicatedStorage");
    
    L = game;
    r82 = L.GetService(L, "Workspace");
    v = L.GetService(L, "Players").LocalPlayer;
    v3 = v.WaitForChild(v, "PlayerGui");
    v6 = v3.WaitForChild(v3, "HeartbeatMinigameUI");
    r83 = v6.WaitForChild(v6, "Frame");
    L = r83;
    Z = L.GetPropertyChangedSignal(L, "Visible");
    
    Z.Connect(Z, function(...)
        v8 = "a@\x1c\xaf`\xe2\x11";
        
        if r83[r16[r15(v8, 30788149704704)]] == true and r32 then
            L = r25;
            
            L.FireServer(L, r82.Rooms.Emergency.Room7, true);
        end;
        
        return; 
    end);
    
    return; 
end)();

local r84 = {
    ["EyeMass"] = false,
    ["TallMonster"] = false,
    ["BedMonster"] = false,
    ["Ghost"] = false,
    ["Hider"] = false
};

local function r86(arg1_10, ...)
    j = arg1_10;
    
    if r84[j.Name] then
        r28("Notif", j.Name .. " Successful Killed", 3);
        
        j.Destroy(j);
    end;
    
    return; 
end;

local function r87(...)
    if r84.EyeMass or (r84.TallMonster or (r84.BedMonster or (r84.Ghost or r84.Hider))) then
        v = workspace;
        v = "ipairs";
        
        for M, v6 in ipairs(v.GetDescendants(v)) do
            v3 = M;
            
            r86(v6); 
        end;
        
        L = not r85;
        
        if L then
            L = workspace.DescendantAdded;
            
            r85 = L.Connect(L, function(arg1_11, ...)
                j = arg1_11;
                M = r16;
                
                task.wait(.05);
                
                if j then
                    Z = j.Parent;
                end;
                
                if j then
                    r86(j);
                end;
                
                return; 
            end);
        end;
    else
        if r85 then
            L = r85;
            
            L.Disconnect(L);
        end;
        
        return;
    end; 
end;

local v21 = game;

local r88 = v21.GetService(v21, "Workspace");
local r89 = true;
local r90 = true;
local r91 = {
    "CameraEffect",
    "Skinwalker",
    "BrokenBones",
    "CursedPhoto",
    "DifferentEars",
    "DifferentFace",
    "HiddenFace",
    "LizInfectedFace",
    "SkinwalkerOpensMouth",
    "Static",
    "TwistNeck",
    "VoidPresence"
};
local r92 = {
    ["Ears"] = true,
    ["Tail"] = true,
    ["NameTag"] = true,
    ["Model"] = true,
    ["Suitcase"] = true
};

local function r93(arg1_12, ...)
    j = arg1_12;
    
    if not j.IsA(j, "Model") then
        return false;
    end;
    
    if r92[j.Name] then
        return false;
    end;
    
    L = j.Parent;
    Z = L;
    
    while not L do
        if I then
            if L.IsA(L, "Model") then
                return false;
            else
                I = I.Parent;
            end;
        end;
        
        return true; 
    end;
    
    Z = L ~= r30 and L ~= r88;
    L = L; 
end;

local function r94(arg1_13, ...)
    j = arg1_13;
    L = ipairs;
    v6 = r91;
    v = 82[2];
    v3 = 82[3];
    
    for v3, v8 in L(Z) do
        v7 = v3;
        
        if j.GetAttribute(j, v8) then
            M = v8;
            I = true;
        else
            
        end; 
    end;
    
    v = r30;
    
    v3 = v.FindFirstChild(v, "Anomalies");
    
    if v3 then
        
        v = j.IsDescendantOf(j, v3);
    end;
    
    L = L;
    
    if v3 then
        I = true;
        
        if not nil then
            M = j.Name;
        end;
    end;
    
    return false, nil; 
end;

local function r95(arg1_14, ...)
    j = arg1_14;
    
    if j.Name == "Doctor" then
        return false;
    end;
    
    if j.GetAttribute(j, "SkippedCheckIn") then
        return true;
    end;
    
    if not j.GetAttribute(j, "IsVisitor") and not j.GetAttribute(j, "IsPatient") then
        return false;
    end;
    
    v3 = {
        r94(j)
    };
    v = v3[2];
    
    if r94(j) then
        return false;
    end;
    
    if j.WaitForChild(j, "PP").ActionText == "Ask to Leave" then
        return false;
    end;
    
    m = "(\x94\xd167`\xb92";
    
    v6 = j.FindFirstChild(j, r16[r15(m, 29287265383749)]);
    
    if v6 then
        
        m = v6.IsA(v6, "MeshPart");
        
        if m then
            
            v7 = string.find(v6.TextureID, "125294235208418");
        end;
        
        j.FindFirstChild(j, r16[v8]);
        
        Z = m;
    end;
    
    if v6 then
        return false;
    end;
    
    return true; 
end;

local function r96(arg1_15, ...)
    j = arg1_15;
    
    if r93(j) then
        M = {
            r94(j)
        };
        I = M[2];
        
        M = r94(j);
        
        L = j.FindFirstChild(j, "Head.002");
        
        if L then
            
            Z = L.IsA(L, "MeshPart");
        end;
        
        if L then
            if string.find(L.TextureID, "125294235208418") then
                M = true;
                
                if not I then
                    I = "Headbang";
                end;
            end;
        end;
        
        if j.WaitForChild(j, "PP").ActionText == "Ask to Leave" then
            M = true;
            
            if not I then
                I = "Headbang";
            end;
        end;
        
        L = L;
        
        if j.Name == "Ghost" or j.Name == "TallMonster" then
            M = true;
            I = j.Name;
        end;
        
        Q = "\xbc\x92\x0c\x10\x19\x8aY\xb4\x84u\x1a%s\x8b\xc9";
        
        t = r15(Q, 22824819763588);
        v10 = j.GetAttribute(j, "PhotoEffect") == r[I][t];
        
        if v10 then
            M = true;
            I = "LIZ UV CAMERA QUEST";
        end;
        
        if M then
            k = r89;
        end;
        
        L = L;
        
        if M then
            v = true;
        else
            t = not M and r90;
            
            if not M and r90 then
                v = true;
            end;
            
            t = j.FindFirstChild(j, "Head") or (j.PrimaryPart or j.FindFirstChildWhichIsA(j, "BasePart"));
            
            Q = j.FindFirstChild(j, "NPC_ESP");
            
            if t then
                
                R = t.FindFirstChild(t, "NPC_TextESP");
            end;
            
            if false then
                if not Q then
                    
                    Q = Instance.new("Highlight");
                    
                    Q.Name = "NPC_ESP";
                    Q.FillTransparency = 0.5;
                    Q.OutlineTransparency = 0;
                    Q.OutlineColor = Color3.fromRGB(255, 255, 255);
                    Q.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                    
                    v12 = arg1_15;
                    
                    Q.Parent = v12;
                end;
                
                if v10 then
                    
                    Q.FillColor = Color3.fromRGB(255, 255, 0);
                else
                    if M then
                        
                        Q.FillColor = Color3.fromRGB(255, 0, 0);
                    else
                        
                        Q.FillColor = Color3.fromRGB(0, 255, 0);
                    end;
                    
                    if t then
                        if not R then
                            
                            R = Instance.new("BillboardGui");
                            
                            R.Name = "NPC_TextESP";
                            R.Size = UDim2.new(0, 200, 0, 50);
                            R.StudsOffset = Vector3.new(0, 3, 0);
                            R.AlwaysOnTop = true;
                            B = Instance.new("TextLabel");
                            B.Size = UDim2.new(1, 0, 1, 0);
                            B.BackgroundTransparency = 1;
                            B.TextScaled = false;
                            B.TextSize = 7;
                            B.Font = Enum.Font.GothamBold;
                            B.TextStrokeTransparency = 0;
                            B.Parent = R;
                            
                            P = j.FindFirstChild(j, r[I][r15("9\"\x05\x91", g)]) or (j.PrimaryPart or j.FindFirstChildWhichIsA(j, "BasePart"));
                            
                            R.Parent = P;
                        end;
                        
                        W = R.FindFirstChildWhichIsA(R, "TextLabel");
                        
                        if W then
                            B = "Text";
                            o = t;
                            K = M;
                            g = t;
                            
                            if M then
                                u = I;
                                
                                LE = R.FindFirstChildWhichIsA(R, B);
                                
                                if I then
                                    L = LE;
                                    L = L;
                                    
                                    W[P[r15("\xd8)\xef\x04", u)]] = I or j.Name;
                                    
                                    if M then
                                        
                                        K = Color3.fromRGB(255, 50, 50);
                                    end;
                                    
                                    L = L;
                                    
                                    if M then
                                        L = L;
                                        
                                        R.FindFirstChildWhichIsA(R, B).TextColor3 = M;
                                        
                                        return;
                                    else
                                        
                                        P = Color3.fromRGB(50, 255, 50);
                                    end;
                                else
                                    u = "Anomaly";
                                end;
                            end;
                        end;
                    end;
                end;
            else
                if Q then
                    Q.Destroy(Q);
                end;
                
                if t then
                    t.Destroy(t);
                end;
            end;
        end;
    end; 
end;

local function r97(...)
    Z = game;
    j = Z.GetService(Z, "Players").LocalPlayer;
    I = j.Character;
    Z = I;
    
    if I then
        v = r88;
        
        M = I.FindFirstChild(I, "HumanoidRootPart");
        v = v.FindFirstChild(v, "Misc") and v.FindFirstChild(v, "CoffeeMachine");
        
        if M then
            Z = v3 and v.FindFirstChild(v, "CoffeeMachine");
        end;
        
        if M then
            
            v3 = v.FindFirstChild(v, "Coffee");
            v3 = v3 and v3.FindFirstChild(v3, "PP");
            
            if v3 then
                
                Z = CFrame.new(-120.307625, 3.41253114, 10.0235615, .0349012539, 6.40760263e-08, .999390781, -6.04629165e-08, 1, -6.20035721e-08, -0.999390781, -5.82620778e-08, .0349012539);
                
                M.CFrame = Z;
                
                task.wait(.15);
                
                fireproximityprompt(v3);
                
                task.wait(.15);
                
                M.CFrame = M.CFrame;
            end;
        end;
        
        return;
    else
        I = j.CharacterAdded;
        
        Z = I.Wait(I);
    end; 
end;

task.spawn(function(...)
    L = r88;
    
    Z = L.WaitForChild(L, "Misc");
    L = Z.WaitForChild(Z, "CoffeeMachine");
    Z = L.WaitForChild(L, "Attachment");
    L = Z.WaitForChild(Z, "UI");
    r98 = L.WaitForChild(L, "status");
    L = r98;
    Z = L.GetPropertyChangedSignal(L, "Text");
    
    Z.Connect(Z, function(...)
        if r33 and r98.Text == "coffee: <font color='rgb(0, 200, 0)'>ready</font>" then
            r97();
        end;
        
        return; 
    end);
    
    return; 
end);

local r99 = hookmetamethod(game, "__namecall", function(arg1_16, ...)
    if r34 and getnamecallmethod() == "FireServer" then
        return;
    end;
    
    return r99(arg1_16, ...); 
end);

local function r100(...)
    M = r30;
    I = M[3];
    M = M[1];
    
    for I, v3 in M, ipairs(M.GetDescendants(M)) do
        v = I;
        
        r96(v3); 
    end;
    
    return; 
end;

local v22 = r30.DescendantAdded;

v22.Connect(v22, function(arg1_17, ...)
    task.wait(.1);
    
    r96(arg1_17);
    
    return; 
end);

local function r101(...)
    L = r88;
    
    j = L.FindFirstChild(L, "NPCs");
    
    if not j then
        return nil;
    end;
    
    v3 = j.GetChildren;
    v = {
        v3(j)
    };
    I = v3[2];
    v = v3[1];
    
    for M, v6 in ipairs(S(v)) do
        v3 = M;
        v7 = "Model";
        
        L = v6.IsA(v6, v7);
        
        if L then
            
            v7 = v6.GetAttribute(v6, "IsPatient");
            L = v6.GetAttribute(v6, "CompletedCheckIn");
            m = L;
            
            if v7 then
                L = L;
                
                if v7 and L == nil then
                    if r94 then
                        k = {
                            r94(v6)
                        };
                        
                        v10 = r94(v6);
                        v3 = k[2];
                    end;
                    
                    if not false then
                        return v6;
                    else
                        
                    end;
                end;
            else
                
                v9 = v6.GetAttribute(v6, "IsVisitor");
            end;
        end; 
    end;
    
    return nil; 
end;

local r102 = CFrame.new(-102.560417, 3.41253114, .488580942, .998134911, 8.75950548e-08, -0.0610469356, -8.30576568e-08, 1, 7.68639339e-08, .0610469356, -7.1650156e-08, .998134911);

local function v23(...)
    
    j = r101();
    
    if not j then
        return;
    end;
    
    Z = game;
    L = Z.GetService(Z, "Players").LocalPlayer.Character;
    Z = L;
    v = Z and L.FindFirstChild(L, "HumanoidRootPart");
    v3 = r88;
    v3 = v3.FindFirstChild(v3, "Misc") and v3.FindFirstChild(v3, "CheckIn");
    
    if v then
        Z = v6 and v3.FindFirstChild(v3, "CheckIn");
    end;
    
    if v then
        v10 = r16;
        k = "\x84D\x96\xe4\n\xe8\xd52\x1e\xd6h\xe7";
        v7 = {};
        v8 = v10[2];
        v10 = v10[1];
        
        for m, O in ipairs({
            "Form",
            "Camera",
            "Computer",
            "Printer",
            v10[r15(k, 4220403238829)]
        }) do
            v9 = m;
            
            k = v3.FindFirstChild(v3, O);
            
            if k then
                
                v11 = k.FindFirstChild(k, "PP");
                
                if v11 then
                    t = v11.Enabled;
                end;
                
                if v11 then
                    table.insert(v7, v11);
                end;
            end; 
        end;
        
        m = j.FindFirstChild(j, "PP");
        
        if m then
            v10 = m.Enabled;
        end;
        
        if #v7 == 0 and not m then
            return;
        end;
        
        t = "H\x80p\xacH\x95";
        
        if #v7 > 0 then
            v.CFrame = r102;
            
            t = r15;
            
            task.wait(.2);
            
            k = t[2];
            O = t[1];
            
            for v11, Q in ipairs(v7) do
                t = v11;
                
                if Q then
                    R = Q.Enabled;
                end;
                
                if Q then
                    fireproximityprompt(Q);
                    
                    task.wait(.2);
                end; 
            end;
        end;
        
        task.wait(1);
        
        if not j.GetAttribute(j, "CompletedCheckIn") then
            
            O = j.FindFirstChild(j, "PP");
            
            if O then
                k = O.Enabled;
            end;
            
            if O then
                v.CFrame = r102;
                
                task.wait(.15);
                
                fireproximityprompt(O);
                
                task.wait(.15);
            end;
        end;
        
        v.CFrame = v[r16[r15(t, 19845026161689)]];
    end;
    
    return; 
end;

local function r103(arg1_18, arg2_18, arg3_18, arg4_18, ...)
    I = arg2_18;
    v = arg4_18;
    j = arg1_18;
    Z = game;
    M = arg3_18;
    v6 = Z.GetService(Z, "Players").LocalPlayer.Character;
    v6 = v6 and v6.FindFirstChild(v6, "HumanoidRootPart");
    
    if not j or not j.Parent then
        return false;
    end;
    
    L = string.lower;
    
    v7 = L(j.ActionText or "");
    
    if I then
        
        v8 = string.lower(I);
    end;
    
    L = L;
    v8 = I or nil;
    v10 = L;
    v9 = not v8;
    m = j.Enabled;
    Z = v9;
    
    if v9 then
        L = L;
        
        if m then
            v9 = Z;
        end;
        
        L = L;
        
        if not m then
            print("is ready ", m);
            print(v7, v8);
            
            return false;
        end;
        
        if v6 then
            Z = arg3_18;
        end;
        
        L = L;
        
        if v6 then
            if (v6.Position - M.Position).Magnitude > 2 then
                O = arg3_18;
                
                v6.CFrame = O;
                
                task.wait(.2);
            end;
        end;
        
        Z = print;
        O = string.format;
        v11 = "[DEBUG] Eksekusi klik '%s' pada target: %s";
        W = L;
        R = v;
        t = tostring;
        
        if v then
            L = L;
            
            Env[v9](k.format(r16[r15("\xb2\x13\x1e\x18M/\xbd\xdc@\x08\x7f\x95W\xcaJ\xed\x19\xa1\x086\xb9{\xb4\xaa\xa4X\xe3\xe2/k\x0e\x99#\xc0\x01\xcb\xc5\xa5\xc391\x9c", a)], v7, Env[Q](v)));
            
            task.wait(0.25);
            
            j.RequiresLineOfSight = false;
            
            fireproximityprompt(j);
            
            O = j.RequiresLineOfSight;
            
            j.RequiresLineOfSight = O;
            
            task.wait(0.25);
            
            return true;
        else
            R = "Object";
        end;
    else
        
        Z = string.find(v7, v8);
    end; 
end;

local function r104(arg1_19, arg2_19, ...)
    j = arg1_19;
    I = arg2_19;
    
    if I then
        I = I;
        v3 = 76[3];
        
        for v3, v7 in 76[1], pairs(arg1_19) do
            v8 = I .. "[" .. tostring(v3) .. "]";
            
            if type(v7) == "table" then
                print(v8, "= <table>");
                
                r104(v7, v8);
            else
                print(v8, "=", v7);
            end; 
        end;
        
        return;
    else
        Z = "a1";
    end; 
end;

local function r105(arg1_20, ...)
    j = arg1_20;
    I = j.npc;
    M = j.step;
    v = j.checkInFolder;
    v3 = j.roomName;
    
    if M == "DonePatient" or M == "DoneVisitor" then
        return M;
    end;
    
    if I.Name == "StalkerMonster" then
        v7 = r88.Misc;
        
        v8 = v7.FindFirstChild(v7, "StrangePaper");
        Z = "CheckStepHighlight";
        
        if v8 then
            m = r88.Misc;
            Z = m.FindFirstChild(m, "StrangePaper").PP.Enabled;
        end;
        
        if Z then
            return "StalkerCheckin";
        end;
        
        if v.FindFirstChild(v, "CheckStepHighlight", true) and v.FindFirstChild(v, "CheckStepHighlight", true).Parent.Name == "Camera" then
            return "StalkerPhoto";
        end;
    end;
    
    v7 = string.find;
    v10 = r16;
    v9 = r15;
    m = "Room6";
    
    v8 = v7(v3, m);
    Z = v8;
    
    if v8 then
        if v8 then
            v6 = "Emergency";
        end;
        
        if I.FindFirstChild(I, "CheckStepHighlight", true) then
            return "Talk";
        end;
        
        v7 = v.FindFirstChild(v, "CheckStepHighlight", true);
        
        if v7 then
            L = I.Name == "StalkerMonster";
            Z = not I.GetAttribute(I, "CompletedCheckIn") and not I.GetAttribute(I, "SkippedCheckIn");
        end;
        
        if v7 then
            if v7.Parent.Name == "Form" then
                return "Stamp";
            end;
            
            if v7.Parent.Name == "Camera" then
                return "Photo";
            end;
            
            if v7.Parent.Name == "PrintedBadge" then
                return "TakeBadge";
            end;
        end;
        
        Z = r88.Misc.CheckIn;
        
        v7 = Z.FindFirstChild(Z, "CheckStepHighlight", true);
        
        if v7 then
            Z = not I.GetAttribute(I, "CompletedCheckIn") or not I.GetAttribute(I, "SkippedCheckIn");
            L = I.Name == "StalkerMonster";
        end;
        
        if v7 then
            v9 = r88.Misc.CheckIn.Computer;
            
            if tostring(v9.GetAttribute(v9, "InUse")) ~= "0" then
                return "Register";
            end;
            
            v9 = r88.Misc.CheckIn.Printer;
            
            if tostring(v9.GetAttribute(v9, "InUse")) ~= "0" then
                return "Print";
            end;
        end;
        
        m = r88.Rooms.Medical[v3].Minigame;
        
        v10 = m.FindFirstChild(m, "PatientHighlight", true);
        
        if v10 then
            if v10.Parent.Name == "Monitor" then
                if v10.Parent.Parent.Name == "xrayMonitor" then
                    return "BeginXRay";
                end;
                
                if v10.Parent.Parent.Name == "Monitor" then
                    if v3 == "Room6" then
                        return "ProcessMonitor6";
                    end;
                    
                    if v3 == "Room7" then
                        return "ProcessMonitor7";
                    end;
                    
                    return "ProcessMonitor";
                end;
            else
                if v10.Parent.Name == "Printer" then
                    return "CollectXRay6";
                end;
                
                L = I.Name == "StalkerMonster";
                
                if v3 == "Room7" and v10.Parent.Name == "StandIV" then
                    return "SetUp";
                end;
                
                if v10.Parent.Name == "Machine" then
                    return "TurnOnMachine";
                end;
                
                if v10.Parent.Name == "HeartMonitor" then
                    return "BeginHeartBeat";
                end;
                
                if v10.Parent.Name == "Printer" then
                    if v3 == "Room7" then
                        return "CollectXRay";
                    end;
                    
                    if v3 == "Room6" then
                        return "CollectXRay6";
                    end;
                else
                    if v10.Parent.Name == "Analyzer" then
                        return "Analyze";
                    end;
                end;
            end;
        end;
        
        L = I.Name == "StalkerMonster";
        
        if m.Monitor.Screen.UI.Enabled and m.TV.Screen.UI.Enabled then
            L = L;
            
            if not m.TV.Screen.UI.Healing.Visible and (M ~= "EquipMedicine" and (M ~= "ApplyTreatment" and M ~= "TakeMedicine")) then
                L = L;
                
                if v3 == "Room6" or v3 == "Room7" then
                    return "GetIllness";
                end;
                
                return "ReadUI";
            end;
            
            if m.TV.Screen.UI.Healing.Visible then
                return "DonePatient";
            end;
        end;
        
        t = r15("\xe3\x17\xfb\xc0\xa1oI\x10E\xc5bm\x89{\xa9\x18", 32015863118396);
        
        v9 = I.FindFirstChild(I, "PP", true);
        
        if I.FindFirstChild(I, r16[t], true) then
            
            v11 = string.find(v9.ActionText, "DNA");
            Z = "Room7";
            
            if v11 then
                Z = v9.Enabled;
            end;
            
            if Z then
                return "WaitTakeDNA";
            end;
            
            t = r16;
            
            if v3 == "Room7" and t.WaitForChild(t, "PP2") then
                return "PreparePatient";
            end;
            
            t = r16;
            L = I.Name == "StalkerMonster";
            
            if v3 == "Room8" and t.WaitForChild(t, "PP2") then
                return "Room8_Prepare";
            end;
        end;
        
        return j.step;
    end; 
end;

local function r106(arg1_21, ...)
    j = arg1_21;
    M = v14;
    I = j.npc;
    
    if M then
        Z = I.Name ~= v14;
    end;
    
    if M then
        print("LAGI AMBIL OBAT ", I.Name, v14);
        
        return;
    end;
    
    if v13 then
        print("TUNGGU LAGI NGUSIR");
        
        return;
    end;
    
    r104(j);
    
    M = j.step;
    
    M = r105(j);
    v = j.checkInFolder;
    v6 = game.Players.LocalPlayer.Character;
    v3 = "Stamp";
    
    if v6 then
        v6 = game.Players.LocalPlayer.Character;
        
        v3 = v6.FindFirstChild(v6, "HumanoidRootPart");
    end;
    
    if not I or (not I.Parent or not v3) then
        j.npc = nil;
        
        return;
    end;
    
    if M == "Stamp" then
        if v then
            
            m = v.FindFirstChild(v, "Form");
            v6 = m and m.FindFirstChild(m, "PP");
            L = M == v6;
        end;
        
        if r103(v, nil, j.counterCF) then
            j.step = "Photo";
        end;
        
        v8 = v.FindFirstChild(v, "Form");
        
        if v8 then
            v8 = v.Form;
            
            v7 = v8.FindFirstChild(v8, "Stamps");
        end;
        
        if v8 then
            j.step = "Photo";
        end;
    else
        
        m = r15("\x805\x7f\x8d\x81\x81\xa9_\xf4%Jk\x07T", 4621141674087);
        
        if M == r16[m] then
            v7 = r88.Misc;
            
            v8 = v7.WaitForChild(v7, "StrangePaper");
            v6 = "Inspect";
            
            if v8 then
                v7 = r88.Misc;
                
                v8 = v7.WaitForChild(v7, "StrangePaper");
                v6 = v8.FindFirstChild(v8, "PP");
            end;
            
            m = r88.Misc;
            
            if r103(v6, "Inspect", m.WaitForChild(m, "StrangePaper")) then
                j.step = "StalkerPhoto";
            end;
        else
            if M == "StalkerPhoto" then
                if v then
                    
                    m = v.FindFirstChild(v, "Camera");
                    v6 = m and m.FindFirstChild(m, "StalkerPP");
                    L = M == v6;
                end;
                
                if r103(v, "Take Photo", j.counterCF) then
                    j.step = "DonePatient";
                end;
            else
                if M == "Photo" then
                    if v then
                        
                        m = v.FindFirstChild(v, "Camera");
                        v6 = m and m.FindFirstChild(m, "PP");
                        L = M == v6;
                    end;
                    
                    if r103(v, nil, j.counterCF) then
                        j.step = "Register";
                    end;
                    
                    if v.FindFirstChild(v, "Photo") then
                        j.step = "Register";
                    end;
                else
                    if M == "Register" then
                        v9 = "\xa1\xcbe\x824|\x80";
                        L = r88.Misc[r16[r15(v9, 7005762882750)]];
                        v6 = r103;
                        
                        if v6 then
                            
                            v8 = string.find(v6.Text, "REGISTERED");
                        end;
                        
                        if v6 and L.FindFirstChild(L, "Computer") then
                            j.step = "Print";
                        end;
                        
                        if v6 then
                            
                            v9 = v6.FindFirstChild(v6, "Computer");
                            v8 = v9 and v9.FindFirstChild(v9, "PP");
                            L = r88[r16[r15("\x15\xf9\xa5\xd5", k)]][r16[v10]];
                        end;
                        
                        if r103(v6, "Register", j.registerCF) then
                            j.step = "Print";
                        end;
                    else
                        v8 = r15;
                        L = M == "Print";
                        
                        if L then
                            L = r88.Misc.CheckIn;
                            v8 = L and L.FindFirstChild(L, "PrintedBadge");
                            
                            if L then
                                
                                v8 = L.FindFirstChild(L, "PP");
                            end;
                            
                            if L then
                                m = v8 and v8.Enabled;
                                L = r88[r16[r15("`f\xd6\xff", k)]][r16[v10]];
                            end;
                            
                            if v7 then
                                j.step = "TakeBadge";
                            end;
                            
                            v10 = "IsVisitor";
                            
                            L = I.GetAttribute(I, v10);
                            
                            if L then
                                v10 = L;
                                m = v10 and L.FindFirstChild(L, "VisitorBadge");
                            else
                                if v6 and L.FindFirstChild(L, "PatientBadge") then
                                    j.step = "Talk";
                                end;
                                
                                if v6 then
                                    
                                    t = v6.FindFirstChild(v6, "Printer");
                                    O = t and t.FindFirstChild(t, "PP");
                                    
                                    I.GetAttribute(I, v10);
                                end;
                                
                                if r103(v6, "Print", j.registerCF) then
                                    j.step = "TakeBadge";
                                end;
                            end;
                        else
                            if M == "TakeBadge" then
                                if v then
                                    
                                    v7 = v.FindFirstChild(v, "PP");
                                end;
                                
                                if r103(v and v.FindFirstChild(v, "PrintedBadge"), nil, j.registerCF) then
                                    j.step = "Talk";
                                end;
                            else
                                if M == "Talk" then
                                    if r103(I.FindFirstChild(I, "PP"), "talk", I.GetPivot(I) * CFrame.new(0, 0, -3), I.Name) then
                                        if I.GetAttribute(I, "IsVisitor") then
                                            print("[DEBUG] Selesai Talk dengan Visitor: ", I.Name);
                                            
                                            j.step = "DoneVisitor";
                                        else
                                            print("[DEBUG] Selesai Talk dengan Pasien: ", I.Name);
                                            
                                            if j.roomName == "Room8" then
                                                j.step = "Room8_Prepare";
                                            else
                                                if j.roomName == "Room7" then
                                                    j.step = "PreparePatient";
                                                else
                                                    if j.roomName == "Room6" then
                                                        j.step = "BeginXRay";
                                                    else
                                                        j.step = "WaitTakeDNA";
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                else
                                    if M == "DoneVisitor" then
                                        if I.GetAttribute(I, "InBed") then
                                            if j.roomName == "Room8" then
                                                j.step = "Room8_Prepare";
                                            else
                                                if j.roomName == "Room7" then
                                                    j.step = "PreparePatient";
                                                else
                                                    if j.roomName == "Room6" then
                                                        j.step = "BeginXRay";
                                                    else
                                                        j.step = "WaitTakeDNA";
                                                    end;
                                                end;
                                            end;
                                        end;
                                    else
                                        L = M == "Room8_Prepare";
                                        
                                        if L then
                                            L = r88.Rooms.Emergency;
                                            
                                            v6 = L.FindFirstChild(L, "Room8");
                                            
                                            if v6 then
                                                
                                                v8 = v6.FindFirstChild(v6, "PP2");
                                            end;
                                            
                                            L = "room8Count";
                                            O = L;
                                            
                                            j[L] = j.room8Count or 1;
                                            
                                            t = v6.Minigame.Bed;
                                            
                                            if r103(v6 and v6.FindFirstChild(v6, "Minigame"), "Sleep Patient", t.GetPivot(t) * CFrame.new(0, 0, -3)) then
                                                task.wait(5);
                                                
                                                j.step = "Room8_SingleLoop";
                                            end;
                                        else
                                            v7 = "Room8_SingleLoop";
                                            
                                            if M == v7 then
                                                Q = 14632750095005;
                                                
                                                task.wait(1.5);
                                                
                                                v6 = r88[r16[r15("\xf36\xe7e\xae", Q)]].Emergency;
                                                
                                                k = r15("r92\t\xbb", 11694870484293);
                                                
                                                v7 = v6.FindFirstChild(v6, r16[k]);
                                                v8 = L;
                                                
                                                if v7 then
                                                    
                                                    k = v7.FindFirstChild(v7, "Minigame");
                                                    v6 = k and k.FindFirstChild(k, "TV");
                                                    L = L;
                                                end;
                                                
                                                if v7 then
                                                    Q = r16;
                                                    v8 = v7.FindFirstChild(v7, "Screen") and Q.FindFirstChild(Q, "UI");
                                                    L = v8;
                                                end;
                                                
                                                L = v8;
                                                
                                                if v7 then
                                                    R = v7.GetChildren;
                                                    Q = {
                                                        R(v7)
                                                    };
                                                    k = R[1];
                                                    v11 = R[2];
                                                    
                                                    for t, Q in ipairs(S(Q)) do
                                                        O = t;
                                                        
                                                        if Q.IsA(Q, "Frame") then
                                                            m = Q.Name;
                                                        else
                                                            
                                                        end; 
                                                    end;
                                                    
                                                    if nil then
                                                        v12 = r16;
                                                        
                                                        print(string.format("[ROOM 8] Siklus ke-%d - Ambil obat dari inv: %s", j.room8Count, nil));
                                                        
                                                        v11 = m;
                                                        
                                                        k = r66(nil);
                                                        O = k;
                                                        
                                                        if k then
                                                            O = k.Parent;
                                                        end;
                                                        
                                                        L = v11;
                                                        
                                                        if O then
                                                            Q = k.Parent;
                                                            
                                                            r103(k, nil, Q.GetPivot(Q), nil);
                                                            
                                                            task.wait(0.5);
                                                            
                                                            O = game.Players.LocalPlayer;
                                                            v11 = r88[O.Name];
                                                            
                                                            if v11 then
                                                                
                                                                t = v11.FindFirstChild(v11, "Humanoid");
                                                            end;
                                                            
                                                            W = v11;
                                                            a = O.Backpack;
                                                            
                                                            v12 = a.FindFirstChild(a, nil);
                                                            
                                                            if v12 then
                                                                a = v12;
                                                                
                                                                if v12 then
                                                                    v12 = v11;
                                                                    W = v12 and not v11.FindFirstChild(v11, nil);
                                                                    L = W;
                                                                end;
                                                                
                                                                if Q then
                                                                    v11.EquipTool(v11, v12);
                                                                end;
                                                                
                                                                task.wait(1.5);
                                                                
                                                                W = v7.Minigame;
                                                                a = W.FindFirstChild(W, "Bed");
                                                                W = a.InBed;
                                                                
                                                                W.FindFirstChild(W, "PP");
                                                                
                                                                B = a;
                                                                
                                                                if a then
                                                                    
                                                                    P = a.GetPivot(a);
                                                                end;
                                                                
                                                                L = a;
                                                                W = a;
                                                                
                                                                if a then
                                                                    L = a;
                                                                    B = W;
                                                                    B = CFrame.new(W.Position.X, r88[O.Name].HumanoidRootPart.Position.v3, W.Position.Z) * CFrame.new(0, 0, -4);
                                                                    
                                                                    B = CFrame.new(B.Position, Vector3.new(W.Position.X, B.Position.v3, W.Position.Z));
                                                                    
                                                                    if r103(W.FindFirstChild(W, r16[K]), "apply treatment", B, "Kasur Room8") then
                                                                        j.room8Count = j.room8Count + 1;
                                                                        
                                                                        if j.room8Count > 5 then
                                                                            print("[ROOM 8] 5 Siklus tunggal selesai. Masuk ke fase 3 obat terakhir...");
                                                                            
                                                                            j.step = "Room8_FinalBatch";
                                                                        end;
                                                                    end;
                                                                    
                                                                    return;
                                                                else
                                                                    
                                                                    W = CFrame.new();
                                                                end;
                                                            else
                                                                
                                                                Q = v11.FindFirstChild(v11, nil);
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            else
                                                if M == "Room8_FinalBatch" then
                                                    Q = 33003463080968;
                                                    
                                                    task.wait(1.5);
                                                    
                                                    v6 = r88[r16[r15("9CU\x85D", Q)]].Emergency;
                                                    
                                                    k = r15("\x00z\xad>p", 31943780629018);
                                                    
                                                    v7 = v6.FindFirstChild(v6, r16[k]);
                                                    
                                                    if v7 then
                                                        
                                                        k = v7.FindFirstChild(v7, "Minigame");
                                                        v6 = k and k.FindFirstChild(k, "TV");
                                                        L = L;
                                                    end;
                                                    
                                                    L = L;
                                                    
                                                    if v7 then
                                                        Q = r16;
                                                        v8 = v7.FindFirstChild(v7, "Screen") and Q.FindFirstChild(Q, "UI");
                                                        L = L;
                                                    end;
                                                    
                                                    L = L;
                                                    
                                                    if v7 then
                                                        m = {};
                                                        W = v7.GetChildren;
                                                        Q = {
                                                            W(v7)
                                                        };
                                                        t = W[3];
                                                        v11 = W[2];
                                                        
                                                        for t, Q in ipairs(S(Q)) do
                                                            O = t;
                                                            
                                                            if Q.IsA(Q, "Frame") then
                                                                table.insert(m, Q.Name);
                                                            end; 
                                                        end;
                                                        
                                                        if #m >= 3 then
                                                            a = "\x13\xbdr\xf9\x1b\xd3\x88\x10\xa9\nC\xef\xedE\xf2[\xd6&\x9d\x7fu\xcd\x1e\xf9\xa5LX\xec\xd2B(V\x00\xdf\x04\x8b\xdc\x99\xde\xceI\ntnh\xd06\xff\x1f\xdd\xae\xec";
                                                            Q = r15;
                                                            
                                                            print(r16[Q(a, 1926345704321)]);
                                                            
                                                            t = Q[3];
                                                            
                                                            for t, Q in Q[1], ipairs(m) do
                                                                O = t;
                                                                v12 = m;
                                                                
                                                                a = r66(Q);
                                                                W = a;
                                                                
                                                                if a then
                                                                    W = a.Parent;
                                                                end;
                                                                
                                                                L = v12;
                                                                
                                                                if W then
                                                                    g = a.Parent;
                                                                    
                                                                    r103(a, nil, g.GetPivot(g), Q);
                                                                    
                                                                    task.wait(.3);
                                                                    
                                                                    W = game.Players.LocalPlayer;
                                                                    v12 = r88[W.Name];
                                                                    
                                                                    if v12 then
                                                                        
                                                                        B = v12.FindFirstChild(v12, "Humanoid");
                                                                    end;
                                                                    
                                                                    o = v12;
                                                                    u = W.Backpack;
                                                                    
                                                                    LE = u.FindFirstChild(u, Q);
                                                                    
                                                                    if LE then
                                                                        L = L;
                                                                        
                                                                        if LE then
                                                                            if v12 then
                                                                                LE = not v12.FindFirstChild(v12, Q);
                                                                            end;
                                                                            
                                                                            o = v12;
                                                                            L = L;
                                                                        end;
                                                                        
                                                                        if g then
                                                                            v12.EquipTool(v12, LE);
                                                                        end;
                                                                        
                                                                        task.wait(1.5);
                                                                        
                                                                        o = v7.Minigame;
                                                                        u = o.FindFirstChild(o, "Bed");
                                                                        o = u.InBed;
                                                                        
                                                                        o.FindFirstChild(o, "PP");
                                                                        
                                                                        H = L;
                                                                        
                                                                        if u then
                                                                            
                                                                            n = u.GetPivot(u);
                                                                        end;
                                                                        
                                                                        o = u;
                                                                        L = L;
                                                                        
                                                                        if u then
                                                                            L = L;
                                                                            H = o;
                                                                            H = CFrame.new(o.Position.X, r88[W.Name].HumanoidRootPart.Position.v3, o.Position.Z) * CFrame.new(0, 0, -4);
                                                                            
                                                                            H = CFrame.new(H.Position, Vector3.new(o.Position.X, H.Position.v3, o.Position.Z));
                                                                            
                                                                            r103(o.FindFirstChild(o, r16[EE]), "apply treatment", H, "Kasur Room8 Final");
                                                                            
                                                                            task.wait(.3);
                                                                        else
                                                                            
                                                                            o = CFrame.new();
                                                                        end;
                                                                    else
                                                                        
                                                                        g = v12.FindFirstChild(v12, Q);
                                                                    end;
                                                                end; 
                                                            end;
                                                            
                                                            print("[ROOM 8] Operasi Selesai Total!");
                                                            
                                                            j.step = "DonePatient";
                                                            j.room8Count = nil;
                                                            
                                                            if j.isCritical then
                                                                r60 = false;
                                                                
                                                                j.isCritical = false;
                                                            end;
                                                            
                                                            r59 = false;
                                                            
                                                            j.npc = nil;
                                                        end;
                                                    end;
                                                else
                                                    v8 = r16;
                                                    v7 = "PreparePatient";
                                                    
                                                    if M == v7 then
                                                        v6 = r88.Rooms.Emergency;
                                                        
                                                        v7 = v6.FindFirstChild(v6, "Room7");
                                                        
                                                        print("[DEBUG] Cek Room7 Object:", v7);
                                                        
                                                        task.wait(2);
                                                        
                                                        v6 = v7.Minigame;
                                                        v8 = v6.FindFirstChild(v6, "Bed");
                                                        m = L;
                                                        
                                                        if v8 then
                                                            
                                                            v11 = v8.GetPivot(v8);
                                                        end;
                                                        
                                                        L = L;
                                                        v6 = v8;
                                                        
                                                        if v8 then
                                                            L = L;
                                                            t = v11;
                                                            t = CFrame.new(v11.Position.X, r88[game.Players.LocalPlayer.Name].HumanoidRootPart.Position.v3, v11.Position.Z) * CFrame.new(0, 0, -4);
                                                            LE = v11.Position.Z;
                                                            
                                                            t = CFrame.new(t.Position, Vector3.new(v11.Position.X, t.Position.v3, LE));
                                                            
                                                            if v7 then
                                                                LE = r16;
                                                                L = L;
                                                                W = v7.FindFirstChild(v7, "Minigame") and (LE.FindFirstChild(LE, "Bed") and LE.FindFirstChild(LE, "InBed"));
                                                            end;
                                                            
                                                            L = L;
                                                            
                                                            print("[DEBUG] Cek InBed Room7:", v7);
                                                            
                                                            if v7 then
                                                                
                                                                v12 = v7.FindFirstChild(v7, "PP2");
                                                            end;
                                                            
                                                            L = L;
                                                            
                                                            if r103(W, "Prepare", t, "Prepare Room 7") then
                                                                j.step = "SetUp";
                                                            end;
                                                        else
                                                            
                                                            v6 = CFrame.new();
                                                        end;
                                                    else
                                                        if M == "BeginXRay" then
                                                            task.wait(2);
                                                            
                                                            v6 = r88.Rooms.Emergency;
                                                            v7 = v6.FindFirstChild(v6, "Room6");
                                                            t = r15;
                                                            
                                                            print("[DEBUG] Cek Room6 Object:", v7);
                                                            
                                                            if v7 then
                                                                
                                                                t = v7.FindFirstChild(v7, "Minigame");
                                                                v6 = t and t.FindFirstChild(t, "xrayMonitor");
                                                                L = L;
                                                            end;
                                                            
                                                            L = L;
                                                            
                                                            print("[DEBUG] Cek xrayMonitor Room6:", v7);
                                                            
                                                            if v7 then
                                                                
                                                                v8 = v7.FindFirstChild(v7, "PP");
                                                            end;
                                                            
                                                            L = L;
                                                            
                                                            if r103(v7, "Begin", v7.GetPivot(v7) * CFrame.new(0, 0, 3), "XRay Room 6") then
                                                                j.step = "ProcessMonitor6";
                                                            end;
                                                        else
                                                            
                                                            v11 = r15("xs\x99\xf5\xc4G\xcb\x13'3h\xa6", 769888846182);
                                                            v7 = r16[v11];
                                                            
                                                            if M == v7 then
                                                                v12 = 1459398328999;
                                                                v6 = r88.Rooms.Emergency;
                                                                
                                                                v7 = v6.FindFirstChild(v6, r16[r15("i\xd1\x88\xb9x", v12)]);
                                                                v8 = L;
                                                                
                                                                if v7 then
                                                                    v12 = r16;
                                                                    L = L;
                                                                    v6 = v7.FindFirstChild(v7, "Minigame") and (v12.FindFirstChild(v12, "Bed") and v12.FindFirstChild(v12, "InBed"));
                                                                end;
                                                                
                                                                v8 = v7;
                                                                
                                                                if v7 then
                                                                    
                                                                    v8 = v7.FindFirstChild(v7, "PP2");
                                                                end;
                                                                
                                                                m = v7.Minigame;
                                                                
                                                                v11 = m.FindFirstChild(m, "Bed");
                                                                m = v11.InBed;
                                                                
                                                                m.FindFirstChild(m, "PP");
                                                                
                                                                W = v8;
                                                                
                                                                if v11 then
                                                                    
                                                                    v12 = v11.GetPivot(v11);
                                                                end;
                                                                
                                                                L = v8;
                                                                m = v11;
                                                                
                                                                if v11 then
                                                                    L = v8;
                                                                    B = v12;
                                                                    B = CFrame.new(v12.Position.X, r88[game.Players.LocalPlayer.Name].HumanoidRootPart.Position.v3, v12.Position.Z) * CFrame.new(0, 0, -4);
                                                                    
                                                                    B = CFrame.new(B.Position, Vector3.new(v12.Position.X, B.Position.v3, v12.Position.Z));
                                                                    
                                                                    if r103(v6, "Sleep Patient", B) then
                                                                        j.step = "ProcessMonitor";
                                                                    end;
                                                                else
                                                                    
                                                                    m = CFrame.new();
                                                                end;
                                                            else
                                                                m = r15;
                                                                
                                                                if M == "WaitTakeDNA" then
                                                                    v6 = r88.Rooms.Medical;
                                                                    
                                                                    I.FindFirstChild(I, "PP");
                                                                    
                                                                    v8 = v6.FindFirstChild(v6, I.GetAttribute(I, "DesignatedRoom")).Minigame;
                                                                    m = v8.FindFirstChild(v8, "Bed");
                                                                    v8 = m.InBed;
                                                                    
                                                                    v8.FindFirstChild(v8, "PP");
                                                                    
                                                                    t = L;
                                                                    
                                                                    if m then
                                                                        
                                                                        W = m.GetPivot(m);
                                                                    end;
                                                                    
                                                                    L = L;
                                                                    v8 = m;
                                                                    
                                                                    if m then
                                                                        L = L;
                                                                        v12 = W;
                                                                        v12 = CFrame.new(W.Position.X, r88[game.Players.LocalPlayer.Name].HumanoidRootPart.Position.v3, W.Position.Z) * CFrame.new(0, 0, -4);
                                                                        
                                                                        v12 = CFrame.new(v12.Position, Vector3.new(W.Position.X, v12.Position.v3, W.Position.Z));
                                                                        
                                                                        if r103(I.FindFirstChild(I, "PP"), "Take DNA", v12) then
                                                                            j.step = "Analyze";
                                                                        end;
                                                                    else
                                                                        
                                                                        v8 = CFrame.new();
                                                                    end;
                                                                else
                                                                    if M == "SetUp" then
                                                                        v6 = r88.Rooms.Emergency.Room7.Minigame.StandIV.PP;
                                                                        t = v6.Parent;
                                                                        
                                                                        if r103(v6, "Set Up", t.GetPivot(t) * CFrame.new(0, 0, -3)) then
                                                                            j.step = "TurnOnMachine";
                                                                        end;
                                                                    else
                                                                        if M == "TurnOnMachine" then
                                                                            v6 = r88.Rooms.Emergency.Room7.Minigame.Machine.PP;
                                                                            t = v6.Parent;
                                                                            
                                                                            if r103(v6, "Turn On", t.GetPivot(t) * CFrame.new(0, 0, -3)) then
                                                                                j.step = "BeginHeartBeat";
                                                                            end;
                                                                        else
                                                                            if M == "BeginHeartBeat" then
                                                                                v6 = r88.Rooms.Emergency.Room7.Minigame.HeartMonitor.PP;
                                                                                t = v6.Parent;
                                                                                
                                                                                if r103(v6, "Begin", t.GetPivot(t) * CFrame.new(0, 0, -3)) then
                                                                                    j.step = "ProcessMonitor7";
                                                                                end;
                                                                            else
                                                                                if M == "Analyze" then
                                                                                    v7 = L;
                                                                                    v8 = r88.Rooms.Medical;
                                                                                    v6 = v8.FindFirstChild(v8, I.GetAttribute(I, "DesignatedRoom")) and v8.FindFirstChild(v8, "Minigame");
                                                                                    
                                                                                    if v6 then
                                                                                        
                                                                                        t = v6.FindFirstChild(v6, "Analyzer");
                                                                                        
                                                                                        if t then
                                                                                            t = v6.Analyzer;
                                                                                            
                                                                                            m = t.FindFirstChild(t, "PP");
                                                                                        end;
                                                                                        
                                                                                        L = v7;
                                                                                        v7 = t;
                                                                                    end;
                                                                                    
                                                                                    L = v7;
                                                                                    W = v6.Analyzer;
                                                                                    
                                                                                    if r103(v6, nil, W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                        j.step = "ProcessMonitor";
                                                                                    end;
                                                                                else
                                                                                    if M == "ProcessMonitor" then
                                                                                        v7 = L;
                                                                                        v8 = r88.Rooms.Medical;
                                                                                        v6 = v8.FindFirstChild(v8, I.GetAttribute(I, "DesignatedRoom")) and v8.FindFirstChild(v8, "Minigame");
                                                                                        
                                                                                        if v6 then
                                                                                            
                                                                                            t = v6.FindFirstChild(v6, "Monitor");
                                                                                            
                                                                                            if t then
                                                                                                t = v6.Monitor;
                                                                                                
                                                                                                m = t.FindFirstChild(t, "PP2");
                                                                                            end;
                                                                                            
                                                                                            L = v7;
                                                                                            v7 = t;
                                                                                        end;
                                                                                        
                                                                                        L = v7;
                                                                                        W = v6.Monitor;
                                                                                        
                                                                                        if r103(v6, "Process Result", W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                            j.step = "ReadUI";
                                                                                        end;
                                                                                    else
                                                                                        if M == "ProcessMonitor7" then
                                                                                            v8 = r88.Rooms.Emergency;
                                                                                            t = "DesignatedRoom";
                                                                                            v6 = v8.FindFirstChild(v8, I.GetAttribute(I, t)) and v8.FindFirstChild(v8, "Minigame");
                                                                                            L = L;
                                                                                            
                                                                                            if v6 then
                                                                                                
                                                                                                t = v6.FindFirstChild(v6, "Monitor");
                                                                                                v7 = t and t.FindFirstChild(t, "PP2");
                                                                                                L = L;
                                                                                            end;
                                                                                            
                                                                                            L = L;
                                                                                            W = v6.Monitor;
                                                                                            
                                                                                            if r103(v6, "Process Result", W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                                j.step = "CollectXRay";
                                                                                            end;
                                                                                        else
                                                                                            if M == "ProcessMonitor6" then
                                                                                                v8 = r88.Rooms.Emergency;
                                                                                                v6 = v8.FindFirstChild(v8, j.roomName) and v8.FindFirstChild(v8, "Minigame");
                                                                                                L = L;
                                                                                                
                                                                                                if v6 then
                                                                                                    
                                                                                                    t = v6.FindFirstChild(v6, "Monitor");
                                                                                                    
                                                                                                    if t then
                                                                                                        t = v6.Monitor;
                                                                                                        
                                                                                                        m = t.FindFirstChild(t, "PP2");
                                                                                                    end;
                                                                                                    
                                                                                                    L = L;
                                                                                                    v7 = t;
                                                                                                end;
                                                                                                
                                                                                                L = L;
                                                                                                W = v6.Monitor;
                                                                                                
                                                                                                if r103(v6, "Process Result", W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                                    j.step = "CollectXRay6";
                                                                                                end;
                                                                                            else
                                                                                                if M == "CollectXRay" then
                                                                                                    task.wait(2);
                                                                                                    
                                                                                                    v8 = r88.Rooms.Emergency;
                                                                                                    v6 = v8.FindFirstChild(v8, j.roomName) and v8.FindFirstChild(v8, "Minigame");
                                                                                                    L = L;
                                                                                                    
                                                                                                    if v6 then
                                                                                                        
                                                                                                        t = v6.WaitForChild(v6, "PrintedXRay");
                                                                                                        
                                                                                                        if t then
                                                                                                            t = v6.PrintedXRay;
                                                                                                            
                                                                                                            m = t.FindFirstChild(t, "PP");
                                                                                                        end;
                                                                                                        
                                                                                                        L = L;
                                                                                                        v7 = t;
                                                                                                    end;
                                                                                                    
                                                                                                    L = L;
                                                                                                    W = v6.PrintedXRay;
                                                                                                    
                                                                                                    if r103(v6, "Collect", W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                                        j.step = "GetIllness";
                                                                                                    end;
                                                                                                else
                                                                                                    if M == "CollectXRay6" then
                                                                                                        task.wait(2);
                                                                                                        
                                                                                                        v7 = L;
                                                                                                        v8 = r88.Rooms.Emergency;
                                                                                                        v6 = v8.FindFirstChild(v8, j.roomName) and v8.FindFirstChild(v8, "Minigame");
                                                                                                        
                                                                                                        if v6 then
                                                                                                            
                                                                                                            t = v6.WaitForChild(v6, "PrintedXRay");
                                                                                                            
                                                                                                            if t then
                                                                                                                t = v6.PrintedXRay;
                                                                                                                
                                                                                                                m = t.FindFirstChild(t, "PP");
                                                                                                            end;
                                                                                                            
                                                                                                            L = v7;
                                                                                                            v7 = t;
                                                                                                        end;
                                                                                                        
                                                                                                        L = v7;
                                                                                                        W = v6.PrintedXRay;
                                                                                                        
                                                                                                        if r103(v6, "Collect", W.GetPivot(W) * CFrame.new(0, 0, -3)) then
                                                                                                            j.step = "GetIllness";
                                                                                                        end;
                                                                                                    else
                                                                                                        if M == "ReadUI" then
                                                                                                            task.wait(3);
                                                                                                            
                                                                                                            e = 1840429433689;
                                                                                                            v8 = r88.Rooms.Medical;
                                                                                                            
                                                                                                            o = r15("(\x04y<\x12\xfe\\\xb4\xfcz\xe4\xddO\x8c", e);
                                                                                                            v6 = v8.FindFirstChild(v8, I.GetAttribute(I, r16[o])) and v8.FindFirstChild(v8, "Minigame");
                                                                                                            L = L;
                                                                                                            v8 = L;
                                                                                                            
                                                                                                            if v6 then
                                                                                                                
                                                                                                                v7 = v6.FindFirstChild(v6, "Monitor");
                                                                                                            end;
                                                                                                            
                                                                                                            m = v6;
                                                                                                            
                                                                                                            if v6 then
                                                                                                                o = r16;
                                                                                                                v8 = v6.FindFirstChild(v6, "Screen") and o.FindFirstChild(o, "UI");
                                                                                                                L = v8;
                                                                                                            end;
                                                                                                            
                                                                                                            if v7 then
                                                                                                                L = m;
                                                                                                                m = v7.Text and (v7.Text ~= "" and v7.Text ~= "Label");
                                                                                                            end;
                                                                                                            
                                                                                                            L = m;
                                                                                                            
                                                                                                            if v7 then
                                                                                                                j.medQueue = {};
                                                                                                                
                                                                                                                v12 = game;
                                                                                                                
                                                                                                                r107 = require(v12.GetService(v12, "ReplicatedStorage").Data.IllnessesAndCures);
                                                                                                                v11 = string.gmatch;
                                                                                                                e = {
                                                                                                                    v11(v7.Text, "[^\r\n]+")
                                                                                                                };
                                                                                                                
                                                                                                                v12 = v11(v7.Text, "[^\r\n]+")(e[2], e[3]);
                                                                                                                
                                                                                                                while v12 do
                                                                                                                    
                                                                                                                    v11 = t(W, e[3]);
                                                                                                                    
                                                                                                                    r108 = string.gsub(v11, "^%-%s*", "");
                                                                                                                    JE = r15;
                                                                                                                    r108 = string.match(r108, "^%s*(.-)%s*$");
                                                                                                                    L = L;
                                                                                                                    
                                                                                                                    if r108 and r108 ~= "" then
                                                                                                                        JE = {
                                                                                                                            pcall(function(...)
                                                                                                                                return r107.GetIllnessByName(r108); 
                                                                                                                            end)
                                                                                                                        };
                                                                                                                        GE = JE[2];
                                                                                                                        
                                                                                                                        f = pcall(function(...)
                                                                                                                            return r107.GetIllnessByName(r108); 
                                                                                                                        end);
                                                                                                                        
                                                                                                                        if f then
                                                                                                                            if GE then
                                                                                                                                JE = GE.HealedWith;
                                                                                                                            end;
                                                                                                                            
                                                                                                                            H = GE;
                                                                                                                            L = f;
                                                                                                                        end;
                                                                                                                        
                                                                                                                        L = f;
                                                                                                                        
                                                                                                                        if f then
                                                                                                                            table.insert(j.medQueue, GE.HealedWith);
                                                                                                                        end;
                                                                                                                    end; 
                                                                                                                end;
                                                                                                                
                                                                                                                if #j.medQueue > 0 then
                                                                                                                    j.medIndex = 1;
                                                                                                                    j.step = "TakeMedicine";
                                                                                                                end;
                                                                                                            end;
                                                                                                        else
                                                                                                            if M == "GetIllness" then
                                                                                                                task.wait(3);
                                                                                                                
                                                                                                                f = 21557701109558;
                                                                                                                v8 = r88.Rooms.Emergency;
                                                                                                                
                                                                                                                o = r15("e\x83\xa0z\x1c}\"y\xcc\x8f\x96\xb5\tT", f);
                                                                                                                v6 = v8.FindFirstChild(v8, I.GetAttribute(I, r16[o])) and v8.FindFirstChild(v8, "Minigame");
                                                                                                                L = L;
                                                                                                                v8 = L;
                                                                                                                
                                                                                                                if v6 then
                                                                                                                    
                                                                                                                    v7 = v6.FindFirstChild(v6, "Monitor");
                                                                                                                end;
                                                                                                                
                                                                                                                m = v6;
                                                                                                                
                                                                                                                if v6 then
                                                                                                                    o = r16;
                                                                                                                    L = v8;
                                                                                                                    v8 = v6.FindFirstChild(v6, "Screen") and o.FindFirstChild(o, "UI");
                                                                                                                end;
                                                                                                                
                                                                                                                if v7 then
                                                                                                                    L = m;
                                                                                                                    m = v7.Text and (v7.Text ~= "" and v7.Text ~= "Label");
                                                                                                                end;
                                                                                                                
                                                                                                                L = m;
                                                                                                                
                                                                                                                if v7 then
                                                                                                                    j.medQueue = {};
                                                                                                                    
                                                                                                                    v12 = game;
                                                                                                                    
                                                                                                                    r109 = require(v12.GetService(v12, "ReplicatedStorage").Data.IllnessesAndCures);
                                                                                                                    v11 = string.gmatch;
                                                                                                                    f = {
                                                                                                                        v11(v7.Text, "[^\r\n]+")
                                                                                                                    };
                                                                                                                    
                                                                                                                    v12 = v11(v7.Text, "[^\r\n]+")(f[2], f[3]);
                                                                                                                    
                                                                                                                    while v12 do
                                                                                                                        
                                                                                                                        v11 = t(W, f[3]);
                                                                                                                        
                                                                                                                        r110 = string.gsub(v11, "^%-%s*", "");
                                                                                                                        FE = r15;
                                                                                                                        r110 = string.match(r110, "^%s*(.-)%s*$");
                                                                                                                        L = L;
                                                                                                                        
                                                                                                                        if r110 and r110 ~= "" then
                                                                                                                            FE = {
                                                                                                                                pcall(function(...)
                                                                                                                                    return r109.GetIllnessByName(r110); 
                                                                                                                                end)
                                                                                                                            };
                                                                                                                            
                                                                                                                            GE = pcall(function(...)
                                                                                                                                return r109.GetIllnessByName(r110); 
                                                                                                                            end);
                                                                                                                            SE = FE[2];
                                                                                                                            
                                                                                                                            if GE then
                                                                                                                                if SE then
                                                                                                                                    FE = SE.HealedWith;
                                                                                                                                end;
                                                                                                                                
                                                                                                                                H = SE;
                                                                                                                                L = GE;
                                                                                                                            end;
                                                                                                                            
                                                                                                                            L = GE;
                                                                                                                            
                                                                                                                            if GE then
                                                                                                                                table.insert(j.medQueue, SE.HealedWith);
                                                                                                                            end;
                                                                                                                        end; 
                                                                                                                    end;
                                                                                                                    
                                                                                                                    if #j.medQueue > 0 then
                                                                                                                        j.medIndex = 1;
                                                                                                                        j.step = "TakeMedicine";
                                                                                                                    end;
                                                                                                                end;
                                                                                                            else
                                                                                                                if M == "TakeMedicine" then
                                                                                                                    L = L;
                                                                                                                    
                                                                                                                    if v14 and I.Name ~= v14 then
                                                                                                                        return;
                                                                                                                    end;
                                                                                                                    
                                                                                                                    FE = 30966038476883;
                                                                                                                    v6 = j.medQueue[j.medIndex];
                                                                                                                    
                                                                                                                    v8 = r66(v6);
                                                                                                                    v14 = I.Name;
                                                                                                                    m = game.Players.LocalPlayer;
                                                                                                                    v11 = r88[m.Name];
                                                                                                                    W = L;
                                                                                                                    v12 = m[r16[r15("J\x07Iv\x12\xcf\x9e\xc2\xbd", FE)]];
                                                                                                                    t = W;
                                                                                                                    
                                                                                                                    if v12 then
                                                                                                                        v12 = m.Character;
                                                                                                                        
                                                                                                                        t = v12.FindFirstChild(v12, "Humanoid");
                                                                                                                    end;
                                                                                                                    
                                                                                                                    if v8 then
                                                                                                                        FE = r15;
                                                                                                                        W = v8.Parent and r103(v8, nil, FE.GetPivot(FE), v6);
                                                                                                                        L = W;
                                                                                                                    end;
                                                                                                                    
                                                                                                                    L = W;
                                                                                                                    
                                                                                                                    if v8 then
                                                                                                                        j.medIndex = j.medIndex + 1;
                                                                                                                        
                                                                                                                        if j.medIndex > #j.medQueue then
                                                                                                                            j.medIndex = 1;
                                                                                                                            j.step = "EquipMedicine";
                                                                                                                        end;
                                                                                                                    end;
                                                                                                                else
                                                                                                                    m = r16;
                                                                                                                    v8 = "EquipMedicine";
                                                                                                                    v6 = M == v8;
                                                                                                                    
                                                                                                                    if v6 then
                                                                                                                        v6 = j.medQueue[j.medIndex];
                                                                                                                        
                                                                                                                        if not v6 then
                                                                                                                            j.medIndex = 1;
                                                                                                                            j.step = "ApplyTreatment";
                                                                                                                            
                                                                                                                            return;
                                                                                                                        end;
                                                                                                                        
                                                                                                                        v8 = game.Players.LocalPlayer;
                                                                                                                        m = r88[v8.Name];
                                                                                                                        W = v8.Character;
                                                                                                                        v11 = L;
                                                                                                                        
                                                                                                                        if W then
                                                                                                                            W = v8.Character;
                                                                                                                            
                                                                                                                            v11 = W.FindFirstChild(W, "Humanoid");
                                                                                                                        end;
                                                                                                                        
                                                                                                                        L = L;
                                                                                                                        
                                                                                                                        if m then
                                                                                                                            
                                                                                                                            t = m.FindFirstChild(m, v6);
                                                                                                                        end;
                                                                                                                        
                                                                                                                        L = L;
                                                                                                                        
                                                                                                                        if m then
                                                                                                                            j.step = "ApplyTreatment";
                                                                                                                        else
                                                                                                                            t = game.Players.LocalPlayer.Backpack;
                                                                                                                            
                                                                                                                            W = t.FindFirstChild(t, j.medQueue[j.medIndex]);
                                                                                                                            
                                                                                                                            if W then
                                                                                                                                t = W;
                                                                                                                            end;
                                                                                                                            
                                                                                                                            L = W;
                                                                                                                            
                                                                                                                            if W then
                                                                                                                                W.EquipTool(W, W);
                                                                                                                                
                                                                                                                                j.step = "ApplyTreatment";
                                                                                                                            else
                                                                                                                                j.step = "TakeMedicine";
                                                                                                                            end;
                                                                                                                        end;
                                                                                                                    else
                                                                                                                        v11 = r15;
                                                                                                                        
                                                                                                                        if M == "ApplyTreatment" then
                                                                                                                            W = r15;
                                                                                                                            v6 = j.medQueue[j.medIndex];
                                                                                                                            v11 = not I;
                                                                                                                            v8 = v11;
                                                                                                                            m = L;
                                                                                                                            
                                                                                                                            if v11 then
                                                                                                                                L = L;
                                                                                                                                
                                                                                                                                if v8 then
                                                                                                                                    return;
                                                                                                                                end;
                                                                                                                                
                                                                                                                                v8 = j.roomName;
                                                                                                                                L = L;
                                                                                                                                
                                                                                                                                if v8 == "Room6" or (v8 == "Room7" or v8 == "Room8") then
                                                                                                                                    m = "Emergency";
                                                                                                                                end;
                                                                                                                                
                                                                                                                                t = r88.Rooms.Medical;
                                                                                                                                
                                                                                                                                W = t.FindFirstChild(t, v8);
                                                                                                                                JE = r88[game.Players.LocalPlayer.Name];
                                                                                                                                
                                                                                                                                if v8 ~= "Room6" then
                                                                                                                                    if W then
                                                                                                                                        sE = r16;
                                                                                                                                        L = L;
                                                                                                                                        FE = W.FindFirstChild(W, "Minigame") and (sE.FindFirstChild(sE, "Bed") and sE.FindFirstChild(sE, "InBed"));
                                                                                                                                    end;
                                                                                                                                    
                                                                                                                                    t = W;
                                                                                                                                    bE = W.Minigame;
                                                                                                                                    
                                                                                                                                    H = bE.FindFirstChild(bE, "Bed");
                                                                                                                                    ZE = L;
                                                                                                                                    
                                                                                                                                    if H then
                                                                                                                                        
                                                                                                                                        rE = H.GetPivot(H);
                                                                                                                                    end;
                                                                                                                                    
                                                                                                                                    L = L;
                                                                                                                                    
                                                                                                                                    if H then
                                                                                                                                        rE = FE;
                                                                                                                                        GE = rE;
                                                                                                                                        
                                                                                                                                        if FE then
                                                                                                                                            
                                                                                                                                            ZE = FE.FindFirstChild(FE, "PP");
                                                                                                                                        end;
                                                                                                                                        
                                                                                                                                        L = CFrame.new(GE.Position.X, JE.HumanoidRootPart.Position.v3, GE.Position.Z) * CFrame.new(0, 0, -4);
                                                                                                                                        v12 = FE;
                                                                                                                                        o = CFrame.new(GE.Position.X, JE.HumanoidRootPart.Position.v3, GE.Position.Z) * CFrame.new(0, 0, -4);
                                                                                                                                        
                                                                                                                                        o = CFrame.new(o.Position, Vector3.new(GE.Position.X, o.Position.v3, GE.Position.Z));
                                                                                                                                        
                                                                                                                                        if v8 == "Room6" then
                                                                                                                                            
                                                                                                                                            v12 = I.FindFirstChild(I, "PP");
                                                                                                                                            o = I.GetPivot(I);
                                                                                                                                        end;
                                                                                                                                        
                                                                                                                                        NE = SE.Character;
                                                                                                                                        
                                                                                                                                        ME = r103(v12, "apply treatment", o, "Kasur " .. v8);
                                                                                                                                        
                                                                                                                                        if NE then
                                                                                                                                            NE = SE.Character;
                                                                                                                                            
                                                                                                                                            ME = NE.FindFirstChild(NE, "Humanoid");
                                                                                                                                        end;
                                                                                                                                        
                                                                                                                                        L = L;
                                                                                                                                        
                                                                                                                                        if JE then
                                                                                                                                            
                                                                                                                                            NE = JE.FindFirstChild(JE, v6);
                                                                                                                                        end;
                                                                                                                                        
                                                                                                                                        L = L;
                                                                                                                                        
                                                                                                                                        if not JE then
                                                                                                                                            vE = SE.Backpack;
                                                                                                                                            
                                                                                                                                            NE = vE.FindFirstChild(vE, v6);
                                                                                                                                            
                                                                                                                                            if NE then
                                                                                                                                                vE = NE;
                                                                                                                                            end;
                                                                                                                                            
                                                                                                                                            L = L;
                                                                                                                                            
                                                                                                                                            if NE then
                                                                                                                                                ME.EquipTool(ME, NE);
                                                                                                                                            end;
                                                                                                                                        end;
                                                                                                                                        
                                                                                                                                        if r103(v12, "apply treatment", o, "Kasur " .. v8) then
                                                                                                                                            j.medIndex = j.medIndex + 1;
                                                                                                                                            
                                                                                                                                            if j.medIndex > #j.medQueue then
                                                                                                                                                print("[DEBUG] Pasien selesai diobati total! Lanjut pasien berikutnya.");
                                                                                                                                                
                                                                                                                                                j.npc = nil;
                                                                                                                                                
                                                                                                                                                v14 = nil;
                                                                                                                                                
                                                                                                                                                j.step = "DonePatient";
                                                                                                                                                
                                                                                                                                                if j.isCritical then
                                                                                                                                                    r60 = false;
                                                                                                                                                end;
                                                                                                                                                
                                                                                                                                                task.wait(0.5);
                                                                                                                                                
                                                                                                                                                j.isCritical = false;
                                                                                                                                            else
                                                                                                                                                j.step = "EquipMedicine";
                                                                                                                                            end;
                                                                                                                                        end;
                                                                                                                                    else
                                                                                                                                        
                                                                                                                                        bE = CFrame.new();
                                                                                                                                    end;
                                                                                                                                end;
                                                                                                                            else
                                                                                                                                v8 = not I.PrimaryPart;
                                                                                                                            end;
                                                                                                                        else
                                                                                                                            if M == "GiveCoffee" then
                                                                                                                            end;
                                                                                                                        end;
                                                                                                                    end;
                                                                                                                end;
                                                                                                            end;
                                                                                                        end;
                                                                                                    end;
                                                                                                end;
                                                                                            end;
                                                                                        end;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end; 
end;

local r111 = {};

local function r112(arg1_22, ...)
    j = arg1_22;
    L = r88.Rooms.Emergency;
    
    I = L.FindFirstChild(L, "Room8");
    
    if not I then
        return;
    end;
    
    M = I.FindFirstChild(I, "Minigame");
    Z = M;
    M = Z and M.FindFirstChild(M, "TV");
    v = M and M.FindFirstChild(M, "Screen");
    
    if not v then
        return;
    end;
    
    m = "\\\xe0W\x801\xbc-X~\xe9o\x12\xd1r\x1d\xa1";
    
    if j.step == r16[r15(m, 21917395593182)] then
        task.wait(1);
        
        m = v.GetChildren;
        v8 = {
            m(v)
        };
        v6 = m[2];
        v7 = m[3];
        
        for v7, v10 in ipairs(S("ipairs")) do
            m = v7;
            
            if v10.IsA(v10, "Frame") then
                v3 = v10.Name;
            else
                
            end; 
        end;
        
        if nil then
            k = r16;
            
            print(string.format("[ROOM 8] Siklus ke-%d - Ambil obat: %s", j.room8Count, nil));
            
            v8 = Env[Z];
            
            v7 = r66(nil);
            v6 = v7;
            
            if v7 then
                v6 = v7.Parent;
            end;
            
            L = v8;
            
            if v6 then
                v10 = v7.Parent;
                
                r103(v7, nil, v10.GetPivot(v10), nil);
                
                task.wait(0.5);
                
                v6 = game.Players.LocalPlayer;
                v8 = r88[v6.Name];
                
                if v8 then
                    
                    m = v8.FindFirstChild(v8, "Humanoid");
                end;
                
                v9 = v8;
                O = v6.Backpack;
                
                k = O.FindFirstChild(O, nil);
                
                if k then
                    L = L;
                    
                    if k then
                        if v8 then
                            k = not v8.FindFirstChild(v8, nil);
                        end;
                        
                        L = L;
                        v9 = v8;
                    end;
                    
                    if v10 then
                        v8.EquipTool(v8, k);
                    end;
                    
                    task.wait(0.5);
                    
                    v9 = I.Minigame;
                    O = v9.FindFirstChild(v9, "Bed");
                    v9 = O.InBed;
                    
                    v9.FindFirstChild(v9, "PP");
                    
                    v11 = L;
                    
                    if O then
                        
                        t = O.GetPivot(O);
                    end;
                    
                    L = L;
                    v9 = O;
                    
                    if O then
                        L = L;
                        
                        if r103(v9.FindFirstChild(v9, r16[R]), "apply treatment", CFrame.new(v9.Position.X, r88[v6.Name].HumanoidRootPart.Position.v3, v9.Position.Z) * CFrame.new(0, 0, -4), "Kasur Room8") then
                            j.room8Count = j.room8Count + 1;
                            
                            if j.room8Count > 5 then
                                print("[ROOM 8] 5 Siklus tunggal selesai. Masuk fase obat terakhir...");
                                
                                j.step = "Room8_FinalBatch";
                            end;
                        end;
                        
                        return;
                    else
                        
                        v9 = CFrame.new();
                    end;
                else
                    
                    v10 = v8.FindFirstChild(v8, nil);
                end;
            end;
        end;
    else
        v9 = "\xe5\xa9\x97\xcc\x9d\x17\xf8\xb3g=\x88\xbdyF\xfdv";
        
        if j.step == r16[r15(v9, 17593298116608)] then
            task.wait(1);
            
            v3 = {};
            v9 = v.GetChildren;
            v10 = {
                v9(v)
            };
            m = v9[3];
            
            for m, v10 in v9[1], ipairs(S(v10)) do
                v6 = m;
                
                if v10.IsA(v10, "Frame") then
                    table.insert(v3, v10.Name);
                end; 
            end;
            
            if #v3 >= 3 then
                O = "\x84gV0a\xfc\x0c\xbc\xe1\x9b\xe2\x8bj\xb5\xecnq;\xd5\xcbN\xc9e\xd1\x19\xc8\xe7c\xba\x8d\xf5T\xd4\x04\xf4(\x96\x8a;\x84\xe4\xc4\\";
                v10 = r15;
                
                print(r16[v10(O, 16943203442385)]);
                
                m = v10[3];
                
                for m, v10 in v10[1], ipairs(v3) do
                    v6 = m;
                    k = Z == v3;
                    
                    O = r66(v10);
                    v9 = O;
                    
                    if O then
                        v9 = O.Parent;
                    end;
                    
                    L = k;
                    
                    if v9 then
                        t = O.Parent;
                        
                        r103(O, nil, t.GetPivot(t), v10);
                        
                        task.wait(.3);
                        
                        v9 = game.Players.LocalPlayer;
                        k = r88[v9.Name];
                        
                        if k then
                            
                            v11 = k.FindFirstChild(k, "Humanoid");
                        end;
                        
                        Q = k;
                        R = v9.Backpack;
                        
                        W = R.FindFirstChild(R, v10);
                        
                        if W then
                            R = W;
                            
                            if W then
                                if k then
                                    W = not k.FindFirstChild(k, v10);
                                end;
                                
                                Q = k;
                                L = Q;
                            end;
                            
                            if t then
                                k.EquipTool(k, W);
                            end;
                            
                            task.wait(1.5);
                            
                            Q = I.Minigame;
                            R = Q.FindFirstChild(Q, "Bed");
                            Q = R.InBed;
                            
                            Q.FindFirstChild(Q, "PP");
                            
                            a = R;
                            
                            if R then
                                
                                v12 = R.GetPivot(R);
                            end;
                            
                            Q = R;
                            L = R;
                            
                            if R then
                                L = R;
                                
                                r103(Q.FindFirstChild(Q, r16[P]), "apply treatment", CFrame.new(Q.Position.X, r88[v9.Name].HumanoidRootPart.Position.v3, Q.Position.Z) * CFrame.new(0, 0, -4), "Kasur Room8 Final");
                                
                                task.wait(.3);
                            else
                                
                                Q = CFrame.new();
                            end;
                        else
                            
                            t = k.FindFirstChild(k, v10);
                        end;
                    end; 
                end;
                
                print("[ROOM 8] Operasi Selesai Total!");
                
                j.step = "DonePatient";
            end;
        end;
    end; 
end;

task.spawn(function(...)
    while task.wait(0.5) do
        if not r57 or r50 then
            
        end;
        
        L = r88.Rooms.Emergency;
        
        j = L.FindFirstChild(L, "Room8");
        I = j and j.FindFirstChild(j, "Minigame");
        M = I and I.FindFirstChild(I, "PP2");
        
        if M then
            L = not M.GetAttribute(M, "ConnectedTrigger");
            
            if L then
                M.SetAttribute(M, "ConnectedTrigger", true);
                
                L = M.Triggered;
                
                L.Connect(L, function(arg1_23, ...)
                    v = game.Players;
                    
                    if arg1_23 == v.LocalPlayer and r57 then
                        print("[ROOM 8] PP2 Kasur di-trigger! Memulai operasi Room 8...");
                        
                        r58 = {
                            ["step"] = "Room8_SingleLoop",
                            ["room8Count"] = 1
                        };
                    end;
                    
                    return; 
                end);
            end;
        end;
        
        if r58 then
            task.wait(3);
            
            r112(r58);
        end; 
    end;
    
    return; 
end);
task.spawn(function(...)
    while task.wait(.2) do
        if not r50 then
        end;
        
        L = not r60;
        
        if L then
            M = r111;
            j = v[2];
            I = v[3];
            
            for I, v3 in ipairs(Z) do
                v = I;
                
                if v3.isCritical then
                    r60 = true;
                else
                    
                end; 
            end;
        end;
        
        if not r59 then
            v3 = r111;
            M = 12181161694760[2];
            v = 12181161694760[3];
            
            for v, v3 in ipairs(v3) do
                j = v;
                L = not Z;
                
                if v3.step == "Room8_SingleLoop" or v3.step == "Room8_FinalBatch" then
                    r59 = true;
                else
                    
                end; 
            end;
        end;
        
        v7 = r59;
        L = L;
        L = L;
        
        if not v7 and not r60 and #r51 > 0 then
            v3 = r51;
            v = v7[3];
            M = v7[2];
            
            for v, v3 in ipairs(v3) do
                if v3 then
                    v7 = v3.Parent;
                end;
                
                L = I;
                
                if v3 then
                    O = r111;
                    v9 = 96[3];
                    
                    for v9, O in 96[1], pairs(O) do
                        v8 = v9;
                        
                        if O.npc == v3 then
                            v7 = true;
                        else
                            
                        end; 
                    end;
                    
                    if not false then
                        table.remove(r51, v);
                        
                        if tostring(v3.GetAttribute(v3, "AsignedCheckIn")) == "2" then
                            O = r88.Misc;
                            
                            v8 = O.FindFirstChild(O, "CheckIn2");
                            m = CFrame.new(-99.5330811, 3.4125309, 8.86906433, .0087252222, 5.56112916e-08, -0.999961913, -7.2707472e-08, 1, 5.49789974e-08, .999961913, 7.22250064e-08, .0087252222);
                            v10 = CFrame.new(-100.390068, 3.41253114, 1.21715105, .537300348, -7.88693733e-09, -0.843390942, -7.75069253e-08, 1, -5.87289151e-08, .843390942, 9.69237064e-08, .537300348);
                            
                            if v8 then
                                
                                O = v8.FindFirstChild(v8, "Computer");
                            end;
                            
                            L = v8;
                            
                            if v8 then
                                v10 = v8.Computer.CFrame * CFrame.new(0, 0, -2.5);
                            end;
                        else
                            R = r88.Misc;
                            
                            R.FindFirstChild(R, "CheckIn");
                            v10 = CFrame.new(-100.390068, 3.41253114, 1.21715105, .537300348, -7.88693733e-09, -0.843390942, -7.75069253e-08, 1, -5.87289151e-08, .843390942, 9.69237064e-08, .537300348);
                            m = CFrame.new(-103.659035, 3.41253114, .207637638, .996194482, -8.09708034e-09, .0871585235, 1.46768198e-08, 1, -7.485081e-08, -0.0871585235, 7.58451719e-08, .996194482);
                        end;
                        
                        R = v3.GetAttribute(v3, "DesignatedRoom");
                        B = "Stamp";
                        L = v8;
                        
                        if v3.GetAttribute(v3, "CompletedCheckIn") or v3.GetAttribute(v3, "SkippedCheckId") then
                            if R == "Room8" then
                                B = "Room8_Prepare";
                            else
                                if R == "Room7" then
                                    B = "PreparePatient";
                                else
                                    if R == "Room6" then
                                        B = "BeginXRay";
                                    else
                                        B = "WaitTakeDNA";
                                    end;
                                end;
                            end;
                        end;
                        
                        if v3.Name == "Barney" then
                            
                        else
                            if v3.Name == "StalkerMonster" then
                                B = "StalkerCheckin";
                            end;
                            
                            if v3.FindFirstChild(v3, "Counter", true) then
                                LE = true;
                            end;
                            
                            table.insert(r111, {
                                ["npc"] = v3,
                                ["step"] = "Stamp",
                                ["checkInFolder"] = v8,
                                ["counterCF"] = nil,
                                ["registerCF"] = nil,
                                ["roomName"] = v3.GetAttribute(v3, "DesignatedRoom"),
                                ["medQueue"] = {},
                                ["medIndex"] = 1,
                                ["room8Count"] = 1,
                                ["isCritical"] = false
                            });
                        end;
                    else
                        
                    end;
                end; 
            end;
        end;
        
        for I = #r111, 1, -1 do
            v7 = r111[I];
            B = r16;
            L = L;
            
            if not v7.npc or (not v7.npc.Parent or B.GetAttribute(B, "Treated") == true) then
                table.remove(r111, I);
            end;
            
            m = v7.step == "Room8_SingleLoop" or v7.step == "Room8_FinalBatch";
            L = L;
            B = r60;
            v10 = true;
            L = L;
            
            if B and (not v7.isCritical and not r59) then
                v10 = false;
            else
                B = r59 and not (v7.step == u[H] or v7.step == "Room8_FinalBatch");
                L = r59 and not (v7.step == u[H] or v7.step == "Room8_FinalBatch");
                
                if r59 and not (v7.step == u[H] or v7.step == "Room8_FinalBatch") then
                    v10 = false;
                end;
                
                if true then
                    r106(v7);
                end;
            end; 
        end; 
    end;
    
    return; 
end);

local r113 = {};

local function r114(...)
    if r59 then
        return;
    end;
    
    L = r30;
    
    if L then
        L = ipairs;
        v6 = r30;
        v6 = "ipairs";
        
        for v3, v8 in L(v6.GetChildren(v6)) do
            v7 = v3;
            L = ipairs;
            O = v11[3];
            v9 = v11[2];
            
            for O, v11 in L(r113) do
                k = O;
                
                if v11 == v8 then
                    m = true;
                else
                    
                end; 
            end;
            
            if not false then
                if not v8.GetAttribute(v8, "AsignedCheckIn") then
                    v10 = "1";
                end;
                
                W = r94(v8);
                
                if W then
                    L = L;
                    L = L;
                    
                    if W and not v8.GetAttribute(v8, "SkippedCheckIn") then
                        j = true;
                        M = v8;
                        
                        if tostring(v8.GetAttribute(v8, "AsignedCheckIn")) == "2" then
                            t = "CheckIn2";
                        end;
                        
                        W = r88;
                        
                        a = W.FindFirstChild(W, "Misc");
                        v12 = L;
                        
                        if a then
                            
                            W = a.FindFirstChild(a, "CheckIn");
                        end;
                        
                        if a then
                            
                            v12 = a.FindFirstChild(a, "Form");
                        end;
                        
                        L = v12;
                        
                        if W then
                            
                            I = W.FindFirstChild(W, "PP");
                        end;
                    else
                        
                    end;
                else
                    t = v8.Name == "Barney";
                end;
            end; 
        end;
    end;
    
    if false then
        
    end;
    
    L = L;
    
    if j then
        v6 = r88.Misc;
        v = v6.FindFirstChild(v6, "ShutterButton") and v6.FindFirstChild(v6, "PP");
        L = L;
        
        if nil.Name == "Barney" then
            if nil.FindFirstChild(nil, "PP").Enabled then
            end;
        end;
        
        if nil then
            v6 = nil.Enabled;
        end;
        
        L = L;
        
        if I then
            v13 = true;
            O = r88.Misc;
            
            t = O.FindFirstChild(O, "ShutterButton");
            
            r88[r24.LocalPlayer.Name].HumanoidRootPart.CFrame = t.GetPivot(t) * CFrame.new(0, 0, -3);
            
            task.wait(0.5);
            
            fireproximityprompt(v);
            
            v.RequiresLineOfSight = false;
            
            task.wait(5);
            
            t = r88.Misc;
            R = t.FindFirstChild(t, "ShutterButton");
            
            r88[r24.LocalPlayer.Name].HumanoidRootPart.CFrame = R.GetPivot(R) * CFrame.new(0, 0, -3);
            
            task.wait(0.5);
            
            fireproximityprompt(v);
            
            v10 = v.RequiresLineOfSight;
            
            v.RequiresLineOfSight = v10;
            
            v13 = false;
            
            table.insert(r113, nil);
        end;
    end;
    
    for y = #r113, 1, -1 do
        R = r113[v8];
        L = v3;
        
        if not R or not R.Parent then
            table.remove(r113, v8);
        end; 
    end;
    
    return; 
end;

task.spawn(function(...)
    while task.wait(2) do
        if not r50 then
        end;
        
        r114();
        
        if r30 then
            M = r30;
            M = "ipairs";
            
            for I, v3 in ipairs(M.GetChildren(M)) do
                v = I;
                
                if r95(v3) then
                    if r61.npc == v3 then
                        
                    else
                        if v3.GetAttribute(v3, "Treated") then
                            
                        else
                            v8 = v9[2];
                            
                            for m, v9 in ipairs(r51) do
                                v10 = m;
                                
                                if v9 == v3 then
                                    v6 = true;
                                else
                                    
                                end; 
                            end;
                            
                            if not false then
                                print("[DEBUG] Sweeper nemu pasien nganggur masuk antrean:", v3.Name);
                                
                                table.insert(r51, v3);
                            end;
                        end;
                    end;
                else
                    
                end; 
            end;
        end; 
    end;
    
    return; 
end);

local v24 = r26;
local v25 = v24.MakeTab(v24, {
    ["Name"] = "Main",
    ["Icon"] = "rbxassetid://86450224791749"
});
local v26 = r26;
local v27 = v26.MakeTab(v26, {
    ["Name"] = "Automation",
    ["Icon"] = "rbxassetid://7733920644"
});
local v28 = r26;
local v29 = v28.MakeTab(v28, {
    ["Name"] = "Anomaly",
    ["Icon"] = "rbxassetid://12974399858"
});
local v30 = v25.MakeSection(v25, {
    ["Name"] = "Support Menu"
});

r70(r31);

v30.AddToggle(v30, {
    ["Name"] = "Instant Prompt",
    ["Default"] = false,
    ["Callback"] = function(arg1_24, ...)
        r70(arg1_24);
        
        return; 
    end
});
v30.AddToggle(v30, {
    ["Name"] = "Anti-Job Stress",
    ["Default"] = r34,
    ["Callback"] = function(arg1_25, ...)
        j = arg1_25;
        r34 = j;
        r115 = game.Players.LocalPlayer;
        
        if j then
            Z = r27.Heartbeat;
            
            r37 = Z.Connect(Z, function(...)
                L = r115;
                
                v = r15("\x83\x1b\xc7\xfc\x95\xfc\x1d\x18\xb7\x12\x9c\x8el\xd9\x7f\x81\xf6\x1b\xf5\xfa!p", 34534529482449);
                
                L.SetAttribute(L, r16[v], 0);
                
                return; 
            end);
            
            r116 = hookmetamethod(game, "__namecall", function(arg1_26, ...)
                if r34 and getnamecallmethod() == "FireServer" then
                    return;
                end;
                
                return r116(arg1_26, ...); 
            end);
            
            r28("Sanity", "Anti-Job Stress ON: Mental Baja!", 2);
        else
            if r37 then
                Z = r37;
                
                Z.Disconnect(Z);
            end;
            
            v = r115;
            
            v.SetAttribute(v, "SanityImpactMultiplier", 1);
            
            r28("Sanity", "Anti-Job Stress OFF: Balik Normal", 2);
            
            return;
        end; 
    end
});

if r34 then
    vm20 = r27.Heartbeat;
    
    r37 = vm20.Connect(vm20, function(...)
        L = r29;
        
        L.SetAttribute(L, "SanityImpactMultiplier", 0);
        
        return; 
    end);
    
    r117 = hookmetamethod(game, "__namecall", function(arg1_27, ...)
        if r34 and getnamecallmethod() == "FireServer" then
            return;
        end;
        
        return r117(arg1_27, ...); 
    end);
end;

v30.AddToggle(v30, {
    ["Name"] = "Enable Anti-AFK",
    ["Default"] = true,
    ["Callback"] = function(arg1_28, ...)
        r68(arg1_28);
        
        return; 
    end
});

r68(true);

local v31 = v25.MakeSection(v25, {
    ["Name"] = "Auto Shift (Checkin & Treatment) [BETA]"
});

v31.AddToggle(v31, {
    ["Name"] = "Enable Auto Shift",
    ["Default"] = false,
    ["Callback"] = function(arg1_29, ...)
        j = arg1_29;
        r50 = j;
        
        if j then
            r28("Automation", "Auto Shift ON", 2);
        else
            table.clear(r51);
            
            r52 = false;
            
            r28("Automation", "Auto Shift OFF", 2);
        end;
        
        return; 
    end
});
v30.AddSlider(v30, {
    ["Name"] = "WalkSpeed",
    ["Min"] = 16,
    ["Max"] = 100,
    ["Default"] = r48,
    ["Callback"] = function(arg1_30, ...)
        L = arg1_30;
        r67 = L;
        M = r29.Character;
        
        if M then
            M = r29.Character;
            
            Z = M.FindFirstChild(M, "Humanoid");
        end;
        
        L = L;
        
        if M then
            r29.Character.Humanoid.WalkSpeed = r67;
        end;
        
        return; 
    end
});
v30.AddButton(v30, {
    ["Name"] = "Reset Walkspeed",
    ["Primary"] = true,
    ["Callback"] = function(...)
        j = r29.Character;
        
        if j then
            j = r29.Character;
            
            Z = j.FindFirstChild(j, "Humanoid");
        end;
        
        if j then
            r29.Character.Humanoid.WalkSpeed = r48;
            
            r28("Success", "Reset Walkspeed", 2);
        end;
        
        return; 
    end
});

local v32 = r29.CharacterAdded;

v32.Connect(v32, function(arg1_31, ...)
    j = arg1_31;
    
    I = j.WaitForChild(j, "Humanoid", 5);
    
    if I then
        I.WalkSpeed = r67;
    end;
    
    return; 
end);
local v33 = v25.MakeSection(v25, {
    ["Name"] = "ESP Menu"
});

v33.AddToggle(v33, {
    ["Name"] = "Enable ESP: Normal Patient",
    ["Default"] = true,
    ["Callback"] = function(arg1_32, ...)
        r90 = arg1_32;
        
        r100();
        
        return; 
    end
});
v33.AddToggle(v33, {
    ["Name"] = "Enable ESP: Anomaly Patient",
    ["Default"] = true,
    ["Callback"] = function(arg1_33, ...)
        r89 = arg1_33;
        
        r100();
        
        return; 
    end
});
local v34 = v29.MakeSection(v29, {
    ["Name"] = "Auto Kill Anomaly"
});

r100();

v34.AddToggle(v34, {
    ["Name"] = "Auto Kill: EyeMass",
    ["Default"] = false,
    ["Callback"] = function(arg1_34, ...)
        j = arg1_34;
        
        r84.EyeMass = j;
        
        r87();
        
        if j then
            r28("Auto Kill", "EyeMass ON", 2);
        end;
        
        return; 
    end
});
v34.AddToggle(v34, {
    ["Name"] = "Auto Kill: TallMonster",
    ["Default"] = false,
    ["Callback"] = function(arg1_35, ...)
        j = arg1_35;
        
        r84.TallMonster = j;
        
        r87();
        
        if j then
            r28("Auto Kill", "TallMonster ON", 2);
        end;
        
        return; 
    end
});
v34.AddToggle(v34, {
    ["Name"] = "Auto Kill: BedMonster",
    ["Default"] = false,
    ["Callback"] = function(arg1_36, ...)
        j = arg1_36;
        
        r84.BedMonster = j;
        
        r87();
        
        if j then
            r28("Auto Kill", "BedMonster ON", 2);
        end;
        
        return; 
    end
});
v34.AddToggle(v34, {
    ["Name"] = "Auto Kill: Ghost",
    ["Default"] = false,
    ["Callback"] = function(arg1_37, ...)
        j = arg1_37;
        
        r84.Ghost = j;
        
        r87();
        
        if j then
            r28("Auto Kill", "Ghost ON", 2);
        end;
        
        return; 
    end
});

local function r119(arg1_38, ...)
    for I = 1, 3 do
        L = r65;
        
        L.FireServer(L, arg1_38);
        
        v6 = I; 
    end;
    
    r28("Notif", "Successful Killed Hider", 3);
    
    return; 
end;

v34.AddToggle(v34, {
    ["Name"] = "Auto Kill: Hider",
    ["Default"] = false,
    ["Callback"] = function(arg1_39, ...)
        j = arg1_39;
        
        r84.Hider = j;
        
        if j then
            v = r88;
            M = v[3];
            v = v[1];
            
            for M, v6 in v, ipairs(v.GetDescendants(v)) do
                v3 = M;
                
                if v6.Name == "Hider" and v6.IsA(v6, "Model") then
                    v7 = v6.Parent;
                    
                    task.spawn(r119, v6);
                end; 
            end;
            
            L = r88.DescendantAdded;
            
            r118 = L.Connect(L, function(arg1_40, ...)
                j = arg1_40;
                M = r84;
                
                if M.Hider and (j.Name == "Hider" and j.IsA(j, "Model")) then
                    task.spawn(r119, j);
                end;
                
                return; 
            end);
            
            r28("Auto Kill", "Auto Kill Hider ON", 2);
        else
            if r118 then
                L = r118;
                
                L.Disconnect(L);
            end;
            
            r28("Auto Kill", "Auto Kill Hider OFF", 2);
            
            return;
        end; 
    end
});
local v35 = v27.MakeSection(v27, {
    ["Name"] = "Auto Carry Fainted Patient"
});

v35.AddToggle(v35, {
    ["Name"] = "Enable Auto Carry",
    ["Default"] = r49,
    ["Callback"] = function(arg1_41, ...)
        j = arg1_41;
        r49 = j;
        
        if j then
            r28("Automation", "Auto Carry Fainted ON", 2);
        else
            r28("Automation", "Auto Carry Fainted OFF", 2);
        end;
        
        return; 
    end
});
local v36 = v27.MakeSection(v27, {
    ["Name"] = "Auto Take Coffee"
});
local v37 = v27.MakeSection(v27, {
    ["Name"] = "Auto Minigame"
});
local v38 = v27.MakeSection(v27, {
    ["Name"] = "Auto Extinguish Fire"
});
local v39 = v27.MakeSection(v27, {
    ["Name"] = "Auto Clean"
});

v36.AddToggle(v36, {
    ["Name"] = "Auto Take Coffee 1",
    ["Default"] = false,
    ["Callback"] = function(arg1_42, ...)
        j = arg1_42;
        r33 = j;
        
        if j then
            M = r88;
            v7 = r[v];
            v3 = "Misc";
            
            v = M.FindFirstChild(M, v3);
            
            if v then
                v3 = r88.Misc;
                v7 = "CoffeeMachine";
                
                M = v3.FindFirstChild(v3, v7);
                Z = M and v7.FindFirstChild(v7, "Attachment");
                L = j;
            end;
            
            if v then
                Z = v.Text == "coffee: <font color='rgb(0, 200, 0)'>ready</font>";
            end;
            
            L = j;
            
            if v then
                r97();
            end;
        end;
        
        return; 
    end
});
v37.AddToggle(v37, {
    ["Name"] = "Auto Surgeon Room 8",
    ["Default"] = false,
    ["Callback"] = function(arg1_43, ...)
        j = arg1_43;
        r57 = j;
        
        if j then
            r28("Automation", "Auto Surgeon Room 8 ON", 2);
        else
            r28("Automation", "Auto Surgeon Room 8 OFF", 2);
        end;
        
        return; 
    end
});
v37.AddToggle(v37, {
    ["Name"] = "Auto Heartbeat Minigame",
    ["Default"] = r32,
    ["Callback"] = function(arg1_44, ...)
        r32 = arg1_44;
        
        return; 
    end
});
v37.AddToggle(v37, {
    ["Name"] = "Auto X-Ray",
    ["Default"] = r43,
    ["Callback"] = function(arg1_45, ...)
        j = arg1_45;
        r43 = j;
        
        if j then
            r80();
            
            Z = r88.DescendantAdded;
            
            r47 = Z.Connect(Z, function(arg1_46, ...)
                j = arg1_46;
                
                if r43 and (j.Name == "boop" and j.IsA(j, "Sound")) then
                    M = r15;
                    I = j.Parent;
                    
                    if I then
                        Z = I.Name == "Button";
                    end;
                    
                    if I then
                        M = I.Parent;
                        
                        if M then
                            Z = M.Name == "Model" and (M.Parent and M.Parent.Name == "Colors");
                            L = I[r16[v3]];
                        end;
                        
                        if M then
                            
                            v = I.WaitForChild(I, "ClickDetector", 3);
                            
                            if v then
                                r77(j, v);
                            end;
                        end;
                    end;
                end;
                
                return; 
            end);
            
            r28("Automation", "Auto X-Ray ON", 2);
        else
            if r47 then
                Z = r47;
                
                Z.Disconnect(Z);
            end;
            
            v7 = r46;
            v3 = 84[2];
            v6 = 84[3];
            
            for v6, v7 in ipairs(v7) do
                M = v6;
                
                v7.Disconnect(v7); 
            end;
            
            table.clear(r46);
            table.clear(r44);
            
            r45 = false;
            
            r28("Automation", "Auto X-Ray OFF", 2);
            
            return;
        end; 
    end
});

local v40 = r43;

if v40 then
    r80();
    
    v40 = r88.DescendantAdded;
    
    r47 = v40.Connect(v40, function(arg1_47, ...)
        j = arg1_47;
        
        if r43 and (j.Name == "boop" and j.IsA(j, "Sound")) then
            I = j.Parent;
            
            if I then
                Z = I.Name == "Button";
            end;
            
            if I then
                M = I.Parent;
                
                if M then
                    Z = M.Name == "Model" and L;
                    L = L;
                end;
                
                if M then
                    
                    v = I.WaitForChild(I, "ClickDetector", 3);
                    
                    if v then
                        r77(j, v);
                    end;
                end;
            end;
        end;
        
        return; 
    end);
end;

local v41 = v27.MakeSection(v27, {
    ["Name"] = "Auto Fix Camera"
});

v41.AddToggle(v41, {
    ["Name"] = "Enable Auto Fix Camera",
    ["Default"] = r40,
    ["Callback"] = function(arg1_48, ...)
        j = arg1_48;
        r40 = j;
        
        if j then
            r28("Automation", "Auto Fix Camera ON", 2);
        else
            r28("Automation", "Auto Fix Camera OFF", 2);
        end;
        
        return; 
    end
});

local v42 = r88;
local r120 = v42.FindFirstChild(v42, "Misc");

v39.AddToggle(v39, {
    ["Name"] = "Auto Clean Slime",
    ["Default"] = r35,
    ["Callback"] = function(arg1_49, ...)
        j = arg1_49;
        r35 = j;
        
        if j then
            Z = r120;
        end;
        
        L = j;
        
        if j then
            v3 = r120;
            v6 = {
                v3.GetChildren(v3)
            };
            M = v3[2];
            v = v3[3];
            
            for v, v6 in ipairs(S(v6)) do
                v3 = v;
                
                if v6.Name == "Slime" then
                    task.spawn(r75, v6);
                end; 
            end;
            
            Z = r120.ChildAdded;
            
            r36 = Z.Connect(Z, function(arg1_50, ...)
                j = arg1_50;
                
                if r35 and j.Name == "Slime" then
                    M = r16;
                    
                    task.wait(.1);
                    task.spawn(r75, j);
                end;
                
                return; 
            end);
            
            r28("Automation", "Auto Clean Slime ON", 2);
        else
            if r36 then
                Z = r36;
                
                Z.Disconnect(Z);
            end;
            
            r28("Automation", "Auto Clean Slime OFF", 2);
            
            return;
        end; 
    end
});

local v43 = r35;
local v44 = v43;

if v43 then
    v44 = r120;
end;

local v45 = r[I];

if v44 then
    vm29 = r120;
    vm29 = {
        ipairs(vm29.GetChildren(vm29))
    };
    
    vm27, vm29 = ipairs(vm29.GetChildren(vm29))(vm29[2], vm29[3]);
    
    while vm27 do
        
        v44 = vm24(v43, vm29[3]);
        
        if vm29.Name == "Slime" then
            task.spawn(r75, vm29);
        end; 
    end;
    
    v44 = r120.ChildAdded;
    
    r36 = v44.Connect(v44, function(arg1_51, ...)
        j = arg1_51;
        
        if r35 and j.Name == "Slime" then
            task.wait(.1);
            task.spawn(r75, j);
        end;
        
        return; 
    end);
end;

v38.AddToggle(v38, {
    ["Name"] = "Auto Extinguish Patient on Fire",
    ["Default"] = r42,
    ["Callback"] = function(arg1_52, ...)
        j = arg1_52;
        r42 = j;
        
        if j then
            r28("Automation", "Auto Extinguish Patient ON", 2);
        else
            r28("Automation", "Auto Extinguish Patient OFF", 2);
        end;
        
        return; 
    end
});
v38.AddToggle(v38, {
    ["Name"] = "Auto Extinguish Room",
    ["Default"] = r38,
    ["Callback"] = function(arg1_53, ...)
        j = arg1_53;
        r38 = j;
        
        if j then
            v3 = r88;
            v6 = {
                v3.GetDescendants(v3)
            };
            M = v3[2];
            v = v3[3];
            
            for v, v6 in ipairs(S(v6)) do
                v3 = v;
                v8 = v6.Name == "Fire";
                
                if v8 then
                    
                    Z = string.find(v6.Parent.Name, "Room");
                end;
                
                v45 = j;
                
                if v8 then
                    v7 = v6.Parent;
                    
                    task.spawn(r76, v6);
                end; 
            end;
            
            Z = r88.DescendantAdded;
            
            r39 = Z.Connect(Z, function(arg1_54, ...)
                j = arg1_54;
                
                if r38 and j.Name == "Fire" then
                    M = r16;
                    
                    task.spawn(r76, j);
                end;
                
                return; 
            end);
            
            r28("Automation", "Auto Clean Fire ON", 2);
        else
            if r39 then
                Z = r39;
                
                Z.Disconnect(Z);
            end;
            
            r28("Automation", "Auto Clean Fire OFF", 2);
            
            return;
        end; 
    end
});

local v46 = r38;

if v46 then
    vm31 = r88;
    vm31 = {
        ipairs(vm31.GetDescendants(vm31))
    };
    
    vm29, vm31 = ipairs(vm31.GetDescendants(vm31))(vm31[2], vm31[3]);
    
    while vm29 do
        
        v46 = v43(vm27, vm31[3]);
        vm33 = vm31.Name == "Fire";
        
        if vm33 then
            
            vm34 = string.find(vm31.Parent.Name, "Room");
        end;
        
        v45 = vm24;
        
        if vm33 then
            vm34 = vm31.Parent;
            
            task.spawn(r76, vm31);
        end; 
    end;
    
    v46 = r88.DescendantAdded;
    
    r39 = v46.Connect(v46, function(arg1_55, ...)
        j = arg1_55;
        
        if r38 and j.Name == "Fire" then
            task.spawn(r76, j);
        end;
        
        return; 
    end);
end;

local v47 = v29.MakeSection(v29, {
    ["Name"] = "Anomaly Attack"
});

v47.AddToggle(v47, {
    ["Name"] = "Auto Knockout Anomaly",
    ["Default"] = r53,
    ["Callback"] = function(arg1_56, ...)
        j = arg1_56;
        r53 = j;
        
        if j then
            r28("Automation", "Auto Knockout Anomaly ON", 2);
        else
            r28("Automation", "Auto Knockout Anomaly OFF", 2);
        end;
        
        return; 
    end
});
v47.AddToggle(v47, {
    ["Name"] = "Auto Stop Death Ritual",
    ["Default"] = r54,
    ["Callback"] = function(arg1_57, ...)
        j = arg1_57;
        r54 = j;
        
        if j then
            r28("Automation", "Auto Stop Ritual ON", 2);
        else
            r28("Automation", "Auto Stop Ritual OFF", 2);
        end;
        
        return; 
    end
});
