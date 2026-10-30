-- kamidere loader

local KEY = (getgenv and getgenv().KAMI_KEY) or rawget(_G, "KAMI_KEY") or "KAMI-XXXX-XXXX-XXXX"
local API = "https://kamidere-api.fly.dev/verify"
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function kickPlayer(msg)
    local ok, _ = pcall(function()
        Players.LocalPlayer:Kick(msg)
    end)
    if not ok then error(msg, 0) end
    task.wait(999)
end

local function getHWID()
    local ok1, id = pcall(function()
        return tostring(game:GetService("RbxAnalyticsService"):GetClientId())
    end)
    if ok1 and id and id ~= "" then return id end
    local ok2, ex = pcall(function() return identifyexecutor() end)
    if ok2 and ex then return ex end
    return tostring(game.PlaceId) .. tostring(Players.LocalPlayer.UserId)
end

local hwid = getHWID()
print("[kami] key=" .. tostring(KEY) .. " hwid=" .. tostring(hwid))

local httpFn
local _foundName = nil
local _candidates = {"syn", "request", "http_request", "fluxus_request", "http", "https"}
for _, name in ipairs(_candidates) do
    local ok, fn = pcall(function()
        -- try getfenv(0), then _G, then rawget
        local v
        if getfenv then
            v = getfenv(0)[name]
        end
        if not v then v = rawget(_G, name) end
        if type(v) == "table" and type(v.request) == "function" then return v.request end
        if type(v) == "function" then return v end
    end)
    if ok and fn then httpFn = fn _foundName = name break end
end

if not httpFn then
    kickPlayer("[KAMI DBG] No HTTP function found. Executor: " .. tostring(identifyexecutor and identifyexecutor() or "unknown"))
end

local ok, response = pcall(function()
    return httpFn({
        Url     = API,
        Method  = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body    = HttpService:JSONEncode({ key = KEY, hwid = hwid }),
    })
end)

if not ok or not response then
    kickPlayer("[KAMI DBG] HTTP request failed. err=" .. tostring(response))
end

local parseOk, body = pcall(function() return HttpService:JSONDecode(response.Body) end)
if not parseOk or not body then
    kickPlayer("[KAMI DBG] Parse error. raw=" .. tostring(response.Body):sub(1, 80))
end

if not body.valid then
    if body.reason == "blacklisted" then
        kickPlayer("YOU ARE BLACKLISTED!\n        KSY NIGGA")
    elseif body.reason == "frozen" then
        kickPlayer("Your key has been frozen.\nContact support: discord.gg/kamidere")
    elseif body.reason == "hwid_mismatch" then
        kickPlayer("HWID Mismatch please reset your HWID!")
    else
        kickPlayer("[KAMI DBG] verify failed. reason=" .. tostring(body.reason) .. " key=" .. tostring(KEY):sub(1,12))
    end
end

local scriptUrl = "https://kamidere-api.fly.dev/script?key=" .. KEY .. "&hwid=" .. hwid
local ok2, scriptSrc = pcall(function() return httpFn({ Url = scriptUrl, Method = "GET" }) end)
if not ok2 or not scriptSrc or not scriptSrc.Body or scriptSrc.Body:sub(1,2) == "--" then
    kickPlayer("[KAMI DBG] script fetch failed. ok=" .. tostring(ok2) .. " body=" .. tostring(scriptSrc and scriptSrc.Body and scriptSrc.Body:sub(1,40) or "nil"))
end
loadstring(scriptSrc.Body)()
