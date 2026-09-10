-- https://scriptblox.com/script/Animal-Hospital-(Anomaly)-Animal-Hospital-Eternal-Hub-Script-Show-Anomalies-245440
-- leaked by rwaldev
local Env = getfenv();
local L = {};
local v1 = game;

local r24 = v1.GetService(v1, "Players");
local v2 = game;
local r25 = v2.GetService(v2, "TweenService");
local v3 = game;
local r26 = v3.GetService(v3, "UserInputService");
local v4 = game;
local r27 = v4.GetService(v4, "RunService");
local v5 = game;
local r28 = v5.GetService(v5, "Lighting");
local v6 = game;
local r29 = v6.GetService(v6, "CollectionService");
local r30 = r24.LocalPlayer;
local v7 = r30;
local r31 = v7.WaitForChild(v7, "PlayerGui");
local r32 = "EternalAnomalies";
local r33 = "https://discord.gg/skGYmredg";
local r34 = Instance.new("ScreenGui");

r34.Name = "KeySystem";
r34.ResetOnSpawn = false;
r34.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
r34.IgnoreGuiInset = true;
r34.Parent = r31;

local v8 = r27.RenderStepped;
local r35 = v8.Connect(v8, function(...)
    r26.MouseBehavior = Enum.MouseBehavior.Default;
    r26.MouseIconEnabled = true;
    
    return; 
end);
local v9 = Instance.new("Frame");
v9.Size = UDim2.fromOffset(360, 260);
v9.Position = UDim2.new(0.5, 0, 0.5, 0);
v9.AnchorPoint = Vector2.new(0.5, 0.5);
v9.BackgroundColor3 = Color3.fromRGB(20, 13, 32);
v9.BorderSizePixel = 0;
v9.Parent = r34;
Instance.new("UICorner", v9).CornerRadius = UDim.new(0, 16);
local v10 = Instance.new("UIStroke", v9);
v10.Color = Color3.fromRGB(168, 85, 247);
v10.Thickness = 2;
local v11 = Instance.new("TextLabel");
v11.Size = UDim2.new(1, -20, 0, 34);
v11.Position = UDim2.fromOffset(10, 14);
v11.BackgroundTransparency = 1;
v11.Text = "KEY REQUIRED";
v11.Font = Enum.Font.GothamBold;
v11.TextSize = 20;
v11.TextColor3 = Color3.fromRGB(245, 240, 255);
v11.Parent = v9;
local v12 = Instance.new("TextLabel");
v12.Size = UDim2.new(1, -20, 0, 20);
v12.Position = UDim2.fromOffset(10, 48);
v12.BackgroundTransparency = 1;
v12.Text = "Enter the access key to continue";
v12.Font = Enum.Font.Gotham;
v12.TextSize = 13;
v12.TextColor3 = Color3.fromRGB(175, 160, 205);
v12.Parent = v9;
local r36 = Instance.new("TextBox");
r36.Size = UDim2.new(1, -40, 0, 40);
r36.Position = UDim2.fromOffset(20, 80);
r36.BackgroundColor3 = Color3.fromRGB(34, 22, 52);
r36.BorderSizePixel = 0;
r36.Text = "";
r36.PlaceholderText = "Type key here...";
r36.Font = Enum.Font.GothamMedium;
r36.TextSize = 15;
r36.TextColor3 = Color3.fromRGB(245, 240, 255);
r36.PlaceholderColor3 = Color3.fromRGB(140, 125, 170);
r36.ClearTextOnFocus = false;
r36.Parent = v9;
Instance.new("UICorner", r36).CornerRadius = UDim.new(0, 10);
local v13 = Instance.new("UIStroke", r36);
v13.Color = Color3.fromRGB(105, 70, 165);
v13.Thickness = 1.5;
local v14 = Instance.new("TextButton");
v14.Size = UDim2.new(1, -40, 0, 38);
v14.Position = UDim2.fromOffset(20, 132);
v14.BackgroundColor3 = Color3.fromRGB(168, 85, 247);
v14.BorderSizePixel = 0;
v14.Text = "Unlock";
v14.Font = Enum.Font.GothamBold;
v14.TextSize = 15;
v14.TextColor3 = Color3.fromRGB(255, 255, 255);
v14.AutoButtonColor = false;
v14.Parent = v9;
Instance.new("UICorner", v14).CornerRadius = UDim.new(0, 10);
local r37 = Instance.new("TextButton");
r37.Size = UDim2.new(1, -40, 0, 38);
r37.Position = UDim2.fromOffset(20, 180);
r37.BackgroundColor3 = Color3.fromRGB(88, 101, 242);
r37.BorderSizePixel = 0;
r37.Text = "Join Discord to get the key";
r37.Font = Enum.Font.GothamBold;
r37.TextSize = 14;
r37.TextColor3 = Color3.fromRGB(255, 255, 255);
r37.AutoButtonColor = false;
r37.Parent = v9;
Instance.new("UICorner", r37).CornerRadius = UDim.new(0, 10);

