-- kamidere free loader
-- get a key at discord.gg/kamidere → Get Free Key button

local KEY   = (getgenv and getgenv().KAMI_KEY)
           or (rawget and rawget(_G, "KAMI_KEY"))
           or (isfile and isfile("kamidere_key.txt") and readfile("kamidere_key.txt"):match("^%s*(.-)%s*$"))
           or "none"

local API_VERIFY = "https://kamidere-api.fly.dev/verify"
local API_SCRIPT = "https://kamidere-api.fly.dev/script"
local DISCORD    = "discord.gg/kamidere"

local Players    = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function kickPlayer(msg)
    local ok = pcall(function() Players.LocalPlayer:Kick(msg) end)
    if not ok then error(msg, 0) end
    task.wait(999)
end

local function getHWID()
    local ok, id = pcall(function()
        return tostring(game:GetService("RbxAnalyticsService"):GetClientId())
    end)
    if ok and id and id ~= "" then return id end
    local ok2, ex = pcall(function() return identifyexecutor() end)
    if ok2 and ex then return ex end
    return tostring(game.PlaceId) .. tostring(Players.LocalPlayer.UserId)
end

if KEY == "none" or KEY == "" then
    local msg = table.concat({
        "[ kamidere ] No key found.",
        "",
        "1. Join our Discord: " .. DISCORD,
        "2. Click  Get Free Key  in #get-script",
        "3. Complete the Workink checkpoint",
        "4. Click  Claim Key  in the bot",
        "5. Click  Get Script  — paste the loader and run",
        "",
        "Need help? Open a ticket.",
    }, "\n")
    kickPlayer(msg)
end

local hwid = getHWID()

local httpFn
for _, name in ipairs({"syn","request","http_request","fluxus_request","http","https"}) do
    local ok, fn = pcall(function()
        local v
        if getfenv then v = getfenv(0)[name] end
        if not v then v = rawget(_G, name) end
        if type(v) == "table" and type(v.request) == "function" then return v.request end
        if type(v) == "function" then return v end
    end)
    if ok and fn then httpFn = fn; break end
end

if not httpFn then
    kickPlayer("[ kamidere ] Executor not supported.\nJoin: " .. DISCORD)
end

-- verify key
local ok, response = pcall(function()
    return httpFn({
        Url     = API_VERIFY,
        Method  = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body    = HttpService:JSONEncode({ key = KEY, hwid = hwid }),
    })
end)

if not ok or not response then
    kickPlayer("[ kamidere ] API unreachable. Try again.\nJoin: " .. DISCORD)
end

local parseOk, body = pcall(function() return HttpService:JSONDecode(response.Body) end)
if not parseOk or not body then
    kickPlayer("[ kamidere ] Bad API response.\nJoin: " .. DISCORD)
end

if not body.valid then
    if body.reason == "blacklisted" then
        kickPlayer("[ kamidere ] You are blacklisted.\nAppeal: " .. DISCORD)
    elseif body.reason == "frozen" then
        kickPlayer("[ kamidere ] Key frozen. Contact support: " .. DISCORD)
    elseif body.reason == "hwid_mismatch" then
        kickPlayer("[ kamidere ] HWID mismatch.\nReset your HWID in Discord → Reset HWID")
    elseif body.reason == "expired" then
        kickPlayer("[ kamidere ] Free key expired.\nGet a new one at: " .. DISCORD)
    else
        kickPlayer("[ kamidere ] Invalid key.\nGet one free at: " .. DISCORD)
    end
end

-- save key locally so user doesn't have to paste it every time
pcall(function()
    if writefile then writefile("kamidere_key.txt", KEY) end
end)

-- fetch and execute script
local ok2, scriptSrc = pcall(function()
    return httpFn({ Url = API_SCRIPT .. "?key=" .. KEY .. "&hwid=" .. hwid, Method = "GET" })
end)

if not ok2 or not scriptSrc or not scriptSrc.Body or #scriptSrc.Body < 10 then
    kickPlayer("[ kamidere ] Failed to load script.\nJoin: " .. DISCORD)
end

loadstring(scriptSrc.Body)()
