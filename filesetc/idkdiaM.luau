if not game:IsLoaded() then game.Loaded:Wait() end
local env = (getgenv and getgenv()) or _G
if env.__DiamondDumperRunning then return end
env.__DiamondDumperRunning = true

local Players = game:GetService("Players")
while not Players.LocalPlayer do task.wait() end

local WORKERS = 24
local DECOMPILE_TIMEOUT = 8
local TREE_LINE_LIMIT = 30000
local HANDLERS = true
local GETGC = true
local MODULES = true
local SIGNATURES = true
local HOOK_OUTGOING = true
local MODULE_TIMEOUT = 4
local MODULE_DEPTH = 4
local HttpService = game:GetService("HttpService")

if not (writefile and makefolder and decompile) then
	warn("[Dumper] writefile, makefolder and decompile are required")
	env.__DiamondDumperRunning = nil
	return
end

local function Notify(text)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Dumper", Text = text, Duration = 8 })
	end)
end

local GameName = "Unknown"
pcall(function() GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
local function Clean(s, max)
	s = tostring(s):gsub("[^%w%._%-]", "_")
	return max and s:sub(1, max) or s
end

local ROOT = "Dump_" .. game.PlaceId .. "_" .. Clean(GameName, 40)
for _, p in ipairs({ ROOT, ROOT .. "/scripts", ROOT .. "/bytecode" }) do
	pcall(function() if not (isfolder and isfolder(p)) then makefolder(p) end end)
end
local function Write(name, text) pcall(writefile, ROOT .. "/" .. name, text) end
local function Full(i)
	local ok, n = pcall(function() return i:GetFullName() end)
	return ok and n or tostring(i)
end

local t0 = os.clock()
Notify("Dump started")

local Remotes, RemoteObjs, RemoteSet, Interactables, Scripts = {}, {}, {}, {}, {}
local REMOTE = { RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true }
local PromptCount, ClickCount = 0, 0

local all = game:GetDescendants()
for n, i in ipairs(all) do
	if n % 20000 == 0 then task.wait() end
	local c = i.ClassName
	if REMOTE[c] then
		RemoteObjs[#RemoteObjs + 1] = i
		RemoteSet[i] = true
	elseif c == "ProximityPrompt" then
		PromptCount += 1
		pcall(function()
			Interactables[#Interactables + 1] = string.format('[ProximityPrompt] %s | action=%q object=%q hold=%s dist=%s key=%s enabled=%s',
				Full(i), i.ActionText, i.ObjectText, i.HoldDuration, i.MaxActivationDistance, tostring(i.KeyboardKeyCode), tostring(i.Enabled))
		end)
	elseif c == "ClickDetector" then
		ClickCount += 1
		Interactables[#Interactables + 1] = "[ClickDetector] " .. Full(i)
	elseif c == "LocalScript" or c == "ModuleScript" then
		local p = Full(i)
		if not (p:find("^CoreGui") or p:find("^CorePackages")) then Scripts[#Scripts + 1] = i end
	elseif c == "Script" then
		local ok, client = pcall(function() return i.RunContext == Enum.RunContext.Client end)
		if ok and client then Scripts[#Scripts + 1] = i end
	end
end
table.sort(Interactables)
Write("interactables.txt", table.concat(Interactables, "\n"))

local function Describe(f)
	local ok, src, line, name = pcall(debug.info, f, "sln")
	if not ok then return "<c function>" end
	return ((name and name ~= "") and name or "anonymous") .. " @ " .. tostring(src) .. ":" .. tostring(line)
end

local function HandlerLines(remote)
	local out = {}
	if not HANDLERS then return out end
	if getconnections and not remote:IsA("RemoteFunction") then
		local ok, conns = pcall(getconnections, remote.OnClientEvent)
		if ok and type(conns) == "table" then
			for _, c in ipairs(conns) do
				local f = c.Function
				out[#out + 1] = "    handler: " .. (type(f) == "function" and Describe(f) or "<no function>")
			end
		end
	end
	if remote:IsA("RemoteFunction") and getcallbackvalue then
		local ok, cb = pcall(getcallbackvalue, remote, "OnClientInvoke")
		if ok and type(cb) == "function" then out[#out + 1] = "    OnClientInvoke: " .. Describe(cb) end
	end
	return out
end

local GcExtra = 0
local function WriteRemotes()
	table.sort(RemoteObjs, function(a, b) return Full(a) < Full(b) end)
	table.clear(Remotes)
	local lines = {}
	for n, r in ipairs(RemoteObjs) do
		if n % 40 == 0 then task.wait() end
		local path = Full(r)
		Remotes[#Remotes + 1] = r.ClassName .. " " .. path
		lines[#lines + 1] = "[" .. r.ClassName .. "] " .. path
		for _, h in ipairs(HandlerLines(r)) do lines[#lines + 1] = h end
	end
	Write("remotes.txt", table.concat(lines, "\n"))
end
pcall(WriteRemotes)

local Lines = {}
local function Walk(inst, depth, max)
	if #Lines >= TREE_LINE_LIMIT then return end
	Lines[#Lines + 1] = string.rep("  ", depth) .. inst.Name .. " [" .. inst.ClassName .. "]"
	if depth >= max then return end
	for _, child in ipairs(inst:GetChildren()) do Walk(child, depth + 1, max) end
end
for _, entry in ipairs({
	{ "ReplicatedFirst", 8 }, { "ReplicatedStorage", 8 }, { "StarterGui", 6 }, { "StarterPlayer", 6 },
	{ "StarterPack", 4 }, { "Lighting", 3 }, { "SoundService", 3 }, { "Teams", 3 }, { "Workspace", 3 },
}) do
	local ok, svc = pcall(game.GetService, game, entry[1])
	if ok and svc then pcall(Walk, svc, 0, entry[2]) end
end
pcall(function()
	local pg = Players.LocalPlayer:FindFirstChild("PlayerGui")
	if pg then Walk(pg, 0, 5) end
	Walk(Players.LocalPlayer, 0, 3)
end)
Write("tree.txt", table.concat(Lines, "\n"))

local Sources, Index = {}, {}
local used, nextIndex, done, decompiled = {}, 1, 0, 0
table.sort(Scripts, function(a, b) return Full(a) < Full(b) end)

local function FileFor(path, ext)
	local base, name, k = Clean(path, 110), nil, 1
	name = base
	while used[name] do
		k += 1
		name = base .. "_" .. k
	end
	used[name] = true
	return name .. ext
end

local function Work()
	while true do
		local mine = nextIndex
		nextIndex += 1
		local s = Scripts[mine]
		if not s then break end
		local path = Full(s)
		local finished, ok, res = false, false, nil
		local th = task.spawn(function()
			ok, res = pcall(decompile, s)
			finished = true
		end)
		local waited = os.clock()
		while not finished and os.clock() - waited < DECOMPILE_TIMEOUT do task.wait() end
		if not finished then pcall(task.cancel, th) end
		if finished and ok and type(res) == "string" and #res > 0 then
			local file = FileFor(path, ".lua")
			Write("scripts/" .. file, "-- " .. path .. "\n" .. res)
			Sources[path] = res
			Index[mine] = path .. " -> " .. file
			decompiled += 1
		else
			local saved = false
			if getscriptbytecode then
				local okB, bc = pcall(getscriptbytecode, s)
				if okB and type(bc) == "string" and #bc > 0 then
					local file = FileFor(path, ".bin")
					Write("bytecode/" .. file, bc)
					Index[mine] = path .. " -> bytecode/" .. file
					saved = true
				end
			end
			if not saved then Index[mine] = path .. " -> failed" end
		end
		done += 1
	end
end

for _ = 1, WORKERS do task.spawn(Work) end
while done < #Scripts do task.wait(0.5) end

local ordered = {}
for i = 1, #Scripts do ordered[#ordered + 1] = Index[i] or "?" end
Write("scripts/_index.txt", table.concat(ordered, "\n"))

local ModuleOk, ModuleTotal = 0, 0
if GETGC and getgc then
	pcall(function()
		for n, v in ipairs(getgc(false)) do
			if n % 4000 == 0 then task.wait() end
			if typeof(v) == "Instance" and REMOTE[v.ClassName] and not RemoteSet[v] then
				RemoteSet[v] = true
				RemoteObjs[#RemoteObjs + 1] = v
				GcExtra += 1
			end
		end
	end)
	if GcExtra > 0 then pcall(WriteRemotes) end
end

if MODULES and getloadedmodules then
	pcall(function() if not isfolder(ROOT .. "/modules") then makefolder(ROOT .. "/modules") end end)
	local function Dump(v, depth, seen, indent)
		if type(v) ~= "table" then
			local t = typeof(v)
			if t == "string" then return HttpService:JSONEncode(#v > 200 and v:sub(1, 200) .. "..." or v) end
			if t == "function" then return '"<function ' .. Describe(v) .. '>"' end
			if t == "Instance" then return '"<' .. v.ClassName .. "> " .. Full(v) .. '"' end
			return tostring(v)
		end
		if seen[v] then return '"<cycle>"' end
		if depth >= MODULE_DEPTH then return "{...}" end
		seen[v] = true
		local keys = {}
		for k in pairs(v) do keys[#keys + 1] = k end
		table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
		local out = { "{" }
		for n, k in ipairs(keys) do
			if n > 200 then out[#out + 1] = indent .. "  more keys" break end
			local key = (type(k) == "string" and k:match("^[%a_][%w_]*$")) and k or ("[" .. Dump(k, depth + 1, seen, "") .. "]")
			out[#out + 1] = indent .. "  " .. key .. " = " .. Dump(v[k], depth + 1, seen, indent .. "  ") .. ","
		end
		out[#out + 1] = indent .. "}"
		seen[v] = nil
		return table.concat(out, "\n")
	end
	local mods = {}
	pcall(function()
		for _, m in ipairs(getloadedmodules()) do
			if typeof(m) == "Instance" and m:IsA("ModuleScript") then
				local p = Full(m)
				if not (p:find("^CoreGui") or p:find("^CorePackages")) then mods[#mods + 1] = m end
			end
		end
	end)
	ModuleTotal = #mods
	local idx = {}
	for _, m in ipairs(mods) do
		local path = Full(m)
		local finished, ok, data = false, false, nil
		local th = task.spawn(function()
			ok, data = pcall(require, m)
			finished = true
		end)
		local waited = os.clock()
		while not finished and os.clock() - waited < MODULE_TIMEOUT do task.wait() end
		if not finished then pcall(task.cancel, th) end
		if finished and ok then
			local file = FileFor("module_" .. path, ".lua")
			local okD, text = pcall(Dump, data, 0, {}, "")
			Write("modules/" .. file, "-- " .. path .. " (runtime data)\nreturn " .. (okD and text or "nil"))
			idx[#idx + 1] = path .. " -> " .. file
			ModuleOk += 1
		else
			idx[#idx + 1] = path .. " -> failed"
		end
	end
	Write("modules/_index.txt", table.concat(idx, "\n"))
end

local Usage = {}
local seen = {}
for _, line in ipairs(Remotes) do
	local path = line:match("^%S+ (.+)$")
	local name = path:match("([^%.]+)$")
	if not seen[name] then
		seen[name] = true
		Usage[#Usage + 1] = name .. "  (" .. path .. ")"
		local found = false
		for sp, src in pairs(Sources) do
			if src:find(name, 1, true) then
				Usage[#Usage + 1] = "    used by: " .. sp
				found = true
			end
		end
		if not found then Usage[#Usage + 1] = "    used by: <no decompiled script mentions it>" end
	end
end
Write("remote_usage.txt", table.concat(Usage, "\n"))

local executor = "Unknown"
pcall(function() executor = tostring((identifyexecutor())) end)
Write("info.txt", table.concat({
	"game: " .. GameName,
	"placeId: " .. game.PlaceId,
	"gameId: " .. game.GameId,
	"jobId: " .. game.JobId,
	"player: " .. Players.LocalPlayer.Name,
	"executor: " .. executor,
	"date: " .. os.date("%Y-%m-%d %H:%M:%S"),
	string.format("remotes: %d (getgc extra: %d) | prompts: %d | clickdetectors: %d", #Remotes, GcExtra, PromptCount, ClickCount),
	string.format("module data: %d / %d", ModuleOk, ModuleTotal),
	"signatures: " .. (SIGNATURES and "incoming" or "off") .. ", outgoing hook: " .. (HOOK_OUTGOING and "on" or "off"),
	string.format("scripts: %d decompiled / %d candidates", decompiled, #Scripts),
	string.format("took: %.1fs", os.clock() - t0),
}, "\n"))

local KeepRunning = false
if SIGNATURES then
	local Sig, Dirty = {}, false
	local function Types(...)
		local n = select("#", ...)
		if n == 0 then return "()" end
		local t = {}
		for i = 1, n do t[i] = typeof((select(i, ...))) end
		return table.concat(t, ",")
	end
	local function Sample(...)
		local t = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			local ty = typeof(v)
			if ty == "string" or ty == "number" or ty == "boolean" then t[i] = v
			elseif ty == "Instance" then t[i] = "<" .. v.ClassName .. "> " .. Full(v)
			else t[i] = ty .. ":" .. tostring(v):sub(1, 120) end
		end
		return t
	end
	local function Entry(r)
		local path = Full(r)
		local e = Sig[path]
		if not e then
			e = { class = r.ClassName, out = { calls = 0, variants = {} }, inc = { calls = 0, variants = {} }, callers = {} }
			Sig[path] = e
		end
		return e
	end
	local function Record(side, r, method, ...)
		local e = Entry(r)
		local b = e[side]
		b.calls += 1
		local sig = Types(...)
		local v = b.variants[sig]
		if not v then
			v = { method = method, count = 0, sample = Sample(...) }
			b.variants[sig] = v
		end
		v.count += 1
		Dirty = true
		return e
	end
	local old
	local hooked = HOOK_OUTGOING and hookmetamethod ~= nil and getnamecallmethod ~= nil and newcclosure ~= nil and pcall(function()
		old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
			local method = getnamecallmethod()
			if (method == "FireServer" or method == "InvokeServer") and typeof(self) == "Instance" and REMOTE[self.ClassName]
				and not (checkcaller and checkcaller()) then
				local caller = getcallingscript and getcallingscript()
				pcall(function(...)
					local e = Record("out", self, method, ...)
					local name = caller and Full(caller) or "?"
					e.callers[name] = (e.callers[name] or 0) + 1
				end, ...)
			end
			return old(self, ...)
		end))
	end)
	local Watched = {}
	local function Watch(r)
		if Watched[r] or r:IsA("RemoteFunction") then return end
		Watched[r] = true
		r.OnClientEvent:Connect(function(...)
			local ok, err = pcall(Record, "inc", r, "OnClientEvent", ...)
			if not ok then pcall(Write, "_errors.txt", "signature record: " .. tostring(err)) end
		end)
	end
	for _, r in ipairs(RemoteObjs) do pcall(Watch, r) end
	game.DescendantAdded:Connect(function(d)
		if REMOTE[d.ClassName] then pcall(Watch, d) end
	end)
	local function Flush()
		if not Dirty then return end
		Dirty = false
		local paths = {}
		for p in pairs(Sig) do paths[#paths + 1] = p end
		table.sort(paths)
		local lines = {}
		for _, p in ipairs(paths) do
			local e = Sig[p]
			lines[#lines + 1] = p .. " [" .. e.class .. "]"
			for _, side in ipairs({ "out", "inc" }) do
				local b = e[side]
				if b.calls > 0 then
					lines[#lines + 1] = "  " .. (side == "out" and "OUT" or "IN ") .. " calls=" .. b.calls
					for sig, v in pairs(b.variants) do
						local ok, sample = pcall(HttpService.JSONEncode, HttpService, v.sample)
						lines[#lines + 1] = "    (" .. sig .. ") x" .. v.count .. "  sample=" .. (ok and sample or "?")
					end
				end
			end
			for c, n in pairs(e.callers) do lines[#lines + 1] = "  caller: " .. c .. " x" .. n end
		end
		Write("signatures.txt", table.concat(lines, "\n"))
	end
	task.spawn(function()
		while true do
			task.wait(5)
			pcall(Flush)
		end
	end)
	KeepRunning = true
	Write("signatures.txt", "incoming only" .. (HOOK_OUTGOING and (hooked and ", outgoing hook installed" or ", outgoing hook FAILED") or ", outgoing hook off") .. ", waiting for remote traffic (flushes every 5s)")
end

Notify(string.format("Dump finished in %.0fs: %d remotes, %d scripts. Folder: %s", os.clock() - t0, #Remotes, decompiled, ROOT))
if not KeepRunning then env.__DiamondDumperRunning = nil end