local v15 = r37.MouseButton1Click;

v15.Connect(v15, function(...)
    if setclipboard then
        setclipboard(r33);
    else
        if toclipboard then
            toclipboard(r33);
        end;
        
        r37.Text = "Invite Copied!";
        
        task.delay(1.5, function(...)
            if r37 and r37.Parent then
                x = r16;
                
                r37.Text = "Join Discord to get the key";
            end;
            
            return; 
        end);
        
        return;
    end; 
end);
local r38 = Instance.new("TextLabel");
r38.Size = UDim2.new(1, -20, 0, 18);
r38.Position = UDim2.fromOffset(10, 228);
r38.BackgroundTransparency = 1;
r38.Text = "";
r38.Font = Enum.Font.Gotham;
r38.TextSize = 12;
r38.TextColor3 = Color3.fromRGB(255, 90, 100);
r38.Parent = v9;

local function r39(...)
    P = r35;
    
    P.Disconnect(P);
    
    r26.MouseBehavior = Enum.MouseBehavior.LockCenter;
    r26.MouseIconEnabled = false;
    
    P = r34;
    
    P.Destroy(P);
    
    return; 
end;

local function r40(...)
    if r36.Text == r32 then
        
        r38.TextColor3 = Color3.fromRGB(80, 220, 130);
        r38.Text = "Access granted";
        
        task.wait(.4);
        
        r39();
        
        loadMainUI();
    else
        
        r38.TextColor3 = Color3.fromRGB(255, 90, 100);
        r38.Text = "Incorrect key";
        r36.Text = "";
    end;
    
    return; 
end;

local v16 = v14.MouseButton1Click;

v16.Connect(v16, r40);

local v17 = r36.FocusLost;

v17.Connect(v17, function(arg1_2, ...)
    if arg1_2 then
        r40();
    end;
    
    return; 
end);

loadMainUI = function(...)
    o = r30.Character;
    F = o;
    
    if o then
        r41 = o;
        P = r41;
        
        r42 = P.WaitForChild(P, "Humanoid");
        P = r30.CharacterAdded;
        
        P.Connect(P, function(arg1_3, ...)
            o = arg1_3;
            r41 = o;
            T = r15;
            
            r42 = o.WaitForChild(o, "Humanoid");
            
            return; 
        end);
        
        j = "\xc0\x9b6\x9c\xab\x0e\xba";
        r43 = {
            ["Bg"] = Color3.fromRGB(20, 13, 32),
            ["Surface"] = Color3.fromRGB(34, 22, 52),
            ["Surface2"] = Color3.fromRGB(46, 30, 70),
            ["Accent"] = Color3.fromRGB(168, 85, 247),
            ["Text"] = Color3.fromRGB(245, 240, 255),
            ["TextDim"] = Color3.fromRGB(175, 160, 205),
            ["ToggleOff"] = Color3.fromRGB(60, 45, 85),
            ["Stroke"] = Color3.fromRGB(105, 70, 165),
            ["Close"] = Color3.fromRGB(220, 70, 90),
            ["Minimize"] = Color3.fromRGB(185, 165, 215),
            ["Green"] = Color3.fromRGB(70, 220, 120),
            ["Red"] = Color3.fromRGB(255, 65, 75),
            ["Discord"] = Color3[r15[r16(j, 17823154954347)]](88, 101, 242)
        };
        r44 = false;
        r45 = false;
        r46 = false;
        r47 = false;
        r48 = 16;
        r49 = {};
        P = {};
        r50 = P;
        
        local function r51(arg1_4, arg2_4, arg3_4, arg4_4, ...)
            x = arg2_4;
            P = r25;
            i = arg4_4;
            J = TweenInfo.new;
            o = arg1_4;
            
            if i then
                P = P;
                
                F = P.Create(P, arg1_4, t[r15[k]](arg3_4 or 0.25, i), arg2_4);
                
                F.Play(F);
                
                return;
            else
                X = Enum.EasingStyle.Quint;
            end; 
        end;
        
        local function r52(arg1_5, arg2_5, arg3_5, ...)
            T = arg3_5;
            
            d = r16(",\xa7Y", 16771882458754);
            P = Instance[r15[d]];
            
            i = P(arg1_5);
            J = d[2];
            d = d[1];
            
            for t, r in pairs(arg2_5) do
                i[t] = r; 
            end;
            
            if T then
                J = arg3_5;
                
                i.Parent = J;
            end;
            
            return i; 
        end;
        
        r53 = r52("ScreenGui", {
            ["Name"] = "AnomalyUI",
            ["ResetOnSpawn"] = false,
            ["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
            ["IgnoreGuiInset"] = true
        }, r31);
        r54 = r52("Frame", {
            ["Size"] = UDim2.fromOffset(310, 360),
            ["Position"] = UDim2.new(0, 18, 0, 18),
            ["BackgroundColor3"] = r43.Bg,
            ["BorderSizePixel"] = 0,
            ["ClipsDescendants"] = true
        }, r53);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 14)
        }, r54);
        r52("UIStroke", {
            ["Color"] = r43.Stroke,
            ["Thickness"] = 1.5,
            ["Transparency"] = .4
        }, r54);
        m = r52("Frame", {
            ["Size"] = UDim2.new(1, 0, 0, 40),
            ["BackgroundColor3"] = r43.Surface,
            ["BorderSizePixel"] = 0
        }, r54);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 14)
        }, m);
        r52("Frame", {
            ["Size"] = UDim2.new(1, 0, 0, 14),
            ["Position"] = UDim2.new(0, 0, 1, -14),
            ["BackgroundColor3"] = r43.Surface,
            ["BorderSizePixel"] = 0
        }, m);
        r52("TextLabel", {
            ["Size"] = UDim2.new(1, -95, 1, 0),
            ["Position"] = UDim2.fromOffset(14, 0),
            ["BackgroundTransparency"] = 1,
            ["Text"] = "ANOMALY DETECTOR",
            ["Font"] = Enum.Font.GothamBold,
            ["TextSize"] = 14,
            ["TextColor3"] = r43.Text,
            ["TextXAlignment"] = Enum.TextXAlignment.Left
        }, m);
        r55 = r52("TextButton", {
            ["Size"] = UDim2.fromOffset(28, 28),
            ["Position"] = UDim2.new(1, -64, 0.5, 0),
            ["AnchorPoint"] = Vector2.new(0, 0.5),
            ["BackgroundColor3"] = r43.Surface2,
            ["BorderSizePixel"] = 0,
            ["Text"] = "\xe2\x80\x93",
            ["Font"] = Enum.Font.GothamBold,
            ["TextSize"] = 18,
            ["TextColor3"] = r43.Minimize,
            ["AutoButtonColor"] = false
        }, m);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 8)
        }, r55);
        h = r52("TextButton", {
            ["Size"] = UDim2.fromOffset(28, 28),
            ["Position"] = UDim2.new(1, -32, 0.5, 0),
            ["AnchorPoint"] = Vector2.new(0, 0.5),
            ["BackgroundColor3"] = r43.Surface2,
            ["BorderSizePixel"] = 0,
            ["Text"] = "\xc3\x97",
            ["Font"] = Enum.Font.GothamBold,
            ["TextSize"] = 18,
            ["TextColor3"] = r43.Close,
            ["AutoButtonColor"] = false
        }, m);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 8)
        }, h);
        
        local function A(arg1_6, arg2_6, ...)
            P = r52;
            
            T = P("TextButton", {
                ["Size"] = UDim2.new(1, -20, 0, 48),
                ["Position"] = UDim2.fromOffset(10, arg2_6),
                ["BackgroundColor3"] = r43.Surface,
                ["BorderSizePixel"] = 0,
                ["Text"] = "",
                ["AutoButtonColor"] = false
            }, r56);
            
            r52("UICorner", {
                ["CornerRadius"] = UDim.new(0, 11)
            }, T);
            r52("UIStroke", {
                ["Color"] = r43.Stroke,
                ["Thickness"] = 1,
                ["Transparency"] = .55
            }, T);
            r52("TextLabel", {
                ["Size"] = UDim2.new(1, -70, 1, 0),
                ["Position"] = UDim2.fromOffset(16, 0),
                ["BackgroundTransparency"] = 1,
                ["Text"] = arg1_6,
                ["Font"] = Enum.Font.GothamMedium,
                ["TextSize"] = 15,
                ["TextColor3"] = r43.Text,
                ["TextXAlignment"] = Enum.TextXAlignment.Left
            }, T);
            i = r52("Frame", {
                ["Size"] = UDim2.fromOffset(44, 24),
                ["Position"] = UDim2.new(1, -56, 0.5, 0),
                ["AnchorPoint"] = Vector2.new(0, 0.5),
                ["BackgroundColor3"] = r43.ToggleOff,
                ["BorderSizePixel"] = 0
            }, T);
            
            r52("UICorner", {
                ["CornerRadius"] = UDim.new(1, 0)
            }, i);
            J = r52("Frame", {
                ["Size"] = UDim2.fromOffset(18, 18),
                ["Position"] = UDim2.fromOffset(3, 3),
                ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
                ["BorderSizePixel"] = 0
            }, i);
            
            r52("UICorner", {
                ["CornerRadius"] = UDim.new(1, 0)
            }, J);
            
            return T, i, J; 
        end;
        
        r56 = r52("Frame", {
            ["Size"] = UDim2.new(1, -8, 0, 440),
            ["BackgroundTransparency"] = 1
        }, r52("ScrollingFrame", {
            ["Size"] = UDim2.new(1, 0, 1, -40),
            ["Position"] = UDim2.fromOffset(0, 40),
            ["BackgroundTransparency"] = 1,
            ["BorderSizePixel"] = 0,
            ["ScrollBarThickness"] = 4,
            ["ScrollBarImageColor3"] = r43.Accent,
            ["CanvasSize"] = UDim2.fromOffset(0, 440),
            ["ScrollingDirection"] = Enum.ScrollingDirection.Y
        }, r54));
        S = {
            A("Show Anomalies", 12)
        };
        r57 = S[2];
        r58 = S[3];
        QU = {
            A("Fullbright", 70)
        };
        r59 = QU[2];
        r60 = QU[3];
        y = {
            A("Noclip", 128)
        };
        r61 = y[2];
        r62 = y[3];
        c = r52("Frame", {
            ["Size"] = UDim2.new(1, -20, 0, 80),
            ["Position"] = UDim2.fromOffset(10, 186),
            ["BackgroundColor3"] = r43.Surface,
            ["BorderSizePixel"] = 0
        }, r56);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 11)
        }, c);
        r52("UIStroke", {
            ["Color"] = r43.Stroke,
            ["Thickness"] = 1,
            ["Transparency"] = .55
        }, c);
        r52("TextLabel", {
            ["Size"] = UDim2.new(1, -70, 0, 22),
            ["Position"] = UDim2.fromOffset(16, 10),
            ["BackgroundTransparency"] = 1,
            ["Text"] = "Speed Throttle",
            ["Font"] = Enum.Font.GothamMedium,
            ["TextSize"] = 15,
            ["TextColor3"] = r43.Text,
            ["TextXAlignment"] = Enum.TextXAlignment.Left
        }, c);
        r63 = r52("TextLabel", {
            ["Size"] = UDim2.fromOffset(50, 22),
            ["Position"] = UDim2.new(1, -62, 0, 10),
            ["BackgroundTransparency"] = 1,
            ["Text"] = "16",
            ["Font"] = Enum.Font.GothamBold,
            ["TextSize"] = 15,
            ["TextColor3"] = r43.Accent,
            ["TextXAlignment"] = Enum.TextXAlignment.Right
        }, c);
        r64 = r52("TextButton", {
            ["Size"] = UDim2.new(1, -32, 0, 12),
            ["Position"] = UDim2.fromOffset(16, 48),
            ["BackgroundColor3"] = r43.ToggleOff,
            ["BorderSizePixel"] = 0,
            ["Text"] = "",
            ["AutoButtonColor"] = false
        }, c);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(1, 0)
        }, r64);
        r65 = r52("Frame", {
            ["Size"] = UDim2.new(.16, 0, 1, 0),
            ["BackgroundColor3"] = r43.Accent,
            ["BorderSizePixel"] = 0
        }, r64);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(1, 0)
        }, r65);
        r66 = r52("Frame", {
            ["Size"] = UDim2.fromOffset(18, 18),
            ["Position"] = UDim2.new(.16, -9, 0.5, 0),
            ["AnchorPoint"] = Vector2.new(0, 0.5),
            ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
            ["BorderSizePixel"] = 0
        }, r64);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(1, 0)
        }, r66);
        r67 = r52("TextButton", {
            ["Size"] = UDim2.new(1, -20, 0, 46),
            ["Position"] = UDim2.fromOffset(10, 280),
            ["BackgroundColor3"] = r43.Discord,
            ["BorderSizePixel"] = 0,
            ["Text"] = "  Discord  \xc2\xb7  Click to Copy Invite",
            ["Font"] = Enum.Font.GothamBold,
            ["TextSize"] = 14,
            ["TextColor3"] = Color3.fromRGB(255, 255, 255),
            ["AutoButtonColor"] = false
        }, r56);
        
        r52("UICorner", {
            ["CornerRadius"] = UDim.new(0, 11)
        }, r67);
        
        P = r67.MouseButton1Click;
        
        P.Connect(P, function(...)
            if setclipboard then
                setclipboard(r33);
            else
                if toclipboard then
                    toclipboard(r33);
                end;
                
                r67.Text = "  Copied!";
                
                task.delay(1.4, function(...)
                    if r67 and r67.Parent then
                        x = r16;
                        
                        r67.Text = "  Discord  \xc2\xb7  Click to Copy Invite";
                    end;
                    
                    return; 
                end);
                
                return;
            end; 
        end);
        
        r68 = false;
        P = m.InputBegan;
        
        P.Connect(P, function(arg1_7, ...)
            o = arg1_7;
            
            if o.UserInputType == Enum.UserInputType.MouseButton1 then
                r68 = true;
                r69 = o.Position;
                r70 = r54.Position;
            end;
            
            return; 
        end);
        
        P = m.InputEnded;
        
        P.Connect(P, function(arg1_8, ...)
            if arg1_8.UserInputType == Enum.UserInputType.MouseButton1 then
                r68 = false;
            end;
            
            return; 
        end);
        
        P = r26.InputChanged;
        
        P.Connect(P, function(arg1_9, ...)
            x = r68;
            o = arg1_9;
            
            if x then
                F = o.UserInputType == Enum.UserInputType.MouseMovement;
            end;
            
            if x then
                x = o.Position - r69;
                
                r54.Position = UDim2.new(r70.X.Scale, r70.X.Offset + x.X, r70.Y.Scale, r70.Y.Offset + x.Y);
            end;
            
            return; 
        end);
        
        local function r71(arg1_10, ...)
            o = arg1_10;
            
            if o.GetAttribute(o, "Anomaly") or (o.GetAttribute(o, "IsAnomaly") or o.GetAttribute(o, "Type") == "Anomaly") then
                P = true;
                
                return P;
            end;
            
            x = r29;
            
            if x.HasTag(x, o, "Anomaly") or x.HasTag(x, o, "Skinwalker") then
                P = true;
                
                return P;
            end;
            
            P = string.lower;
            
            x = P(o.Name);
            
            i = string.find(x, "anomaly");
            
            if i then
                return i;
            else
                P = P;
                F = string.find(x, "skinwalker") or string.find(x, "monster");
            end; 
        end;
        
        local function r72(arg1_11, ...)
            o = arg1_11;
            
            if not o.IsA(o, "Model") or o == r30.Character then
                P = false;
                
                return P;
            end;
            
            P = string.lower;
            t = "cat";
            i = t[3];
            J = t[1];
            
            for i, d in J, ipairs(J) do
                t = i;
                
                if string.find(P(o.Name), d) then
                    return true;
                else
                    
                end; 
            end;
            
            if o.FindFirstChildOfClass(o, "Humanoid") then
                X = o.GetChildren;
                J = X[2];
                t = X[3];
                
                for t, X in ipairs(X(o)) do
                    d = t;
                    
                    if X.IsA(X, "BasePart") then
                        0 = 0 + 1;
                    end; 
                end;
                
                return 0 >= 3;
            end;
            
            return false; 
        end;
        
        local function r73(...)
            P = pairs;
            T = r49;
            o = 26[2];
            T = 26[1];
            
            for x, J in P(T) do
                i = x;
                
                if J then
                    J.Destroy(J);
                end; 
            end;
            
            table.clear(r49);
            
            return; 
        end;
        
        local function r74(arg1_12, arg2_12, ...)
            x = arg2_12;
            o = arg1_12;
            P = r49[o];
            
            if P then
                return;
            end;
            
            T = Instance.new("Highlight");
            
            T.Adornee = o;
            T.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            T.FillTransparency = 0.5;
            T.OutlineTransparency = .1;
            
            P = "FillColor";
            i = P;
            F = x and r43.Red;
            P = P;
            
            if x then
                P = r16;
                
                T[P] = J and r43.Red;
                
                P = "OutlineColor";
                i = P;
                
                if x then
                    
                    J = Color3.fromRGB(255, 110, 120);
                end;
                
                F = x;
                P = P;
                
                if x then
                    P = r16;
                    
                    T[P] = J;
                    
                    F = arg1_12;
                    
                    T.Parent = F;
                    
                    r49[o] = T;
                    
                    return;
                else
                    
                    F = Color3.fromRGB(100, 255, 150);
                end;
            else
                F = r43.Green;
            end; 
        end;
        
        local function r75(...)
            P = not r44;
            
            if P then
                r73();
                
                return;
            end;
            
            T = r49;
            x = 26[3];
            o = 26[2];
            
            for x, J in pairs(F) do
                if not x.Parent then
                    if J then
                        J.Destroy(J);
                    end;
                    
                    r49[x] = nil;
                end; 
            end;
            
            i = workspace;
            J = {
                i.GetDescendants(i)
            };
            T = i[3];
            
            for T, J in i[1], ipairs(s(J)) do
                i = T;
                
                X = r72(J);
                
                if X then
                    t = not r49[J];
                end;
                
                if X then
                    r74(J, r71(J));
                end; 
            end;
            
            return; 
        end;
        
        local function r77(arg1_13, ...)
            o = arg1_13;
            P = o;
            r44 = P;
            
            if o then
                r51(r57, {
                    ["BackgroundColor3"] = r43.Accent
                });
                r51(r58, {
                    ["Position"] = UDim2.fromOffset(23, 3)
                }, .28, Enum.EasingStyle.Back);
                
                r75();
                
                F = r27.Heartbeat;
                
                r76 = F.Connect(F, function(...)
                    if tick() % .4 < .02 then
                        L[gU]();
                    end;
                    
                    return; 
                end);
            else
                r51(r57, {
                    ["BackgroundColor3"] = r43.ToggleOff
                });
                r51(r58, {
                    ["Position"] = UDim2.fromOffset(3, 3)
                }, .28, Enum.EasingStyle.Back);
                
                F = r76;
                
                if F then
                    F = r76;
                    
                    F.Disconnect(F);
                end;
                
                r73();
                
                return;
            end; 
        end;
        
        P = A("Show Anomalies", 12).MouseButton1Click;
        
        P.Connect(P, function(...)
            r77(not r44);
            
            return; 
        end);
        
        local function r78(arg1_14, ...)
            o = arg1_14;
            P = o;
            r45 = P;
            
            if o then
                r50 = {
                    ["Brightness"] = r28.Brightness,
                    ["Ambient"] = r28.Ambient,
                    ["OutdoorAmbient"] = r28.OutdoorAmbient,
                    ["ClockTime"] = r28.ClockTime,
                    ["FogEnd"] = r28.FogEnd,
                    ["GlobalShadows"] = r28.GlobalShadows
                };
                
                r28.Brightness = 2;
                
                r28.Ambient = Color3.fromRGB(180, 180, 180);
                r28.OutdoorAmbient = Color3.fromRGB(180, 180, 180);
                r28.ClockTime = 14;
                r28.FogEnd = 9000000000;
                r28.GlobalShadows = false;
                
                r51(r59, {
                    ["BackgroundColor3"] = r43.Accent
                });
                r51(r60, {
                    ["Position"] = UDim2.fromOffset(23, 3)
                }, .28, Enum.EasingStyle.Back);
            else
                
                d = r16("64\xe6>G\xf6\x16\xfb\x03i", 25961680891705);
                
                if r50[r15[d]] then
                    t = r50;
                    J = d[3];
                    
                    for J, t in d[1], pairs(t) do
                        r28[J] = t; 
                    end;
                end;
                
                r51(r59, {
                    ["BackgroundColor3"] = r43.ToggleOff
                });
                r51(r60, {
                    ["Position"] = UDim2.fromOffset(3, 3)
                }, .28, Enum.EasingStyle.Back);
                
                return;
            end; 
        end;
        
        P = A("Fullbright", 70).MouseButton1Click;
        
        P.Connect(P, function(...)
            r78(not r45);
            
            return; 
        end);
        
        local function r80(arg1_15, ...)
            o = arg1_15;
            P = o;
            r46 = P;
            
            if o then
                r51(r61, {
                    ["BackgroundColor3"] = r43.Accent
                });
                r51(r62, {
                    ["Position"] = UDim2.fromOffset(23, 3)
                }, .28, Enum.EasingStyle.Back);
                
                F = r27.Stepped;
                
                r79 = F.Connect(F, function(...)
                    if r41 then
                        T = r41;
                        o = T[2];
                        T = T[1];
                        
                        for x, J in ipairs(T.GetDescendants(T)) do
                            i = x;
                            
                            if J.IsA(J, "BasePart") then
                                J.CanCollide = false;
                            end; 
                        end;
                    end;
                    
                    return; 
                end);
            else
                r51(r61, {
                    ["BackgroundColor3"] = r43.ToggleOff
                });
                r51(r62, {
                    ["Position"] = UDim2.fromOffset(3, 3)
                }, .28, Enum.EasingStyle.Back);
                
                F = r79;
                
                if F then
                    F = r79;
                    
                    F.Disconnect(F);
                end;
                
                return;
            end; 
        end;
        
        P = A("Noclip", 128).MouseButton1Click;
        
        P.Connect(P, function(...)
            r80(not r46);
            
            return; 
        end);
        
        local function r81(arg1_16, ...)
            P = math.clamp;
            
            r48 = P(math.floor(arg1_16), 0, 100);
            
            r63.Text = tostring(r48);
            
            x = r48 / 100;
            
            r65.Size = UDim2.new(x, 0, 1, 0);
            r66.Position = UDim2.new(x, -9, 0.5, 0);
            
            return; 
        end;
        
        local function r82(...)
            P = pcall;
            
            P(function(...)
                o = r42;
                
                if o and r42.Parent then
                    P = r42;
                    
                    P.WalkSpeed = r48;
                end;
                
                return; 
            end);
            
            return; 
        end;
        
        P = r27.RenderStepped;
        
        P.Connect(P, r82);
        
        P = r27.Heartbeat;
        
        P.Connect(P, r82);
        
        P = r27.Stepped;
        
        P.Connect(P, r82);
        
        P = r30.CharacterAdded;
        
        P.Connect(P, function(arg1_17, ...)
            o = arg1_17;
            
            task.wait(0.5);
            r42 = o.WaitForChild(o, "Humanoid", 5);
            
            r82();
            
            return; 
        end);
        
        r83 = false;
        P = r64.MouseButton1Down;
        
        P.Connect(P, function(...)
            r83 = true;
            
            return; 
        end);
        
        P = r26.InputEnded;
        
        P.Connect(P, function(arg1_18, ...)
            if arg1_18.UserInputType == Enum.UserInputType.MouseButton1 then
                r83 = false;
            end;
            
            return; 
        end);
        
        P = r26.InputChanged;
        
        P.Connect(P, function(arg1_19, ...)
            o = arg1_19;
            
            if r83 and o.UserInputType == Enum.UserInputType.MouseMovement then
                r81(math.clamp((o.Position.X - r64.AbsolutePosition.X) / r64.AbsoluteSize.X, 0, 1) * 100);
            end;
            
            return; 
        end);
        
        r81(16);
        
        r84 = UDim2.fromOffset(310, 360);
        P = r55.MouseButton1Click;
        
        P.Connect(P, function(...)
            r47 = not r47;
            
            if r47 then
                r51(r54, {
                    ["Size"] = UDim2.fromOffset(310, 40)
                });
                
                r55.Text = "+";
            else
                r51(r54, {
                    ["Size"] = r84
                }, .3, Enum.EasingStyle.Back);
                
                r55.Text = "\xe2\x80\x93";
            end;
            
            return; 
        end);
        
        P = h.MouseButton1Click;
        
        P.Connect(P, function(...)
            P = r76;
            
            if P then
                P = r76;
                
                P.Disconnect(P);
            end;
            
            P = r79;
            
            if P then
                P = r79;
                
                P.Disconnect(P);
            end;
            
            r73();
            
            if r45 then
                r78(false);
            end;
            
            P = r53;
            
            P.Destroy(P);
            
            return; 
        end);
        r54.Size = UDim2.fromOffset(310, 0);
        r54.BackgroundTransparency = 1;
        
        task.wait(.05);
        
        r51(r54, {
            ["Size"] = r84,
            ["BackgroundTransparency"] = 0
        }, .4, Enum.EasingStyle.Back);
        
        print("[AnomalyUI] Loaded");
        
        return;
    else
        o = r30.CharacterAdded;
        
        F = o.Wait(o);
    end; 
end;
