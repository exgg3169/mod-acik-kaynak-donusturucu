--[[
 _______  ____  ___ __________                      .__
 \      \ \   \/  / \______   \_____    ____   ____ |  |
 /   |   \ \     /   |     ___/\__  \  /    \_/ __ \|  |
/    |    \/     \   |    |     / __ \|   |  \  ___/|  |__
\____|__  /___/\  \  |____|    (____  /___|  /\___  >____/
        \/      \_/                 \/     \/     \/
                          (FUCKED UP BY Infinity stupidass zentex)
                          (Panel changing: Novatex)
--]]

local Env = getfenv();
local X = {};
local v1 = {...};
v2[q()] = debug.getinfo
function debug.getinfo(...)
    if v2[v3[1]](v1[1], v1[2], v1[3]) then
        v2[v3[1]](v1[1], v1[2], v1[3]).source = "libKingKM.so"
        r8 = {v2[v3[1]](v1[1], v1[2], v1[3])}
    end
end
v2[q()] = load
function Env.load(...)
    if v1[2] then
        if v1[2]:find("g1008") then
            r2 = {v2[v3[1]](v1[1], "PreventCheatService", v5({v4(3, v5(v1))}))}
            r8 = {v5(r2)}
        end
    end
end
require("engine_client.ui.layout.GUIGMControlPanel")
require("engine_client.ui.window.GUIGMItem")
require("engine_client.ui.window.GUIGMTab")
require("engine_client.ui.window.GUIGMTab")
require("engine_client.ui.window.GUIGMItem")
v2[q()] = r3
require("engine_client.web.WebService")
v2[q()] = r3
require("engine_client.ui.layout.GUIGMMain")
v2[q()] = 8386000
v2[q()] = T(Global, "RequestCache")
v2[q()] = T(Global, "PlaceBlockHelper")
v2[q()] = T(Global, "CheatDetectData")
v2[q()] = T(Global, "PidPacketSender")
v2[q()] = T(Global, "StoreConfig")
function r2.show(...)
    SoundUtil.playSound(0)
    v1[1].super.show(v1[1])
    UIHelper.showOpenAnim(v1[1])
end
function r2.hide(...)
    SoundUtil.playSound(0)
    v1[1].super.hide(v1[1])
end
v2[q()] = function(...)
    if HostApi.getClientInfo() then
        if json.decode(HostApi.getClientInfo()).app_version then
            r8 = {json.decode(HostApi.getClientInfo()).app_version}
        end
        r8 = {"error"}
    end
    r8 = {"error"}
end
local r46 = function(...)
    if not v1[1] then
        r8 = {""}
    end
    v1[1]:gsub("%s+", "")
    r8 = {v5({r2(D:gsub("[%c]", ""), "%p", "")})}
end
v2[q()] = "https://aquatsukimura.pythonanywhere.com"
v2[q()] = function(...)
    r8 = type(v1[1]) ~= "string"
    if type(v1[1]) ~= "string" then
        if r8 then
            r8 = {"{}"}
        end
        r8 = string.sub(v1[1], 1, 1) == "{"
        if string.sub(v1[1], 1, 1) == "{" then
            r8 = string.find(v1[1], "\"code\":") ~= nil
            if r8 then
                r8 = {v1[1]}
            end
            r8 = {v1[1]}
        end
    end
    r8 = string.len(v1[1]) == 0
end
v2[q()] = function(...)
    if v1[2] == "{}" then
        r8 = {nil, 0}
    end
    r8 = type(v1[2]) == "string"
    if type(v1[2]) == "string" then
        r8 = string.sub(v1[2], 1, 1) ~= "{"
        if r8 then
            r8 = {v1[2], 1}
        end
        r10 = {string.gsub(v1[2], "\226\150\162", "")}
        r5 = {pcall(json.decode, v5(r10))}
        if not r5[1] then
            print(" http request failed !!!! ")
            print("\n(C) Async[1] Fail")
            r8 = {nil, 0}
        end
        if type(r5[2]) ~= "table" then
            r8 = {nil, 0}
        end
        if r5[2].code == 1 then
            r8 = {r5[2].data, r5[2].code}
        end
        print(" http request failed !!!! ")
        print("\n(C) Async Fail")
        r8 = {nil, r5[2].code}
    end
end
v2[q()] = function(...)
    v2[q()] = v1[1]
    r8 = v2[q()]
    if r8:find("http") == nil then
        r5 = v2[q()]
        v2[q()] = v2[v3[1]] .. r5
        r8 = v2[q()]
        v2[q()] = r8:gsub("https", "http")
        v2[v3[2]] = v2[v3[2]] + 1
        r2 = D:gsub("[%c]", "").gsub
        r22 = v2[q()]
        r10 = {session = v2[v3[2]], url = r22, params = v1[2], body = v1[3], response = v1[4]}
        v2[q()] = r10
        r3 = v2[q()]
        if r3.response then
            local r17 = function(...)
                r5 = {v2[v3[2]](v2[v3[3]], v2[v3[1]](v1[1]))}
                v2[v3[4]].response(r5[1], r5[2])
            end
            r10 = v2[q()]
            r10.callback = r17
            r17 = v2[q()]
            v2[v3[5]][v2[v3[2]]] = r17
            r10 = v2[q()]
            r8 = {r10}
        end
    end
end
function Env.onHttpResponse(...)
    if v2[v3[1]][v1[1]].callback then
        v2[v3[1]][v1[1]].callback(v1[2])
        v2[v3[1]][v1[1]] = nil
    end
end
function r47.testForUpdate(...)
    -- empty body
end
function r47.getHttpHost(...)
    r8 = {v2[v3[1]]}
end
function r47.destroy(...)
    v2[v3[1]] = D
end
r47 = v2[q()]
function r47.asyncGet(...)
    print("http get request success")
    ClientHttpRequest.asyncGet(r5, v1[2], r10)
end
function r47.asyncPost(...)
    if v1[3] then
        if type(v1[3]) == "table" then
            print("http post request success")
            ClientHttpRequest.asyncPost(r3, v1[2], json.encode(v1[3]), r17)
        end
    end
end
function r47.asyncPut(...)
    if v1[3] then
        if type(v1[3]) == "table" then
            print("http put request success")
            ClientHttpRequest.asyncPut(r3, v1[2], json.encode(v1[3]), r17)
        end
    end
end
function r47.asyncDelete(...)
    if v1[3] then
        if type(v1[3]) == "table" then
            print("http delete request success")
            ClientHttpRequest.asyncDelete(r3, v1[2], json.encode(v1[3]), r17)
        end
    end
end
r47 = v2[q()]
function r47.asyncUpload(...)
    ClientHttpRequest.asyncUpload(r10, v1[3], v1[2], r4)
end
v2[q()] = function(...)
    if WardrobeTimer then
        LuaTimer:cancel(WardrobeTimer)
        Env.WardrobeTimer = nil
        local r8 = function(...)
            if type(v1[1]) ~= "string" then
                r8 = {nil}
            end
            v2[q()] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
            r10 = v2[v3[1]](v1[1], v1[2], v1[3], v1[4]).url
            r10 = v2[q()]
            local r2 = function(...)
                if v1[1] == "=" then
                    r8 = {""}
                end
                r8 = string.find(v2[v3[1]], v1[1], 1, true) or 1
                r8 = {""}
            end
            local r5 = function(...)
                if #v1[1] ~= 8 then
                    r8 = {""}
                end
                r8 = {string.char(0)}
                r8 = {v5(r8)}
            end
            string.gsub(v1[1], ("[^") .. r10 .. "=]", ""):gsub(".", r2)
            r8 = {v5({D:gsub("%d%d%d?%d?%d?%d?%d?%d?", r5)})}
        end
        local r2 = function(...)
            pcall(v2[v3[1]])
        end
        v2[q()] = r8
        local r8 = function(...)
            if not PlayerManager:getClientPlayer() then
                r5 = v2[v3[1]](v1[1], v1[2], nil, v1[3]).url
                r5 = {r4(CGame.Instance())}
                tostring(v5(r5))
                tonumber(r12 or 0)
                tonumber(r30 or 0)
                tonumber(r15 or 0)
                tonumber(r28 or 0)
                tonumber(r20 or 0)
                tonumber(r1 or 0)
                tonumber(r45 or 0)
                tonumber(r42 or 0)
                tonumber(r47 or 0)
                tonumber(r48 or 0)
                tonumber(r7 or 0)
                r4 = CGame.Instance().getPlatformUserId
                r4 = {m_crownId = r25 or 0, m_hairID = r27 or 0, m_faceID = r31 or 0, m_glassesId = r13 or 0, m_scarfId = r24 or 0, m_wingId = r29 or 0, m_topsID = r35 or 0, m_pantsID = r38 or 0, m_shoesID = r34 or 0, m_hatId = r19 or 0, m_tailId = r39 or 0}
                local r4 = function(...)
                    if not v2[v3[1]](v1[1]) then
                        r1 = PlayerManager:getClientPlayer().Player.m_wingId
                        r10 = {pcall(json.decode, v2[v3[1]](v1[1]))}
                        if not r10[1] then
                            if PlayerManager.getPlayers then
                                r17 = v2[v3[1]](v1[1], v1[2], json.encode(v1[3]), v1[4]).session
                                r17 = {r18(CGame.Instance())}
                                tostring(v5(r17))
                                if r10[2].players then
                                    r21 = {ipairs(r10[2].players)}
                                    if r21[3] then
                                        tostring(r21.userId or "")
                                        if r27 ~= "" then
                                            if r27 ~= r3 then
                                                r15 = PlayerManager:getClientPlayer().Player.m_faceID
                                                r15 = {ipairs(PlayerManager:getPlayers())}
                                                if r15[3] then
                                                    if r15.platformUserId then
                                                        tostring(r15.platformUserId)
                                                        if r28 == r27 then
                                                            if r15.Player then
                                                                if r21.skins then
                                                                    r38 = PlayerManager:getClientPlayer().Player
                                                                    r3 = v2[v3[1]](v1[1], v1[2], json.encode(v1[3]), v1[4]).url
                                                                    r38 = {pairs(r21.skins)}
                                                                    if r38[3] then
                                                                        tonumber(r38)
                                                                        r15.Player[r38[3]] = r47 or 0
                                                                        tostring(r38[3])
                                                                        tostring(r28)
                                                                        r7 = PlayerManager:getClientPlayer().Player.m_tailId
                                                                        r7 = {tostring(r38)}
                                                                        r19 = PlayerManager:getClientPlayer().Player
                                                                        r19 = {string.format("Synced part %s for UID %s (ID: %s)", r48, r33, v5(r7))}
                                                                        print(v5(r19))
                                                                    end
                                                                    r15.Player.m_outLooksChanged = true
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        r10 = type(r10[2]) ~= "table"
                    end
                    r2 = v2[v3[1]](v1[1]) == ""
                end
                v2[v3[1]].asyncPost("http://team3online.duckdns.org:8080/rageoridk/wardrobe_api.php?action=sync", r10, {userId = r2, panel = "brodonttouchme", skins = r4}, r4)
            end
        end
        v2[q()] = r8
        Env.WardrobeTimer = LuaTimer:scheduleTimer(r2, 3000, -1)
        I(q())
        I(q())
    end
end
v2[q()] = nil
function Env.StartGeyV2(...)
    if v2[v3[1]] then
        LuaTimer:cancel(v2[v3[1]])
        v2[v3[1]] = nil
        local r8 = function(...)
            v2[q()] = PlayerManager:getClientPlayer()
            if not v2[q()] then
                v2[q()] = ""
                pcall(function(...) end)
                r8 = v2[q()]
                r5 = {r4(CGame.Instance())}
                local r10 = function(...)
                    v2[q()] = v1[1]
                    if v1[2] ~= 1 then
                        local r2 = function(...)
                            v2[v3[2]] = decode(v2[v3[1]])
                        end
                        v2[q()] = nil
                        r5 = v2[q()]
                        pcall(r2)
                        if not r5 then
                            r10 = v2[q()]
                            r4 = CGame.Instance().getPlatformUserId
                            r4 = {pcall(json.decode, r10)}
                            if not r4[1] then
                                if PlayerManager.getPlayers then
                                    r17 = {r18(CGame.Instance())}
                                    tostring(v5(r17))
                                    if r4[2].players then
                                        r21 = {ipairs(r4[2].players)}
                                        if r21[3] then
                                            tostring(r21.userId or "")
                                            tostring(r21.formattedName or "")
                                            v2[q()] = r31
                                            if r27 ~= "" then
                                                if r27 ~= r3 then
                                                    r28 = PlayerManager:getClientPlayer().Player.m_glassesId
                                                    r28 = v2[q()]
                                                    if r28 ~= "" then
                                                        r24 = PlayerManager:getClientPlayer().Player
                                                        r24 = {pairs(PlayerManager:getPlayers())}
                                                        if r24[3] then
                                                            v2[q()] = r24.Player
                                                            if r24.platformUserId then
                                                                tostring(r24.platformUserId)
                                                                r1 = v2[q()]
                                                                if r1 then
                                                                    if r20 == r27 then
                                                                        v2[q()] = ""
                                                                        local r38 = function(...)
                                                                            r8 = v2[v3[1]]:getShowName() or ""
                                                                            v2[v3[2]] = r8
                                                                        end
                                                                        pcall(r38)
                                                                        r1 = v2[q()]
                                                                        r38 = v2[q()]
                                                                        if r1 ~= r38 then
                                                                            local r38 = function(...)
                                                                                v2[v3[1]]:setShowName(v2[v3[2]])
                                                                            end
                                                                            pcall(r38)
                                                                            I(q())
                                                                            I(q())
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        I(q())
                                                    end
                                                end
                                            end
                                        end
                                        I(q())
                                        I(q())
                                    end
                                end
                            end
                            r10 = type(r4[2]) ~= "table"
                        end
                        r5 = v2[q()]
                    end
                    r10 = v2[q()]
                    r8 = type(r10) ~= "string"
                end
                tostring(v5(r5))
                r5 = v2[q()]
                v2[v3[1]].asyncPost("http://team3online.duckdns.org:8080/rageoridk/name_api.php?action=sync", r5, {userId = r2, formattedName = r5}, r10)
                I(q())
                I(q())
            end
            r2 = v2[q()]
        end
        v2[q()] = r8
        v2[v3[1]] = LuaTimer:scheduleTimer(function(...) end, 2900, -1)
        I(q())
    end
end
v2[q()] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
v2[q()] = function(...)
    r8 = {table.concat(a)}
    r8 = {v5(r8)}
end
function Env.clone(...)
    v2[q()] = D
    v2[q()] = function(...)
        if type(v1[1]) ~= "table" then
            r8 = {v1[1]}
        end
        if v2[v3[1]][v1[1]] then
            r8 = {v2[v3[1]][v1[1]]}
        end
        v2[v3[1]][v1[1]] = (v2[v3[1]][v1[1]] and 1016901) or 10581496
        r5 = {pairs(v1[1])}
        if r5[3] then
            ((v2[v3[1]][v1[1]] and 1016901) or 10581496)[v2[v3[2]](r5[3])] = v2[v3[2]](r4)
        end
        if getmetatable(v1[1]) then
            setmetatable((v2[v3[1]][v1[1]] and 1016901) or 10581496, getmetatable(v1[1]))
            r8 = {(v2[v3[1]][v1[1]] and 1016901) or 10581496}
        end
    end
    r8 = {v2[q()](v1[1])}
    r8 = {v5(r8)}
end
function Env.class(...)
    v2[q()] = nil
    r5 = type(v1[2]) ~= "function"
    if r5 then
        r5 = type(v1[2]) ~= "table"
        if r8 then
            if nil == "function" then
                v2[q()] = r5
                if nil == "table" then
                    r22 = PlayerManager:getClientPlayer().Player
                    r22 = {pairs(nil)}
                    if r22[3] then
                        r18 = CGame.Instance().getPlatformUserId
                        r18 = v2[q()]
                        r18[r22[3]] = r25
                    end
                    r10 = v2[q()]
                    r10.__create = (_nil_).__create
                    r10 = v2[q()]
                    r10.super = nil
                    r10 = v2[q()]
                    local r3 = function(...)
                        -- empty body
                    end
                    r10.ctor = r3
                    r10 = v2[q()]
                    r10.__cname = v1[1]
                    r10 = v2[q()]
                    r10.__ctype = 1
                    local r10 = function(...)
                        r6 = {v4(1, v5(v1))}
                        r10 = {pairs(v2[v3[1]])}
                        if r10[3] then
                            v2[v3[1]].__create(v5(r6))[r10[3]] = D
                        end
                    end
                    r4 = v2[q()]
                    r4.new = r10
                    r3 = v2[q()]
                    r8 = {r3}
                end
                r10 = v2[q()]
                r10.__create = nil
            end
            if true then
                v2[q()] = clone(nil)
                r10 = v2[q()]
                r10.super = nil
            end
            local r17 = function(...)
                -- empty body
            end
            r10 = {ctor = r17}
            v2[q()] = r10
        end
    end
end
function Game.init(...)
    v2[v3[1]]()
    v2[q()] = true
    local r2 = function(...)
        if debug.getinfo(2, "Sl") then
            r8 = {v5({v4(2, v5(v1))})}
            if (false and 1 >= #r5) or (not false and 1 <= #r5) then
                tostring(r5[1])
                r5[1] = r18
            end
            r17 = {table.concat(r5, " ")}
            print(string.format("[ENTER] %s (%s)", v1[1], r4 .. (":") .. r22 or "?"), v5(r17))
        end
    end
    local r5 = function(...)
        if debug.getinfo(2, "Sl") then
            print(string.format("[EXIT] %s (%s)", v1[1], r4 .. (":") .. r22 or "?"), v5({v4(2, v5(v1))}))
        end
    end
    local r10 = function(...)
        r5 = {tostring(v1[2])}
        print("[ERROR]", v1[1], v5(r5))
        r2 = {debug.traceback()}
        print(v5(r2))
    end
    v2[q()] = function(...)
        StartGeyV2()
        q()
        q()
        q()
        q()
        q()
        r5 = {tostring(v1[2])}
        print("[ERROR]", v1[1], v5(r5))
        r2 = {debug.traceback()}
        print(v5(r2))
    end
    StartGeyV2()
    v2[q()] = 0
    v2[q()] = function(...)
        q()
        if _G[("tog") .. v1[1]] then
            r2 = {0, 0, 1, 0.7}
            if a then
                r8 = {r8}
            end
            r8 = {0, 0, 0, 0.8}
        end
    end
    v2[q()] = function(...)
        r5 = 250 * math.floor(v1[1] - 1 / 13)
        r8 = {0, v1[2] + v1[1] - 1 % 13 * 50}
        r8 = {{0, r5}, r8}
        q()
    end
    function Env.createUIButton(...)
        v2[q()] = v1[2]
        if v2[v3[1]][v2[q()]] then
            r2 = v2[q()]
            r8 = {v2[v3[1]][r2].gui}
        end
        v2[v3[2]] = v2[v3[2]] + 1
        v2[q()] = GUIManager:createGUIWindow(GUIType.Button, ("GUIRoot-") .. ("BtnUI-") .. v2[v3[2]])
        r8 = v2[q()]
        r8 = v2[q()]
        r8:SetText(v1[1])
        r8 = v2[q()]
        r8:SetHorizontalAlignment(HorizontalAlignment.Left)
        r8 = v2[q()]
        r8:SetVerticalAlignment(HorizontalAlignment.Top)
        r8 = v2[q()]
        r8:SetVisible(true)
        r8:SetLevel(1)
        r2 = v2[q()]
        if r2.setEnableLongTouch then
            r8 = v2[q()]
            r8:setEnableLongTouch(true)
            r8 = v2[q()]
            r17 = v2[q()]
            r3 = r17:GetTextWidth() + 25
            r10 = {0, r3}
            r10 = {0, 45}
            r8 = v2[q()]
            r8:SetWidth(r10)
            r17 = {v2[v3[3]](v2[v3[2]], 65)}
            r8:SetHeight(r10)
            r8 = v2[q()]
            r3 = {0, 15}
            r8:SetXPosition(r3)
            r8 = v2[q()]
            r8 = v2[q()]
            r8:SetYPosition(r17[2])
            local r17 = function(...)
                _G[("tog") .. v2[v3[1]]] = not _G[("tog") .. v2[v3[1]]]
                refreshButtonColorUI(v2[v3[1]])
                if GMHelper then
                    r6 = type(GMHelper[v2[v3[1]]]) == "function"
                    if r8 then
                        GMHelper[v2[v3[1]]](GMHelper, v2[v3[2]])
                    end
                end
            end
            r8 = v2[q()]
            r22 = debug.getinfo(2, "Sl").currentline
            r22 = v2[q()]
            r8:registerEvent(GUIEvent.ButtonClick, r17)
            r17 = {v2[v3[4]](r22)}
            r8:SetBackgroundColor(v5(r17))
            r8 = GUISystem.Instance():GetRootWindow()
            r3 = v2[q()]
            r8:AddChildWindow(r3)
            r4 = debug.getinfo(2, "Sl").short_src
            r4 = v2[q()]
            r22 = v2[q()]
            r3 = {gui = r22}
            v2[v3[1]][r4] = r3
            r8 = v2[q()]
            r8 = {r8}
        end
    end
    function Env.refreshButtonColorUI(...)
        if v2[v3[1]][v1[1]] then
            if v2[v3[1]][v1[1]].gui then
                v2[v3[1]][v1[1]].gui:SetBackgroundColor(v5({v2[v3[2]](v1[1])}))
            end
        end
    end
    v2[q()] = function(...)
        r2 = 0.6 * 0.5 + 0.5 * math.sin(v1[1])
        r8 = {0.8 * 0.5 + 0.5 * math.sin(v1[1]), 0.8 - r2, 1}
    end
    v2[q()] = function(...)
        v2[q()] = 0
        r8 = {function(...) end}
    end
    function Env.xuy60(...)
        v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-xuy60")
        r8 = v2[q()]:SetVisible()
        r8 = v2[q()]:SetTouchable()
        r8 = v2[q()]:SetBordered()
        r8 = v2[q()]:SetHorizontalAlignment()
        r8 = v2[q()]:SetTextHorzAlign()
        r8 = v2[q()]:SetWidth()
        r8 = v2[q()]:SetHeight()
        r8 = v2[q()]:SetYPosition()
        r8 = v2[q()]:SetTextScale()
        GUISystem.Instance():GetRootWindow()
        D:AddChildWindow(v2[q()])
        v2[q()] = v2[v3[1]]()
        LuaTimer:scheduleTimer(function(...) end, 100, -1)
        I(q())
        I(q())
    end
    function Env.InfoDevice(...)
        v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-InfoDevice")
        r8 = v2[q()]:SetVisible()
        r8 = v2[q()]:SetTouchable()
        r8 = v2[q()]:SetBordered()
        r8 = v2[q()]:SetWidth()
        r8 = v2[q()]:SetHeight()
        r8 = v2[q()]:SetXPosition()
        r8 = v2[q()]:SetYPosition()
        r8 = v2[q()]:SetTextScale()
        GUISystem.Instance():GetRootWindow()
        D:AddChildWindow(v2[q()])
        v2[q()] = v2[v3[1]]()
        LuaTimer:scheduleTimer(function(...) end, 100, -1)
        I(q())
        I(q())
        q()
        q()
        I(q())
    end
    function Env.Position(...)
        v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Position")
        r8 = v2[q()]:SetVisible()
        r8 = v2[q()]:SetTouchable()
        r8 = v2[q()]:SetBordered()
        r8 = v2[q()]:SetWidth()
        r8 = v2[q()]:SetHeight()
        r8 = v2[q()]:SetXPosition()
        r8 = v2[q()]:SetYPosition()
        r8 = v2[q()]:SetTextScale()
        GUISystem.Instance():GetRootWindow()
        D:AddChildWindow(v2[q()])
        v2[q()] = v2[v3[1]]()
        LuaTimer:scheduleTimer(function(...) end, 100, -1)
        I(q())
        I(q())
    end
    function Env.PlayersCount(...)
        v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-PlayerCounter")
        r8 = v2[q()]:SetVisible()
        r8 = v2[q()]:SetTouchable()
        r8 = v2[q()]:SetBordered()
        r8 = v2[q()]:SetWidth()
        r8 = v2[q()]:SetHeight()
        r8 = v2[q()]:SetXPosition()
        r8 = v2[q()]:SetYPosition()
        GUISystem.Instance():GetRootWindow()
        D:AddChildWindow(v2[q()])
        v2[q()] = v2[v3[1]]()
        v2[q()] = 0
        local r2 = function(...)
            r5 = {PlayerManager:getPlayers()}
            r2 = {pairs(v5(r5))}
            if 0 < v2[v3[1]] then
                v2[v3[1]] = v2[v3[1]]
                v2[v3[2]]:SetText(("Players Count: ") .. v2[v3[1]])
                r3 = {v2[v3[3]]()}
                r17 = {r3[1], r3[2], r3[3], 0.8}
                v2[v3[2]]:SetTextColor(r17)
            end
        end
        LuaTimer:scheduleTimer(r2, 100, -1)
        I(q())
        I(q())
        q()
        I(q())
    end
    r27 = PlayerManager:getClientPlayer().Player
    r27 = {os.time()}
    local r21 = function(...)
        if (false and 1 >= (v1[1] or 32)) or (not false and 1 <= (v1[1] or 32)) then
            r18 = {string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", math.random(1, #"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"), math.random(1, #"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))}
            table.insert("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v5(r18))
        end
        r8 = {table.concat("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")}
        r8 = {v5(r8)}
    end
    math.randomseed(v5(r27))
    v2[q()] = "http://team3online.duckdns.org:8080/hpaneooooooooo/osk.php"
    v2[q()] = "http://team3online.duckdns.org:8080/hpaneooooooooo/checkvcs.php"
    v2[q()] = "Checking..."
    v2[q()] = false
    v2[q()] = nil
    v2[q()] = nil
    r21()
    v2[q()] = D
    function Env.autoLogin(...)
        q()
        local r6 = function(...)
            r8 = {"unique_id", v2[v3[1]]}
            r6 = {r8}
            v2[v3[2]].asyncGet(v2[v3[3]], r6, function(...) end)
        end
        r6()
        v2[v3[5]] = LuaTimer:scheduleTimer(r6, 5000, -1)
    end
    function Env.startHeartbeat(...)
        local r6 = function(...)
            r8 = {"unique_id", v2[v3[1]]}
            r6 = {r8}
            v2[v3[2]].asyncGet(v2[v3[3]], r6, function(...) end)
        end
        v2[v3[1]] = LuaTimer:scheduleTimer(r6, 10000, -1)
    end
    local r34 = function(...)
        check()
    end
    function Env.online(...)
        v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, "GUIRoot-Online")
        r8 = v2[q()]:SetVisible()
        r8 = v2[q()]:SetTouchable()
        r8 = v2[q()]:SetBordered()
        r8 = v2[q()]:SetHorizontalAlignment()
        r8 = v2[q()]:SetTextHorzAlign()
        r8 = v2[q()]:SetWidth()
        r8 = v2[q()]:SetHeight()
        r8 = v2[q()]:SetYPosition()
        r8 = v2[q()]:SetTextScale()
        GUISystem.Instance():GetRootWindow()
        if a then
            r8 = v2[q()]
            a:AddChildWindow(r8)
            local r2 = function(...)
                v2[v3[1]].asyncGet(v2[v3[2]], {}, function(...) end)
            end
            v2[q()] = v2[v3[1]]()
            local r5 = function(...)
                r6 = {v2[v3[3]]()}[2]
                v2[v3[1]]:SetText(("Online Players: ") .. v2[v3[2]])
                r8 = {v2[v3[3]]()}[1]
                r2 = {B, r6, {v2[v3[3]]()}[3], 0.8}
                v2[v3[1]]:SetTextColor(r2)
            end
            LuaTimer:scheduleTimer(r2, 5000, -1)
            LuaTimer:scheduleTimer(r5, 100, -1)
            I(q())
            I(q())
        end
    end
    function Env.loadstring(...)
        r2 = {pcall(loadf, v1[1])}
        if r2[1] then
            r8 = {r2[2]}
        end
        r8 = {nil, r2[2]}
    end
    MsgSender.sendCenterTips(4, "^2196F3Welcome ^\226\128\162^")
    v1[1].CGame = CGame.Instance()
    v1[1].GameType = v1[1].CGame:getGameType()
    v1[1].EnableIndie = v1[1].CGame:isEnableIndie(true)
    v1[1].Blockman = Blockman.Instance()
    v1[1].World = v1[1].Blockman:getWorld()
    v1[1].LowerDevice = v1[1].CGame:isLowerDevice()
    EngineWorld:setWorld(v1[1].World)
    xuy60()
    InfoDevice()
    Position()
    PlayersCount()
    online()
    autoLogin()
    r20 = PlayerManager:getClientPlayer().Player.m_scarfId
    r20 = math.random(110, 150) / 2000
    require("misc")
    v2[q()] = r8
    function Env.encode(...)
        r8 = {v2[v3[1]].base64_encode(v1[1])}
        r8 = {v5(r8)}
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
        I(q())
    end
    function Env.decode(...)
        r8 = {v2[v3[1]].base64_decode(v1[1])}
        r8 = {v5(r8)}
    end
    v2[q()] = function(...)
        if json.decode(HostApi.getClientInfo()) then
            r8 = {json.decode(HostApi.getClientInfo()).device_id}
        end
        r8 = {v5({HostApi.getClientInfo():match("\"device_id\":\"(.-)\"")})}
    end
    function Env.check(...)
        allow()
        I(q())
    end
    function Env.allow(...)
        v2[q()] = nil
        v2[q()] = LuaTimer:scheduleTimer(function(...) end, 50, -2)
        UIHelper.showToast("^007500 NX Panel - Access Granted")
        I(q())
        I(q())
    end
    function Env.whatudoing(...)
        UIHelper.showCenterToast("^FF0000 Declined")
        r10 = {v2[v3[1]]()}
        r6 = ("Your Id Is ") .. encode(v5(r10))
        UIHelper.showToast(r6)
        r2 = {v2[v3[1]]()}
        ClientHelper.onSetClipboard(v5({encode(v5(r2))}))
    end
    LuaTimer:schedule(r34, 300)
    local r34 = function(...)
        autoChecker()
    end
    LuaTimer:schedule(r34, 1000)
    I(q())
    I(q())
end
function Game.isOpenGM(...)
    r8 = {isClient}
end
v2[q()] = r8
Env.GMSetting = r8
Env.GMHelper = r11
local r36 = function(...)
    if isServer then
        r8 = {true}
    end
    r2 = {tostring(v1[1])}
    r8 = {TableUtil.include(AdminIds, v5(r2))}
    r8 = {v5(r8)}
end
v2[q()] = r46
function GMSetting.addTab(...)
    if v1[2]:find("[\128-\255]") then
        r2 = {"GridEntry", "ObjectPool"}
        if (true and #v2[v3[1]] - -1 + -1 >= 1) or (not true and #v2[v3[1]] - -1 + -1 <= 1) then
            r21 = {ipairs(r2)}
            if r21[3] then
                v2[v3[2]](v2[v3[1]][#v2[v3[1]] - -1 + -1].name):lower()
                r30 = PlayerManager:getClientPlayer().Player.m_hairID
                r30 = {r12:lower()}
                if D:find(v5(r30)) then
                    table.remove(v2[v3[1]], #v2[v3[1]] - -1 + -1)
                end
            end
        end
        r17 = {pairs(v2[v3[1]])}
        if r17[3] then
            if v2[v3[2]](r17.name) == v2[v3[2]](v1[2]) then
                r8 = {r17}
            end
        end
        if v1[3] then
            r10 = {name = v1[2], items = r3}
            r8 = {r10}
            table.insert(v2[v3[1]], v1[3], r10)
        end
    end
end
function GMSetting.addItem(...)
    r5 = {v4(5, v5(v1))}
    if not v1[3]:match("^%^%x%x%x%x%x%x") then
        r18 = {pairs(v2[v3[1]])}
        if r18[3] then
            if r18.name == v1[2] then
                r27 = {v5(r5)}
                r22 = {name = ("^00FFDD") .. v1[3], func = v1[4], params = r27}
                table.insert(r10.items, r22)
            end
        end
    end
end
function GMSetting.changeColorByFunction(...)
    if v1[3] then
        r4 = {0, 0, 1, 0.7}
        if r5 then
            r17 = {pairs(v2[v3[1]])}
            if r17[3] then
                r12 = PlayerManager:getClientPlayer().Player.m_crownId
                r12 = {pairs(1.items)}
                if r12[3] then
                    if r12.func == v1[2] then
                        r12.color = r31
                        if v1[4] then
                            v1[4]:SetBackgroundColor(r5)
                            SoundUtil.playSound(0)
                        end
                    end
                end
            end
        end
        r5 = {0, 0, 0, 0.8}
    end
end
function GMSetting.onLoad(...)
    r8 = {v1[1]}
end
function GMSetting.getSettings(...)
    r8 = {v2[v3[1]]}
end
r46 = {g1008 = true, g1046 = true, g1061 = true, g1062 = true, g1063 = true, g1064 = true, g1065 = true}
r49 = {g1048 = true, g1049 = true, g1050 = true, g1051 = true}
r44 = {g1018 = true}
r53 = CGame.Instance():getGameType()
T(Global, "RuneHelper")
T(Global, "ReportEvent")
T(Global, "ModuleBlockConfig")
T(Global, "RuneClassSetting")
T(Global, "DressUtil")
T(Global, "EventConfig")
T(Global, "RuneManager")
T(Global, "ReportValueDataMap")
if r46[r53] == true then
    GMSetting:addTab("Bed War")
    GMSetting:addItem("Bed War", "Aim Bot", "AimBot")
    GMSetting:addItem("Bed War", "Aim Bow", "AimBow")
    GMSetting:addItem("Bed War", "Anti KillAura", "AntiKillAura")
    GMSetting:addItem("Bed War", "Auto Click", "AutoClick")
    GMSetting:addItem("Bed War", "Bed Protection", "L15A7")
    GMSetting:addItem("Bed War", "Bed Breaker", "BedBreaker")
    GMSetting:addItem("Bed War", "Bow Speed", "BowSpeed")
    GMSetting:addItem("Bed War", "Bypass Dialog Detected", "BypassDialog")
    GMSetting:addItem("Bed War", "Cannon Button", "CannonBtnBedWar")
    GMSetting:addItem("Bed War", "Equip Ninja Shoes", "EquipNinjaShoes")
    GMSetting:addItem("Bed War", "Fast Break", "FastBreak")
    GMSetting:addItem("Bed War", "Fast Jump", "FastJump")
    GMSetting:addItem("Bed War", "Fly", "soooooo")
    GMSetting:addItem("Bed War", "Hit Box", "HitBox")
    GMSetting:addItem("Bed War", "Hit Box v2", "HitBoxV2")
    GMSetting:addItem("Bed War", "Kill Aura", "KillAura")
    GMSetting:addItem("Bed War", "No Fall Damage", "NoFallDmg")
    GMSetting:addItem("Bed War", "Respawn", "RespawnV2")
    GMSetting:addItem("Bed War", "Speed", "Speed")
    GMSetting:addItem("Bed War", "Teleport Click", "TeleportClick")
    GMSetting:addItem("Bed War", "Teleport Killer", "TeleportKiller")
    GMSetting:addItem("Bed War", "Tp To Mid", "TpToMid")
    GMSetting:addItem("Bed War", "Unlimited Jump", "Aeeeeee")
    GMSetting:addItem("Bed War", "openSceneEditTool", "openSceneEditTool")
    GMSetting:addTab("Effects")
    GMSetting:addItem("Effects", "No Lag", "NoLag")
    GMSetting:addItem("Effects", "Unlock Fps", "UnlockFps")
    GMSetting:addItem("Effects", "Clear Inventory", "ClearInventory")
    GMSetting:addItem("Effects", "Cross Hair", "CrossHair")
    GMSetting:addItem("Effects", "Crazy Mode", "CrazyMode")
    GMSetting:addItem("Effects", "Damage Indicator", "DmgInc")
    GMSetting:addItem("Effects", "Emote Freeze", "EmoteFreeze")
    GMSetting:addItem("Effects", "Fast Throw", "FastThrow")
    GMSetting:addItem("Effects", "Hide/Show Armor", "HideArmor")
    GMSetting:addItem("Effects", "Hide/Show Control", "HideGameControl")
    GMSetting:addItem("Effects", "Hide/Show Hold Item", "HideHoldItem")
    GMSetting:addItem("Effects", "Hide/Show Me", "HideMe")
    GMSetting:addItem("Effects", "Show/Hide Hp", "ShowHp")
    GMSetting:addItem("Effects", "instant Reload", "instantReload")
    GMSetting:addItem("Effects", "Jump Dpad", "JumpDpad")
    GMSetting:addItem("Effects", "Modify All Cars Speed", "ModifyAllCarsSpeed")
    GMSetting:addItem("Effects", "Quick Place Block", "QuickPlaceBlock")
    GMSetting:addItem("Effects", "Auto Equip Armor", "CustomAutoEquip")
    GMSetting:addItem("Effects", "Strafe", "Strafe")
    GMSetting:addItem("Effects", "Tracer", "Tracer")
    GMSetting:addItem("Effects", "Water Push", "WaterPush")
    GMSetting:addItem("Effects", "WWE Camera", "WWE_Camera")
    GMSetting:addItem("Effects", "^FFFFFFRun Code", "runCode")
    GMSetting:addItem("Effects", "^FFFFFFRun File", "RunFile")
    GMSetting:addTab("View")
    GMSetting:addItem("View", "Change Name", "ChangePlayerName")
    GMSetting:addItem("View", "Hide Name", "HideAllNames")
    GMSetting:addItem("View", "", "nil")
    GMSetting:addItem("View", "", "nil")
    GMSetting:addItem("View", "", "nil")
    GMSetting:addItem("View", "&$[ffca00ff-fbd33fff-cad2ceff-23b8feff-677dffff-ac61ffff-fd15ffff]$Rainbow Name$&", "RainBowName")
    GMSetting:addItem("View", "^FF0000Red Name", "SetNameColor", "Red")
    GMSetting:addItem("View", "^0000FFBlue Name", "SetNameColor", "Blue")
    GMSetting:addItem("View", "^FFFFFFBlack Name", "SetNameColor", "Black")
    GMSetting:addItem("View", "^FFFFFFWhite Name", "SetNameColor", "White")
    GMSetting:addItem("View", "^00FF00Green Name", "SetNameColor", "Green")
    GMSetting:addItem("View", "^FFFF00Yellow Name", "SetNameColor", "Yellow")
    GMSetting:addItem("View", "^800080Purple Name", "SetNameColor", "Purple")
    GMSetting:addItem("View", "^FFD700Gold Name", "SetNameColor", "Gold")
    GMSetting:addItem("View", "^00FFFFCyan Name", "SetNameColor", "Cyan")
    GMSetting:addTab("Special")
    GMSetting:addItem("Special", "SetTime", "SetTime")
    GMSetting:addItem("Special", "Day", "ChangeTime", false)
    GMSetting:addItem("Special", "Night", "ChangeTime", true)
    GMSetting:addItem("Special", "Start/Stop cycle", "StartTime")
    GMSetting:addItem("Special", "SetYaw", "setYaw")
    GMSetting:addItem("Special", "SpawnNPC", "SpawnNPC")
    GMSetting:addItem("Special", "SpawnItem", "SpawnItem")
    GMSetting:addItem("Special", "SetBlockToAir", "SetBlockToAir")
    GMSetting:addItem("Special", "SpawnBlock", "SpawnBlock")
    GMSetting:addItem("Special", "SpawnCar", "spawnCar")
    GMSetting:addItem("Special", "SpYaw", "SpYaw")
    GMSetting:addItem("Special", "SpYawSet", "SpYawSet")
    GMSetting:addItem("Special", "CreateGUIDEArrow", "CreateGUIDEArrow")
    GMSetting:addItem("Special", "DelAllGUIDEArrow", "DelAllGUIDEArrow")
    GMSetting:addTab("Skins")
    GMSetting:addItem("Skins", "Parachute Wing", "ParachuteWing")
    GMSetting:addItem("Skins", "", "nil")
    GMSetting:addItem("Skins", "", "nil")
    GMSetting:addItem("Skins", "", "nil")
    GMSetting:addItem("Skins", "", "nil")
    GMSetting:addItem("Skins", "ChangeHair", "ChangeHair")
    GMSetting:addItem("Skins", "ChangeFace", "ChangeFace")
    GMSetting:addItem("Skins", "ChangeTops", "ChangeTops")
    GMSetting:addItem("Skins", "ChangePants", "ChangePants")
    GMSetting:addItem("Skins", "ChangeWing", "ChangeWing")
    GMSetting:addItem("Skins", "ChangeScarf", "ChangeScarf")
    GMSetting:addItem("Skins", "ChangeGlasses", "ChangeGlasses")
    GMSetting:addItem("Skins", "ChangeShoes", "ChangeShoes")
    GMSetting:addItem("Skins", "ChangeHat", "ChangeHat")
    GMSetting:addItem("Skins", "ChangeHat(Dec)", "ChangeDecHat")
    GMSetting:addItem("Skins", "ChangeTail", "ChangeTail")
    GMSetting:addItem("Skins", "ChangeBagl", "ChangeBagI")
    GMSetting:addItem("Skins", "ChangeCrown", "ChangeCrown")
    GMSetting:addItem("Skins", "ChangeSkinById", "ChangeSkinById")
    GMSetting:addTab("Vip Tag")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 1", "UpdatePlayerNickname")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 2", "UpdatePlayerNickname2")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 3", "UpdatePlayerNickname3")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 4", "UpdatePlayerNickname4")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 5", "UpdatePlayerNickname5")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 6", "UpdatePlayerNickname6")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 7", "UpdatePlayerNickname7")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 8", "UpdatePlayerNickname8")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 9", "UpdatePlayerNickname9")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 10", "UpdatePlayerNickname10")
    GMSetting:addItem("Vip Tag", "^00FFFFVip 10 Plus", "UpdatePlayerNickname11")
    GMSetting:addTab("Values")
    GMSetting:addItem("Values", "^FF0000reset Values", "resetValues")
    if r53 ~= "g1014" then
        GMSetting:addItem("Values", "Set Hit Box", "SetHitBox")
        GMSetting:addItem("Values", "Set Speed", "SetSpeed")
        GMSetting:addItem("Values", "Set High Jump", "SetHighJump")
        GMSetting:addItem("Values", "Set Aim Bot", "SetAimBot")
        GMSetting:addItem("Values", "Set Fov", "SetFov")
        GMSetting:addItem("Values", "Set FPS", "SetMaxFPS")
        if r53 == "g1019" then
            GMSetting:addTab("Mobs")
            GMSetting:addItem("Mobs", "Teleport Mob To Me", "MobTpToMe")
            GMSetting:addItem("Mobs", "Mob Hit box", "MobHitbox")
            GMSetting:addItem("Mobs", "Mob Tracer", "MobTracer")
            GMSetting:addItem("Mobs", "Mob Aim bot", "MobAimbot")
            GMSetting:addTab("Esp Mode")
            GMSetting:addItem("Esp Mode", "Esp Box", "Esp")
            GMSetting:addItem("Esp Mode", "Esp Xray", "EspMode")
            GMSetting:addItem("Esp Mode", "Esp Line", "EspSnapLine")
            GMSetting:addItem("Esp Mode", "Esp Skeleton", "EspSkeleton")
            GMSetting:addTab("Potion Giver")
            GMSetting:addItem("Potion Giver", "Move Speed", "move_speed")
            GMSetting:addItem("Potion Giver", "Move Slowdown", "move_slowdown")
            GMSetting:addItem("Potion Giver", "Dig Speed", "dig_speed")
            GMSetting:addItem("Potion Giver", "Dig Slowdown", "dig_slowdown")
            GMSetting:addItem("Potion Giver", "Damage Boost", "damage_boost")
            GMSetting:addItem("Potion Giver", "Instant Heal", "instant_heal")
            GMSetting:addItem("Potion Giver", "Instant Harm", "instant_harm")
            GMSetting:addItem("Potion Giver", "Jump Boost", "jump_boost")
            GMSetting:addItem("Potion Giver", "Confusion", "confusion")
            GMSetting:addItem("Potion Giver", "Regeneration", "regeneration")
            GMSetting:addItem("Potion Giver", "Resistance", "resistance")
            GMSetting:addItem("Potion Giver", "Fire Resistance", "fire_resistance")
            GMSetting:addItem("Potion Giver", "Water Breathing", "water_breathing")
            GMSetting:addItem("Potion Giver", "Invisibility", "invisibility")
            GMSetting:addItem("Potion Giver", "Blindness", "blindness")
            GMSetting:addItem("Potion Giver", "Night Vision", "night_vision")
            GMSetting:addItem("Potion Giver", "Hunger", "hunger")
            GMSetting:addItem("Potion Giver", "Weakness", "weakness")
            GMSetting:addItem("Potion Giver", "Poison", "poison")
            GMSetting:addItem("Potion Giver", "Wither", "wither")
            GMSetting:addItem("Potion Giver", "Health Boost", "health_boost")
            GMSetting:addItem("Potion Giver", "Absorption", "absorption")
            GMSetting:addItem("Potion Giver", "Saturation", "saturation")
            GMSetting:addTab("Teleport Map")
            GMSetting:addItem("Teleport Map", "Hunger Games Map1", "EnterGame", "m1001_1", "g1001")
            GMSetting:addItem("Teleport Map", "Clan Wars", "EnterGame", "m1072_1", "g1072")
            GMSetting:addItem("Teleport Map", "Hunger Games Map2", "EnterGame", "m1001_2", "g1001")
            GMSetting:addItem("Teleport Map", "Hunger Games Map3", "EnterGame", "m1001_3", "g1001")
            GMSetting:addItem("Teleport Map", "Hunger Games Map4", "EnterGame", "m1001_4", "g1001")
            GMSetting:addItem("Teleport Map", "Sky Wars Map1", "EnterGame", "m1002_1", "g1002")
            GMSetting:addItem("Teleport Map", "Sky Wars Map2", "EnterGame", "m1002_2", "g1002")
            GMSetting:addItem("Teleport Map", "Sky Wars Map2", "EnterGame", "m1002_3", "g1002")
            GMSetting:addItem("Teleport Map", "Bow Spleef Map1", "EnterGame", "m701", "g1007")
            GMSetting:addItem("Teleport Map", "Bow Spleef Map2", "EnterGame", "m702", "g1007")
            GMSetting:addItem("Teleport Map", "Bed War", "EnterGame", "m1008_2", "g1008")
            GMSetting:addItem("Teleport Map", "Murder Mystery", "EnterGame", "m901", "g1009")
            GMSetting:addItem("Teleport Map", "Tnt Run", "EnterGame", "m1001", "g1010")
            GMSetting:addItem("Teleport Map", "SnowBall Battle Map1", "EnterGame", "m1101", "g1011")
            GMSetting:addItem("Teleport Map", "SnowBall Battle Map2", "EnterGame", "m1102", "g1011")
            GMSetting:addItem("Teleport Map", "SnowBall Battle Map3", "EnterGame", "m1103", "g1011")
            GMSetting:addItem("Teleport Map", "Zombie Infecting", "EnterGame", "m1301", "g1013")
            GMSetting:addItem("Teleport Map", "Jail Break", "EnterGame", "m1401", "g1014")
            GMSetting:addItem("Teleport Map", "Jail Break v2", "EnterGame", "m1402", "g1014")
            GMSetting:addItem("Teleport Map", "Treasure Hunter", "EnterGame", "m1501_1", "g1015")
            GMSetting:addItem("Teleport Map", "PUBG", "EnterGame", "m1601", "g1016")
            GMSetting:addItem("Teleport Map", "Hide and seak", "EnterGame", "m1701", "g1017")
            GMSetting:addItem("Teleport Map", "Egg Wars Map1", "EnterGame", "m1018_1", "g1018")
            GMSetting:addItem("Teleport Map", "Egg Wars Map2", "EnterGame", "m1018_2", "g1018")
            GMSetting:addItem("Teleport Map", "Egg Wars Map3", "EnterGame", "m1018_3", "g1018")
            GMSetting:addItem("Teleport Map", "Egg Wars Map4", "EnterGame", "m1018_4", "g1018")
            GMSetting:addItem("Teleport Map", "Egg Wars Map5", "EnterGame", "m1018_5", "g1018")
            GMSetting:addItem("Teleport Map", "Aliens Attack", "EnterGame", "m1019_1", "g1019")
            GMSetting:addItem("Teleport Map", "Mini Town", "EnterGame", "m1020_1", "g1020")
            GMSetting:addItem("Teleport Map", "Rainbow parkour Map1", "EnterGame", "m1021_1", "g1021")
            GMSetting:addItem("Teleport Map", "Rainbow parkour Map2", "EnterGame", "m1021_2", "g1021")
            GMSetting:addItem("Teleport Map", "Rainbow parkour Map3", "EnterGame", "m1021_3", "g1021")
            GMSetting:addItem("Teleport Map", "Capture The Flag", "EnterGame", "m1022_1", "g1022")
            GMSetting:addItem("Teleport Map", "Build Battle", "EnterGame", "m1023_1", "g1023")
            GMSetting:addItem("Teleport Map", "Gem Knight", "EnterGame", "m1024_1", "g1024")
            GMSetting:addItem("Teleport Map", "Hero Tycoon 2", "EnterGame", "m1025_1", "g1025")
            GMSetting:addItem("Teleport Map", "Tnt Tag Map1", "EnterGame", "m1026_1", "g1026")
            GMSetting:addItem("Teleport Map", "Tnt Tag Map2", "EnterGame", "m1026_2", "g1026")
            GMSetting:addItem("Teleport Map", "Sky Royale", "EnterGame", "m1027_1", "g1027")
            GMSetting:addItem("Teleport Map", "Ultimate Fighting", "EnterGame", "m1028_2", "g1028")
            GMSetting:addItem("Teleport Map", "Mega Walls Map1", "EnterGame", "m1029_1", "g1029")
            GMSetting:addItem("Teleport Map", "Mega Walls Map2", "EnterGame", "m1029_2", "g1029")
            GMSetting:addItem("Teleport Map", "Snowman Defender Map1", "EnterGame", "m1030_1", "g1030")
            GMSetting:addItem("Teleport Map", "Snowman Defender Map2", "EnterGame", "m1030_2", "g1030")
            GMSetting:addItem("Teleport Map", "Snowman Defender Map3", "EnterGame", "m1030_3", "g1030")
            GMSetting:addItem("Teleport Map", "Ranchers", "EnterGame", "m1031_1", "g1031")
            GMSetting:addItem("Teleport Map", "Blockman Strike Lobby", "EnterGame", "m1032_1", "g1032")
            GMSetting:addItem("Teleport Map", "Blockman Strike Map1", "EnterGame", "m1033_2", "g1033")
            GMSetting:addItem("Teleport Map", "Blockman Strike Map2", "EnterGame", "m1033_3", "g1033")
            GMSetting:addItem("Teleport Map", "Blockman Strike Map3", "EnterGame", "m1033_4", "g1033")
            GMSetting:addItem("Teleport Map", "Ender Vs Slender Map1", "EnterGame", "m1036_1", "g1036")
            GMSetting:addItem("Teleport Map", "Ender Vs Slender Map2", "EnterGame", "m1036_2", "g1036")
            GMSetting:addItem("Teleport Map", "Hide And Seek2", "EnterGame", "m1037_1", "g1037")
            GMSetting:addItem("Teleport Map", "Hide And Seek2 Map1", "EnterGame", "m1038_1", "g1038")
            GMSetting:addItem("Teleport Map", "Hide And Seek2 Map2", "EnterGame", "m1038_2", "g1038")
            GMSetting:addItem("Teleport Map", "Hide And Seek2 Map3", "EnterGame", "m1039_1", "g1039")
            GMSetting:addItem("Teleport Map", "Hide And Seek2 Map4", "EnterGame", "m1039_2", "g1039")
            GMSetting:addItem("Teleport Map", "Bird Simulator", "EnterGame", "m1041_2", "g1041")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1042_1", "g1042")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1043_1", "g1043")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1043_2", "g1043")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1043_3", "g1043")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1043_4", "g1043")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1044_1", "g1044")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1044_2", "g1044")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1044_3", "g1044")
            GMSetting:addItem("Teleport Map", "Build And Shoot", "EnterGame", "m1044_4", "g1044")
            GMSetting:addItem("Teleport Map", "Bed War Lobby", "EnterGame", "m1046_2", "g1046")
            GMSetting:addItem("Teleport Map", "Realm City", "EnterGame", "m1047_1", "g1047")
            GMSetting:addItem("Teleport Map", "Sky Block", "EnterGame", "m1048_1", "g1048")
            GMSetting:addItem("Teleport Map", "Sky Block Mining", "EnterGame", "m1049_2", "g1049")
            GMSetting:addItem("Teleport Map", "Sky Block Product", "EnterGame", "m1050_1", "g1050")
            GMSetting:addItem("Teleport Map", "Walking Dead", "EnterGame", "m1051_1", "g1051")
            GMSetting:addItem("Teleport Map", "Block Fort", "EnterGame", "m1052", "g1052")
            GMSetting:addItem("Teleport Map", "Battle Royale", "EnterGame", "m1053_1", "g1053")
            GMSetting:addItem("Teleport Map", "Lucky Block Sky war", "EnterGame", "m1054_1", "g1054")
            GMSetting:addItem("Teleport Map", "Lucky Block Sky war", "EnterGame", "m1054_2", "g1054")
            GMSetting:addItem("Teleport Map", "WWE", "EnterGame", "m1055_1", "g1055")
            GMSetting:addItem("Teleport Map", "Angry Pets", "EnterGame", "m1056_1", "g1056")
            GMSetting:addItem("Teleport Map", "Angry Pets", "EnterGame", "m1057_1", "g1057")
            GMSetting:addItem("Teleport Map", "Lucky Blocks", "EnterGame", "m1058_1", "g1058")
            GMSetting:addItem("Teleport Map", "Bed wars", "EnterGame", "m1061_1", "g1061")
            GMSetting:addItem("Teleport Map", "Bed wars", "EnterGame", "m1062_1", "g1062")
            GMSetting:addItem("Teleport Map", "Bed wars", "EnterGame", "m1063_1", "g1063")
            GMSetting:addItem("Teleport Map", "Bullets fly", "EnterGame", "m1064_1", "g1064")
            GMSetting:addItem("Teleport Map", "Bed wars 10vs10", "EnterGame", "m1065_1", "g1065")
            GMSetting:addTab("Action State")
            GMSetting:addItem("Action State", "Lying", "Lying")
            GMSetting:addItem("Action State", "Sit", "Sit")
            GMSetting:addItem("Action State", "Sit2", "Sit2")
            GMSetting:addItem("Action State", "Flyg", "Flyg")
            GMSetting:addItem("Action State", "Climb", "Climb")
            GMSetting:addItem("Action State", "Climb2", "Climb2")
            GMSetting:addItem("Action State", "Sneaky", "Sneaky")
            GMSetting:addItem("Action State", "Swim", "Swim")
            GMSetting:addItem("Action State", "Float", "Float")
            GMSetting:addItem("Action State", "Run", "Run")
            GMSetting:addTab("Render World")
            GMSetting:addItem("Render World", "Set Render World", "RenderWorld")
            GMSetting:addItem("Render World", "Break Particles", "BreakParticles")
            GMSetting:addItem("Render World", "Hide/Show Dark", "Dark")
            GMSetting:addItem("Render World", "Hide/Show Clouds", "Clouds")
            GMSetting:addTab("Actors")
            GMSetting:addItem("Actors", "^FF0000Change Actor", "ChangeActorForMe")
            GMSetting:addItem("Actors", "Boy", "changePlayerActor")
            GMSetting:addItem("Actors", "Girl", "changePlayerActor")
            GMSetting:addItem("Actors", "Mario", "SetMario")
            GMSetting:addItem("Actors", "Spider Man", "SetSpiderMan")
            GMSetting:addItem("Actors", "Iron Man", "SetIronMan")
            GMSetting:addItem("Actors", "Hulk", "SetHulk")
            GMSetting:addTab("Blocks")
            GMSetting:addItem("Blocks", "No End Stone", "NoEndStone1")
            GMSetting:addItem("Blocks", "No Wood", "NoWool1")
            GMSetting:addItem("Blocks", "No Wool", "NoOakPlanks1")
            GMSetting:addItem("Blocks", "No Obsidian", "NoObsidian1")
            GMSetting:addItem("Blocks", "No Glass", "NoGlass1")
            GMSetting:addItem("Blocks", "No Diamond Bomb", "NoBomb1")
            GMSetting:addItem("Blocks", "No Iron Door", "NoIDoor1")
            GMSetting:addItem("Blocks", "No Quartz Block", "NoQuartz1")
            GMSetting:addTab("Chat")
            GMSetting:addItem("Chat", "Hide/Show Chat", "HideChat")
            GMSetting:addItem("Chat", "Spam Chat v2", "SpamChat")
            GMSetting:addItem("Chat", "", "nil")
            GMSetting:addItem("Chat", "", "nil")
            GMSetting:addItem("Chat", "", "nil")
            GMSetting:addItem("Chat", "\226\150\162FFFF0000Red", "applyColorToChat", "Red")
            GMSetting:addItem("Chat", "\226\150\162FF0000FFBlue", "applyColorToChat", "Blue")
            GMSetting:addItem("Chat", "\226\150\162FFFF00FFPink", "applyColorToChat", "Pink")
            GMSetting:addItem("Chat", "\226\150\162FF00FFFFCyan", "applyColorToChat", "Cyan")
            GMSetting:addItem("Chat", "\226\150\162FF00FF00Green", "applyColorToChat", "Green")
            GMSetting:addItem("Chat", "\226\150\162FF9600FFPurple", "applyColorToChat", "Purple")
            GMSetting:addItem("Chat", "\226\150\162FFFFFF00Yellow", "applyColorToChat", "Yellow")
            GMSetting:addItem("Chat", "\226\150\162FFFFAF00Orange", "applyColorToChat", "Orange")
            GMSetting:addItem("Chat", "\226\150\162FFFFD700Gold", "applyColorToChat", "Gold")
            GMSetting:addItem("Chat", "\226\150\162FFFFFFFFWhite", "applyColorToChat", "White")
            GMSetting:addTab("Items")
            local r43 = function(...)
                if (false and false) or (not false and true) then
                    if Item.getItemById(1) then
                        Item.getItemById(1):getUnlocalizedName()
                        if Lang:getString(r4 .. ".name") == r4 .. ".name" then
                            r22 = r4:gsub("item%.", "") .. ".name"
                            if Lang:getString(("item.") .. r22) == ("item.") .. r22 then
                                tostring(1)
                                GMSetting:addItem("Items", ("Item:") .. r21, "ItemID")
                            end
                            tostring(1)
                            r21 = Lang:getString(("item.") .. r22) .. ("(") .. r13 .. ")"
                        end
                        tostring(1)
                        r21 = Lang:getString(r4 .. ".name") .. ("(") .. r13 .. ")"
                    end
                end
            end
            LuaTimer:schedule(r43, 1000)
            GMSetting:addTab("G-Cube")
            GMSetting:addItem("G-Cube", "^FF0000Reset G-Cube", "GiveGCubes_Reset")
            GMSetting:addItem("G-Cube", "Give 1", "GiveGCubes_1")
            GMSetting:addItem("G-Cube", "Give 2", "GiveGCubes_2")
            GMSetting:addItem("G-Cube", "Give 5", "GiveGCubes_5")
            GMSetting:addItem("G-Cube", "Give 10", "GiveGCubes_10")
            GMSetting:addItem("G-Cube", "Give 20", "GiveGCubes_20")
            GMSetting:addItem("G-Cube", "Give 50", "GiveGCubes_50")
            GMSetting:addItem("G-Cube", "Give 100", "GiveGCubes_100")
            GMSetting:addItem("G-Cube", "Give 200", "GiveGCubes_200")
            GMSetting:addItem("G-Cube", "Give 500", "GiveGCubes_500")
            GMSetting:addItem("G-Cube", "Give 1k", "GiveGCubes_1k")
            GMSetting:addItem("G-Cube", "Give 2k", "GiveGCubes_2k")
            GMSetting:addItem("G-Cube", "Give 5k", "GiveGCubes_5k")
            GMSetting:addItem("G-Cube", "Give 10k", "GiveGCubes_10k")
            GMSetting:addItem("G-Cube", "Give 20k", "GiveGCubes_20k")
            GMSetting:addItem("G-Cube", "Give 50k", "GiveGCubes_50k")
            GMSetting:addItem("G-Cube", "Give 100k", "GiveGCubes_100k")
            GMSetting:addItem("G-Cube", "Give 200k", "GiveGCubes_200k")
            GMSetting:addItem("G-Cube", "Give 500k", "GiveGCubes_500k")
            GMSetting:addItem("G-Cube", "Give 1M", "GiveGCubes_1M")
            GMSetting:addItem("G-Cube", "Give 2M", "GiveGCubes_2M")
            GMSetting:addItem("G-Cube", "Give 5M", "GiveGCubes_5M")
            GMSetting:addItem("G-Cube", "Give 10M", "GiveGCubes_10M")
            GMSetting:addItem("G-Cube", "Give 20M", "GiveGCubes_20M")
            GMSetting:addItem("G-Cube", "Give 50M", "GiveGCubes_50M")
            GMSetting:addItem("G-Cube", "Give 100M", "GiveGCubes_100M")
            GMSetting:addItem("G-Cube", "Give 200M", "GiveGCubes_200M")
            GMSetting:addItem("G-Cube", "Give 500M", "GiveGCubes_500M")
            GMSetting:addItem("G-Cube", "Give 1B", "GiveGCubes_1B")
            GMSetting:addItem("G-Cube", "Give 2B", "GiveGCubes_2B")
            GMSetting:addItem("G-Cube", "Give 5B", "GiveGCubes_5B")
            GMSetting:addItem("G-Cube", "Give 10B", "GiveGCubes_10B")
            GMSetting:addItem("G-Cube", "Give 20B", "GiveGCubes_20B")
            GMSetting:addItem("G-Cube", "Give 50B", "GiveGCubes_50B")
            GMSetting:addTab("Game & Panel")
            GMSetting:addItem("Game & Panel", "^FF0000re Enter Game", "reEnter")
            GMSetting:addItem("Game & Panel", "Close Game", "closeGame")
            GMSetting:addItem("Game & Panel", "Hide/Show Background Panel", "setP")
            GMSetting:addItem("Game & Panel", "Hide/Show Panel", "HidePanel")
            GMSetting:addItem("Game & Panel", "Movable/UnMovable Panel", "MovablePanel")
            GMSetting:addItem("Game & Panel", "^FFD700Exchange Owner", "ExchangeOwner")
            GMSetting:addTab("Credits")
            GMSetting:addItem("Credits", "^FFFFFF@INFO", "nil")
            GMSetting:addItem("Credits", "^FFFFFF@INFO", "nil")
            GMSetting:addItem("Credits", "^FFFFFF@INFO", "nil")
            GMSetting:addItem("Credits", "^FFFFFF@INFO", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFFFFFCreator Panel: ^00FFDD--->", "nil")
            GMSetting:addItem("Credits", "Azure", "a")
            GMSetting:addItem("Credits", "Khd Bg", "b")
            GMSetting:addItem("Credits", "Simik", "c")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFFFFFHelper ^00FFDD--->", "nil")
            GMSetting:addItem("Credits", "Rage(oguri)", "c")
            GMSetting:addItem("Credits", "Ak47 BG", "c")
            GMSetting:addItem("Credits", "Nickel", "c")
            GMSetting:addItem("Credits", "Shado", "e")
            GMSetting:addItem("Credits", "^FFFFFFBypass ^00FFDD--->", "nil")
            GMSetting:addItem("Credits", "Azure", "o")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFFFFFPanel changing: ^00FFDD--->", "nil")
            GMSetting:addItem("Credits", "Novatex", "c")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFFFFFFeatures Taken From: ^00FFDD--->", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700Vortex Panel", "nil")
            GMSetting:addItem("Credits", "VortexHacker", "c")
            GMSetting:addItem("Credits", "Helpers: ShadowPS, KingKM", "c")
            GMSetting:addItem("Credits", "^AAAAAAJetPack, Air Speed, Sharp Move", "nil")
            GMSetting:addItem("Credits", "^AAAAAASmooth Jumps, UnDeath, Mob AimBow", "nil")
            GMSetting:addItem("Credits", "^AAAAAAShow Durability, Chroma Wing, Return Name", "nil")
            GMSetting:addItem("Credits", "^AAAAAAClan Wars TP, Treasure Hunter", "nil")
            GMSetting:addItem("Credits", "^AAAAAADestroy All Buttons, Copy Device ID", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700EPanel", "nil")
            GMSetting:addItem("Credits", "Panel Creator: Eternal", "c")
            GMSetting:addItem("Credits", "Bypass Author: RustyKoper", "c")
            GMSetting:addItem("Credits", "Apk Bypasser: BHT", "c")
            GMSetting:addItem("Credits", "^AAAAAABlock XRay", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700Rask Client", "nil")
            GMSetting:addItem("Credits", "Founder: Rage.99.vg", "c")
            GMSetting:addItem("Credits", "^AAAAAANo Hunger, Hoe Aura, Break Crop Aura", "nil")
            GMSetting:addItem("Credits", "^AAAAAAPlace Crop Aura, Claim Rewards, Chat Bypass", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700NickelSo Panel", "nil")
            GMSetting:addItem("Credits", "Nickel, Novatex", "c")
            GMSetting:addItem("Credits", "Partner: Vision_dsh", "c")
            GMSetting:addItem("Credits", "^AAAAAATeleport+, Outfit ID, Sky & Camera", "nil")
            GMSetting:addItem("Credits", "^AAAAAAAnimations, HUD & Info", "nil")
            GMSetting:addItem("Credits", "^AAAAAAWing Fly, Target Aura, Item Collector", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700nClient", "nil")
            GMSetting:addItem("Credits", "Lead Developer: Ice", "c")
            GMSetting:addItem("Credits", "Co-Developer: What?", "c")
            GMSetting:addItem("Credits", "^AAAAAAAnti Knockback, Bunny Hop, Spider Climb", "nil")
            GMSetting:addItem("Credits", "^AAAAAAWater Walk, Glide, Fast Fall, Fast Swim", "nil")
            GMSetting:addItem("Credits", "^AAAAAAInfinite Sprint, Auto Walk, Auto Sneak", "nil")
            GMSetting:addItem("Credits", "^AAAAAACriticals, Auto Melee, Multi Aura", "nil")
            GMSetting:addItem("Credits", "^AAAAAATarget Lock, Mine God, Crash Game", "nil")
            GMSetting:addItem("Credits", "^AAAAAAAscend, Descend, TP Nearest Entity", "nil")
            GMSetting:addItem("Credits", "^AAAAAATP To Spawn, Walk To Waypoint, Orbit", "nil")
            GMSetting:addItem("Credits", "^AAAAAAESP Health, ESP 2D Box, Reset Pose", "nil")
            GMSetting:addItem("Credits", "^AAAAAAFun Tab", "nil")
            GMSetting:addItem("Credits", "", "nil")
            GMSetting:addItem("Credits", "^FFD700Discord", "nil")
            GMSetting:addItem("Credits", "8majksp01", "c")
            GMSetting:addItem("Credits", "^AAAAAAAuto Treasure", "nil")
            GMSetting:addItem("Credits", "rage.v", "c")
            GMSetting:addItem("Credits", "^AAAAAATriggerBot", "nil")
            GMSetting:addTab("Community")
            GMSetting:addItem("Community", "Hyper Community", "OpenLink")
            GMSetting:addItem("Community", "Azure Channel", "OpenLink1")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "Vape Community", "OpenLink2")
            GMSetting:addItem("Community", "Khd Channel", "OpenLink3")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "", "nil")
            GMSetting:addItem("Community", "Prax Client Community", "OpenLink4")
            GMSetting:addItem("Community", "Krixx Channel", "OpenLink5")
            GMSetting:addTab("^4B0082Sky Royale")
            GMSetting:addItem("^4B0082Sky Royale", "Button Bridge", "BtnBridge")
            GMSetting:addItem("^4B0082Sky Royale", "Auto Bridge", "AutoBridge")
            GMSetting:addItem("^4B0082Sky Royale", "", "nil")
            GMSetting:addItem("^4B0082Sky Royale", "", "nil")
            GMSetting:addItem("^4B0082Sky Royale", "", "nil")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Red (New)", "TpTeamRedNew")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Blue (New)", "TpTeamBlueNew")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Yellow (New)", "TpTeamYellowNew")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Green (New)", "TpTeamGreenNew")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Middle (New)", "TpMidNew")
            GMSetting:addItem("^4B0082Sky Royale", "Tp Tp Red", "TpTeamRedOld")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Blue", "TpTeamBlueOld")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Yellow", "TpTeamYellowOld")
            GMSetting:addItem("^4B0082Sky Royale", "Tp Tp Green", "TpTeamGreenOld")
            GMSetting:addItem("^4B0082Sky Royale", "Tp To Middle", "TpMidOld")
            GMSetting:addTab("^4B0082TP")
            GMSetting:addItem("^4B0082TP", "Tp To Respawn", "TpToRespawn")
            GMSetting:addItem("^4B0082TP", "Tp To Jail", "TpToJail")
            GMSetting:addItem("^4B0082TP", "Tp To Police", "TpToPolice")
            GMSetting:addItem("^4B0082TP", "Tp To Black Market", "TpToBlackMarket")
            GMSetting:addItem("^4B0082TP", "Tp To Bank", "TpToBank")
            GMSetting:addItem("^4B0082TP", "Tp To Mall", "TpToMall")
            GMSetting:addItem("^4B0082TP", "Tp To Hospital", "TpToHospital")
            GMSetting:addItem("^4B0082TP", "Tp To Mansion", "TpToMansion")
            GMSetting:addItem("^4B0082TP", "Tp To INN", "TpToINN")
            GMSetting:addTab("^4B0082WWE Sim")
            GMSetting:addItem("^4B0082WWE Sim", "Edit Size", "EditSize")
            GMSetting:addItem("^4B0082WWE Sim", "Auto Sell", "AutoSell")
            GMSetting:addItem("^4B0082WWE Sim", "Infinity Shield", "InfShield")
            GMSetting:addItem("^4B0082WWE Sim", "Equip Sun", "EquipSun")
            GMSetting:addItem("^4B0082WWE Sim", "Equip Earth", "EquipEarth")
            GMSetting:addItem("^4B0082WWE Sim", "Equip Air Craff", "EquipAirCraff")
            GMSetting:addItem("^4B0082WWE Sim", "Change Skin Sim", "ChangeSkinSim")
            GMSetting:addItem("^4B0082WWE Sim", "Heal Sim", "HealSim")
            function GMHelper.enableGM(...)
                Env.GUIGMControlPanel = UIHelper.newEngineGUILayout("GUIGMControlPanel", "GMControlPanel.json")
                Env.GUIGMMain = UIHelper.newEngineGUILayout("GUIGMMain", "GMMain.json")
                GUIGMMain:changeOpenEventDialog(ClientHelper.getBoolForKey("g1008_isOpenEventDialog", false))
                if GMSetting.addItemGMItems then
                    GMSetting:addItemGMItems()
                    GMSetting.addItemGMItems = nil
                end
            end
            function GMHelper.openInput(...)
                r10 = {pairs(v1[2])}
                if r10[3] then
                    if type(r3) ~= "string" then
                        if isClient then
                            assert(true, "param need string type")
                        end
                    end
                end
                GUIGMControlPanel:openInput(v1[2], v1[3])
            end
            function GMHelper.callCommand(...)
                if type(v1[1][v1[2]]) == "function" then
                    v1[1][v1[2]](v1[1], v5({v4(3, v5(v1))}))
                    r4 = {v5({v4(3, v5(v1))})}
                    GMSetting:changeColorByFunction(v1[2], _G[("tog") .. v1[2]], v5({v4(3, v5(v1))}))
                    r10 = {name = v1[2], params = r4}
                    if #r10.params > 0 then
                        table.remove(r10.params)
                    end
                end
            end
            function r2.openInput(...)
                v2[q()] = v1[1]
                r8 = v2[q()]
                r8.llInput:SetVisible(true)
                v2[q()].paramTexts = v1[2]
                v2[q()].inputTable = r2
                v2[q()].callBack = v1[3]
                r17 = ("EnterButton_") .. math.random(1000, 9999)
                v2[q()].enterButton = GUIManager:createGUIWindow(GUIType.Button, r17)
                r8 = v2[q()]
                r22 = {0, 40}
                r8.enterButton:SetHeight(r22)
                r8 = v2[q()]
                r22 = {0, 100}
                r8.enterButton:SetWidth(r22)
                r8 = v2[q()]
                r8.enterButton:SetHorizontalAlignment(HorizontalAlignment.Left)
                r8 = v2[q()]
                r8.enterButton:SetVerticalAlignment(VerticalAlignment.Bottom)
                r8 = v2[q()]
                r8.enterButton:SetTouchable(true)
                r8 = v2[q()]
                r8.enterButton:SetVisible(true)
                r8 = v2[q()]
                r22 = {0, 0}
                r8.enterButton:SetXPosition(r22)
                r8 = v2[q()]
                r22 = {0, -625}
                r8.enterButton:SetYPosition(r22)
                r8 = v2[q()]
                r8.enterButton:SetText("Enter")
                r8 = v2[q()]
                r22 = {0, 1, 0, 1}
                r8.enterButton:SetBackgroundColor(r22)
                r8 = v2[q()]
                local r18 = function(...)
                    v2[v3[1]]:inputText()
                end
                r8.enterButton:registerEvent(GUIEvent.ButtonClick, r18)
                r8 = v2[q()]
                r18 = v2[q()]
                r8.llInput:AddChildWindow(r18.enterButton)
                r22 = ("ClearButton_") .. math.random(1000, 9999)
                v2[q()].clearButton = GUIManager:createGUIWindow(GUIType.Button, r22)
                r8 = v2[q()]
                r18 = {0, 40}
                r8.clearButton:SetHeight(r18)
                r8 = v2[q()]
                r18 = {0, 100}
                r8.clearButton:SetWidth(r18)
                r8 = v2[q()]
                r8.clearButton:SetHorizontalAlignment(HorizontalAlignment.Left)
                r8 = v2[q()]
                r8.clearButton:SetVerticalAlignment(VerticalAlignment.Bottom)
                r8 = v2[q()]
                r8.clearButton:SetTouchable(true)
                r8 = v2[q()]
                r8.clearButton:SetVisible(true)
                r8 = v2[q()]
                r18 = {0, 110}
                r8.clearButton:SetXPosition(r18)
                r8 = v2[q()]
                r18 = {0, -625}
                r8.clearButton:SetYPosition(r18)
                r8 = v2[q()]
                r8.clearButton:SetText("Clear")
                r8 = v2[q()]
                r18 = {1, 0, 0, 1}
                r8.clearButton:SetBackgroundColor(r18)
                r8 = v2[q()]
                local r25 = function(...)
                    v2[v3[1]].edInput:SetText("")
                end
                r8.clearButton:registerEvent(GUIEvent.ButtonClick, r25)
                r8 = v2[q()]
                r25 = PlayerManager:getClientPlayer().Player
                r25 = v2[q()]
                r8.llInput:AddChildWindow(r25.clearButton)
                r18 = ("CopyButton_") .. math.random(1000, 9999)
                v2[q()].copyButton = GUIManager:createGUIWindow(GUIType.Button, r18)
                r8 = v2[q()]
                r25 = {0, 40}
                r8.copyButton:SetHeight(r25)
                r8 = v2[q()]
                r25 = {0, 100}
                r8.copyButton:SetWidth(r25)
                r8 = v2[q()]
                r8.copyButton:SetHorizontalAlignment(HorizontalAlignment.Left)
                r8 = v2[q()]
                r8.copyButton:SetVerticalAlignment(VerticalAlignment.Bottom)
                r8 = v2[q()]
                r8.copyButton:SetTouchable(true)
                r8 = v2[q()]
                r8.copyButton:SetVisible(true)
                r8 = v2[q()]
                r25 = {0, 220}
                r8.copyButton:SetXPosition(r25)
                r8 = v2[q()]
                r25 = {0, -625}
                r8.copyButton:SetYPosition(r25)
                r8 = v2[q()]
                r8.copyButton:SetText("Copy")
                r8 = v2[q()]
                r25 = {0, 0, 1, 1}
                r8.copyButton:SetBackgroundColor(r25)
                r8 = v2[q()]
                local r21 = function(...)
                    if v2[v3[1]].edInput:GetText() ~= "" then
                        ClientHelper.onSetClipboard(v2[v3[1]].edInput:GetText())
                    end
                end
                r8.copyButton:registerEvent(GUIEvent.ButtonClick, r21)
                r8 = v2[q()]
                r21 = v2[q()]
                r8.llInput:AddChildWindow(r21.copyButton)
                local r25 = function(...)
                    v2[v3[1]]:showInputBox()
                end
                LuaTimer:schedule(r25, 50)
                I(q())
            end
            function r2.showInputBox(...)
                v2[q()] = v1[1]
                r10 = v2[q()]
                r17 = v2[q()]
                v2[q()].tipText = tostring(r10.paramTexts[#r17.inputTable + 1])
                r8 = v2[q()]
                r8.edInput:SetText(v2[q()].tipText)
                r8 = v2[q()]
                r8.edInput:OpenKeyboard()
                LuaTimer:schedule(function(...) end, 50)
                I(q())
            end
            function r2.inputText(...)
                table.insert(v1[1].inputTable, v1[1].edInput:GetText())
                if #v1[1].inputTable < #v1[1].paramTexts then
                    v1[1]:showInputBox()
                end
                v1[1].edInput:SetText("")
                if v1[1].callBack then
                    r2 = {unpack(v1[1].inputTable)}
                    v1[1]:closeInput()
                    v1[1].callBack(v5(r2))
                end
            end
            function r2.closeInput(...)
                v1[1].llInput:SetVisible(false)
                v1[1].paramTexts = r8
                v1[1].inputTable = r8
                v1[1].callBack = nil
                v1[1].edInput:SetText("")
                if v1[1].enterButton then
                    v1[1].enterButton:SetVisible(false)
                    if v1[1].clearButton then
                        v1[1].clearButton:SetVisible(false)
                        if v1[1].copyButton then
                            v1[1].copyButton:SetVisible(false)
                        end
                    end
                end
            end
            Env.red = "\226\150\162FFFF0000"
            Env.pink = "^000000\226\150\162FFFF00FF"
            Env.green = "\226\150\162FF00FF00"
            Env.purple = "\226\150\162FF9700FF "
            Env.rose = "^FF1493"
            Env.roses = "^FF1493 "
            Env.cyan = "^00FFFF"
            Env.blue = "^0000FF"
            Env.gray = "\226\150\162DDDDDDDD"
            Env.white = "^FFFFFF"
            v2[q()] = r57
            v2[q()] = "Customization"
            r68 = v2[q()]
            GMSetting:addTab(r68)
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDadd item", "AddGay")
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDremove item", "RemoveGay")
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDenable all item", "EnableGay")
            r68 = v2[q()]
            GMSetting:addItem(r68, "", "nil")
            r68 = v2[q()]
            GMSetting:addItem(r68, "", "nil")
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDadd custom tab", "AddCustomTab")
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDadd custom item", "AddItemTab")
            r68 = v2[q()]
            GMSetting:addItem(r68, "^00FFDDcheck custom tab list", "CheckList")
            r68 = v2[q()]
            GMSetting:addItem(r68, "", "nil")
            r68 = v2[q()]
            local r78 = function(...)
                if io.open(v1[1], "rb") then
                    io.open(v1[1], "rb"):read("*a")
                    io.open(v1[1], "rb"):close()
                    if B then
                        r8 = {B}
                    end
                end
            end
            GMSetting:addItem(r68, "", "nil")
            v2[q()] = "/sdcard/Android/data/com.sandboxol.blockymods/files/Download/SandboxOL/BlockMan/config/"
            r58 = {add = false, remove = false, itemList = r71}
            v2[q()] = r58
            r58 = {action = false, remove = false, add = false}
            v2[q()] = r58
            r58 = {["nil"] = true, AddGay = true, RemoveGay = true, EnableGay = true, RemoveAllGay = true}
            v2[q()] = r58
            local r73 = function(...)
                if io.open(v2[v3[1]] .. "config.json", "rb") then
                    io.open(v2[v3[1]] .. "config.json", "rb"):read("*a")
                    io.open(v2[v3[1]] .. "config.json", "rb"):close()
                    if a then
                        if a ~= "" then
                            if json.decode(a) then
                                v2[v3[2]].itemList = json.decode(a)
                                r4 = {pairs(v2[v3[2]].itemList)}
                                if r4[3] then
                                    if ("itemList").item then
                                        if ("itemList").item.name then
                                            if ("itemList").item.func then
                                                GMSetting:addItem("Customization", ("itemList").item.name, ("itemList").item.func)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            GUISystem.Instance():GetRootWindow()
            I(q())
            I(q())
            I(q())
            LuaTimer:schedule(r73, 2000)
            r8 = {nil}
            v2[q()] = (not a and 7200333) or 6825960
            v2[q()] = GUIManager:createGUIWindow(GUIType.StaticText, ("Motorian_3D_") .. v1[1] .. ("_") .. 1)
            local r22 = function(...)
                v2[v3[1]]:SetLevel(99)
                v2[v3[1]]:SetAlwaysOnTop(true)
            end
            pcall(r22)
            r8 = v2[q()]
            a:AddChildWindow(r8)
            r8 = v2[q()]
            v2[q()][1] = r8
            I(q())
            v2[q()].info = GUIManager:createGUIWindow(GUIType.StaticText, ("Motorian_3D_I_") .. v1[1])
            r8 = v2[q()]
            r8.info:SetTextScale(0.85)
            r8 = v2[q()]
            r8.info:SetTextHorzAlign(HorizontalAlignment.Center)
            local r2 = function(...)
                v2[v3[1]].info:SetLevel(99)
                v2[v3[1]].info:SetAlwaysOnTop(true)
            end
            r2 = v2[q()]
            pcall(r2)
            a:AddChildWindow(r2.info)
            r8 = {v2[q()]}
            function GMHelper.AddGay(...)
                v2[v3[1]].add = not v2[v3[1]].add
                Env.togAddGay = v2[v3[1]].add
                v2[v3[2]].action = v2[v3[1]].add
                v2[v3[2]].add = v2[v3[1]].add
                v2[v3[2]].remove = false
            end
            function GMHelper.RemoveGay(...)
                v2[v3[1]].remove = not v2[v3[1]].remove
                Env.togRemoveGay = v2[v3[1]].remove
                v2[v3[2]].action = v2[v3[1]].remove
                v2[v3[2]].remove = v2[v3[1]].remove
                v2[v3[2]].add = false
            end
            function GMHelper.EnableGay(...)
                Env.togEnableGay = not togEnableGay
                r10 = {pairs(v2[v3[1]].itemList)}
                if r10[3] then
                    if r10.available then
                        if r10.item then
                            if not r10.item.gui then
                                print("not founded ")
                                r21 = math.random(1, 100000000000) .. r10[3]
                                if r10.item.func then
                                    if r10.item.func ~= "nil" then
                                        GMHelper:callCommand(r10.item.func, GUIManager:createGUIWindow("StaticText", ("GMIyemaGayyy") .. r21))
                                        GMSetting:changeColorByFunction(r10.item.func, _G[("tog") .. r10.item.func])
                                    end
                                end
                            end
                        end
                    end
                end
                GMSetting:changeColorByFunction("EnableGay", togEnableGay)
            end
            function GMHelper.handleAction(...)
                if not v2[v3[1]].action then
                    if not v1[2] then
                        error("Invalid Item!", 0)
                    end
                    if v2[v3[3]][v1[2].data.func or "nil"] then
                        if v1[3] == "add" then
                            r25 = {pairs(v2[v3[2]].itemList)}
                            if r25[3] then
                                if r25.item.name == (v1[2].data.name or "") then
                                    r25.available = true
                                    if not true then
                                        r21 = {name = v1[2].data.name or "", func = v1[2].data.func or "nil"}
                                        r18 = {item = r21, available = true}
                                        table.insert(v2[v3[2]].itemList, r18)
                                        GMSetting:addItem(v2[v3[4]], v1[2].data.name or "", v1[2].data.func or "nil")
                                    end
                                    UIHelper.showToast(red .. "Items Already Added")
                                end
                            end
                        end
                        if v1[3] == "remove" then
                            r21 = {pairs(v2[v3[2]].itemList)}
                            if r21[3] then
                                if v2[v3[2]].itemList.item.name == (v1[2].data.name or "") then
                                    if r21[3] then
                                        table.remove(v2[v3[2]].itemList, r21[3])
                                        GMSetting:removeItem(v2[v3[4]], v1[2].data.name or "")
                                    end
                                end
                            end
                        end
                        error(("Invalid Action Type : ") .. v1[3], 0)
                    end
                end
            end
            function r5.onLoad(...)
                v2[q()] = v1[1]
                v2[q()].tvItem = v2[q()]:getChildWindowByName("GMButton", GUIType.StaticText)
                LuaTimer:schedule(function(...) end, 100)
                r8 = v2[q()]
                r8.tvItem:registerEvent(GUIEvent.Click, function(...) end)
                I(q())
            end
            function GMSetting.removeItem(...)
                r3 = {pairs(v2[v3[1]])}
                if r3[3] then
                    if r17.name == v1[2] then
                        if r2 then
                            r22 = {ipairs(r2.items)}
                            if r22[3] then
                                if r2.items.name == v1[3] then
                                    table.remove(r2.items, r22[3])
                                end
                            end
                        end
                    end
                end
            end
            v2[q()] = "/storage/emulated/0/Android/data/com.sandboxol.blockymods/mb/resmdc5.json"
            r66 = {tab = r72}
            Env.KhdCustom = r66
            function GMHelper.AddCustomTab(...)
                r8 = {"Name:"}
                v1[1]:openInput(r8, function(...) end)
            end
            function GMHelper.AddItemTab(...)
                r8 = {"TabName:", "ItemName:"}
                v1[1]:openInput(r8, function(...) end)
            end
            local r81 = function(...)
                if io.open(v2[v3[1]], "rb") then
                    r8 = io.open(v2[v3[1]], "rb"):read("*a") or "{}"
                    r2 = (io.open(v2[v3[1]], "rb") and 11194351) or 13718925
                    if json.decode(a) then
                        Env.KhdCustom = json.decode(a)
                        r17 = {pairs(KhdCustom.tab)}
                        if r17[3] then
                            GMSetting:addTab(r17[3])
                            r27 = {pairs(KhdCustom.tab.item)}
                            if r27[3] then
                                GMSetting:addItem(r17[3], r27[3], KhdCustom.tab.item)
                            end
                        end
                    end
                end
            end
            function r5.onDataChanged(...)
                v1[1].data = v1[2]
                if v1[1].data.func == "nil" then
                    v1[1].tvItem:SetBackgroundColor(Color.TRANS)
                    v1[1].tvItem:SetProperty("Font", "HT14")
                    v1[1].tvItem:SetText(v1[2].name)
                    if v1[1].tvItem:GetTextWidth() > r8 then
                        v1[1].tvItem:SetProperty("Font", "HT12")
                        if v1[1].tvItem:GetTextWidth() > r8 then
                            v1[1].tvItem:SetProperty("Font", "HT10")
                            if v1[1].data.color then
                                v1[1].tvItem:SetBackgroundColor(v1[1].data.color)
                            end
                        end
                    end
                end
            end
            function r3.onLoad(...)
                v1[1].root:SetLevel(2)
                v1[1].btnOpen = v1[1]:getChildWindow("GMMain-Open", GUIType.Button)
                v1[1].btnOpen:registerEvent(GUIEvent.ButtonClick, function(...) end)
                v1[1].btnOpen:SetVisible(false)
            end
            function r10.onLoad(...)
                v2[q()] = v1[1]
                v2[q()].tvTab = v2[q()]:getChildWindowByName("GMButton", GUIType.StaticText)
                r8 = v1[1].tvItem:GetPixelSize().x
                r8 = v2[q()]
                r8.tvTab:registerEvent(GUIEvent.Click, function(...) end)
                I(q())
            end
            v2[q()] = nil
            function r4.onLoad(...)
                v2[q()] = v1[1]
                v2[q()].tvTab = v2[q()]:getChildWindowByName("GMButton", GUIType.StaticText)
                r8 = v2[q()]
                r2 = {VectorUtil.newVector3(0.9, 0.9, 0.9)}
                r8.tvTab:SetScale(v5(r2))
                r8 = v2[q()]
                r8.tvTab:SetProperty("Font", "HT14")
                r5 = v2[q()]
                if r8:GetTextWidth() > r8 then
                    r8 = r5.tvTab:GetPixelSize().x
                    r8 = v2[q()]
                    r8.tvTab:SetProperty("Font", "HT12")
                    r5 = v2[q()]
                    if r8:GetTextWidth() > r8 then
                        r8 = r5.tvTab:GetPixelSize().x
                        r8 = v2[q()]
                        r8.tvTab:SetProperty("Font", "HT10")
                        r8 = v2[q()]
                        local r2 = function(...)
                            if v2[v3[1]] then
                                if v2[v3[1]] ~= v2[v3[2]] then
                                    v2[v3[1]]:resetTabColor()
                                    v2[v3[1]] = v2[v3[2]]
                                    v2[v3[2]]:setSelectedTabColor()
                                    GUIGMControlPanel:selectTab(v2[v3[2]].name)
                                end
                            end
                        end
                        local r2 = function(...)
                            v2[v3[1]] = v2[v3[1]] + 0.05
                            r8 = 0.5 + 0.5 * math.sin(v2[v3[1]])
                            if v2[v3[2]].tvTab then
                                r10 = {0.8 * r6, 0.8 - 0.6 * r6, 1, 0.8}
                                v2[v3[2]].tvTab:SetTextColor(r10)
                                v2[v3[2]].tvTab:SetBordered(true)
                            end
                        end
                        v2[q()] = 0
                        r8.tvTab:registerEvent(GUIEvent.Click, r2)
                        LuaTimer:scheduleTimer(r2, 100, -1)
                        r8 = v2[q()]:resetTabColor()
                        I(q())
                        I(q())
                    end
                end
            end
            function r4.setSelectedTabColor(...)
                v1[1].tvTab:SetBackgroundColor({0.2, 0.4, 1, 0.7})
                SoundUtil.playSound(0)
            end
            function r4.resetTabColor(...)
                v1[1].tvTab:SetBackgroundColor({0, 0, 0, 0.7})
                SoundUtil.playSound(0)
            end
            function r4.onTabChange(...)
                if v1[2] ~= v1[1].name then
                    v1[1]:resetTabColor()
                    v2[v3[1]]:onDataChanged(data)
                    GMSetting:addItem(itemName)
                end
            end
            function r81.onItemChange(...)
                if v1[2] ~= v1[1].name then
                    v2[v3[1]]:onDataChanged(data)
                    GMSetting:addItem(itemName)
                end
            end
            function Env.Teleport1(...)
                v2[q()] = v1[1]
                PlayerManager:getClientPlayer().Player:getPosition()
                r2 = v2[q()]
                r5 = v2[q()]
                if math.sqrt(r2.x - x * r2.x - x + r5.z - z * r5.z - z) < 45 then
                    r4 = v2[q()]
                    v2[q()] = checkBlockSafe(r4)
                    r4 = v2[q()]
                    PlayerManager:getClientPlayer().Player:setPosition(r4)
                    PlayerManager:getClientPlayer().Player:setAllowFlying(false)
                    PlayerManager:getClientPlayer().Player:setFlying(false)
                end
                if y < 165 then
                    r3 = {x, 165, z}
                    r4 = PlayerManager:getClientPlayer().Player:setPosition()
                    if math.abs(r2.x - x) > 8 then
                        r3 = math.abs(r5.z - z) > 8
                        if r3 then
                            r3 = PlayerManager:getClientPlayer().Player:setPosition()
                            local r22 = function(...)
                                Teleport1(v2[v3[1]])
                            end
                            I(q())
                            LuaTimer:scheduleTimer(r22, 20, 1)
                        end
                        r22 = v2[q()]
                    end
                    r22 = v2[q()]
                end
            end
            function Env.distanceM(...)
                r8 = v2[q()].y
                r8 = {math.sqrt(v1[1].x - v1[2].x * v1[1].x - v1[2].x + v1[1].y - v1[2].y * v1[1].y - v1[2].y + v1[1].z - v1[2].z * v1[1].z - v1[2].z)}
                r8 = {v5(r8)}
            end
            function Env.Teleport(...)
                v2[q()] = v1[1]
                if not PlayerManager:getClientPlayer() then
                    v2[q()] = PlayerManager:getClientPlayer().Player
                    r8 = v2[q()]:setAllowFlying()
                    r8 = v2[q()]:setFlying()
                    r8 = v2[q()]:getPosition()
                    v2[q()] = r8
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r17 = v2[q()]
                    r22 = v2[q()]
                    r18 = v2[q()]
                    r25 = v2[q()]
                    v2[q()] = {x = r17.x - r22.x, z = r18.z - r25.z}
                    r18 = v2[q()]
                    r25 = v2[q()]
                    r25 = v2[q()]
                    r21 = v2[q()]
                    v2[q()] = 25
                    r25 = v2[q()]
                    local r22 = function(...)
                        r8 = {math.abs(v2[v3[1]][v1[1]]) > v2[v3[2]]}
                    end
                    local r18 = function(...)
                        if v2[v3[2]][v1[1]] > 0 then
                            if v2[v3[3]] then
                                v2[v3[1]][v1[1]] = v2[v3[1]][v1[1]] + v2[v3[3]]
                                v2[v3[4]]:setPosition(v2[v3[1]])
                                LuaTimer:scheduleTimer(function(...) end, 0.01, 1)
                            end
                        end
                    end
                    if r25.y < 165 then
                        v2[q()].y = 82.5
                        r22("x")
                        if D then
                            r18("x")
                        end
                        r22("z")
                        if D then
                            r18("z")
                        end
                        local r25 = function(...)
                            if EngineWorld:getBlockId(v1[1]) ~= BlockID.AIR then
                                v1[1].y = v1[1].y + 1
                                if v1[1].y > 256 then
                                    r8 = {v1[1]}
                                end
                            end
                        end
                        r8 = v2[q()]
                        r25(r8)
                        v2[q()] = D
                        r12 = v2[q()]
                        r30 = v2[q()]
                        r30 = v2[q()]
                        r8 = v2[q()]
                        r8.noClip = true
                        r8 = v2[q()]
                        r8:setPosition(VectorUtil.newVector3(r12.x, r30.y + 1.3, r30.z))
                        r8 = v2[q()]
                        r8.noClip = false
                        r8 = v2[q()]
                        r8:setPosition(VectorUtil.newVector3(r12.x, r30.y + 1.3, r30.z))
                        r8 = v2[q()]
                        r8 = v2[q()]
                        r8 = v2[q()]
                        r8:setAllowFlying(true)
                        r8 = v2[q()]
                        r8:setFlying(false)
                        local r12 = function(...)
                            if math.sqrt(r8 - v2[v3[2]].x * r8 - v2[v3[2]].x + r8 - v2[v3[2]].y * r8 - v2[v3[2]].y + r8 - v2[v3[2]].z * r8 - v2[v3[2]].z) > 3 then
                                Teleport(v2[v3[2]])
                            end
                        end
                        I(q())
                        I(q())
                        I(q())
                        LuaTimer:scheduleTimer(r12, 0.025, 1)
                        I(q())
                        I(q())
                    end
                end
            end
            function Env.dist(...)
                r8 = v2[v3[1]]:getPosition().z
                r8 = {math.sqrt(v1[1].x - v1[2].x * v1[1].x - v1[2].x + v1[1].y - v1[2].y * v1[1].y - v1[2].y + v1[1].z - v1[2].z * v1[1].z - v1[2].z)}
                r8 = {v5(r8)}
            end
            function Env.tport(...)
                v2[q()] = v1[1]
                if not PlayerManager:getClientPlayer() then
                    v2[q()] = PlayerManager:getClientPlayer().Player
                    r8 = v2[q()]:setAllowFlying()
                    r8 = v2[q()]:setFlying()
                    r8 = v2[q()]:getPosition()
                    v2[q()] = r8
                    r8 = v2[q()]
                    r5 = v2[q()]
                    r17 = v2[q()]
                    r2 = PlayerManager:getClientPlayer().Player
                    r22 = v2[q()]
                    r18 = v2[q()]
                    r25 = v2[q()]
                    v2[q()] = {x = r17.x - r22.x, z = r18.z - r25.z}
                    v2[q()] = 25
                    r18 = v2[q()]
                    local r17 = function(...)
                        r8 = {math.abs(v2[v3[1]][v1[1]]) > v2[v3[2]]}
                    end
                    local r22 = function(...)
                        if v2[v3[2]][v1[1]] > 0 then
                            if v2[v3[3]] then
                                v2[v3[1]][v1[1]] = v2[v3[1]][v1[1]] + v2[v3[3]]
                                v2[v3[4]]:setPosition(v2[v3[1]])
                                LuaTimer:scheduleTimer(function(...) end, 15, 1)
                            end
                        end
                    end
                    if r18.y < 85 then
                        v2[q()].y = 85
                        r17("x")
                        if D then
                            r22("x")
                        end
                        r17("z")
                        if D then
                            r22("z")
                        end
                        r8 = v2[q()]
                        local r18 = function(...)
                            if EngineWorld:getBlockId(v1[1]) ~= BlockID.AIR then
                                v1[1].y = v1[1].y + 1
                                if v1[1].y > 256 then
                                    r8 = {v1[1]}
                                end
                            end
                        end
                        r18(r8)
                        v2[q()] = D
                        r27 = v2[q()]
                        r31 = PlayerManager:getClientPlayer().Player
                        r31 = v2[q()]
                        r31 = v2[q()]
                        r8 = v2[q()]
                        r8.noClip = true
                        r8 = v2[q()]
                        r8:setPosition(VectorUtil.newVector3(r27.x, r31.y + 1.3, r31.z))
                        r8 = v2[q()]
                        r8.noClip = false
                        r8 = v2[q()]
                        r8:setPosition(VectorUtil.newVector3(r27.x, r31.y + 1.3, r31.z))
                        r8 = v2[q()]
                        r8 = v2[q()]
                        r8.rotationPitch = r5.rotationPitch
                        r8 = v2[q()]
                        r8:setAllowFlying(true)
                        r8 = v2[q()]
                        r8:setFlying(false)
                        local r27 = function(...)
                            if dist(v2[v3[1]]:getPosition(), v2[v3[2]]) > 3 then
                                tport(v2[v3[2]])
                            end
                        end
                        I(q())
                        I(q())
                        I(q())
                        I(q())
                        LuaTimer:scheduleTimer(r27, 25, 1)
                        I(q())
                    end
                end
            end
            function Env.digusur(...)
                if not PlayerManager:getClientPlayer() then
                    v2[q()] = PlayerManager:getClientPlayer().Player
                    r8 = v2[q()]:getPosition()
                    r8 = v2[q()]:getPosition()
                    if not v1[2] then
                        r17 = {string.format("\226\150\162FF00FF00move dis : %.2f", distanceM(r5, v1[1]))}
                        UIHelper.showToast(v5(r17))
                        r8 = v2[q()]:setAllowFlying()
                        r8 = v2[q()]:setFlying()
                        r2 = PlayerManager:getClientPlayer().Player
                        r22 = {distanceM(r5, v1[1])}
                        if math.abs(v5(r22)) <= 55 then
                            fastTeleport(v1[1], true)
                        end
                        v2[q()] = v1[1]
                        local r22 = function(...)
                            if distanceM(v2[v3[1]]:getPosition(), v2[v3[2]]) < 20 then
                                v2[v3[1]]:setPosition(v2[v3[2]])
                                v2[v3[1]]:setFlying(false)
                            end
                        end
                        Teleport(VectorUtil.newVector3(v1[1].x, v1[1].y + 1.8, v1[1].z))
                        LuaTimer:scheduleTimer(r22, 10, 1)
                        I(q())
                        I(q())
                    end
                end
            end
            r81 = v2[q()]
            function r81.tryPlaceBlock(...)
                if not isGameStart then
                    r8 = {false}
                end
                if not v1[3] then
                    r8 = {false}
                end
                v1[2]:getInventory()
                r10:getRealCurrentItem()
                if not r4 then
                    r8 = {false}
                end
                r4:getItem()
                if not r3 then
                    r8 = {false}
                end
                r22 = Blockman.Instance():getPlayer()
                r18 = Blockman.Instance():getWorld()
                if r3:onItemUse(r4, r22, r18, v1[3], v1[4], v1[3]) then
                    r22 = r4:getItemStackSize() == 0
                    if r22 then
                        r10:decrStackSize(r10:findItemStack(r4), 0)
                        v1[2].Player:swingItem()
                        r18 = {pid = "TryPlaceBlock", position = v1[3], face = v1[4], source = v1[5] or "screen"}
                        v1[2]:sendPacket(r18)
                        r8 = {true}
                    end
                end
                r8 = {false}
            end
            r71 = {2441, 2442, 2443, 2444, 5, 121, 49, 95}
            v2[q()] = r71
            local r71 = function(...)
                if v1[1] % 360 < 0 then
                    r8 = {v1[1] % 360 + 360}
                end
            end
            local r82 = function(...)
                v1[1]:getInventory()
                if not r2 then
                    r8 = {false}
                end
                r2:getCurrentItemIndexInMain()
                if (false and false) or (not false and true) then
                    r2:getItemStackInfo(0)
                    if r25 then
                        if r25.id then
                            if r25.num > 0 then
                                if (false and 1 >= #v2[v3[1]]) or (not false and 1 <= #v2[v3[1]]) then
                                    if r25.id == v2[v3[1]][1] then
                                        if 0 then
                                            if not 0 then
                                                r8 = {false}
                                            end
                                            r2:setCurrentItemIndexInMain(0)
                                            r8 = {v2[v3[2]]:tryPlaceBlock(v1[1], v1[2], v1[3], "auto")}
                                            r2:setCurrentItemIndexInMain(r5)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Env.norm_deg = r71
            local r71 = function(...)
                if v1[1] + 450 % 360 < 0 then
                    if v1[1] + 450 % 360 + 360 < 45 then
                        r8 = {1, 0}
                    end
                    if v1[1] + 450 % 360 + 360 >= 45 then
                        if v1[1] + 450 % 360 + 360 < 135 then
                            r8 = {0, 1}
                        end
                        if v1[1] + 450 % 360 + 360 >= 135 then
                            if v1[1] + 450 % 360 + 360 < 225 then
                                r8 = {-1, 0}
                            end
                            r8 = {0, -1}
                        end
                    end
                end
            end
            v2[q()] = r82
            function GMHelper.TpTeamGreenNew(...)
                tport(VectorUtil.newVector3(565.6, 17.62, 66.16))
                GUIGMControlPanel:hide()
            end
            local r82 = function(...)
                tport(VectorUtil.newVector3(480.45, 16.62, 67.71))
                GUIGMControlPanel:hide()
            end
            r8 = os.clock() * (v1[1] or 1)
            r8 = r8 % 1 * 6 - math.floor(r8 % 1 * 6)
            I(q())
            I(q())
            q()
            r38 = {1, B, 0, 1}
            r8 = {r38}
            GMHelper.TpTeamRedNew = r82
            function GMHelper.TpTeamYellowNew(...)
                tport(VectorUtil.newVector3(478.83, 17.62, -20.16))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpTeamBlueNew(...)
                tport(VectorUtil.newVector3(566.29, 17.62, -21.16))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpMidNew(...)
                tport(VectorUtil.newVector3(521.4, 48.62, 22.7))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpTeamGreenOld(...)
                tport(VectorUtil.newVector3(127.87, 24.62, 507.99))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpTeamRedOld(...)
                tport(VectorUtil.newVector3(66.89, 24.62, 445.73))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpTeamYellowOld(...)
                tport(VectorUtil.newVector3(189.33, 24.62, 446.17))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpTeamBlueOld(...)
                tport(VectorUtil.newVector3(127.95, 24.62, 384.4))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpMidOld(...)
                tport(VectorUtil.newVector3(126.6, 24.62, 445.29))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToRespawn(...)
                tport(VectorUtil.newVector3(-637.6, 75.62, -755.52))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToJail(...)
                tport(VectorUtil.newVector3(-615.14, 75.62, -791.87))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToPolice(...)
                tport(VectorUtil.newVector3(-600.72, 75.62, -832.14))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToBlackMarket(...)
                tport(VectorUtil.newVector3(-536.26, 75.62, -763.09))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToBank(...)
                tport(VectorUtil.newVector3(-964.08, 75.62, -787.3))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToMall(...)
                tport(VectorUtil.newVector3(-955.89, 75.62, -1004.55))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToHospital(...)
                tport(VectorUtil.newVector3(-703.69, 75.62, -1072.98))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToMansion(...)
                tport(VectorUtil.newVector3(-565.13, 75.62, -1009.87))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToINN(...)
                tport(VectorUtil.newVector3(-484.5, 75.62, -983.51))
                GUIGMControlPanel:hide()
            end
            function GMHelper.tp_flag1(...)
                tport(VectorUtil.newVector3(-173.54, 67.62, -22.4))
                GUIGMControlPanel:hide()
            end
            function GMHelper.tp_flag2(...)
                tport(VectorUtil.newVector3(60.4, 67.62, -52.78))
                GUIGMControlPanel:hide()
            end
            function GMHelper.TpToMid(...)
                if not PlayerManager:getClientPlayer() then
                    RootGuiLayout.Instance():showMainControl()
                    tport(PacketSender:sendLuaCommonData("TeleportHallInitPos"))
                    GUIGMControlPanel:hide()
                end
            end
            Env.TpClickCallbackId = nil
            function GMHelper.TeleportClick(...)
                Env.togTeleportClick = not togTeleportClick
                if togTeleportClick then
                    local r8 = function(...)
                        if not togTeleportClick then
                            if not PlayerManager:getClientPlayer() then
                                if not r8 then
                                    UIHelper.showToast("^FF0000Must be on ground")
                                end
                                r10 = {math.floor(v1[1].z)}
                                r8 = PlayerManager:getClientPlayer().Player:setPosition()
                            end
                        end
                    end
                    Env.TpClickCallbackId = Listener.registerCallBack(CEvents.ClickToBlockEvent, B)
                end
                if TpClickCallbackId then
                    Env.TpClickCallbackId = nil
                end
            end
            function GMHelper.Aeeeeee(...)
                Env.togAeeeeee = not togAeeeeee
                if togAeeeeee then
                    v1[1].doubleJumpCount = 999999999999
                end
                v1[1].doubleJumpCount = 1
            end
            function GMHelper.NoKnockBack(...)
                Env.togNoKnockBack = not togNoKnockBack
                v2[q()] = nil
                v2[q()] = nil
                if togNoKnockBack then
                    local r17 = function(...)
                        if not PlayerManager:getClientPlayer() then
                            PlayerManager:getClientPlayer().Player:getHealth()
                            PlayerManager:getClientPlayer().Player:getPosition()
                            if v2[v3[1]] then
                                if B < v2[v3[1]] then
                                    if v2[v3[2]] then
                                        PlayerManager:getClientPlayer().Player:setPosition(v2[v3[2]])
                                        v2[v3[1]] = D
                                        v2[v3[2]] = r8
                                    end
                                end
                            end
                        end
                    end
                    UIHelper.showToast("^00FF00Enabled")
                    v2[q()] = nil
                    v2[q()] = nil
                    v1[1].NoKnockbackTimer = LuaTimer:scheduleTimer(r17, 10, -1)
                    I(q())
                    I(q())
                end
                UIHelper.showToast("^FF0000Disabled")
                if v1[1].NoKnockbackTimer then
                    LuaTimer:cancel(v1[1].NoKnockbackTimer)
                    v1[1].NoKnockbackTimer = nil
                    v2[q()] = nil
                    v2[q()] = nil
                end
            end
            v2[q()] = nil
            function GMHelper.HitBox(...)
                Env.togHitBox = not togHitBox
                if v2[v3[1]] then
                    v2[v3[1]] = nil
                    LuaTimer:cancel(v2[v3[1]])
                    if togHitBox then
                        local r2 = function(...)
                            r5 = PlayerManager:getClientPlayer().Player
                            r5 = {ipairs(PlayerManager:getPlayers())}
                            if r5[3] then
                                r17 = r4 ~= PlayerManager:getClientPlayer()
                                if r17 then
                                    if r4.Player then
                                        r4.Player.height = 6
                                        r4.Player.width = 6
                                        r4.Player.length = 6
                                    end
                                end
                            end
                        end
                        v2[v3[1]] = LuaTimer:scheduleTimer(r2, 500, -1)
                    end
                    UIHelper.showToast("^FF0000Disabled")
                    r3 = {ipairs(PlayerManager:getPlayers())}
                    if r3[3] then
                        if r3.Player then
                            r3.Player.height = 1.8
                            r3.Player.width = 0.6
                            r3.Player.length = 0.6
                        end
                    end
                end
            end
            function GMHelper.HitBoxV2(...)
                Env.togHitBoxV2 = not togHitBoxV2
                v2[q()] = PlayerManager:getClientPlayer()
                r8 = v2[q()]
                local r8 = function(...)
                    r5 = {pairs(PlayerManager:getPlayers())}
                    if r5[3] then
                        if r4 ~= v2[v3[1]] then
                            r17 = r4:getTeamId() ~= v2[v3[2]]
                            if r3 then
                                r4:getPosition()
                                if MathUtil:distanceSquare2d(r3, v2[v3[1]]:getPosition()) < 40 then
                                    r12 = {math.floor(r3.z)}
                                    Zentex(r4.entityId, VectorUtil.newVector3(math.floor(r3.x), math.floor(r3.y), v5(r12)))
                                end
                            end
                        end
                    end
                end
                v2[q()] = r8:getTeamId()
                if togHitBoxV2 then
                    UIHelper.showToast("Enabled")
                    CEvents.PlayerClickScreenEvent:registerCallBack(a)
                    I(q())
                    I(q())
                end
                UIHelper.showToast("Disabled")
                CEvents.PlayerClickScreenEvent:unregisterAll()
            end
            function GMHelper.setP(...)
                Env.togsetP = not togsetP
                r2 = PlayerManager:getClientPlayer().Player
                r2 = {0, 0, 0, 0.784314}
                if togsetP then
                    GUIGMControlPanel:setBackgroundColor(Color.TRANS)
                end
            end
            function GMHelper.AntiVoid(...)
                Env.togAntiVoid = not togAntiVoid
                v2[q()] = PlayerManager:getClientPlayer()
                if togAntiVoid then
                    v2[q()] = r8:getPosition()
                    if CheckBlockPos then
                        Env.CheckBlockPos = CheckBlockPos
                        if AntiVoidChecker then
                            Env.AntiVoidChecker = AntiVoidChecker
                            I(q())
                            I(q())
                        end
                        local r3 = function(...)
                            if not v2[v3[1]].Player.onGround then
                                r6 = v2[v3[1]].Player:getPosition().y < 0
                                if r8 then
                                    tport(v2[v3[2]])
                                    v2[v3[1]].Player.fallDistance = 0
                                end
                            end
                        end
                    end
                    local r4 = function(...)
                        if v2[v3[1]].Player.onGround then
                            v2[v3[2]] = v2[v3[1]].Player:getPosition()
                        end
                    end
                end
                UIHelper.showToast("^FF0000Disabled")
                if AntiVoidChecker then
                    LuaTimer:cancel(AntiVoidChecker)
                    Env.AntiVoidChecker = nil
                    if CheckBlockPos then
                        LuaTimer:cancel(CheckBlockPos)
                        Env.CheckBlockPos = nil
                    end
                end
            end
            function GMHelper.Reach(...)
                Env.togReach = not togReach
                if togReach then
                    if not reachTimer then
                        Env.reachTimer = LuaTimer:scheduleTimer(function(...) end, 20, -1)
                    end
                end
                if reachTimer then
                    Env.reachTimer = nil
                    Env.togReachToggle = false
                    ClientHelper.putFloatPrefs("BlockReachDistance", 4.5)
                    ClientHelper.putFloatPrefs("EntityReachDistance", 3)
                end
            end
            function GMHelper.WWE_Camera(...)
                Env.togWWE_Camera = not togWWE_Camera
                if togWWE_Camera then
                    UIHelper.showToast("^00FF00Enabled")
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.BowSpeed(...)
                Env.togBowSpeed = not togBowSpeed
                if togBowSpeed then
                    UIHelper.showToast("^00FF00Enabled")
                    GUIGMControlPanel:hide()
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            local r65 = function(...)
                Env.togBanClickCD = not togBanClickCD
                if togBanClickCD then
                    UIHelper.showToast("^00FF00Enabled")
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            local r91 = function(...)
                if io.open(v1[1], "wb") then
                    r2 = (io.open(v1[1], "wb") and 5285972) or 5805853
                    io.open(v1[1], "wb"):write(v1[2] or "")
                    r8 = io.open(v1[1], "wb"):close()
                end
            end
            GMHelper.BanClickCD = r65
            function GMHelper.HideChat(...)
                Env.togHideChat = not togHideChat
                if togHideChat then
                    r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                    r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                end
                r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
            end
            v2[q()] = "^FFFFFF"
            function GMHelper.applyColorToChat(...)
                if v1[2] == "Red" then
                    v2[v3[1]] = "^FF0000"
                    r19 = GUIManager:getWindowByName("Chat-Input-Box"):GetText()
                    r48 = PlayerManager:getClientPlayer().Player.m_hatId
                    r48 = v2[v3[1]] .. r19:sub(8)
                    r33 = GUIManager:getWindowByName("Chat-Input-Box"):SetText()
                end
                if v1[2] == "Green" then
                    v2[v3[1]] = "^00FF00"
                end
                if v1[2] == "Blue" then
                    v2[v3[1]] = "^0000FF"
                end
                if v1[2] == "Yellow" then
                    v2[v3[1]] = "^FFFF00"
                end
                if v1[2] == "Cyan" then
                    v2[v3[1]] = "^00FFFF"
                end
                if v1[2] == "Magenta" then
                    v2[v3[1]] = "^FF00FF"
                end
                if v1[2] == "Black" then
                    v2[v3[1]] = "^000000"
                end
                if v1[2] == "White" then
                    v2[v3[1]] = "^FFFFFF"
                end
                if v1[2] == "Orange" then
                    v2[v3[1]] = "^FFA500"
                end
                if v1[2] == "Purple" then
                    v2[v3[1]] = "^800080"
                end
                if v1[2] == "Pink" then
                    v2[v3[1]] = "^FFC0CB"
                end
                if v1[2] == "Brown" then
                    v2[v3[1]] = "^A52A2A"
                end
                if v1[2] == "Gray" then
                    v2[v3[1]] = "^808080"
                end
                if v1[2] == "LightBlue" then
                    v2[v3[1]] = "^ADD8E6"
                end
                if v1[2] == "Indigo" then
                    v2[v3[1]] = "^4B0082"
                end
                if v1[2] == "Violet" then
                    v2[v3[1]] = "^8A2BE2"
                end
                if v1[2] == "Gold" then
                    v2[v3[1]] = "^FFD700"
                end
                if v1[2] == "Silver" then
                    v2[v3[1]] = "^C0C0C0"
                end
                if v1[2] == "Teal" then
                    v2[v3[1]] = "^008080"
                end
                if v1[2] == "Lime" then
                    v2[v3[1]] = "^00FF00"
                end
                if v1[2] == "Turquoise" then
                    v2[v3[1]] = "^40E0D0"
                end
                if v1[2] == "Salmon" then
                    v2[v3[1]] = "^FA8072"
                end
                if v1[2] == "Crimson" then
                    v2[v3[1]] = "^DC143C"
                end
                if v1[2] == "Olive" then
                    v2[v3[1]] = "^808000"
                end
                if v1[2] == "Navy" then
                    v2[v3[1]] = "^000080"
                end
                if v1[2] == "Maroon" then
                    v2[v3[1]] = "^800000"
                end
                if v1[2] == "Lavender" then
                    v2[v3[1]] = "^E6E6FA"
                end
                if v1[2] == "Coral" then
                    v2[v3[1]] = "^FF7F50"
                end
                v2[v3[1]] = "^FFFFFF"
            end
            function GMHelper.Speed(...)
                Env.togSpeed = not togSpeed
                if PlayerManager:getClientPlayer() then
                    if togSpeed then
                        if r8 then
                            r8 = PlayerManager:getClientPlayer().info
                            r8:setValue("addSpeed", 1500)
                            UIHelper.showToast("^00FF00Bypass Enabled")
                        end
                    end
                    if r8 then
                        r8 = PlayerManager:getClientPlayer().info
                        r8:setValue("addSpeed", 7)
                        UIHelper.showToast("^FF0000Bypass Disabled")
                    end
                end
            end
            function GMHelper.SpeedSB(...)
                Env.togSpeedSB = not togSpeedSB
                if PlayerManager:getClientPlayer() then
                    if togSpeedSB then
                        if r8 then
                            r8 = PlayerManager:getClientPlayer().info
                            r8:setValue("addSpeed", 1500)
                            UIHelper.showToast("^00FF00Bypass Enabled")
                        end
                    end
                    if r8 then
                        r8 = PlayerManager:getClientPlayer().info
                        r8:setValue("addSpeed", 0)
                        UIHelper.showToast("^FF0000Bypass Disabled")
                    end
                end
            end
            function GMHelper.AtkBtn(...)
                Env.togAtkBtn = not togAtkBtn
                v2[q()] = GUIManager:getWindowByName("Main-Attack-btn-img")
                r8 = PlayerManager:getClientPlayer().Player
                r8 = v2[q()]
                r8:SetProperty("ImageName", "set:main_btn.json image:skill_btn")
                GUIManager:getWindowByName("Main-Attack-btn")
                GUIManager:getWindowByName("Main-Main-Attack-Operate")
                if togAtkBtn then
                    r8 = GUIManager:getWindowByName("Main-Main-Attack-Operate"):SetVisible()
                    r8 = GUIManager:getWindowByName("Main-Main-Attack-Operate"):SetAlwaysOnTop()
                    r8 = GUIManager:getWindowByName("Main-Main-Attack-Operate"):SetLevel()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):setEnableLongTouch()
                    local r8 = function(...)
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
                        r8 = {0, 0}
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetXPosition(r8)
                        r8 = {0, -170}
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetYPosition(r8)
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetAlpha(0)
                        GUISystem.Instance():GetRootWindow()
                        D:AddChildWindow(GUIManager:getWindowByName("Main-throwpot-Controls"))
                        r8 = Blockman.Instance().m_gameSettings:setCollimatorMode()
                        CGame.Instance():handleTouchClick(1, 1)
                        v2[v3[1]]:SetProperty("DrawColor", "0 1 1 1")
                    end
                    local r8 = function(...)
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(false)
                        r8 = {0, 0}
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetXPosition(r8)
                        r8 = {0, -170}
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetYPosition(r8)
                        r8 = Blockman.Instance().m_gameSettings:setCollimatorMode()
                    end
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    r8 = GUIManager:getWindowByName("Main-Attack-btn"):registerEvent()
                    local r10 = function(...)
                        GUIManager:getWindowByName("Main-Attack-btn-img"):SetProperty("ImageName", "set:main_btn.json image:skill_btn")
                    end
                    I(q())
                    LuaTimer:scheduleTimer(r10, 50, -1)
                end
                r8 = GUIManager:getWindowByName("Main-Main-Attack-Operate"):SetVisible()
            end
            function GMHelper.DmgInc(...)
                Env.togDmgInc = not togDmgInc
                if not togDmgInc then
                    UIHelper.showToast("^FF0000Disabled")
                end
                v2[q()] = r8
                local r8 = function(...)
                    r10 = {ipairs(v2[v3[1]])}
                    if r10[3] then
                        if r4.entityId == v1[1] then
                            r4.hp = v1[2]
                        end
                    end
                    r5 = PlayerManager:getClientPlayer().Player
                    r5 = {entityId = v1[1], hp = v1[2]}
                    table.insert(v2[v3[1]], r5)
                end
                v2[q()] = r8
                local r5 = function(...)
                    if PlayerManager:getPlayerByUserId(v1[1]) then
                        r8 = PlayerManager:getPlayerByUserId(v1[1]) ~= PlayerManager:getClientPlayer()
                        if r8 then
                            r2 = {r5(PlayerManager:getPlayerByUserId(v1[1]))}
                            v2[v3[1]](PlayerManager:getPlayerByUserId(v1[1]).entityId, v5(r2))
                        end
                    end
                end
                CEvents.PlayerLoginEvent:registerCallBack(r5)
                local r5 = function(...)
                    v2[q()] = v1[1]
                    v2[q()] = v1[2]
                    LuaTimer:schedule(function(...) end, 1000)
                    I(q())
                    I(q())
                end
                CEvents.EntityHealthChangeEvent:registerCallBack(r5)
                local r5 = function(...)
                    r10 = {ipairs(v2[v3[1]])}
                    if r10[3] then
                        if r4.entityId == v1[1] then
                            PlayerManager:getPlayerByEntityId(v1[1]):getHealth()
                            if r4.hp - r3 > 0 then
                                r25 = {x = 0, y = 1, z = 0}
                                PlayerManager:getPlayerByEntityId(v1[1]):getPosition()
                                r27 = {x = r21.x + r25.x, y = r21.y + r25.y, z = r21.z + r25.z}
                                r31 = ("number_") .. math.floor(r4.hp - r3 + 0.5)
                                WorldImageRender.Instance():addFloatNumber(r31, r27, 0.9, 1)
                            end
                        end
                    end
                end
                CEvents.AttackEntityEvent:registerCallBack(r5)
                r3 = {PlayerManager:getPlayers()}
                r4 = {pairs(v5(r3))}
                if r4[3] then
                    r8 = r3 ~= PlayerManager:getClientPlayer()
                    if r8 then
                        r8 = v2[q()]
                        r18 = {r3:getHealth()}
                        r17 = r8(r3.entityId, v5(r18))
                    end
                end
                I(q())
                I(q())
            end
            v2[q()] = "/sdcard/Android/data/com.sandboxol.blockymods/files/Download/stat.txt"
            v2[q()] = r78
            v2[q()] = r91
            function Env.setVisible(...)
                r5 = PlayerManager:getPlayerByUserId(v1[1]).getHealth
                r5 = {pairs({"GUIRoot-xuy60", "GUIRoot-Position", "GUIRoot-InfoDevice", "GUIRoot-PlayerCounter", "GUIRoot-Online"})}
                if r5[3] then
                    if GUIManager:getWindowByName(r4) then
                        GUIManager:getWindowByName(r4):SetVisible(not v1[1])
                    end
                end
                if GUIManager:getWindowByName("GMMain-Open") then
                    r5 = (GUIManager:getWindowByName("GMMain-Open") and 13459144) or 4428160
                    r4 = (GUIManager:getWindowByName("GMMain-Open") and 13459144) or 4428160
                    GUIManager:getWindowByName("GMMain-Open"):SetAlpha((v1[1] and 0) or 1)
                end
            end
            function GMHelper.HidePanel(...)
                Env.togHidePanel = not togHidePanel
                r5 = {tostring(togHidePanel)}
                if togHidePanel then
                    UIHelper.showToast("^00FF00Enabled")
                    LuaTimer:schedule(function(...) end, 10)
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            local r95 = function(...)
                r2 = v2[v3[1]](v2[v3[2]]) == "true"
                setVisible((r2 and true) or false)
            end
            LuaTimer:scheduleTimer(r95, 1, -1)
            function GMHelper.MovablePanel(...)
                Env.togMovablePanel = not togMovablePanel
                if togMovablePanel then
                    v2[q()] = GUIManager:getWindowByName("GMMain-Open")
                    Env.togmoving = not togmoving
                    if togmoving then
                        if GUIManager:getWindowByName("Main") then
                            r5 = v2[q()]
                            GUIManager:getWindowByName("Main"):AddChildWindow(r5)
                            r5 = v2[q()]:SetHorizontalAlignment()
                            r5 = v2[q()]:SetVerticalAlignment()
                            r10 = {0, 80}
                            r5 = v2[q()]:SetWidth()
                            r10 = {0, 80}
                            r5 = v2[q()]:SetHeight()
                            r5 = v2[q()]:SetTouchable()
                            r10 = v2[q()]
                            r5 = GUISystem.Instance():GetRootWindow():AddChildWindow()
                            UIHelper.showToast("^00FF00Enabled")
                            r5 = v2[q()]:SetVisible()
                            r10 = {0, -273}
                            r5 = v2[q()]:SetYPosition()
                            r10 = {0, 0}
                            r5 = v2[q()]:SetXPosition()
                            r5 = v2[q()]
                            r5 = v2[q()]
                            r5:registerEvent(GUIEvent.TouchMove, function(...) end)
                            local r3 = function(...)
                                GUIGMControlPanel:show()
                                local r6 = function(...)
                                    -- empty body
                                end
                                LuaTimer:scheduleTimer(r6, 5, 100)
                            end
                            r5:registerEvent(GUIEvent.ButtonClick, r3)
                            I(q())
                        end
                    end
                    if togMovablePanel then
                        UIHelper.showToast("^FF0000Disabled")
                        r2 = v2[q()]:SetTouchable()
                        r5 = {0, 70}
                        r2 = v2[q()]:SetWidth()
                        r5 = {0, 70}
                        r2 = v2[q()]:SetHeight()
                        r5 = {0, 0}
                        r2 = v2[q()]:SetXPosition()
                        r5 = {0, -273}
                        r2 = v2[q()]:SetYPosition()
                        if timer.cipka then
                            LuaTimer:cancelTimer(timer.cipka)
                            timer.cipka = nil
                        end
                    end
                end
            end
            function GMHelper.CannonBtn(...)
                v2[q()] = GUIManager:getWindowByName("Main-Cannon")
                Env.togCannonBtn = not togCannonBtn
                r8 = v2[q()]
                if togCannonBtn then
                    r8 = v2[q()]
                    v2[q()] = 0.5
                    r8 = v2[q()]
                    r4 = v2[q()]
                    r3 = v2[q()]
                    r17 = v2[q()]
                    r10 = {VectorUtil.newVector3(r4, r3, r17)}
                    local r5 = function(...)
                        if v2[v3[1]] <= 1 then
                            v2[v3[1]] = v2[v3[1]] + 0.05
                            r2 = {VectorUtil.newVector3(v2[v3[1]], v2[v3[1]], v2[v3[1]])}
                            v2[v3[2]]:SetScale(v5(r2))
                        end
                        v2[v3[1]] = v2[v3[1]] - 0.0125
                    end
                    r8:SetScale(v5(r10))
                    r8 = v2[q()]
                    LuaTimer:scheduleTicker(r5, 1, 15)
                    local r10 = function(...)
                        if PlayerManager:getClientPlayer() then
                            r8 = PlayerManager:getClientPlayer().Player:getPitch()
                            r8 = PlayerManager:getClientPlayer().Player:getYaw()
                            r8 = math.cos(math.rad(a)) * math.sin(math.rad(-B))
                            r8 = -math.sin(math.rad(a))
                            r8 = math.cos(math.rad(a)) * math.cos(math.rad(-B))
                            r8 = PlayerManager:getClientPlayer().Player:setVelocity()
                        end
                    end
                    r8:registerEvent(GUIEvent.ButtonClick, r10)
                    r8 = v2[q()]
                    r8:setEnableLongTouch(true)
                    r8 = v2[q()]
                    local r10 = function(...)
                        local r6 = function(...)
                            if PlayerManager:getClientPlayer() then
                                if r8 then
                                    r8 = PlayerManager:getClientPlayer().Player:getYaw()
                                    r8 = PlayerManager:getClientPlayer().Player:getPitch()
                                    r8 = -1.7 * math.cos(math.rad(B))
                                    r4 = r8 * math.sin(math.rad(a))
                                    r3 = -1.7 * math.sin(math.rad(B))
                                    r8 = 1.7 * math.cos(math.rad(B))
                                    r17 = r8 * math.cos(math.rad(a))
                                    r8 = PlayerManager:getClientPlayer().Player:setVelocity()
                                end
                            end
                        end
                        Env.CannonTimer = LuaTimer:scheduleTimer(r6, 5, 200000)
                    end
                    r8 = v2[q()]
                    r8:registerEvent(GUIEvent.LongTouchStart, r10)
                    local r10 = function(...)
                        if CannonTimer then
                            LuaTimer:cancel(CannonTimer)
                            Env.CannonTimer = nil
                            if SoundLoop then
                                LuaTimer:cancel(SoundLoop)
                                Env.SoundLoop = nil
                            end
                        end
                    end
                    r8:registerEvent(GUIEvent.LongTouchEnd, r10)
                    I(q())
                    I(q())
                end
            end
            function GMHelper.ChangeTime(...)
                if v1[2] then
                    EngineWorld:getWorld():setWorldTime(15000)
                    UIHelper.showToast("^00FF00Now Night!")
                end
                EngineWorld:getWorld():setWorldTime(6000)
                UIHelper.showToast("^00FF00Now Day!")
            end
            function GMHelper.SpawnItem(...)
                GMHelper:openInput({"ID", "Count"}, function(...) end)
            end
            function GMHelper.SetBlockToAir(...)
                GMHelper:openInput({"block Position X", "block Position Y", "block Position Z"}, function(...) end)
            end
            function GMHelper.SpawnBlock(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.spawnCar(...)
                GMHelper:openInput({"Car ID (erase this text and write carID)"}, function(...) end)
            end
            function GMHelper.SpYaw(...)
                v1[1].spYawEnabled = not v1[1].spYawEnabled
                if v1[1].spYawEnabled then
                    PlayerManager:getClientPlayer().Player.spYaw = true
                    UIHelper.showToast("Enabled")
                end
                PlayerManager:getClientPlayer().Player.spYaw = false
                UIHelper.showToast("Disabled")
            end
            function GMHelper.SpYawSet(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.CreateGUIDEArrow(...)
                PlayerManager:getClientPlayer():getPosition()
                r8 = PlayerManager:getClientPlayer().Player:addGuideArrow()
                UIHelper.showToast("^FF00EESuccess")
            end
            function GMHelper.DelAllGUIDEArrow(...)
                r8 = PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
                UIHelper.showToast("^FF00EESuccess")
            end
            function GMHelper.SpawnNPC(...)
                GMHelper:openInput({".actor"}, function(...) end)
            end
            function GMHelper.NoLag(...)
                Env.togNoLag = not togNoLag
                if not togNoLag then
                    r8 = CGame.Instance():SetMaxFps()
                    UIHelper.showToast("^FF0000Disabled")
                end
                r8 = CGame.Instance():SetMaxFps()
                UIHelper.showToast("^00FF00Enabled")
            end
            function GMHelper.UnlockFps(...)
                Env.togUnlockFps = not togUnlockFps
                if not v1[1]._originalRenderDistance then
                    v1[1]._originalRenderDistance = ClientHelper.getIntPrefs("BlockRenderDistance")
                    if togUnlockFps then
                        ClientHelper.putIntPrefs("BlockRenderDistance", 100)
                    end
                    ClientHelper.putIntPrefs("BlockRenderDistance", v1[1]._originalRenderDistance)
                end
            end
            v2[q()] = 1
            function GMHelper.HighJump(...)
                Env.togHighJump = not togHighJump
                PlayerManager:getClientPlayer()
                if togHighJump then
                    r8 = PlayerManager:getClientPlayer().Player
                    r8:setFloatProperty("JumpHeight", v2[v3[1]])
                end
                r8 = PlayerManager:getClientPlayer().Player
                r8:setFloatProperty("JumpHeight", 0.4)
            end
            function GMHelper.FreeCamera(...)
                Env.togFreeCamera = not togFreeCamera
                if not togFreeCamera then
                    r8 = GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible()
                    UIHelper.showToast("^FF0000Disabled")
                end
                r8 = GUIManager:getWindowByName("Main-HideAndSeek-Operate"):SetVisible()
                UIHelper.showToast("^00FF00Enabled")
            end
            v2[q()] = function(...)
                v2[q()] = v1[2]
                v2[q()] = false
                v2[q()] = nil
                PlayerManager:getClientPlayer():getPosition()
                v2[q()] = D
                v2[q()] = function(...)
                    if v2[v3[1]] then
                        PlayerManager:getClientPlayer():getPosition()
                        v2[v3[2]] = D
                        r8 = PlayerManager:getClientPlayer().Player
                        r8:moveEntity(v2[v3[3]])
                    end
                end
                local r4 = function(...)
                    if not v2[v3[1]] then
                        v2[v3[1]] = true
                        v2[v3[3]] = LuaTimer:scheduleTimer(v2[v3[2]], 0.05, -1)
                    end
                end
                local r3 = function(...)
                    v2[v3[1]] = false
                    if v2[v3[2]] then
                        LuaTimer:cancel(v2[v3[2]])
                        v2[v3[2]] = nil
                    end
                end
                v1[1]:registerEvent(GUIEvent.TouchDown, r4)
                r17 = v2[q()]
                v1[1]:registerEvent(GUIEvent.TouchMove, r17)
                v1[1]:registerEvent(GUIEvent.TouchUp, r3)
                v1[1]:registerEvent(GUIEvent.LongTouchStart, r4)
                v1[1]:registerEvent(GUIEvent.LongTouchEnd, r3)
                v1[1]:registerEvent(GUIEvent.DragStart, r4)
                r17 = v2[q()]
                v1[1]:registerEvent(GUIEvent.Dragging, r17)
                v1[1]:registerEvent(GUIEvent.DragEnd, r3)
                v1[1]:registerEvent(GUIEvent.Release, r3)
                I(q())
                I(q())
                I(q())
                I(q())
                I(q())
            end
            function GMHelper.soooooo(...)
                v2[q()] = v1[1]
                Env.togsoooooo = not togsoooooo
                local r8 = function(...)
                    if PlayerManager:getClientPlayer() then
                        r8 = PlayerManager:getClientPlayer().Player
                        r8 = {r8}
                    end
                end
                v2[q()] = r8
                r8 = v2[q()]
                r5 = v2[q()]
                if not r5.flyButton then
                    v2[q()] = GUIManager:createGUIWindow(GUIType.Button, "GUIRoot-BwFly")
                    r8 = v2[q()]
                    r8:SetHorizontalAlignment(HorizontalAlignment.Right)
                    r8 = v2[q()]
                    r8:SetVerticalAlignment(VerticalAlignment.Bottom)
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r8:SetLevel(50)
                    r10 = {0, 0, 0, 0}
                    r8:SetTouchable(true)
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r8:SetBackgroundColor(r10)
                    r8:SetVisible(false)
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r8:SetProperty("Area", "{{-0.015,0},{-0.330000,0},{-0.015,70},{-0.330000,70}}")
                    r8:SetNormalImage("set:fly_control.json image:luodi")
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r10 = v2[q()]
                    r8:SetPushedImage("set:fly_control.json image:luodi")
                    r10 = v2[q()]
                    r10 = {0, 70}
                    r17 = {0, 70}
                    r8:SetArea(r10:GetXPosition(), r10:GetYPosition(), r10, r17)
                    r8 = GUISystem.Instance():GetRootWindow()
                    r10 = v2[q()]
                    r8 = v2[q()]
                    r10 = v2[q()]
                    r8:AddChildWindow(r10)
                    r8.flyButton = r10
                    r3 = {VectorUtil.newVector3(0, -0.002, 0)}
                    r3 = {VectorUtil.newVector3(0, 0.002, 0)}
                    v2[v3[1]](GUIManager:getWindowByName("Main-Down"), v5(r3))
                    r8 = v2[q()]
                    v2[v3[1]](GUIManager:getWindowByName("Main-Up"), v5(r3))
                    local r4 = function(...)
                        if v2[v3[2]].fly then
                            LuaTimer:cancel(v2[v3[2]].fly)
                            local r2 = function(...)
                                if not v2[v3[1]]() then
                                    LuaTimer:cancel(v2[v3[2]].fly)
                                end
                                v2[v3[1]]():getIsFlying()
                                if D then
                                    v2[v3[3]]:SetVisible(false)
                                end
                                v2[v3[3]]:SetVisible(true)
                                LuaTimer:cancel(v2[v3[2]].fly)
                            end
                            v2[v3[2]].fly = LuaTimer:scheduleTimer(r2, 50, -1)
                            v2[v3[1]]():setAllowFlying(true)
                            v2[v3[1]]():setFlying(true)
                            v2[v3[1]]():moveEntity(v5({VectorUtil.newVector3(0, 1.35, 0)}))
                        end
                    end
                    r8:registerEvent(GUIEvent.ButtonClick, r4)
                    I(q())
                    r5 = v2[q()]
                    r5.flyButton:SetVisible(togsoooooo)
                    if togsoooooo then
                        r8 = v2[q()]
                        r5 = r8()
                        if r5 then
                            r8 = r5:getCapabilities():setFlySpeed()
                            r5:getCapabilities().allowFlying = true
                            r5:getCapabilities().isFlying = false
                            r5.m_isPulled = true
                            r5.m_remainingFlyTicksByPulled = 999999
                            r5.onGround = false
                            r5.onGroundPrev = false
                            r5.m_flyingByPulled = false
                            r8 = type(ground) == "function"
                            if r8 then
                                ground()
                                r8 = type(bypass) == "function"
                                if r8 then
                                    bypass()
                                    I(q())
                                    I(q())
                                end
                            end
                        end
                    end
                end
            end
            function GMHelper.sooooooSB(...)
                v2[q()] = v1[1]
                Env.togsooooooSB = not togsooooooSB
                local r8 = function(...)
                    if PlayerManager:getClientPlayer() then
                        r8 = PlayerManager:getClientPlayer().Player
                        r8 = {r8}
                    end
                end
                v2[q()] = r8
                r8 = v2[q()]
                r5 = v2[q()]
                if not r5.flyButton then
                    v2[q()] = GUIManager:createGUIWindow(GUIType.Button, "GUIRoot-BwFly")
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r8:SetHorizontalAlignment(HorizontalAlignment.Right)
                    r8 = v2[q()]
                    r8:SetVerticalAlignment(VerticalAlignment.Bottom)
                    r8 = v2[q()]
                    r8:SetLevel(50)
                    r8:SetTouchable(true)
                    r8 = v2[q()]
                    r10 = {0, 0, 0, 0}
                    r8:SetBackgroundColor(r10)
                    r8 = v2[q()]
                    r8:SetVisible(false)
                    r8 = v2[q()]
                    r8:SetProperty("Area", "{{-0.015,0},{-0.330000,0},{-0.015,70},{-0.330000,70}}")
                    r8 = v2[q()]
                    r8 = v2[q()]
                    r8:SetNormalImage("set:fly_control.json image:luodi")
                    r8 = v2[q()]
                    r8:SetPushedImage("set:fly_control.json image:luodi")
                    r10 = v2[q()]
                    r10 = v2[q()]
                    r10 = {0, 70}
                    r17 = {0, 70}
                    r8:SetArea(r10:GetXPosition(), r10:GetYPosition(), r10, r17)
                    r8 = GUISystem.Instance():GetRootWindow()
                    r10 = v2[q()]
                    r8:AddChildWindow(r10)
                    r8 = v2[q()]
                    r10 = v2[q()]
                    r8.flyButton = r10
                    r3 = {VectorUtil.newVector3(0, -0.001, 0)}
                    r3 = {VectorUtil.newVector3(0, 0.001, 0)}
                    v2[v3[1]](GUIManager:getWindowByName("Main-Down"), v5(r3))
                    r8 = v2[q()]
                    v2[v3[1]](GUIManager:getWindowByName("Main-Up"), v5(r3))
                    local r4 = function(...)
                        if v2[v3[2]].fly then
                            LuaTimer:cancel(v2[v3[2]].fly)
                            local r2 = function(...)
                                if not v2[v3[1]]() then
                                    LuaTimer:cancel(v2[v3[2]].fly)
                                end
                                v2[v3[1]]():getIsFlying()
                                if D then
                                    v2[v3[3]]:SetVisible(false)
                                end
                                v2[v3[3]]:SetVisible(true)
                                LuaTimer:cancel(v2[v3[2]].fly)
                            end
                            v2[v3[2]].fly = LuaTimer:scheduleTimer(r2, 50, -1)
                            v2[v3[1]]():setAllowFlying(true)
                            v2[v3[1]]():setFlying(true)
                            v2[v3[1]]():moveEntity(v5({VectorUtil.newVector3(0, 1.35, 0)}))
                        end
                    end
                    r8:registerEvent(GUIEvent.ButtonClick, r4)
                    I(q())
                    r5 = v2[q()]
                    r5.flyButton:SetVisible(togsooooooSB)
                    if togsooooooSB then
                        r8 = v2[q()]
                        r5 = r8()
                        if r5 then
                            r8 = r5:getCapabilities():setFlySpeed()
                            r5:getCapabilities().allowFlying = true
                            r5:getCapabilities().isFlying = false
                            r5.m_isPulled = true
                            r5.m_remainingFlyTicksByPulled = 999999
                            r5.onGround = false
                            r5.onGroundPrev = false
                            r5.m_flyingByPulled = false
                            r8 = type(ground) == "function"
                            if r8 then
                                ground()
                                r8 = type(bypass) == "function"
                                if r8 then
                                    bypass()
                                    I(q())
                                    I(q())
                                end
                            end
                        end
                    end
                end
            end
            function GMHelper.BreakBlock(...)
                Env.togBreakBlock = not togBreakBlock
                v2[q()] = EngineWorld:getWorld()
                r8 = PlayerManager:getClientPlayer():getPosition()
                r8 = PlayerManager:getClientPlayer():getYaw()
                r8 = PlayerManager:getClientPlayer():getInventory()
                v2[q()] = r8
                v2[q()] = 36
                local r8 = function(...)
                    v2[v3[1]]:destroyBlock(v1[3], true)
                    if (false and 0 >= v2[v3[2]]) or (not false and 0 <= v2[v3[2]]) then
                        if r17 == v1[2] then
                            v2[v3[3]]:decrStackSize(0, -100000000)
                            r8 = {true}
                        end
                        if r17 == nil then
                            v2[v3[3]]:addItemToInventory(Item.getItemById(v1[2]), 1)
                            r8 = {true}
                        end
                    end
                end
                v2[v3[1]]:spawnItemInWorld(v1[2], 1, 0, 480, v1[3], VectorUtil.ZERO, false, true)
                r8 = {true}
            end
            local r8 = function(...)
                r22 = {v2[v3[1]]:getCurrentItemIndex()}
                EngineWorld:setBlock(VectorUtil.newVector3(v1[4].x, v1[4].y + 1, v1[4].z), r10)
                v2[v3[1]]:decrStackSize(v2[v3[1]]:getCurrentItemIndex(), 1)
                r8 = {true}
            end
            CEvents.BlockBreakEvent:registerCallBack(r17)
            CEvents.PlayerPlaceBlockEvent:registerCallBack(r22)
            UIHelper.showToast("^00FF00Enabled")
            I(q())
            I(q())
            I(q())
            CEvents.BlockBreakEvent:unregisterCallBack(r17)
            CEvents.PlayerPlaceBlockEvent:unregisterCallBack(r22)
            UIHelper.showToast("^FF0000Disabled")
            v2[q()] = nil
            function GMHelper.ReachPlayers(...)
                Env.togReachPlayers = not togReachPlayers
                if togReachPlayers then
                    if not PlayerManager:getClientPlayer() then
                        v2[q()] = r2.entityId
                        local r8 = function(...)
                            if not PlayerManager:getPlayerByEntityId(v1[1]) then
                                r8 = PlayerManager:getPlayerByEntityId(v1[1]).Player:getPosition()
                                ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
                                r10 = v2[v3[1]]:getItemStackInfo(v5(r22)).id
                                r10 = {VectorUtil.newVector3(0, 0.3, 0)}
                                Zentex(v2[v3[1]], v5(r10))
                                Zentex(r5.entityId, B)
                                ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
                            end
                        end
                        v2[v3[1]] = Listener.registerCallBack(CEvents.AttackEntityEvent, r5)
                        I(q())
                    end
                end
                ClientHelper.putFloatPrefs("EntityReachDistance", 4.5)
                if v2[v3[1]] then
                    v2[v3[1]] = nil
                    Listener.unregisterCallBack(CEvents.AttackEntityEvent, v2[v3[1]])
                end
            end
            function GMHelper.ShowHp(...)
                Env.togShowHp = not togShowHp
                local r8 = function(...)
                    if v1[1] > 15 then
                        r8 = {"\226\150\162FFFF1F1F"}
                    end
                    if v1[1] > 5 then
                        r8 = {"\226\150\162FFFFFF00"}
                    end
                    r8 = {"\226\150\162FF00FF00"}
                end
                v2[q()] = r8
                if togShowHp then
                    local r5 = function(...)
                        if PlayerManager:getPlayers() then
                            r2 = PlayerManager:getPlayerByEntityId(v1[1]).Player
                            r2 = {ipairs(PlayerManager:getPlayers())}
                            if r2[3] then
                                if PlayerManager.Player then
                                    r3 = PlayerManager.Player:getHealth() + 0.5
                                    r17 = v2[v3[3]]:getItemStackInfo(0).id
                                    r17 = PlayerManager.Player:getMaxHealth() + 0.5
                                    r17 = math.floor(r17) - math.floor(r3)
                                    tostring(math.floor(r3))
                                    r18 = v2[v3[1]](r17) .. r21 .. "\226\157\164"
                                    r25 = PlayerManager.Player:getShowName() or ""
                                    r27 = v2[v3[1]](r17) .. r21 .. "\226\157\164"
                                    if StringUtil.split(r25, "\n") then
                                        r27 = #StringUtil.split(r25, "\n")
                                        if (true and r27 - -1 + -1 >= 1) or (not true and r27 - -1 + -1 <= 1) then
                                            r28 = StringUtil.split(r25, "\n")[r27 - -1 + -1]
                                            if string.find(r28, "\226\157\164") then
                                                table.remove(StringUtil.split(r25, "\n"), r27 - -1 + -1)
                                            end
                                        end
                                        table.insert(StringUtil.split(r25, "\n"), r18)
                                        r31 = {table.concat(StringUtil.split(r25, "\n"), "\n")}
                                        PlayerManager.Player:setShowName(v5(r31))
                                    end
                                end
                            end
                        end
                    end
                    v1[1].ShowHpTimer = LuaTimer:scheduleTimer(r5, 50, -1)
                    I(q())
                end
                if PlayerManager:getPlayers() then
                    r4 = {ipairs(PlayerManager:getPlayers())}
                    if r4[3] then
                        if r4.Player then
                            r8 = r4.Player:getShowName() or ""
                            if StringUtil.split(r17, "\n") then
                                r8 = #StringUtil.split(r17, "\n")
                                if (true and r8 - -1 + -1 >= 1) or (not true and r8 - -1 + -1 <= 1) then
                                    r30 = StringUtil.split(r17, "\n")[r8 - -1 + -1]
                                    if string.find(r30, "\226\157\164") then
                                        table.remove(StringUtil.split(r17, "\n"), r8 - -1 + -1)
                                    end
                                end
                                r25 = {table.concat(StringUtil.split(r17, "\n"), "\n")}
                                r4.Player:setShowName(v5(r25))
                            end
                        end
                    end
                end
            end
            function GMHelper.QuickPlaceBlock(...)
                Env.togQuickPlaceBlock = not togQuickPlaceBlock
                if togQuickPlaceBlock then
                    ClientHelper.putIntPrefs("QuicklyBuildBlockNum", 100)
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.NoFall(...)
                Env.togNoFall = not togNoFall
                if togNoFall then
                    if not fallTimer then
                        Env.fallTimer = LuaTimer:scheduleTimer(function(...) end, 100, -1)
                    end
                end
                if fallTimer then
                    Env.fallTimer = nil
                    ClientHelper.putIntPrefs("SprintLimitCheck", 0)
                end
            end
            function GMHelper.RespawnInSamePlace(...)
                Env.togRespawnInSamePlace = not togRespawnInSamePlace
                if togRespawnInSamePlace then
                    local r8 = function(...)
                        r8 = CGame.Instance():getPlatformUserId()
                        if v1[1] == r8 then
                            if not PlayerManager:getClientPlayer() then
                                PlayerManager:getClientPlayer().Player:getPosition()
                                PlayerManager:getClientPlayer().Player:getPitch()
                                PlayerManager:getClientPlayer().Player:getYaw()
                                r8 = CGame.Instance():getGameType()
                                if r8 == "g1014" then
                                    local r4 = function(...)
                                        respawn()
                                    end
                                    respawn()
                                    LuaTimer:scheduleTimer(r4, 1000, 6)
                                    PlayerManager:getClientPlayer().Player.rotationPitch = r8
                                    PlayerManager:getClientPlayer().Player.rotationYaw = r8
                                    RootGuiLayout.Instance():showMainControl()
                                end
                                PacketSender:getSender():sendRebirth()
                                r25 = {math.floor(r2.z)}
                                r3 = {VectorUtil.newVector3(math.floor(r2.x), math.floor(r2.y), v5(r25))}
                                Teleport1(v5(r3))
                            end
                        end
                    end
                    Env.RespawnInSamePlaceCallback = r8
                    CEvents.LuaPlayerDeathEvent:registerCallBack(RespawnInSamePlaceCallback)
                end
                UIHelper.showToast("^FF0000Disabled")
                if RespawnInSamePlaceCallback then
                    CEvents.LuaPlayerDeathEvent:unregisterCallBack(RespawnInSamePlaceCallback)
                    Env.RespawnInSamePlaceCallback = nil
                end
            end
            function GMHelper.InfinityKillAura(...)
                Env.togInfinityKillAura = not togInfinityKillAura
                if togInfinityKillAura then
                    if PlayerManager:getClientPlayer() then
                        if r8 then
                            r18 = {math.floor(r21 + 600)}
                            r4 = {VectorUtil.newVector3(math.floor(r22), math.floor(r25 + 2), v5(r18))}
                            r8 = PlayerManager:getClientPlayer().Player
                            r8:setPosition(v5(r4))
                            local r5 = function(...)
                                if PlayerManager:getPlayers() then
                                    r2 = PlayerManager:getClientPlayer().Player
                                    r2 = {ipairs(PlayerManager:getPlayers())}
                                    if r2[3] then
                                        if r10 then
                                            r10 = PlayerManager:getClientPlayer().Player
                                            r10:getPosition()
                                            r12 = {math.floor(r4.z)}
                                            r18 = {VectorUtil.newVector3(math.floor(r4.x), math.floor(r4.y), v5(r12))}
                                            Zentex(r10.entityId, v5(r18))
                                        end
                                    end
                                end
                            end
                            Env.InfKillAuraTimer = LuaTimer:scheduleTimer(r5, 900, -1)
                        end
                    end
                end
                if InfKillAuraTimer then
                    Env.InfKillAuraTimer = nil
                end
            end
            function GMHelper.AutoClick(...)
                v2[q()] = v1[1]
                Env.togAutoClick = not togAutoClick
                if autoClickTimer then
                    Env.autoClickTimer = nil
                    if GUIManager:getWindowByName("Main-throwpot-Controls") then
                        GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(false)
                        UIHelper.showToast("^FF0000Disabled")
                        if togAutoClick then
                            createUIButton("AutoClick", "AutoClick")
                            UIHelper.showToast("^00FF00Enabled")
                            local r5 = function(...)
                                if GUIManager:getWindowByName("Main-throwpot-Controls") then
                                    GUIManager:getWindowByName("Main-throwpot-Controls"):SetVisible(true)
                                    GUIManager:getWindowByName("Main-throwpot-Controls"):SetAlpha(0)
                                    r8 = {0, 0}
                                    GUIManager:getWindowByName("Main-throwpot-Controls"):SetXPosition(r8)
                                    r8 = {0, -170}
                                    GUIManager:getWindowByName("Main-throwpot-Controls"):SetYPosition(r8)
                                    CGame.Instance():handleTouchClick(1, 1)
                                end
                            end
                            Env.autoClickTimer = LuaTimer:scheduleTimer(r5, 100, -1)
                            I(q())
                        end
                    end
                end
            end
            function GMHelper.EmoteFreeze(...)
                Env.togEmoteFreeze = not togEmoteFreeze
                if togEmoteFreeze then
                    a:setBoolProperty("DisableUpdateAnimState", true)
                    UIHelper.showToast("^00FF00Enabled")
                end
                a:setBoolProperty("DisableUpdateAnimState", false)
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.Blink(...)
                Env.togBlink = not togBlink
                if togBlink then
                    ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
                end
                ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
            end
            v2[q()] = nil
            function GMHelper.FastJump(...)
                Env.togFastJump = not togFastJump
                if not PlayerManager:getClientPlayer() then
                    if togFastJump then
                        ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
                        if v2[v3[1]] then
                            LuaTimer:cancel(v2[v3[1]])
                            local r2 = function(...)
                                if PlayerManager:getClientPlayer() then
                                    if r8 then
                                        PlayerManager:getClientPlayer().Player.m_keepJumping = false
                                    end
                                end
                            end
                            v2[v3[1]] = LuaTimer:scheduleTimer(r2, 50, -1)
                        end
                    end
                    UIHelper.showToast("^FF0000Disabled")
                    ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
                    if v2[v3[1]] then
                        LuaTimer:cancel(v2[v3[1]])
                        v2[v3[1]] = nil
                        r2 = PlayerManager:getClientPlayer().Player
                        r2.m_keepJumping = true
                    end
                end
            end
            function GMHelper.EquipNinjaShoes(...)
                Env.togNinjaShoes = not togNinjaShoes
                v2[q()] = PlayerManager:getClientPlayer()
                if togNinjaShoes then
                    if not ninjaTimer then
                        local r2 = function(...)
                            v2[v3[1]].Player:setFloatProperty("JumpHeight", 0.5)
                            v2[v3[1]].doubleJumpCount = 2
                        end
                        Env.ninjaTimer = LuaTimer:scheduleTimer(r2, 200, -1)
                        I(q())
                    end
                end
                UIHelper.showToast("^FF0000Disabled")
                if ninjaTimer then
                    LuaTimer:cancel(ninjaTimer)
                    Env.ninjaTimer = nil
                    r5 = PlayerManager:getClientPlayer().Player
                    r5 = v2[q()]
                    r5.Player:setFloatProperty("JumpHeight", 0.42)
                    r2 = v2[q()]
                    r2.doubleJumpCount = 1
                end
            end
            function GMHelper.AimBow(...)
                Env.togAimBow = not togAimBow
                if aimBowTimer then
                    Env.aimBowTimer = nil
                    if not togAimBow then
                        UIHelper.showToast("^FF0000Disabled")
                    end
                    v2[q()] = 3
                    v2[q()] = 0.05
                    v2[q()] = 200
                    v2[q()] = nil
                    v2[q()] = false
                    local r17 = function(...)
                        if PlayerManager:getClientPlayer() then
                            r8 = PlayerManager:getClientPlayer().Player:getHeldItemId()
                            if r2.isUsingItem then
                                r2 = PlayerManager:getClientPlayer().Player:isUsingItem()
                                if B then
                                    if not v2[v3[1]] then
                                        v2[v3[2]] = os.clock()
                                        v2[v3[1]] = true
                                        r10 = PlayerManager:getClientPlayer().Player
                                        r10:getPosition()
                                        if r17 then
                                            r17 = PlayerManager:getClientPlayer():getTeamId()
                                            PlayerManager:getPlayers()
                                            if r10:getPosition() then
                                                r18 = #PlayerManager:getPlayers()
                                                if (false and 1 >= r25) or (not false and 1 <= r25) then
                                                    r12 = PlayerManager:getPlayers()[1]
                                                    r13 = PlayerManager:getClientPlayer().Player
                                                    r13 = r12 ~= PlayerManager:getClientPlayer()
                                                    if r13 then
                                                        if r12.Player then
                                                            if r12:isEntityAlive() then
                                                                r30 = (r12:isEntityAlive() and 1628065) or 14515116
                                                                if r12.getTeamId then
                                                                    if not r10 then
                                                                        if r12.Player:getPosition() then
                                                                            r24 = {ent = r12, pos = r12.Player:getPosition()}
                                                                            table.insert(r3, r24)
                                                                        end
                                                                    end
                                                                end
                                                                r28 = r12:getTeamId() ~= r10
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            if (false and 1 >= #r3) or (not false and 1 <= #r3) then
                                            end
                                            r12 = math.sqrt((_nil_).pos.x - r27 * (_nil_).pos.x - r27 + (_nil_).pos.z - r31 * (_nil_).pos.z - r31) < 0.1
                                            if v2[v3[2]] then
                                                r15 = os.clock() - v2[v3[2]]
                                                if r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1 then
                                                    r42 = PlayerManager:getClientPlayer().Player.m_pantsID
                                                    r42 = v2[v3[5]] * math.sqrt((_nil_).pos.x - r27 * (_nil_).pos.x - r27 + (_nil_).pos.z - r31 * (_nil_).pos.z - r31)
                                                    r34 = PlayerManager:getClientPlayer().Player
                                                    r34 = r42 * math.sqrt((_nil_).pos.x - r27 * (_nil_).pos.x - r27 + (_nil_).pos.z - r31 * (_nil_).pos.z - r31)
                                                    r34 = v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) - math.sqrt(v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) - v2[v3[5]] * r34 + 2 * (_nil_).pos.y + 2.28 - r31 + 1.5 * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1) * v2[v3[4]] * (r15 * v2[v3[3]] / 20 * r15 * v2[v3[3]] / 20 + r15 * v2[v3[3]] / 20 * 2 / 3 > 1 and 1))
                                                    r42 = v2[v3[5]] * math.sqrt((_nil_).pos.x - r27 * (_nil_).pos.x - r27 + (_nil_).pos.z - r31 * (_nil_).pos.z - r31)
                                                    r47 = PlayerManager:getClientPlayer().Player.m_shoesID
                                                    r47 = {math.atan2(-(_nil_).pos.x - r27, (_nil_).pos.z - r31)}
                                                    r45 = PlayerManager:getClientPlayer().Player.m_topsID
                                                    r45 = math.deg(v5(r47)) + 360
                                                    r45 = PlayerManager:getClientPlayer().Player
                                                    r45.rotationYaw = r45 % 360
                                                    r19 = -math.deg(math.atan(r34 / r42))
                                                    r45 = PlayerManager:getClientPlayer().Player
                                                    r45.rotationPitch = r19
                                                end
                                            end
                                        end
                                    end
                                end
                                if not B then
                                    v2[v3[2]] = nil
                                    v2[v3[1]] = false
                                end
                            end
                        end
                    end
                end
                Env.aimBowTimer = LuaTimer:scheduleTimer(r17, 50, -1)
                I(q())
                I(q())
                I(q())
                I(q())
                I(q())
            end
            function GMHelper.SetAimBot(...)
                GMHelper:openInput({"Set Aimbot range (blocks)"}, function(...) end)
            end
            function GMHelper.SetHighJump(...)
                GMHelper:openInput({"Set new jump value"}, function(...) end)
            end
            function GMHelper.SetSpeed(...)
                GMHelper:openInput({"Set new speed value"}, function(...) end)
            end
            function GMHelper.SetMaxFPS(...)
                GMHelper:openInput({""}, function(...) end)
            end
            v2[q()] = nil
            v2[q()] = nil
            v2[q()] = nil
            v2[q()] = nil
            function GMHelper.SetHitBox(...)
                GMHelper:openInput({"Height", "Width", "Length"}, function(...) end)
            end
            function GMHelper.SetFov(...)
                GMHelper:openInput({"Enter FOV Value"}, function(...) end)
            end
            function GMHelper.resetValues(...)
                if PlayerManager:getClientPlayer() then
                    if r8 then
                        r8 = PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel()
                        r8 = PlayerManager:getClientPlayer().Player:setFloatProperty()
                        if aimbotTimer then
                            LuaTimer:cancel(aimbotTimer)
                            Env.aimbotTimer = nil
                            r4 = {ipairs(PlayerManager:getPlayers())}
                            if r4[3] then
                                r22 = r8:getPosition().x
                                r22 = r3 ~= PlayerManager:getClientPlayer()
                                if r22 then
                                    if r3.Player then
                                        r3.Player.height = 1.8
                                        r3.Player.width = 0.6
                                        r3.Player.length = 0.6
                                    end
                                end
                            end
                            r8 = Blockman.Instance().m_gameSettings
                            r8:setFovSetting(1)
                            UIHelper.showToast("^FFFF00Reset Complete")
                        end
                    end
                end
            end
            function GMHelper.TeleportKiller(...)
                Env.togTeleportKiller = not togTeleportKiller
                if togTeleportKiller then
                    if not tpKillTimer then
                        Env.tpKillTimer = LuaTimer:scheduleTimer(function(...) end, 300, -1)
                    end
                end
                if tpKillTimer then
                    Env.tpKillTimer = nil
                end
            end
            function GMHelper.KillAura(...)
                Env.togKillAura = not togKillAura
                if togKillAura then
                    if not killAuraTimer then
                        Env.killAuraTimer = LuaTimer:scheduleTimer(function(...) end, 600, -1)
                    end
                end
                if killAuraTimer then
                    Env.killAuraTimer = nil
                end
            end
            function GMHelper.FastBreak(...)
                Env.togFastBreak = not togFastBreak
                if togFastBreak then
                    if (false and false) or (not false and true) then
                        if BlockManager.getBlockById(1) then
                            r8 = BlockManager.getBlockById(1):setHardness()
                        end
                    end
                end
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(1) then
                        r8 = BlockManager.getBlockById(1):setHardness()
                    end
                end
            end
            function GMHelper.Dark(...)
                Env.togDark = not togDark
                if togDark then
                    cBlockManager.cGetBlockById(253)
                    if cBlockManager.cGetBlockById(66) then
                        r8 = cBlockManager.cGetBlockById(66):setNeedRender()
                        if cBlockManager.cGetBlockById(253) then
                            r8 = cBlockManager.cGetBlockById(253):setNeedRender()
                            if (false and false) or (not false and true) then
                                if BlockManager.getBlockById(1) then
                                    r8 = BlockManager.getBlockById(1):setLightValue()
                                end
                            end
                            GUIGMControlPanel:hide()
                        end
                    end
                end
                cBlockManager.cGetBlockById(253)
                if cBlockManager.cGetBlockById(66) then
                    r8 = cBlockManager.cGetBlockById(66):setNeedRender()
                    if cBlockManager.cGetBlockById(253) then
                        r8 = cBlockManager.cGetBlockById(253):setNeedRender()
                        if (false and false) or (not false and true) then
                            if BlockManager.getBlockById(1) then
                                r8 = BlockManager.getBlockById(1):setLightValue()
                            end
                        end
                    end
                end
            end
            function GMHelper.BreakParticles(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.Clouds(...)
                Env.togClouds = not togClouds
                if togClouds then
                    UIHelper.showToast("^00FF00Enabled")
                    GUIGMControlPanel:hide()
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.RenderWorld(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.AimBot(...)
                Env.togAimBot = not togAimBot
                if togAimBot then
                    local r5 = function(...)
                        if PlayerManager:getClientPlayer() then
                            r8 = PlayerManager:getClientPlayer().Player:getPosition()
                            r8 = PlayerManager:getClientPlayer().Player:getTeamId()
                            r17 = {pairs(PlayerManager:getPlayers())}
                            if r17[3] then
                                r21 = r8:getPosition().z
                                r21 = r18 ~= PlayerManager:getClientPlayer()
                                if r21 then
                                    if r18.Player then
                                        r12 = r18.Player:getTeamId() ~= r2
                                        if r25 then
                                            r18:getPosition()
                                            if MathUtil:distanceSquare2d(r25, a) < math.huge then
                                                MathUtil:distanceSquare2d(r25, a)
                                            end
                                        end
                                    end
                                end
                            end
                            if false then
                                UIHelper.showToast(string.format("Closest player's health: %.1f", math.min((_nil_):getHealth(), 50)))
                                r4 = SceneManager.Instance():getMainCamera()
                                r30 = VectorUtil.sub3((_nil_):getPosition(), r4:getPosition()).x
                                r30 = -math.atan2(r28 + 1.5, math.sqrt(r13 * r15 + r15 * r24))
                                r31 = PlayerManager:getClientPlayer().Player
                                r31.rotationYaw = r21 * -180 or 0
                                r31 = PlayerManager:getClientPlayer().Player
                                r31.rotationPitch = r30 / math.pi * 180 or 0
                            end
                        end
                    end
                end
                v1[1].ja = LuaTimer:scheduleTimer(r5, 5, 99999)
            end
            function GMHelper.NoFallDmg(...)
                Env.togNoFallDmg = not togNoFallDmg
                if togNoFallDmg then
                    if not noFallTimer then
                        Env.noFallTimer = LuaTimer:scheduleTimer(function(...) end, 50, -1)
                    end
                end
                if noFallTimer then
                    Env.noFallTimer = nil
                    if PlayerManager:getClientPlayer() then
                        if B then
                            PlayerManager:getClientPlayer().Player.noClip = false
                        end
                    end
                end
            end
            function GMHelper.InfShield(...)
                DataBuilder.new():fromTable({Time = 99999999999})
                PacketSender:CommonData("AddInvincibleState", D:getData())
                UIHelper.showToast("^00FF00Enabled")
            end
            v2[q()] = nil
            function GMHelper.AutoSell(...)
                Env.togAutoSell = not togAutoSell
                if togAutoSell then
                    v2[v3[1]] = LuaTimer:scheduleTimer(function(...) end, 500, -1)
                end
                if v2[v3[1]] then
                    v2[v3[1]] = nil
                    LuaTimer:cancel(v2[v3[1]])
                    UIHelper.showToast("^FF0000Disabled")
                end
            end
            function GMHelper.EditSize(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.EquipSun(...)
                DataBuilder.new():fromTable({ItemId = 607, selectMode = Define.SelectMode.Equip})
                PacketSender:CommonData("ChangeHoldItemActor", D:getData())
                UIHelper.showToast("^00FF00Enabled")
            end
            function GMHelper.EquipEarth(...)
                DataBuilder.new():fromTable({ItemId = 606, selectMode = Define.SelectMode.Equip})
                PacketSender:CommonData("ChangeHoldItemActor", D:getData())
                UIHelper.showToast("^00FF00Enabled")
            end
            function GMHelper.EquipAirCraft(...)
                DataBuilder.new():fromTable({ItemId = 605, selectMode = Define.SelectMode.Equip})
                PacketSender:CommonData("ChangeHoldItemActor", D:getData())
                UIHelper.showToast("^00FF00Enabled")
            end
            function GMHelper.ChangeSkinSim(...)
                GMHelper:openInput({""}, function(...) end)
            end
            function GMHelper.HealSim(...)
                DataBuilder.new():addParam("index", Define.SelectSkinType.Free)
                DataBuilder.new():addParam("index", Define.SelectSkinType.Default)
                PacketSender:CommonData("SelectSkin", D:getData())
                PacketSender:CommonData("SelectSkin", D:getData())
                UIHelper.showToast("^00FF00Enabled")
            end
            function GMHelper.RaketButton(...)
                Env.togRaketButton = not togRaketButton
                if PlayerManager:getClientPlayer() then
                    if not togRaketButton then
                        if GUIManager:getWindowByName("Main-BuildWar-Block") then
                            r8 = GUIManager:getWindowByName("Main-BuildWar-Block"):SetVisible()
                        end
                    end
                    if GUIManager:getWindowByName("Main-BuildWar-Block") then
                        r8 = GUIManager:getWindowByName("Main-BuildWar-Block"):SetVisible()
                        local r5 = function(...)
                            PlayerManager:getClientPlayer().Player:setAllowFlying(true)
                            PlayerManager:getClientPlayer().Player:setFlying(true)
                            PlayerManager:getClientPlayer().Player:moveEntity(VectorUtil.newVector3(0, 1.35, 0))
                            PlayerManager:getClientPlayer().Player:setSpeedAdditionLevel(150000)
                            UIHelper.showToast("^00FF00ON")
                        end
                        r8 = GUIManager:getWindowByName("Main-BuildWar-Block"):registerEvent()
                    end
                end
            end
            function GMHelper.Tracer(...)
                Env.togTracer = not togTracer
                if tracerTimer then
                    Env.tracerTimer = nil
                    if PlayerManager:getClientPlayer() then
                        if a then
                            r2 = PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
                            if togTracer then
                                UIHelper.showToast("^00FF00Enabled")
                                local r5 = function(...)
                                    if PlayerManager:getClientPlayer() then
                                        r8 = PlayerManager:getClientPlayer().Player:deleteAllGuideArrow()
                                        PlayerManager:getClientPlayer():getTeamId()
                                        r10 = PlayerManager:getClientPlayer().Player
                                        r10 = {pairs(PlayerManager:getPlayers())}
                                        if r10[3] then
                                            r22 = r3 ~= PlayerManager:getClientPlayer()
                                            if r22 then
                                                if r3.Player then
                                                    if r3:isEntityAlive() then
                                                        if r3:getTeamId() ~= B then
                                                            r18 = {r3.Player:getPosition()}
                                                            r17 = PlayerManager:getClientPlayer().Player:addGuideArrow()
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                Env.tracerTimer = LuaTimer:scheduleTimer(r5, 500, -1)
                            end
                            UIHelper.showToast("^FF0000Disabled")
                        end
                    end
                end
            end
            function GMHelper.AutoRespawn(...)
                Env.togAutoRespawn = not togAutoRespawn
                if not togAutoRespawn then
                    if respawnCallback then
                        Env.respawnCallback = nil
                        UIHelper.showToast("^FF0000Disabled")
                    end
                end
                function Env.respawnCallback(...)
                    r8 = CGame.Instance():getPlatformUserId()
                    if PlayerManager:getClientPlayer() then
                        PacketSender:getSender():sendRebirth()
                        PlayerManager:createClientPlayer()
                        RootGuiLayout.Instance():showMainControl()
                    end
                end
                CEvents.LuaPlayerDeathEvent:registerCallBack(respawnCallback)
            end
            function GMHelper.DropSpeed(...)
                Env.togDropSpeed = not togDropSpeed
                if togDropSpeed then
                    PlayerManager:getClientPlayer().m_reloadBulletInt = 9999999
                    UIHelper.showToast("^00FF00Enabled")
                end
                PlayerManager:getClientPlayer().m_reloadBulletInt = 1
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.AutoKnockBack(...)
                Env.togAutoKnockBack = not togAutoKnockBack
                if togAutoKnockBack then
                    local r2 = function(...)
                        r6 = {v4(1, v5(v1))}
                        sprint(4)
                    end
                    Env.knock = LuaTimer:scheduleTimer(r2, 100, 99999999)
                end
            end
            function GMHelper.ModifyAllCarsSpeed(...)
                Env.togModifyAllCarsSpeed = not togModifyAllCarsSpeed
                r8 = {1, 2, 3, 4, 5, 6, 7, 8, 9}
                if not carBackupData then
                    Env.carBackupData = r8
                    if togModifyAllCarsSpeed then
                        r17 = {ipairs(r2)}
                        if r17[3] then
                            if CarSetting.getCarSetting(r17) then
                                r25 = r8:getPosition().y
                                r2 = PlayerManager:getClientPlayer().Player
                                r25 = {t = r27, rt = r31, bf = r13, mcf = r24, cad = r29}
                                carBackupData[r17] = r25
                                CarSetting.getCarSetting(r17).traction = r21 * 10
                                CarSetting.getCarSetting(r17).reverseTraction = r21 * 10
                                CarSetting.getCarSetting(r17).brakingForce = r21 * 10
                                CarSetting.getCarSetting(r17).maxCentripetalForce = r21 * 10
                                CarSetting.getCarSetting(r17).coefAirDrag = r21 * 0.9
                            end
                        end
                        UIHelper.showToast("^00FF00Enabled")
                    end
                    r17 = {ipairs(r2)}
                    if r17[3] then
                        if CarSetting.getCarSetting(r17) then
                            if carBackupData[r17] then
                                CarSetting.getCarSetting(r17).traction = carBackupData[r17].t
                                CarSetting.getCarSetting(r17).reverseTraction = carBackupData[r17].rt
                                CarSetting.getCarSetting(r17).brakingForce = carBackupData[r17].bf
                                CarSetting.getCarSetting(r17).maxCentripetalForce = carBackupData[r17].mcf
                                CarSetting.getCarSetting(r17).coefAirDrag = carBackupData[r17].cad
                            end
                        end
                    end
                    UIHelper.showToast("^FF0000Disabled")
                end
            end
            function GMHelper.JumpDpad(...)
                Env.togJumpDpad = not togJumpDpad
                GUIManager:getWindowByName("MainControl-jump")
                if togJumpDpad then
                    UIHelper.showToast("^00FF00Enabled")
                    if GUIManager:getWindowByName("MainControl-jump") then
                        r8 = GUIManager:getWindowByName("MainControl-jump"):SetNormalImage()
                        r8 = GUIManager:getWindowByName("MainControl-jump"):SetPushedImage()
                        r8 = GUIManager:getWindowByName("MainControl-jump"):SetVisible()
                    end
                end
                UIHelper.showToast("^FF0000Disabled")
                if GUIManager:getWindowByName("MainControl-jump") then
                    r8 = GUIManager:getWindowByName("MainControl-jump"):SetNormalImage()
                    r8 = GUIManager:getWindowByName("MainControl-jump"):SetPushedImage()
                    r8 = GUIManager:getWindowByName("MainControl-jump"):SetVisible()
                end
            end
            function GMHelper.WaterPush(...)
                if PlayerManager:getClientPlayer() then
                    Env.togWaterPush = not togWaterPush
                    if togWaterPush then
                        UIHelper.showToast("^00FF00Enabled")
                    end
                    UIHelper.showToast("^FF0000Disabled")
                end
            end
            function GMHelper.HideArmor(...)
                Env.togHideArmor = not togHideArmor
                if togHideArmor then
                    r8 = LogicSetting.Instance():setHideArmor()
                    UIHelper.showToast("^00FF00Enabled")
                end
                r8 = LogicSetting.Instance():setHideArmor()
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.HideHoldItem(...)
                Env.togHideHoldItem = not togHideHoldItem
                if togHideHoldItem then
                    r8 = PlayerManager:getClientPlayer():setHideHoldItem()
                    UIHelper.showToast("^00FF00Enabled")
                end
                r8 = PlayerManager:getClientPlayer():setHideHoldItem()
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.FlyParachute(...)
                if PlayerManager:getClientPlayer() then
                    Env.togFlyParachute = not togFlyParachute
                    if togFlyParachute then
                        r5 = PlayerManager:getClientPlayer().Player
                        r5 = {VectorUtil.newVector3(0, 1.35, 0)}
                        UIHelper.showToast("^00FF00Enabled")
                    end
                    UIHelper.showToast("^FF0000Disabled")
                end
            end
            function GMHelper.Strafe(...)
                Env.togStrafe = not togStrafe
                if togStrafe then
                    UIHelper.showToast("^00FF00Enabled")
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.AutoBridge(...)
                Env.togAutoBridge = not togAutoBridge
                if togAutoBridge then
                    Env.autoBridgeTimer = LuaTimer:scheduleTimer(function(...) end, 10, -1)
                end
                if autoBridgeTimer then
                    Env.autoBridgeTimer = nil
                end
            end
            function GMHelper.LongJump(...)
                if PlayerManager:getClientPlayer() then
                    Env.togLongJump = not togLongJump
                    if longJumpTimer then
                        Env.longJumpTimer = nil
                        if togLongJump then
                            SoundUtil.playSound(8)
                            UIHelper.showToast("^00FF00Enabled")
                            r2 = PlayerManager:getClientPlayer().Player:setFloatProperty()
                            local r5 = function(...)
                                if PlayerManager:getClientPlayer() then
                                    if r8 then
                                        r8 = PlayerManager:getClientPlayer().Player:setGlide()
                                    end
                                end
                            end
                            Env.longJumpTimer = LuaTimer:scheduleTimer(r5, 1, -1)
                        end
                        SoundUtil.playSound(207)
                        UIHelper.showToast("^FF0000Disabled")
                        r5 = PlayerManager:getClientPlayer().Player:setFloatProperty()
                    end
                end
            end
            function GMHelper.BtnBridge(...)
                Env.togBtnBridge = not togBtnBridge
                v2[q()] = 0
                if not togBtnBridge then
                    if BuildBtn then
                        BuildBtn:SetVisible(false)
                    end
                end
                local r8 = function(...)
                    PlayerManager:getClientPlayer():getInventory()
                    B:getRealCurrentItem()
                    if not r2 then
                        r8 = {false}
                    end
                    r2:getItem()
                    if not r5 then
                        r8 = {false}
                    end
                    PlayerManager:getClientPlayer():getPosition()
                    SceneManager.Instance():getMainCamera()
                    r4:getDirection()
                    if math.abs(r3.x) >= math.abs(r3.z) then
                        table.insert(r22, VectorUtil.toBlockVector3(r10.x, r10.y - 1, r10.z))
                        if (false and false) or (not false and true) then
                            r28 = VectorUtil.sub3((_nil_):getPosition(), r4:getPosition()).y
                            r28 = {VectorUtil.newVector3(r29, 0, r35)}
                            table.insert(r22, VectorUtil.add3(VectorUtil.toBlockVector3(r10.x, r10.y - 1, r10.z), v5(r28)))
                        end
                        r30 = {ipairs(r22)}
                        if r30[3] then
                            if r28 then
                                if r13 then
                                    r24 = Blockman.Instance():getPlayer()
                                    r28 = Blockman.Instance():getWorld()
                                    if r5:onItemUse(r2, r24, r28, r30, 0, r30) then
                                        r24 = r2:getItemStackSize() == 0
                                        if r24 then
                                            B:decrStackSize(B:findItemStack(r2), 0)
                                            r24 = PlayerManager:getClientPlayer().sendPacket
                                            r24:swingItem()
                                            r28 = {pid = "TryPlaceBlock", position = r30, face = 0, source = "bridge"}
                                            r24 = r24(PlayerManager:getClientPlayer(), r28)
                                            v2[v3[1]] = v2[v3[1]] + 1
                                            if not B:getRealCurrentItem() then
                                                r8 = {v2[v3[1]] > 0}
                                            end
                                            r29 = B:getRealCurrentItem():getItem()
                                        end
                                    end
                                end
                            end
                        end
                    end
                    r30 = (math.abs(r3.x) >= math.abs(r3.z) and 10091958) or 13567839
                    r1 = VectorUtil.newVector3((r3.x > 0 and 1) or -1, 0, 0).z
                    r12 = (math.abs(r3.x) >= math.abs(r3.z) and 10091958) or 13567839
                end
                GMHelper.buildSimpleBridge = r8
                local r8 = function(...)
                    if GMHelper:buildSimpleBridge() then
                        normalToast(("Bridge Built! Total Blocks: ") .. v2[v3[1]])
                    end
                    normalToast("Could not build bridge!")
                end
                if not BuildBtn then
                    Env.BuildBtn = GUIManager:createGUIWindow(GUIType.Button, "BlockToggleBtn")
                    BuildBtn:SetHorizontalAlignment(HorizontalAlignment.Center)
                    r10 = {0, 120}
                    BuildBtn:SetVerticalAlignment(VerticalAlignment.Center)
                    BuildBtn:SetHeight(r10)
                    r10 = {0, 120}
                    BuildBtn:SetWidth(r10)
                    r10 = {0, 325}
                    BuildBtn:SetXPosition(r10)
                    r10 = {0, 55}
                    BuildBtn:SetYPosition(r10)
                    r8 = GUISystem.Instance():GetRootWindow()
                    r8:AddChildWindow(BuildBtn)
                    BuildBtn:SetText("Bridge")
                    BuildBtn:SetTouchable(true)
                    BuildBtn:SetVisible(true)
                    BuildBtn:SetBackgroundColor(Color.BLACK)
                    BuildBtn:setEnableLongTouch(true)
                    BuildBtn:SetVisible(true)
                    UIHelper.showToast(Green .. "Bridge Button : Enabled")
                    BuildBtn:registerEvent(GUIEvent.ButtonClick, B)
                    BuildBtn:registerEvent(GUIEvent.LongTouchStart, B)
                    BuildBtn:registerEvent(GUIEvent.TouchDown, B)
                    BuildBtn:registerEvent(GUIEvent.TouchUp, B)
                    BuildBtn:registerEvent(GUIEvent.LongTouchEnd, B)
                    BuildBtn:registerEvent(GUIEvent.TouchEnd, B)
                    I(q())
                    BuildBtn:registerEvent(GUIEvent.Release, B)
                end
            end
            function GMHelper.instantReload(...)
                if not PlayerManager:getClientPlayer() then
                    Env.togInstantReload = not togInstantReload
                    if togInstantReload then
                        PlayerManager:getClientPlayer().Player.m_isReloadBullet = true
                        PlayerManager:getClientPlayer().Player.m_reloadPregress = 9999
                        PlayerManager:getClientPlayer().Player.m_prevReloadPregress = 9999
                        PlayerManager:getClientPlayer().Player.m_reloadBulletInt = 9999
                        PlayerManager:getClientPlayer().Player.gunFireProgress = 9999
                        PlayerManager:getClientPlayer().Player.prevGunFireProgress = 9999
                    end
                    PlayerManager:getClientPlayer().Player.m_isReloadBullet = false
                    PlayerManager:getClientPlayer().Player.m_reloadPregress = 1
                    PlayerManager:getClientPlayer().Player.m_prevReloadPregress = 1
                    PlayerManager:getClientPlayer().Player.m_reloadBulletInt = 1
                    PlayerManager:getClientPlayer().Player.gunFireProgress = 1
                    PlayerManager:getClientPlayer().Player.prevGunFireProgress = 1
                end
            end
            function GMHelper.closeGame(...)
                UIHelper.showToast("^FF0000Bye")
                CGame.Instance():exitGame("normal")
            end
            function GMHelper.reEnter(...)
                r8 = CGame.Instance():getGameType() or "g1001"
                Env.gameType = r8
                if targetId then
                    Env.targetId = targetId
                    Env.mapId = mapId or ""
                    UIHelper.showToast("^FF0000Resetting...")
                    r2 = CGame.Instance():resetGame()
                end
            end
            function GMHelper.HideAllNames(...)
                Env.togHideAllNames = not togHideAllNames
                if togHideAllNames then
                    UIHelper.showToast("^00FF00Enabled")
                end
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.HideGameControl(...)
                Env.togHideGameControl = not togHideGameControl
                r8 = {"Main-Fly", "Main-PoleControl-BG", "Main-PoleControl-Center", "Main-Up", "Main-Down", "Main-Break-Block-Progress-Nor", "Main-Break-Block-Progress-Pre", "Main-Jump", "MainControl-top-right", "MainControl-top-left", "MainControl-left", "MainControl-right", "MainControl-back", "MainControl-forward", "MainControl-jump", "Main-Drop"}
                v2[q()] = r8
                if togHideGameControl then
                    if hideControlTimer then
                        LuaTimer:cancel(hideControlTimer)
                        local r2 = function(...)
                            r2 = {ipairs(v2[v3[1]])}
                            if r2[3] then
                                if GUIManager:getWindowByName(r5) then
                                    GUIManager:getWindowByName(r5):SetAlpha(0)
                                end
                            end
                            ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 0)
                            ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 0)
                        end
                        Env.hideControlTimer = LuaTimer:scheduleTimer(r2, 30, -1)
                        I(q())
                    end
                end
                UIHelper.showToast("^FF0000Controls Visible")
                if hideControlTimer then
                    LuaTimer:cancel(hideControlTimer)
                    Env.hideControlTimer = nil
                    r3 = v2[q()]
                    r17 = {ipairs(r3)}
                    if r17[3] then
                        if GUIManager:getWindowByName(r3) then
                            r17 = GUIManager:getWindowByName(r3):SetAlpha()
                        end
                    end
                    ClientHelper.putFloatPrefs("MainControlKeyAlphaNormal", 1)
                    ClientHelper.putFloatPrefs("MainControlKeyAlphaPress", 1)
                end
            end
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            GUIManager:createGUIWindow(GUIType.StaticText, ("AzureSnap_") .. v1[1]):SetTouchable(false)
            GUIManager:createGUIWindow(GUIType.StaticText, ("AzureSnap_") .. v1[1]):SetText("")
            GUIManager:createGUIWindow(GUIType.StaticText, ("AzureSnap_") .. v1[1]):SetVisible(false)
            GUISystem.Instance():GetRootWindow()
            D:AddChildWindow(GUIManager:createGUIWindow(GUIType.StaticText, ("AzureSnap_") .. v1[1]))
            r8 = {GUIManager:createGUIWindow(GUIType.StaticText, ("AzureSnap_") .. v1[1])}
            function GMHelper.RequestTrade(...)
                Env.togRequestTrade = not togRequestTrade
                if togRequestTrade then
                    if not tradeSpammerTimer then
                        Env.tradeSpammerTimer = LuaTimer:scheduleTimer(function(...) end, 1000, -1)
                    end
                end
                if tradeSpammerTimer then
                    Env.tradeSpammerTimer = nil
                end
            end
            function GMHelper.ChatSpamSB(...)
                GMHelper:openInput({"Enter Spam Message"}, function(...) end)
            end
            function GMHelper.GetAllPassReward(...)
                if (false and false) or (not false and true) then
                    r8 = {pid = "tryGetAllPassReward"}
                    PlayerManager:getClientPlayer():sendPacket(r8)
                end
                UIHelper:showToast("^00FF00Rewards Requested")
            end
            v2[q()] = 0
            v2[q()] = r95
            r95 = {"Main-Fly", "Main-PoleControl-BG", "Main-PoleControl-Center", "Main-Up", "Main-Down", "Main-Break-Block-Progress-Nor", "Main-Break-Block-Progress-Pre", "Main-Jump", "MainControl-top-right", "MainControl-top-left", v6[1], v6[2], v6[3], v6[4], v6[5], v6[6], v6[7], v6[8], v6[9], v6[10], v6[11], v6[12], v6[13]}
            v2[q()] = r95
            v2[q()] = function(...)
                r8 = 1 - math.abs(v1[1] * 6 % 2 - 1)
                if v1[1] < 0.16666666666667 then
                    r8 = {v1[3] * v1[2] + v1[3] - v1[3] * v1[2], v1[3] * v1[2] * r8 + v1[3] - v1[3] * v1[2], v1[3] - v1[3] * v1[2]}
                end
            end
            v2[q()] = 0.5
            function GMHelper.CrazyMode(...)
                Env.togCrazyMode = not togCrazyMode
                r10 = {ipairs(v2[v3[1]])}
                if r10[3] then
                    v2[q()] = GUIManager:getWindowByName(r10)
                    r8 = v2[q()]
                    if r8 then
                        r22 = v2[q()]
                        local r17 = function(...)
                            if not togCrazyMode then
                                v2[v3[1]]:SetDrawColor(Color.TRANS)
                            end
                            v2[v3[2]] = v2[v3[2]] + 0.01 * v2[v3[3]] % 1
                            r4 = {v2[v3[4]](v2[v3[2]], 1, 1)}
                            r4 = {string.format("%.3f %.3f %.3f 1", r4[1], r4[2], r4[3])}
                            v2[v3[1]]:SetProperty("DrawColor", v5(r4))
                        end
                        table.insert(v2[v3[2]], r22)
                        LuaTimer:scheduleTimer(r17, 50, -1)
                        I(q())
                    end
                end
            end
            function GMHelper.ChangeActorForMe(...)
                v2[q()] = PlayerManager:getClientPlayer().Player
                local r2 = function(...)
                    GUIGMControlPanel:hide()
                    Blockman.Instance():getWorld()
                    D:changePlayerActor(v2[v3[1]], v1[1])
                    Blockman.Instance():getWorld()
                    D:changePlayerActor(v2[v3[1]], v1[1])
                    v2[v3[1]].m_isPeopleActor = false
                    EngineWorld:restorePlayerActor(v2[v3[1]])
                    GUIGMControlPanel:hide()
                    UIHelper.showToast("^00FFEESuccess")
                    GUIGMControlPanel:hide()
                end
                GMHelper:openInput({".actor"}, r2)
                I(q())
            end
            function GMHelper.changePlayerActor(...)
                if isGameStart then
                    if v1[2] == 1 then
                        ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
                        ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
                        r10 = {pairs(PlayerManager:getPlayers())}
                        if r10[3] then
                            if r3.Player then
                                entity.m_isPeopleActor = false
                                EngineWorld:restorePlayerActor(r3)
                            end
                        end
                        UIHelper.showToast("^00FF00Success!")
                        GUIGMControlPanel:hide()
                    end
                    if v1[2] == 2 then
                        ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
                        ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
                    end
                    ClientHelper.putStringPrefs("BoyActorName", "spiderman.actor")
                    ClientHelper.putStringPrefs("GirlActorName", "spiderman.actor")
                end
                if v1[2] == 1 then
                    ClientHelper.putStringPrefs("BoyActorName", "boy.actor")
                    ClientHelper.putStringPrefs("GirlActorName", "boy.actor")
                end
                if v1[2] == 2 then
                    ClientHelper.putStringPrefs("BoyActorName", "girl.actor")
                    ClientHelper.putStringPrefs("GirlActorName", "girl.actor")
                end
                ClientHelper.putStringPrefs("BoyActorName", "spiderman.actor")
                ClientHelper.putStringPrefs("GirlActorName", "spiderman.actor")
            end
            function GMHelper.Lying(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 15)
                end
            end
            function GMHelper.Sit(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 12)
                end
            end
            function GMHelper.Sit2(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 13)
                end
            end
            function GMHelper.Flyg(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 2)
                end
            end
            function GMHelper.Climb(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 9)
                end
            end
            function GMHelper.Climb2(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 10)
                end
            end
            function GMHelper.Sneaky(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 1008)
                end
            end
            function GMHelper.Swim(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 7)
                end
            end
            function GMHelper.Float(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setBoolProperty("DisableUpdateAnimState", true)
                    HostApi.setClientAction(PlayerManager:getClientPlayer().Player, 0, 2, 8)
                end
            end
            function GMHelper.Run(...)
            end
            function GMHelper.NoObsidian1(...)
                Env.togNoObsidian1 = not togNoObsidian1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(49) then
                        r2 = PlayerManager:getClientPlayer().Player
                        r25 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r27 = CarSetting.getCarSetting(r17).traction
                        r27 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r12 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r21 = CarSetting.getCarSetting(r17).coefAirDrag
                        r21 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r31 = CarSetting.getCarSetting(r17).reverseTraction
                        r31 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r27 = (BlockManager.getBlockById(49) and 5507478) or 14622942
                        r8 = BlockManager.getBlockById(49):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoObsidian1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoOakPlanks1(...)
                Env.togNoOakPlanks1 = not togNoOakPlanks1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(5) then
                        r27 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r25 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r12 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r31 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r21 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r27 = (BlockManager.getBlockById(5) and 4794438) or 6467462
                        r8 = BlockManager.getBlockById(5):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoOakPlanks1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoGlass1(...)
                Env.togNoGlass1 = not togNoGlass1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(94) then
                        r27 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r25 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r12 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r31 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r21 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r27 = (BlockManager.getBlockById(94) and 9417154) or 12238247
                        r8 = BlockManager.getBlockById(94):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoGlass1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoEndStone1(...)
                Env.togNoEndStone1 = not togNoEndStone1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(120) then
                        r27 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r25 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r12 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r21 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r31 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r27 = (BlockManager.getBlockById(120) and 13794856) or 7774140
                        r8 = BlockManager.getBlockById(120):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoEndStone1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoWool1(...)
                Env.togNoWool1 = not togNoWool1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(1441) then
                        r27 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r25 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r12 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r21 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r27 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r31 = (BlockManager.getBlockById(1441) and 2302674) or 14749705
                        r8 = BlockManager.getBlockById(1441):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoWool1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoBomb1(...)
                Env.togNoBomb1 = not togNoBomb1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(593) then
                        r25 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r27 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r12 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r21 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r31 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r27 = (BlockManager.getBlockById(593) and 14065939) or 16090787
                        r8 = BlockManager.getBlockById(593):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoBomb1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoIDoor1(...)
                Env.togNoIDoor1 = not togNoIDoor1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(241) then
                        r25 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r27 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r12 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r21 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r31 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r27 = (BlockManager.getBlockById(241) and 5885642) or 10700134
                        r8 = BlockManager.getBlockById(241):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoIDoor1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.NoQuartz1(...)
                Env.togNoQuartz1 = not togNoQuartz1
                if (false and false) or (not false and true) then
                    if BlockManager.getBlockById(155) then
                        r27 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r25 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r21 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r12 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r31 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r27 = (BlockManager.getBlockById(155) and 6149985) or 14762490
                        r8 = BlockManager.getBlockById(155):setBlockBounds()
                    end
                end
                UIHelper.showToast((togNoQuartz1 and "^00FF00Enabled") or "^FF0000Disabled")
            end
            function GMHelper.openSceneEditTool(...)
                if GUICustomSceneEditTool then
                    GUICustomSceneEditTool:show()
                    GUIGMControlPanel:hide()
                end
                Env.GUICustomSceneEditTool = UIHelper.newGameGUILayout("GUICustomSceneEditTool")
                GUICustomSceneEditTool:show()
            end
            function GMHelper.CrossHair(...)
                Env.togCrossHair = not togCrossHair
                if togCrossHair then
                    r8 = GUIManager:getWindowByName("Main-BedWar-BowShoot-Operate"):SetVisible()
                    r8 = GUIManager:getWindowByName("Main-BedWar-BowShoot-CrossHairs"):SetVisible()
                    Env.w = LuaTimer:scheduleTimer(function(...) end, 5, -1)
                end
                Env.w = nil
                r2 = Blockman.Instance().m_gameSettings:setCollimatorMode()
                UIHelper.showToast("^FF0000Disabled")
            end
            function GMHelper.AntiKillAura(...)
                Env.togAntiKillAura = not togAntiKillAura
                if togAntiKillAura then
                    if not antiKATimer then
                        Env.antiKATimer = LuaTimer:scheduleTimer(function(...) end, 100, -1)
                    end
                end
                if antiKATimer then
                    Env.antiKATimer = nil
                    if PlayerManager:getClientPlayer() then
                        if B then
                            PlayerManager:getClientPlayer().Player.m_knockBackCoefficient = 1
                        end
                    end
                end
            end
            function GMHelper.CannonBtnBedWar(...)
                v2[q()] = GUIManager:getWindowByName("Main-Cannon")
                Env.togCannonBtnBedWar = not togCannonBtnBedWar
                r8 = v2[q()]
                if togCannonBtnBedWar then
                    r8 = v2[q()]
                    v2[q()] = 0.5
                    r8 = v2[q()]
                    r4 = v2[q()]
                    r3 = v2[q()]
                    r17 = v2[q()]
                    r10 = PlayerManager:getClientPlayer().Player
                    r10 = {VectorUtil.newVector3(r4, r3, r17)}
                    local r5 = function(...)
                        if v2[v3[1]] <= 1 then
                            v2[v3[1]] = v2[v3[1]] + 0.01
                            r2 = {VectorUtil.newVector3(v2[v3[1]], v2[v3[1]], v2[v3[1]])}
                            v2[v3[2]]:SetScale(v5(r2))
                        end
                        v2[v3[1]] = v2[v3[1]] - 0.011
                    end
                    r8:SetScale(v5(r10))
                    r8 = v2[q()]
                    LuaTimer:scheduleTicker(r5, 1, 40)
                    local r10 = function(...)
                        if PlayerManager:getClientPlayer() then
                            if r8 then
                                r2 = PlayerManager:getClientPlayer().Player:getYaw()
                                r8 = PlayerManager:getClientPlayer().Player:getPitch() * math.pi
                                r8 = math.cos(r8 / 180) * math.sin(r2 * -math.pi / 180)
                                r8 = -math.sin(r8 / 180)
                                r8 = math.cos(r8 / 180) * math.cos(r2 * -math.pi / 180)
                                r3 = {VectorUtil.newVector3(r8 * 3, r8 * 4, r8 * 3)}
                                r8 = PlayerManager:getClientPlayer().Player:setVelocity()
                                SoundUtil.playSound(313)
                            end
                        end
                    end
                    r8:registerEvent(GUIEvent.ButtonClick, r10)
                    I(q())
                    I(q())
                end
            end
            function GMHelper.ItemID(...)
                PlayerManager:getClientPlayer():getInventory()
                D:addItemToInventory(Item.getItemById(v1[2], 1, 0))
                PlayerManager:getClientPlayer():getPlayerInventory()
                D:AddItem(v1[2], 1, 0)
            end
            v2[q()] = nil
            local r87 = function(...)
                local r6 = function(...)
                    if Game:getPlayer() then
                        if not Game:getPlayer():getWallet() then
                            LuaTimer:cancel(v2[v3[1]])
                            v2[v3[1]] = nil
                        end
                        r8 = Game:getPlayer():getWallet()
                        if a.m_diamondGolds >= v2[v3[2]] then
                            LuaTimer:cancel(v2[v3[1]])
                            v2[v3[1]] = nil
                        end
                        r5 = a.m_diamondGolds + math.max(1, v2[v3[2]] - a.m_diamondGolds * 0.1)
                    end
                    r5 = math.abs(a.m_diamondGolds - v2[v3[2]]) < 1
                end
            end
            v2[v3[1]] = LuaTimer:scheduleTimer(r6, v2[v3[3]], -1)
            v2[q()] = 0
            v2[q()] = 16
            v2[q()] = function(...)
                if Game:getPlayer() then
                    r2 = Game:getPlayer():getWallet()
                    if not r8 then
                        UIHelper.showToast("Failed to give G-Cubes")
                    end
                    Game:getPlayer():getWallet()
                    v2[v3[1]] = math.max(m_diamondGolds, v2[v3[1]])
                    v2[v3[1]] = v2[v3[1]] + v1[1]
                    r3 = {string.format("+%d G-Cubes!", v1[1])}
                    UIHelper.showToast(v5(r3))
                    v2[v3[2]]()
                end
            end
            function GMHelper.GiveGCubes_1(...)
                v2[v3[1]](1)
            end
            function GMHelper.GiveGCubes_2(...)
                v2[v3[1]](2)
            end
            function GMHelper.GiveGCubes_5(...)
                v2[v3[1]](5)
            end
            function GMHelper.GiveGCubes_10(...)
                v2[v3[1]](10)
            end
            function GMHelper.GiveGCubes_20(...)
                v2[v3[1]](20)
            end
            function GMHelper.GiveGCubes_50(...)
                v2[v3[1]](50)
            end
            function GMHelper.GiveGCubes_100(...)
                v2[v3[1]](100)
            end
            function GMHelper.GiveGCubes_200(...)
                v2[v3[1]](200)
            end
            function GMHelper.GiveGCubes_500(...)
                v2[v3[1]](500)
            end
            function GMHelper.GiveGCubes_1k(...)
                v2[v3[1]](1000)
            end
            function GMHelper.GiveGCubes_2k(...)
                v2[v3[1]](2000)
            end
            function GMHelper.GiveGCubes_5k(...)
                v2[v3[1]](5000)
            end
            function GMHelper.GiveGCubes_10k(...)
                v2[v3[1]](10000)
            end
            function GMHelper.GiveGCubes_20k(...)
                v2[v3[1]](20000)
            end
            function GMHelper.GiveGCubes_50k(...)
                v2[v3[1]](50000)
            end
            function GMHelper.GiveGCubes_100k(...)
                v2[v3[1]](100000)
            end
            local r92 = function(...)
                v2[v3[1]](200000)
            end
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            I(q())
            r5 = {original_io_open(v1[1], "w")}
            tostring(r5[2])
            r8 = {false, ("Gagal membuka file: ") .. r3}
            r4 = {tostring(v1[2])}
            r10 = {r5[1]:write(v5(r4))}
            r5[1]:close()
            tostring(r10[2])
            r8 = {false, ("Gagal menulis ke file: ") .. r22}
            r8 = {true}
            GMHelper.GiveGCubes_200k = r92
            function GMHelper.GiveGCubes_500k(...)
                v2[v3[1]](500000)
            end
            function GMHelper.GiveGCubes_1M(...)
                v2[v3[1]](1000000)
            end
            function GMHelper.GiveGCubes_2M(...)
                v2[v3[1]](2000000)
            end
            function GMHelper.GiveGCubes_5M(...)
                v2[v3[1]](5000000)
            end
            function GMHelper.GiveGCubes_10M(...)
                v2[v3[1]](10000000)
            end
            function GMHelper.GiveGCubes_20M(...)
                v2[v3[1]](20000000)
            end
            function GMHelper.GiveGCubes_50M(...)
                v2[v3[1]](50000000)
            end
            function GMHelper.GiveGCubes_100M(...)
                v2[v3[1]](100000000)
            end
            function GMHelper.GiveGCubes_200M(...)
                v2[v3[1]](200000000)
            end
            function GMHelper.GiveGCubes_500M(...)
                v2[v3[1]](500000000)
            end
            function GMHelper.GiveGCubes_1B(...)
                v2[v3[1]](1000000000)
            end
            function GMHelper.GiveGCubes_2B(...)
                v2[v3[1]](2000000000)
            end
            function GMHelper.GiveGCubes_5B(...)
                v2[v3[1]](5000000000)
            end
            function GMHelper.GiveGCubes_10B(...)
                v2[v3[1]](10000000000)
            end
            function GMHelper.GiveGCubes_20B(...)
                v2[v3[1]](20000000000)
            end
            function GMHelper.GiveGCubes_50B(...)
                v2[v3[1]](50000000000)
            end
            function GMHelper.GiveGCubes_100B(...)
                v2[v3[1]](100000000000)
            end
            function GMHelper.GiveGCubes_200B(...)
                v2[v3[1]](200000000000)
            end
            function GMHelper.GiveGCubes_MAX(...)
                v2[v3[1]] = 999999999999
                v2[v3[2]]()
            end
            function GMHelper.GiveGCubes_Reset(...)
                if v2[v3[1]] then
                    LuaTimer:cancel(v2[v3[1]])
                    v2[v3[1]] = nil
                    v2[v3[2]] = 0
                    if Game:getPlayer() then
                        r5 = Game:getPlayer():getWallet()
                        if a then
                            Game:getPlayer():getWallet().m_diamondGolds = 0
                            UIHelper.showCenterToast("G-Cubes Reset to 0")
                        end
                    end
                end
            end
            v2[q()] = "/storage/emulated/0/Android/data/com.sandboxol.blockymods/files/Download/SandboxOL/BlockMan/MyGC.txt"
            v2[q()] = nil
            v2[q()] = function(...)
                I(q())
                if original_io_open then
                    r5 = {original_io_open(v2[v3[1]], "r")}
                    r5[1]:read("*a")
                    r5[1]:close()
                    tonumber(r5)
                    if r10 then
                        if r10 > 0 then
                            v2[v3[2]] = D
                            if Game:getPlayer() then
                                r17 = Game:getPlayer():getWallet()
                                if r8 then
                                    r8 = Game:getPlayer():getWallet()
                                    r8.m_diamondGolds = 0
                                    v2[v3[3]]()
                                end
                            end
                        end
                    end
                end
            end
            Env["MainControl-right"]["MainControl-back"] = function(...)
                v2[v3[3]] = LuaTimer:scheduleTimer(function(...) end, 1500, -1)
            end
            Env["GMHelper"]["ToggleAutoSaveGCubes"] = function(...)
                CEvents.LuaPlayerDeathEvent:registerCallBack(function(...) end)
            end
            Env["GMHelper"]["setupDeathTriggerTimer"] = function(...)
                LuaTimer:scheduleTimer(function(...) end, 1, -1)
            end
            Env["GMHelper"]["Dupe"] = function(...)
                Env.togNoClip = not togNoClip
                UIHelper.showToast((Nocliptog and "^00FF00Enabled") or "^FF0000Disabled")
            end
            Env["GMHelper"]["NoClip"] = function(...)
                Blockman.Instance():getWorld()
                GUIGMControlPanel:hide()
                r2:changePlayerActor(PlayerManager:getClientPlayer().Player, v1[2])
                r2:changePlayerActor(PlayerManager:getClientPlayer().Player, v1[2])
                PlayerManager:getClientPlayer().Player.m_isPeopleActor = false
                EngineWorld:restorePlayerActor(PlayerManager:getClientPlayer().Player)
                UIHelper.showToast(("^00FFEESuccess: ") .. v1[2])
            end
            Env["GMHelper"]["_applyActor"] = function(...)
                GMHelper:_applyActor("Mario.actor")
                I(q())
            end
            Env["GMHelper"]["SetMario"] = function(...)
                GMHelper:_applyActor("hero_spiderman.actor")
            end
            Env["GMHelper"]["SetSpiderMan"] = function(...)
                GMHelper:_applyActor("hero_ironman.actor")
                I(q())
            end
            Env["GMHelper"]["SetIronMan"] = function(...)
                GMHelper:_applyActor("hero_hulk.actor")
            end
            Env["GMHelper"]["SetHulk"] = function(...)
                _G.togL15A7 = true
                refreshButtonColorUI("L15A7")
                r5 = {math.random(100000, 999999)}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetHorizontalAlignment(HorizontalAlignment.Center)
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetVerticalAlignment(VerticalAlignment.Center)
                r8 = PlayerManager.getClientPlayer().Player
                r8 = {0, 60}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetHeight(r8)
                r8 = {0, 60}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetWidth(r8)
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetLevel(1)
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetTouchable(true)
                GUISystem.Instance():GetRootWindow()
                D:AddChildWindow(GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))))
                r8 = {0, 0, 0, 0.6}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetBackgroundColor(r8)
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetVisible(true)
                r8 = {0.445, 0}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetXPosition(r8)
                r8 = {-0.25, 0}
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetYPosition(r8)
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetNormalImage("set:btn_fishing.json image:FullImage")
                GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):SetPushedImage("set:btn_fishing.json image:FullImage")
                v1[1]._L15A7Button = GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5)))
                local r2 = function(...)
                    if not PlayerManager:getClientPlayer() then
                        PlayerManager:getClientPlayer().Player:getPosition()
                        if (false and false) or (not false and true) then
                            if (false and false) or (not false and true) then
                                r34 = {x = r2.x + -20, y = r2.y + -26, z = r2.z + -20}
                                if EngineWorld:getBlockId(r34) == BlockID.BED then
                                    r47 = EngineWorld:getBlockMeta(r34) >= 0
                                    if r47 then
                                        r47 = EngineWorld:getBlockMeta(r34) <= 100
                                        if r8 then
                                            if math.sqrt(r2.x + -20 - r2.x ^ 2 + r2.y + -26 - r2.y ^ 2 + r2.z + -20 - r2.z ^ 2) < math.huge then
                                                math.sqrt(r2.x + -20 - r2.x ^ 2 + r2.y + -26 - r2.y ^ 2 + r2.z + -20 - r2.z ^ 2)
                                                r8 = {x = r2.x + -20, y = r2.y + -26, z = r2.z + -20}
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not nil then
                        UIHelper.showToast("^FF0000No bed nearby")
                    end
                    if (false and false) or (not false and true) then
                        if (false and false) or (not false and true) then
                            if false then
                                if not false then
                                    r47 = {x = (_nil_).x + -2, y = (_nil_).y + -2, z = (_nil_).z + -2}
                                    if EngineWorld:getBlockId(r47) ~= BlockID.BED then
                                        r39 = PlayerManager:getClientPlayer().Player
                                        r39 = {x = (_nil_).x + -2, y = (_nil_).y + -2, z = (_nil_).z + -2}
                                        table.insert(1, r39)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            r12 = {ipairs(1)}
            v2[v3[1]](PlayerManager:getClientPlayer(), VectorUtil.newVector3((_false_).x, (_false_).y, (_false_).z), 1)
            UIHelper.showToast(("^00FF00Built ") .. r30 .. " blocks around bed.")
            GUIManager:createGUIWindow(GUIType.Button, ("GUIButton-L15A7-") .. tostring(v5(r5))):registerEvent(GUIEvent.ButtonClick, r2)
            Env["GMHelper"]["L15A7"] = function(...)
                Env.togDestroyBlock = not togDestroyBlock
                if v1[1].breakBlockCallback then
                    if not v1[1].breakBlockEnabled then
                        v1[1].breakBlockCallback = nil
                        if togDestroyBlock then
                            v1[1].breakBlockCallback = function(...)
                                if v1[1] then
                                    EngineWorld:setBlock(VectorUtil.newVector3(v1[1].x, v1[1].y, v1[1].z), BlockID.AIR)
                                end
                            end
                            CEvents.ClickToBlockEvent:registerCallBack(v1[1].breakBlockCallback)
                        end
                        if v1[1].breakBlockCallback then
                            v1[1].breakBlockCallback = nil
                        end
                    end
                end
            end
            Env["GMHelper"]["DestroyBlock"] = function(...)
                Env.togHideChat = not togHideChat
                if togHideChat then
                    r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                    r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                end
                r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
                r8 = GUIManager:getWindowByName("Main-Chat-Message"):SetVisible()
            end
            Env["GMHelper"]["HideChat"] = function(...)
                Game:resetGame(v1[3], r2, v1[2])
            end
            Env["GMHelper"]["EnterGame"] = function(...)
                v2[q()] = v1[1]
                Env.togFastBreakSB = not togFastBreakSB
                I(q())
                UIHelper.showToast((togFastBreakSB and "FastBreak Enabled") or "FastBreak Disabled")
            end
            Env["GMHelper"]["FastBreakSB"] = function(...)
                I(q())
                I(q())
                if io.open("/storage/emulated/0/Android/data/com.sandboxol.blockymods/RunCode.lua", "r") then
                    io.open("/storage/emulated/0/Android/data/com.sandboxol.blockymods/RunCode.lua", "r"):read("*all")
                    v2[q()] = D
                    io.open("/storage/emulated/0/Android/data/com.sandboxol.blockymods/RunCode.lua", "r"):close()
                    local r10 = function(...)
                        if loadstring(v2[v3[1]]) then
                            loadstring(v2[v3[1]])()
                            UIHelper.showToast("Code Executed Successfully")
                        end
                    end
                    r4 = {pcall(r10)}
                    if not r4[1] then
                        tostring(r4[2])
                        UIHelper.showToast(("Error: ") .. r22)
                        I(q())
                    end
                end
                UIHelper.showToast("File Not Found")
            end
            Env["GMHelper"]["RunFile"] = function(...)
                r8 = {""}
                v1[1]:openInput(r8, function(...) end)
            end
            Env["GMHelper"]["runCode"] = function(...)
                Env.togHitBoxV3 = not togHitBoxV3
                CEvents.ClickSceneEvent:registerCallBack(function(...) end)
            end
            Env["GMHelper"]["HitBoxV3"] = function(...)
                v2[q()] = false
                v2[q()] = 0
                v2[q()] = 1000
                v2[q()] = 1000
                v2[v6[1]] = v6[6]
                PlayerManager:getClientPlayer():getPosition()
                r18 = {pairs(v2[v3[1]]:getAllMonsterEntity())}
                if r18[3] then
                    if (_nil_).entity then
                        r8 = PlayerManager:getClientPlayer().Player
                        r8 = distanceM(r2, (_nil_).entity:getPosition()) <= (v1[1] or 7)
                    end
                end
                r8 = {nil}
            end
            v2[q()] = PlayerManager:getClientPlayer()
            r10 = v2[q()]
            r10 = {pid = "TryCatchFish"}
            r8 = v2[q()]:sendPacket()
            v2[v3[1]] = v2[v3[1]] + 1
            UIHelper.showToast(("Total Fish Count : ") .. v2[v3[1]])
            I(q())
            local r4 = function(...)
                r6 = {pid = "TryTossFishingRod"}
                v2[v3[1]]:sendPacket(r6)
            end
            LuaTimer:schedule(r4, v2[v3[2]])
            v2[q()] = function(...)
                v2[q()] = function(...)
                    Env.togAutoFish = not togAutoFish
                    if togAutoFish then
                        r8 = PlayerManager:getClientPlayer():sendPacket()
                        if not v2[v3[1]] then
                            v2[v3[1]] = true
                            Events.PlayerFishingStateChangeEvent:registerCallBack(v2[v3[2]])
                            print("By KhdBg")
                            print("Panel changing: Novatex")
                        end
                    end
                end
                Env["GMHelper"]["AutoFish"] = function(...)
                    I(q())
                    I(q())
                    if not PlayerManager:getClientPlayer() then
                        r5 = PlayerManager:getClientPlayer().task
                        r5 = {pairs(r5.groups)}
                        if r5[3] then
                            r18 = {pairs(("groups").tasks)}
                            if r18[3] then
                                q()
                                v2[D] = r18
                                if v2[r18].status == Define.TaskStatus.Doing then
                                    if v2[r18]:cfg() then
                                        if r12 == Define.TaskType.SubmitItem then
                                            tonumber(r30[1])
                                            tonumber(r15[2])
                                            v2[q()] = r30 or 1
                                            if v2[v3[1]]:getGoodsCfgByItemId(r12 or 0, -1) then
                                                if r27 then
                                                    r2 = PlayerManager:getClientPlayer().userId
                                                    r20 = VectorUtil.newVector3((r3.x > 0 and 1) or -1, 0, 0).x
                                                    r20 = v2[q()]
                                                    r30 = v2[r18]:cfg().condition
                                                    r30 = {pid = "tryBuyGoods", goodsId = r28, count = r20}
                                                    local r13 = function(...)
                                                        v2[v3[1]]:tryDoSubmitItemTask(v2[v3[2]])
                                                    end
                                                    r27 = PlayerManager:getClientPlayer():sendPacket()
                                                    LuaTimer:schedule(r13, 200)
                                                    local r13 = function(...)
                                                        if v2[v3[1]].status == Define.TaskStatus.Finish then
                                                            v2[v3[3]]:tryReceiveTask(v2[v3[1]])
                                                            UIHelper.showToast("Task Completed")
                                                        end
                                                    end
                                                end
                                                LuaTimer:schedule(r13, 500)
                                                I(q())
                                                I(r18)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            v2[q()] = function(...)
                Env.togAutoSubmitItem = not togAutoSubmitItem
                if togAutoSubmitItem then
                    if SubmitTimer then
                        LuaTimer:cancel(SubmitTimer)
                        Env.SubmitTimer = LuaTimer:scheduleTimer(v2[v3[1]], v2[v3[2]] or 1000, -1)
                    end
                end
                if SubmitTimer then
                    LuaTimer:cancel(SubmitTimer)
                    Env.SubmitTimer = nil
                end
            end
            Env["GMHelper"]["AutoSubmitItem"] = function(...)
                v2[q()] = nil
                I(q())
                if not PlayerManager:getClientPlayer() then
                    if v2[v3[1]](1000) then
                        if r8 then
                            v2[v3[1]](1000).entity:getPosition()
                            Teleport(VectorUtil.newVector3(r5.x, r5.y + 1.2, r5.z))
                            r8 = v2[v3[1]](1000).entity
                            r8 = {pid = "tryAttackMonster", entityId = EntityCache:getServerId(r2)}
                            PlayerManager:getClientPlayer():sendPacket(r8)
                        end
                    end
                end
            end
            v2[q()] = function(...)
                Env.togAutoGayMobKiller = not togAutoGayMobKiller
                if v2[v3[1]] then
                    v2[v3[1]] = nil
                    LuaTimer:cancel(v2[v3[1]])
                    if togAutoGayMobKiller then
                        v2[v3[1]] = LuaTimer:scheduleTimer(v2[v3[2]], 350, -1)
                        UIHelper.showToast("^00FF00Enabled")
                    end
                    UIHelper.showToast("^FF0000Disabled")
                end
            end
            Env["GMHelper"]["AutoGayMobKiller"] = function(...)
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink"] = function(...)
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink1"] = function(...)
                I(q())
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink2"] = function(...)
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink3"] = function(...)
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink4"] = function(...)
                UIHelper.showToast("Success")
            end
            Env["GMHelper"]["OpenLink5"] = function(...)
                v1[1]:GetScreenRenderArea()
                r8 = type(a) == "table"
                if type(a) == "table" then
                    if #a >= 4 then
                        r8 = {VectorUtil.newVector2(a[1] + a[3] - a[1] / 2, a[2] + a[4] - a[2] / 2)}
                        r8 = {v5(r8)}
                    end
                    r8 = {VectorUtil.newVector2(0, 0)}
                    r8 = {v5(r8)}
                end
            end
            v2[q()] = function(...)
                v2[q()] = v1[2]
                r2 = v2[v3[1]](1000).entity.entityId
                r2 = v2[q()]
                if not r2 then
                    v2[q()] = v2[v3[1]](v2[q()])
                    r5 = v2[q()]
                    r2 = {r5}
                    r8 = v2[q()]:TouchDown()
                    local r2 = function(...)
                        if v2[v3[1]] then
                            r6 = {v2[v3[2]]}
                            v2[v3[1]]:TouchUp(r6)
                        end
                    end
                    LuaTimer:schedule(r2, 40)
                    I(q())
                    I(q())
                end
                r2 = v2[q()]
            end
            v6[13][v6[14]] = v6[12]
            GUIManager:showWindowByName("DeathSettlement.binary")
            GUIManager:showWindowByName("DeathSettlement.json")
            GUIManager:setWindowByName("DeathSettlement.json")
            r8:SetVisible(true)
            GUIManager:setWindowByName("DeathSettlement.binary")
            r8:SetVisible(true)
            GMHelper:Click()
            UIHelper.showToast("^FF00EESuccessful")
            Env["GMHelper"]["RespawnV2"] = function(...)
                if v1[1].AutoArmorTimer then
                    LuaTimer:cancel(v1[1].AutoArmorTimer)
                    v1[1].AutoArmorTimer = nil
                    r8 = {ids = {310, 306, 302, 314, 298}, slot = 36}
                    r2 = {311, 307, 303, 315, 299}
                    r5 = {312, 308, 304, 316, 300}
                    r10 = {313, 309, 305, 317, 301}
                    r2 = {ids = r10, slot = 39}
                    v2[q()] = {r8, {ids = r2, slot = 37}, {ids = r5, slot = 38}, r2}
                    local r2 = function(...)
                        if not PlayerManager:getClientPlayer() then
                            r8 = PlayerManager:getClientPlayer().Player:getInventory()
                            r10 = {ipairs(v2[v3[1]])}
                            if r10[3] then
                                a:getItemStackInfo(r4.slot)
                                r27 = {ipairs(r4.ids)}
                                if r27[3] then
                                    if r3 then
                                        if r3.id == r27 then
                                            if not true then
                                                r31 = {ipairs(r4.ids)}
                                                if r31[3] then
                                                    if (false and false) or (not false and true) then
                                                        if a:getItemStackInfo(0) then
                                                            if r1 == r4.ids then
                                                                if a:getStackInSlot(0) then
                                                                    a:equipArmor(a:getStackInSlot(0))
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            a:onInventoryChanged()
                        end
                    end
                    v1[1].AutoArmorTimer = LuaTimer:scheduleTicker(r2, 20, -1)
                    I(q())
                end
            end
            Env["GMHelper"]["CustomAutoEquip"] = function(...)
                if not PlayerManager:getClientPlayer() then
                    PlayerManager:getClientPlayer().Player:setAllowFlying(false)
                    PlayerManager:getClientPlayer().Player:setFlying(false)
                    PlayerManager:getClientPlayer().Player:setPosition(v1[1])
                end
            end
            v2[q()] = function(...)
                Env.togReachPlayersSB = not togReachPlayersSB
                if ReachPlayersTimer then
                    LuaTimer:cancel(ReachPlayersTimer)
                    if togReachPlayersSB then
                        v2[q()] = PlayerManager:getClientPlayer()
                        r1 = a:getItemStackInfo(0).id
                        r10 = v2[q()]
                        if not r10 then
                            local r8 = function(...)
                                if not PlayerManager:getPlayerByEntityId(v1[1]) then
                                    v2[q()] = v2[v3[1]].Player:getPosition()
                                    PlayerManager:getPlayerByEntityId(v1[1]).Player:getPosition()
                                    v2[v3[2]](VectorUtil.newVector3(r10.x, r10.y + 1.2, r10.z))
                                    r8 = {pid = "tryAttackPlayer", entityId = EntityCache:getServerId(r2)}
                                    PlayerManager:getPlayerByEntityId(v1[1]):sendPacket(r8)
                                    local r3 = function(...)
                                        v2[v3[1]](v2[v3[2]])
                                    end
                                    LuaTimer:schedule(r3, 10)
                                    I(q())
                                end
                            end
                            v2[v3[2]] = Listener.registerCallBack(CEvents.AttackEntityEvent, B)
                            I(q())
                        end
                        r4 = v2[q()]
                    end
                    ClientHelper.putFloatPrefs("EntityReachDistance", 4.5)
                    if v2[v3[2]] then
                        v2[v3[2]] = nil
                        Listener.unregisterCallBack(CEvents.AttackEntityEvent, v2[v3[2]])
                    end
                end
            end
            Env["GMHelper"]["ReachPlayersSB"] = function(...)
                Env.togKillAuraMob = not togKillAuraMob
                if togKillAuraMob then
                    if not killAuraMobTimer then
                        Env.killAuraMobTimer = LuaTimer:scheduleTimer(function(...) end, 200, -1)
                    end
                end
                if killAuraMobTimer then
                    Env.killAuraMobTimer = nil
                end
            end
            Env["GMHelper"]["KillAuraMob"] = function(...)
                Env.togInfKillAuraMob = not togInfKillAuraMob
                if togInfKillAuraMob then
                    if not killAuraMobTimer then
                        Env.killAuraMobTimer = LuaTimer:scheduleTimer(function(...) end, 700, -1)
                    end
                end
                if killAuraMobTimer then
                    Env.killAuraMobTimer = nil
                end
            end
            Env["GMHelper"]["InfKillAuraMob"] = function(...)
                Env.togHitBoxMob = not togHitBoxMob
                v2[q()] = PlayerManager:getClientPlayer()
                local r8 = function(...)
                    if MonsterManager:getMonsters() then
                        r5 = {pairs(MonsterManager:getMonsters())}
                        if r5[3] then
                            if r4.entity then
                                if r4.entity:isEntityAlive() then
                                    r4.entity:getPosition()
                                    if MathUtil:distanceSquare2d(r17, v2[v3[1]]:getPosition()) < 120 then
                                        if EntityCache:getServerId(r4.entity.entityId) then
                                            r31 = {math.floor(r17.z)}
                                            r2 = PlayerManager:getPlayerByEntityId(v1[1]).Player
                                            r27 = {pid = "tryAttackMonster", entityId = EntityCache:getServerId(r4.entity.entityId), position = VectorUtil.newVector3(math.floor(r17.x), math.floor(r17.y), v5(r31))}
                                            v2[v3[1]]:sendPacket(r27)
                                            Zentex(EntityCache:getServerId(r4.entity.entityId), VectorUtil.newVector3(math.floor(r17.x), math.floor(r17.y), v5(r31)))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            UIHelper.showToast("^00FF00Mob HitBox Enabled")
            CEvents.PlayerClickScreenEvent:registerCallBack(a)
            I(q())
            UIHelper.showToast("^FF0000Mob HitBox Disabled")
            CEvents.PlayerClickScreenEvent:unregisterAll()
            Env["GMHelper"]["HitBoxMob"] = function(...)
                if not v1[2] then
                    r22 = {math.atan2(v1[3].y - v1[2].y, v1[3].x - v1[2].x)}
                    r27 = math.sqrt(v1[3].x - v1[2].x ^ 2 + v1[3].y - v1[2].y ^ 2) / 2
                    r8 = {0, v1[2].x + v1[3].x / 2 - r27}
                    r25 = {0, v1[2].y + v1[3].y / 2 - v1[5] / 2}
                    r21 = {0, math.sqrt(v1[3].x - v1[2].x ^ 2 + v1[3].y - v1[2].y ^ 2)}
                    r27 = {0, v1[5]}
                    v1[1]:SetArea(r8, r25, r21, r27)
                    v1[1]:SetRotate(math.deg(v5(r22)))
                    v1[1]:SetBackgroundColor(v1[4])
                    v1[1]:SetVisible(true)
                end
            end
            v2[q()] = function(...)
                if not v1[2] then
                    r25 = math.sqrt(v1[3].x - v1[2].x ^ 2 + v1[3].y - v1[2].y ^ 2) / 2
                    r8 = {0, v1[2].x + v1[3].x / 2 - r25}
                    r17 = {0, v1[2].y + v1[3].y / 2 - v1[5] / 2}
                    r22 = {0, math.sqrt(v1[3].x - v1[2].x ^ 2 + v1[3].y - v1[2].y ^ 2)}
                    r18 = {0, v1[5]}
                    v1[1]:SetArea(r8, r17, r22, r18)
                    r18 = {math.atan2(v1[3].y - v1[2].y, v1[3].x - v1[2].x)}
                    r17 = {math.deg(v5(r18))}
                    v1[1]:SetRotate(v5(r17))
                    v1[1]:SetBackgroundColor(v1[4])
                    v1[1]:SetVisible(true)
                end
            end
            v2[q()] = function(...)
                v2[v6[16]] = v6[15]
                v2[v6[17]] = v6[15]
                v2[v6[18]] = v6[15]
                v2[q()] = function(...)
                    v2[q()] = function(...)
                        I(q())
                        if v2[v3[1]] then
                            v2[v3[1]] = false
                            if v2[v3[2]] then
                                v2[v3[2]] = nil
                                LuaTimer:cancel(v2[v3[2]])
                                r4 = {pairs(v2[v3[3]])}
                                if r4[3] then
                                    if (false and false) or (not false and true) then
                                        if v2[v3[3]][1] then
                                            GUIManager:destroyGUIWindow(v2[v3[3]][1])
                                        end
                                    end
                                    if v2[v3[3]].info then
                                        GUIManager:destroyGUIWindow(v2[v3[3]].info)
                                    end
                                end
                                v2[v3[3]] = {}
                                UIHelper.showToast("off")
                            end
                        end
                        v2[v3[1]] = true
                        local r2 = function(...)
                            GUISystem.Instance():GetScreenWidth()
                            r8 = GUISystem.Instance():GetScreenHeight()
                            SceneManager.Instance():getMainCamera()
                            r5:getPosition()
                            r25 = {pairs(v2[v3[2]])}
                            if r25[3] then
                                r13 = v2[v3[1]]:getGoodsCfgByItemId(r12 or 0, -1).goodsId
                                r13 = {pairs(PlayerManager:getPlayers())}
                                if r13[3] then
                                    if r15.userId == r25[3] then
                                        if not true then
                                            if (false and false) or (not false and true) then
                                                if r21[1] then
                                                    GUIManager:destroyGUIWindow(r21[1])
                                                end
                                            end
                                            if r21.info then
                                                GUIManager:destroyGUIWindow(r21.info)
                                                v2[v3[2]][r25[3]] = nil
                                            end
                                        end
                                    end
                                end
                            end
                            r21 = {pairs(PlayerManager:getPlayers())}
                            if r21[3] then
                                if r21 then
                                    if r21.userId ~= r13 then
                                        if not v2[v3[2]][r21.userId] then
                                            v2[v3[2]][r21.userId] = v2[v3[3]](r21.userId)
                                            if v2[v3[3]](r21.userId) then
                                                r13 = PlayerManager:getClientPlayer().userId
                                                r13 = (v2[v3[3]](r21.userId) and 10222435) or 5189127
                                                if not r21.Player then
                                                    if (false and false) or (not false and true) then
                                                        r29 = v2[v3[3]](r21.userId)[1]
                                                        r29:SetVisible(false)
                                                    end
                                                    r31 = v2[v3[3]](r21.userId).info
                                                    r31:SetVisible(false)
                                                end
                                                math.sqrt(r35 - r10.x ^ 2 + r1 - r10.y ^ 2 + r35 - r10.z ^ 2)
                                                if r20 - r10.x * r20 + r35 - r10.y * r35 + r20 - r10.z * r20 <= 0 then
                                                    if (false and false) or (not false and true) then
                                                        r1 = r21.Player:getPosition(0).y
                                                        r1 = v2[v3[3]](r21.userId)[1]
                                                        r1:SetVisible(false)
                                                    end
                                                    r24 = v2[v3[3]](r21.userId).info
                                                    r24:SetVisible(false)
                                                end
                                                r29 = r21.Player:getYaw() or 0
                                                r35 = r5:getDirection().y
                                                r35 = {-0.45, -0.45}
                                                r1 = {0.45, -0.45}
                                                r38 = {0.45, 0.45}
                                                r45 = {-0.45, 0.45}
                                                r24 = {r35, r1, r38, r45}
                                                math.sin(math.rad(r29))
                                                math.cos(math.rad(r29))
                                                if (false and false) or (not false and true) then
                                                    r39 = r24[1][1] * math.cos(math.rad(r29))
                                                    r48 = r24[1][2] * math.sin(math.rad(r29))
                                                    r48 = r24[1][1] * math.sin(math.rad(r29))
                                                    r33 = r24[1][2] * math.cos(math.rad(r29))
                                                    r7 = {x = r36 + r39 - r48, y = r46 - 0.1, z = r44 + r48 + r33}
                                                    r48 = Blockman.Instance():getScreenPos()
                                                    r14 = {x = r37 + r39 - r48, y = r49 + 1.9, z = r53 + r48 + r33}
                                                    r33 = Blockman.Instance():getScreenPos()
                                                    if not r48 then
                                                        if false then
                                                            if (false and false) or (not false and true) then
                                                                r48 = v2[v3[3]](r21.userId)[1]
                                                                r48 = v2[v3[3]](r21.userId)[5]
                                                                v2[v3[4]](r48, r35[1], r35[2], v2[v3[1]](0.5), 2)
                                                                r48 = v2[v3[3]](r21.userId)[9]
                                                                v2[v3[4]](r48, r35[5], r35[6], v2[v3[1]](0.5), 2)
                                                                v2[v3[4]](r48, r35[1], r35[5], v2[v3[1]](0.5), 2)
                                                            end
                                                            r38 = v2[v3[3]](r21.userId).info
                                                            r38:SetVisible(true)
                                                            r38 = v2[v3[3]](r21.userId).info
                                                            r38:SetTextColor(v2[v3[1]](0.5))
                                                            r19 = {0, r35[5].x + r35[7].x / 2 - 100}
                                                            r47 = {0, r35[5].y + r35[7].y / 2 - 25}
                                                            r39 = {0, 200}
                                                            r48 = {0, 20}
                                                            r34 = v2[v3[3]](r21.userId).info
                                                            r34:SetArea(r19, r47, r39, r48)
                                                        end
                                                        if (false and false) or (not false and true) then
                                                            r47 = v2[v3[3]](r21.userId)[1]
                                                            r47:SetVisible(false)
                                                        end
                                                        r38 = v2[v3[3]](r21.userId).info
                                                        r38:SetVisible(false)
                                                    end
                                                    r14 = {x = r48.x * B, y = r48.y * r2}
                                                    r35[1] = r14
                                                    r11 = {x = r33.x * B, y = r33.y * r2}
                                                    r35[5] = r11
                                                end
                                            end
                                        end
                                        r29 = math.sqrt(r35 - r10.x ^ 2 + r1 - r10.y ^ 2 + r35 - r10.z ^ 2) > 500
                                    end
                                end
                            end
                        end
                    end
                end
            end
            UIHelper.showToast("on")
            v2[v3[2]] = LuaTimer:scheduleTimer(r2, 16, -1)
            Env["GMHelper"]["Esp"] = function(...)
                v2[q()] = {}
                v2[q()] = nil
                v2[q()] = function(...)
                    Env.togEspSnapLine = not togEspSnapLine
                    I(q())
                    if togEspSnapLine then
                        UIHelper.showToast("on")
                        if not togEspSnapLine then
                            if v2[v3[1]] then
                                v2[v3[1]] = nil
                                LuaTimer:cancel(v2[v3[1]])
                                r4 = {pairs(v2[v3[2]])}
                                if r4[3] then
                                    v2[v3[2]]:SetVisible(false)
                                end
                            end
                        end
                        local r2 = function(...)
                            SceneManager.Instance():getMainCamera()
                            if not PlayerManager:getClientPlayer() then
                                GUISystem.Instance():GetScreenWidth()
                                r8 = GUISystem.Instance():GetScreenHeight()
                                a:getPosition()
                                r18 = {PlayerManager:getPlayers()}
                                r22 = {ipairs(v5(r18))}
                                if r22[3] then
                                    if PlayerManager.getPlayers.userId ~= r27 then
                                        if v2[v3[2]][PlayerManager.getPlayers.userId] then
                                            v2[v3[2]][PlayerManager.getPlayers.userId] = v2[v3[2]][PlayerManager.getPlayers.userId]
                                            if PlayerManager.getPlayers.Player then
                                                if PlayerManager.getPlayers:isEntityAlive() then
                                                    PlayerManager.getPlayers.Player:getPosition()
                                                    if r12.x - r5.x * r28 + r12.y - r5.y * r29 + r12.z - r5.z * r28 > 0 then
                                                        r28 = a:getDirection().z
                                                        r28 = {x = r12.x, y = r12.y + 1, z = r12.z}
                                                        Blockman.Instance():getScreenPos(r28)
                                                        if r24.x > 0 then
                                                            if r24.x < 1 then
                                                                if r24.y > 0 then
                                                                    if r24.y < 1 then
                                                                        v2[v3[2]][PlayerManager.getPlayers.userId]:SetVisible(true)
                                                                        v2[v3[2]][PlayerManager.getPlayers.userId]:SetBackgroundColor(v2[v3[1]](0.5))
                                                                        r47 = r24.x * B - B * 0.5 - math.sqrt(r24.x * B - B * 0.5 ^ 2 + r24.y * r2 ^ 2)
                                                                        r34 = {0.5, r47 / 2}
                                                                        r42 = {0, r24.y * r2 / 2}
                                                                        r19 = {0, math.sqrt(r24.x * B - B * 0.5 ^ 2 + r24.y * r2 ^ 2)}
                                                                        r47 = {0, 2}
                                                                        v2[v3[2]][PlayerManager.getPlayers.userId]:SetArea(r34, r42, r19, r47)
                                                                        r47 = {math.atan2(r24.y * r2, r24.x * B - B * 0.5)}
                                                                        r42 = {math.deg(v5(r47))}
                                                                        v2[v3[2]][PlayerManager.getPlayers.userId]:SetRotate(v5(r42))
                                                                    end
                                                                    v2[v3[2]][PlayerManager.getPlayers.userId]:SetVisible(false)
                                                                end
                                                            end
                                                        end
                                                    end
                                                    v2[v3[2]][PlayerManager.getPlayers.userId]:SetVisible(false)
                                                end
                                                v2[v3[2]][PlayerManager.getPlayers.userId]:SetVisible(false)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        v2[v3[1]] = LuaTimer:scheduleTimer(r2, 16, -1)
                    end
                    UIHelper.showToast("off")
                end
                v6[24][v6[25]] = v6[23]
                v2[v6[26]] = v6[23]
                v2[q()] = nil
                v2[q()] = {}
                v2[q()] = GUISystem.Instance()
                v2[q()] = GUIManager
                r8 = v2[q()]:GetRootWindow()
                v2[q()] = r8
                if v2[v3[1]] then
                    v2[v3[1]] = false
                    if v2[v3[2]] then
                        LuaTimer:cancel(v2[v3[2]])
                        v2[v3[2]] = nil
                        r22 = {pairs(v2[v3[3]])}
                        if r22[3] then
                            if (false and false) or (not false and true) then
                                if v2[v3[3]][1] then
                                    r12 = v2[r18]:cfg().type
                                    r12 = v2[q()]
                                    r12:destroyGUIWindow(v2[v3[3]][1])
                                end
                            end
                        end
                        v2[v3[3]] = r5
                        UIHelper.showToast("off")
                    end
                end
                v2[v3[1]] = true
                local r17 = function(...)
                    SceneManager.Instance():getMainCamera()
                    PlayerManager:getPlayers()
                    if not PlayerManager:getClientPlayer() then
                        r31 = {pairs(PlayerManager:getPlayers())}
                        v2[v3[2]]:GetScreenHeight()
                        if r31[3] then
                            v2[v3[3]][r13.userId] = true
                        end
                        r13 = {pairs(v2[v3[4]])}
                        if r13[3] then
                            if not v2[v3[3]][r13[3]] then
                                if (false and false) or (not false and true) then
                                    if r13[1] then
                                        v2[v3[5]]:destroyGUIWindow(r13[1])
                                    end
                                end
                                v2[v3[4]][r13[3]] = nil
                            end
                        end
                        r30 = {pairs(PlayerManager:getPlayers())}
                        if r30[3] then
                            if r13.userId ~= r24 then
                                if not v2[v3[4]][r13.userId] then
                                    v2[v3[4]][r13.userId] = r28
                                    if (false and false) or (not false and true) then
                                        v2[q()] = v2[v3[5]]:createGUIWindow(GUIType.StaticText, ("Skel_") .. r13.userId .. ("_") .. 1)
                                        local r34 = function(...)
                                            v2[v3[1]]:SetLevel(99)
                                            v2[v3[1]]:SetAlwaysOnTop(true)
                                        end
                                        pcall(r34)
                                        r34 = v2[q()]
                                        v2[v3[1]]:AddChildWindow(r34)
                                        r38 = v2[q()]
                                        v2[v3[4]][r13.userId][1] = r38
                                        I(q())
                                    end
                                    if r13.Player then
                                        if r13:isEntityAlive() then
                                            r20 = r5:getDirection().z
                                            r20 = r13.Player:getPosition(0) or nil
                                            if not r13:isEntityAlive() then
                                                if (false and false) or (not false and true) then
                                                    v2[v3[4]][r13.userId][1]:SetVisible(false)
                                                end
                                            end
                                            r4 = B:getPosition().x
                                            r42 = r13.Player:getYaw() or 0
                                            r47 = {x = r20.x, y = r20.y + 1.65, z = r20.z}
                                            r39 = {x = r20.x, y = r20.y + 0.7, z = r20.z}
                                            r14 = 0.35 * math.cos(math.rad(r42))
                                            r46 = r21.Player:getPosition(0).y
                                            r46 = 0.35 * math.sin(math.rad(r42))
                                            r48 = {x = r20.x - r14, y = r20.y + 1.3, z = r20.z - r46}
                                            r11 = 0.35 * math.cos(math.rad(r42))
                                            r49 = r21.Player:getPosition(0).y
                                            r49 = 0.35 * math.sin(math.rad(r42))
                                            r33 = {x = r20.x + r11, y = r20.y + 1.3, z = r20.z + r49}
                                            r36 = r21.Player:getPosition(0).x
                                            r36 = 0.35 * math.cos(math.rad(r42))
                                            r44 = r21.Player:getPosition(0).z
                                            r44 = 0.35 * math.sin(math.rad(r42))
                                            r7 = {x = r20.x - r36, y = r20.y + 0.6, z = r20.z - r44}
                                            r37 = r21.Player:getPosition(0).x
                                            r37 = 0.35 * math.cos(math.rad(r42))
                                            r53 = r21.Player:getPosition(0).z
                                            r53 = 0.35 * math.sin(math.rad(r42))
                                            r14 = {x = r20.x + r37, y = r20.y + 0.6, z = r20.z + r53}
                                            r46 = 0.15 * math.cos(math.rad(r42))
                                            r53 = 0.15 * math.sin(math.rad(r42))
                                            r11 = {x = r20.x - r46, y = r20.y, z = r20.z - r53}
                                            r49 = 0.15 * math.cos(math.rad(r42))
                                            r40 = 0.15 * math.sin(math.rad(r42))
                                            r36 = {x = r20.x + r49, y = r20.y, z = r20.z + r40}
                                            r45 = {r47, r39, r48, r33, r7, r14, r11, r36}
                                            if (false and false) or (not false and true) then
                                                r36 = Blockman.Instance():getScreenPos()
                                                if not r36 then
                                                    if false then
                                                        r33 = {1, 2}
                                                        r7 = {3, 4}
                                                        r14 = {3, 5}
                                                        r11 = {4, 6}
                                                        r36 = {2, 7}
                                                        r46 = {2, 8}
                                                        r48 = {r33, r7, r14, r11, r36, r46}
                                                        if (false and false) or (not false and true) then
                                                            v2[v3[6]](v2[v3[4]][r13.userId][1], r47[r48[1][1]], r47[r48[1][2]], v2[v3[3]](0.5), 2)
                                                        end
                                                    end
                                                    if (false and false) or (not false and true) then
                                                        v2[v3[4]][r13.userId][1]:SetVisible(false)
                                                    end
                                                end
                                                r44 = r36.x * v2[v3[2]]:GetScreenWidth()
                                                r40 = r36.y * v2[v3[2]]:GetScreenHeight()
                                                r46 = {x = r44, y = r40}
                                                r47[1] = r46
                                            end
                                        end
                                    end
                                    r34 = math.sqrt(r20.x - r4 ^ 2 + r20.y - r3 ^ 2 + r20.z - r10 ^ 2) > 500
                                end
                            end
                        end
                    end
                end
            end
            UIHelper.showToast("on")
            v2[v3[2]] = LuaTimer:scheduleTimer(r17, 16, -1)
            I(q())
            I(q())
            I(q())
            v6[27][v6[28]] = v6[25]
            Env.togImmortality = not togImmortality
            PlayerManager:getClientPlayer()
            r8 = PlayerManager:getClientPlayer():sendPacket()
            UIHelper.showToast("ON")
            UIHelper.showToast("OFF")
            Env["GMHelper"]["Immortality"] = function(...)
                v2[q()] = v1[2]
                v2[q()] = v1[3]
                v2[q()] = v1[4]
                local r10 = function(...)
                    if PlayerManager:getClientPlayer().Player then
                        if _G.PotionEffect.new(v2[v3[1]], v2[v3[2]], v2[v3[3]]) then
                            PlayerManager:getClientPlayer().Player:addPotionEffect(_G.PotionEffect.new(v2[v3[1]], v2[v3[2]], v2[v3[3]]))
                        end
                    end
                end
                r4 = PlayerManager:getClientPlayer().userId
                r4 = {pcall(r10)}
                I(q())
                if not r4[1] then
                    tostring(r4[2])
                    print(("Potion Error: ") .. r22)
                    I(q())
                    I(q())
                    I(q())
                end
            end
            Env["GMHelper"]["applyEffect"] = function(...)
                v1[1]:applyEffect(1, 6000, 0)
                I(q())
                I(q())
            end
            Env["GMHelper"]["move_speed"] = function(...)
                v1[1]:applyEffect(2, 6000, 0)
            end
            Env["GMHelper"]["move_slowdown"] = function(...)
                v1[1]:applyEffect(3, 6000, 0)
            end
            Env["GMHelper"]["dig_speed"] = function(...)
                v1[1]:applyEffect(4, 6000, 0)
            end
            Env["GMHelper"]["dig_slowdown"] = function(...)
                v1[1]:applyEffect(5, 6000, 0)
            end
            Env["GMHelper"]["damage_boost"] = function(...)
                v1[1]:applyEffect(6, 1, 0)
            end
            Env["GMHelper"]["instant_heal"] = function(...)
                v1[1]:applyEffect(7, 1, 0)
            end
            Env["GMHelper"]["instant_harm"] = function(...)
                v1[1]:applyEffect(8, 6000, 0)
            end
            Env["GMHelper"]["jump_boost"] = function(...)
                v1[1]:applyEffect(9, 6000, 0)
            end
            Env["GMHelper"]["confusion"] = function(...)
                v1[1]:applyEffect(10, 6000, 0)
            end
            Env["GMHelper"]["regeneration"] = function(...)
                v1[1]:applyEffect(11, 6000, 0)
            end
            Env["GMHelper"]["resistance"] = function(...)
                v1[1]:applyEffect(12, 6000, 0)
            end
            Env["GMHelper"]["fire_resistance"] = function(...)
                v1[1]:applyEffect(13, 6000, 0)
            end
            Env["GMHelper"]["water_breathing"] = function(...)
                v1[1]:applyEffect(14, 6000, 0)
            end
            Env["GMHelper"]["invisibility"] = function(...)
                v1[1]:applyEffect(15, 6000, 0)
                I(q())
                I(q())
            end
            Env["GMHelper"]["blindness"] = function(...)
                v1[1]:applyEffect(16, 6000, 0)
            end
            Env["GMHelper"]["night_vision"] = function(...)
                v1[1]:applyEffect(17, 6000, 0)
            end
            Env["GMHelper"]["hunger"] = function(...)
                v1[1]:applyEffect(18, 6000, 0)
            end
            Env["GMHelper"]["weakness"] = function(...)
                v1[1]:applyEffect(19, 6000, 0)
            end
            Env["GMHelper"]["poison"] = function(...)
                v1[1]:applyEffect(20, 6000, 0)
            end
            Env["GMHelper"]["wither"] = function(...)
                v1[1]:applyEffect(21, 6000, 0)
            end
            Env["GMHelper"]["health_boost"] = function(...)
                v1[1]:applyEffect(22, 6000, 0)
            end
            Env["GMHelper"]["absorption"] = function(...)
                v1[1]:applyEffect(23, 6000, 0)
            end
            Env["GMHelper"]["saturation"] = function(...)
                Env.togBypassDialog = not togBypassDialog
                if engineLoop then
                    Env.engineLoop = nil
                    v2[q()] = v2[v3[1]].sendShowDialogTip
                    if v2[v3[2]] then
                        v2[q()] = v2[v3[2]]
                        if CheatDetectMgr then
                            v2[q()] = CheatDetectMgr
                            local r4 = function(...)
                                local r4 = function(...)
                                    -- empty body
                                end
                                local r22 = function(...)
                                    -- empty body
                                end
                                local r17 = function(...)
                                    -- empty body
                                end
                                local r3 = function(...)
                                    -- empty body
                                end
                                v2[v3[1]].trigger = r4
                                v2[v3[1]].setCheated = r3
                                v2[v3[1]].incCheatTimes = r17
                                v2[v3[1]].ifGoIllegalPrison = r22
                                local r2 = function(...)
                                    r8 = {false}
                                end
                                v2[v3[1]].isCheating = function(...)
                                    r8 = {false}
                                end
                                v2[v3[1]].isCheated = r2
                                local r2 = function(...)
                                    -- empty body
                                end
                                v2[v3[2]].onTick = function(...)
                                    -- empty body
                                end
                                v2[v3[2]].init = r2
                                ClientHelper.putBoolPrefs("LockUIShowAndHide", false)
                                ClientHelper.putBoolPrefs("DisableMovement", false)
                                Blockman.Instance():getPlayer()
                                if r6 then
                                    r6:setCanUpdate(true)
                                    if PlayerManager:getClientPlayer() then
                                        if r8 then
                                            function PlayerManager:getClientPlayer().cheat.setCheated(...)
                                                -- empty body
                                            end
                                            v2[v3[4]].sendShowDialogTip = function(...)
                                                r5 = v1[4] == Lang:getString("cheat.detect.tip")
                                                if r5 then
                                                    v2[v3[1]](v1[1], v1[2], v1[3], v1[4])
                                                end
                                                tostring(v1[4])
                                                r3 = r3:lower():find()
                                            end
                                        end
                                    end
                                end
                            end
                            Env.engineLoop = LuaTimer:scheduleTimer(r4, 10, -1)
                            I(q())
                            I(q())
                            I(q())
                        end
                    end
                end
            end
            Env["GMHelper"]["BypassDialog"] = function(...)
                Env.togBedBreaker = not togBedBreaker
                if not togBedBreaker then
                    if beds then
                        Env.beds = nil
                    end
                end
                local r5 = function(...)
                    r6 = {v4(1, v5(v1))}
                    if not togBedBreaker then
                        if beds then
                            LuaTimer:cancel(beds)
                            Env.beds = nil
                        end
                    end
                    if not PlayerManager:getClientPlayer() then
                        r8 = PlayerManager:getClientPlayer().Player
                        r8 = {1, 2, 3, 4}
                        if (false and 1 >= #r10) or (not false and 1 <= #r10) then
                            r8 = r10[1] ~= r2:getTeamId()
                            if r8 then
                                if TeamConfig:getTeam(r10[1]) then
                                    r30 = (TeamConfig:getTeam(r10[1]) and 12742528) or 12155733
                                    if r13 then
                                        if r15[1] then
                                            if r8 then
                                                if (false and r12[1].y - 1 + 1 >= r12[1].y + 15) or (not false and r12[1].y - 1 + 1 <= r12[1].y + 15) then
                                                    r38 = {x = r12[1].x + 2, y = r12[1].y - 1 + 1, z = r12[1].z}
                                                    r45 = {x = r12[1].x + 2, y = r12[1].y - 1 + 1 + 1, z = r12[1].z}
                                                    EngineWorld:getBlockId(r45)
                                                    if r34 then
                                                        if r8 then
                                                            if r12[1].y - 1 + 1 == r12[1].y then
                                                                r20 = {team = r10[1], x = r12[1].x + 2, y = r12[1].y + 5 + 1.5, z = r12[1].z}
                                                                table.insert(r4, r20)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if #r4 > 0 then
                            v2[q()] = r2:getPosition()
                            local r18 = function(...)
                                r8 = EngineWorld:getBlockId(r12[1]) ~= BlockID.AIR
                                r8 = {MathUtil:distanceSquare3d(v2[v3[1]], v1[1]) < MathUtil:distanceSquare3d(v2[v3[1]], v1[2])}
                            end
                            table.sort(r4, r18)
                            r25 = {x = r4[1].x, y = r4[1].y, z = r4[1].z}
                            tport(r25)
                            I(q())
                        end
                        UIHelper.showToast("^FF0000All beds broken!")
                        if beds then
                            LuaTimer:cancel(beds)
                            Env.beds = nil
                            Env.togBedBreaker = false
                        end
                    end
                end
                Env.beds = LuaTimer:scheduleTimer(r5, 400, 9999999)
            end
            Env["GMHelper"]["BedBreaker"] = function(...)
                I(q())
                I(q())
                if io.open(v1[1], "wb") then
                    r2 = (io.open(v1[1], "wb") and 5179884) or 1167475
                    r4 = {pairs(v1[2])}
                    if r4[3] then
                        tostring(I(q()))
                        if type(I(q())) == "string" then
                            r25 = I(q()) .. "\""
                            table.insert(r2, ("\"") .. r4[3] .. ("\":") .. ("\"") .. r25)
                        end
                    end
                    r3 = table.concat(r2, ",") .. "}"
                    r5 = io.open(v1[1], "wb"):write()
                    r5 = io.open(v1[1], "wb"):close()
                end
            end
            io.open(v1[1], "rb"):read("*a")
            v2[q()] = D
            io.open(v1[1], "rb"):close()
            r2 = v2[q()]
            r5 = v2[q()]
            local r5 = function(...)
                v2[q()] = D
                v2[v3[1]]:gsub("\"([^\"]+)\":([^,}]+)", function(...) end)
                r8 = {v2[q()]}
            end
            r10 = PlayerManager:getClientPlayer().Player
            r10 = {pcall(r5)}
            r8 = {r10[2]}
            I(q())
            r8 = {3757348}
            v2[q()] = function(...)
                v2[q()] = function(...)
                    v2[v3[1]](v1[1].SavedSkinsPath)[v1[2]] = v1[3]
                    v2[v3[2]](v1[1].SavedSkinsPath, v2[v3[1]](v1[1].SavedSkinsPath))
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["SaveSkinValue"] = function(...)
                    v2[v3[1]](v1[1].SavedNamePath, {SavedCustomName = v1[1].SavedCustomName or "", SavedColor = v1[1].SavedColor or "", SavedVipTier = v1[1].SavedVipTier or 0, SavedVipText = v1[1].SavedVipText or "", SavedIsRainbow = (v1[1].SavedIsRainbow and true) or false})
                    I(q())
                end
                Env["GMHelper"]["SaveNameState"] = function(...)
                    if v2[v3[1]](v1[1].SavedNamePath).SavedCustomName then
                        if r2 ~= "" then
                            v1[1].SavedCustomName = r8
                            if v2[v3[1]](v1[1].SavedNamePath).SavedColor then
                                if r2 ~= "" then
                                    v1[1].SavedColor = r8
                                    if v2[v3[1]](v1[1].SavedNamePath).SavedVipTier then
                                        if r2 ~= 0 then
                                            v1[1].SavedVipTier = r8
                                            if v2[v3[1]](v1[1].SavedNamePath).SavedVipText then
                                                if r2 ~= "" then
                                                    v1[1].SavedVipText = r8
                                                    if r8 ~= nil then
                                                        v1[1].SavedIsRainbow = r8
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                Env["GMHelper"]["LoadNameState"] = function(...)
                    if v1[1].SavedCustomName then
                        if v1[1].SavedCustomName ~= "" then
                            r8 = v2[v3[1]](v1[1].SavedNamePath).SavedIsRainbow
                            r8 = {v1[1].SavedCustomName}
                        end
                        if PlayerManager:getClientPlayer() then
                            if r8 then
                                r2 = PlayerManager:getClientPlayer().Player:getEntityName()
                                r8 = PlayerManager:getClientPlayer().Player
                                r8 = {r2 or "Player"}
                            end
                            r8 = {"Player"}
                        end
                    end
                end
                Env["GMHelper"]["GetPlayerBaseName"] = function(...)
                    if not PlayerManager:getClientPlayer() then
                        r8 = {""}
                    end
                    PlayerManager:getClientPlayer():getTeamId()
                    r8 = CGame.Instance():getGameType()
                    if r8 ~= "g1014" then
                        if B == 1 then
                            r8 = {" \226\150\162FFFF0000[Red]"}
                        end
                    end
                end
                Env["GMHelper"]["GetTeamNameTag"] = function(...)
                    if PlayerManager:getClientPlayer() then
                        v1[1]:GetPlayerBaseName()
                        v1[1]:GetTeamNameTag()
                        r10 = {Red = "FF0000", Blue = "0000FF", Pink = "FF00FF", Cyan = "00FFFF", Green = "00FF00", Purple = "9600FF", Yellow = "FFFF00", Orange = "FFAF00", Gold = "FFD700", Black = "000000", White = "FFFFFF"}
                        if v1[1].SavedIsRainbow then
                            if v1[1].SavedVipTier then
                                if v1[1].SavedVipTier > 0 then
                                    if v1[1].SavedVipTier == 11 then
                                        r22 = PlayerManager:getClientPlayer().Player
                                        r2 = PlayerManager:getClientPlayer().Player
                                        r22:setShowName(("&$[ffca00ff-fbd33fff-cad2ceff-23b8feff-677dffff-ac61ffff-fd15ffff]$") .. r5 .. ("$&") .. ("[S=vip_nameplate_10_plus.json]") .. r2)
                                    end
                                end
                            end
                        end
                    end
                end
                Env["GMHelper"]["UpdateNameDisplay"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({""}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangePlayerName"] = function(...)
                    I(q())
                    if {Red = "FF0000", Blue = "0000FF", Pink = "FF00FF", Cyan = "00FFFF", Green = "00FF00", Purple = "9600FF", Yellow = "FFFF00", Orange = "FFAF00", Gold = "FFD700", Black = "000000", White = "FFFFFF"}[v1[2]] then
                        v1[1].SavedColor = v1[2]
                        v1[1].SavedIsRainbow = false
                        v1[1]:SaveNameState()
                        v1[1]:UpdateNameDisplay()
                        r4 = {Red = "FF0000", Blue = "0000FF", Pink = "FF00FF", Cyan = "00FFFF", Green = "00FF00", Purple = "9600FF", Yellow = "FFFF00", Orange = "FFAF00", Gold = "FFD700", Black = "000000", White = "FFFFFF"}[v1[2]]
                        UIHelper.showToast(("\226\150\162FF") .. r4 .. "Name Color Changed")
                    end
                end
                Env["GMHelper"]["SetNameColor"] = function(...)
                    v1[1].SavedIsRainbow = true
                    v1[1].SavedColor = nil
                    v1[1]:SaveNameState()
                    v1[1]:UpdateNameDisplay()
                    UIHelper.showToast("&$[ffca00ff-fbd33fff-cad2ceff-23b8feff-677dffff-ac61ffff-fd15ffff]$RainBow Name Activated$&")
                    I(q())
                end
                Env["GMHelper"]["RainBowName"] = function(...)
                    v2[q()] = v1[1]
                    v2[q()] = v1[2]
                    v2[q()] = v1[3]
                    v2[q()] = true
                    CustomDialog.builder()
                    CustomDialog.setTitleText("Terms and Conditions")
                    CustomDialog.setContentText("Please agree to the terms and conditions to continue.")
                    CustomDialog.setRightText("Agree")
                    CustomDialog.setLeftText("Cancel")
                    if GUIGMControlPanel then
                        if GUIGMControlPanel.hide then
                            GUIGMControlPanel:hide()
                            local r5 = function(...)
                                if v2[v3[1]] then
                                    if not PlayerManager:getClientPlayer() then
                                        v2[v3[2]].SavedVipTier = v2[v3[3]]
                                        v2[v3[2]].SavedVipText = v2[v3[4]]
                                        v2[v3[2]]:SaveNameState()
                                        v2[v3[2]]:UpdateNameDisplay()
                                        r4 = (" Successfully By: ") .. v2[v3[2]]:GetPlayerBaseName()
                                        UIHelper.showToast(("^FF00EE Vip") .. v2[v3[3]] .. r4)
                                        CustomDialog.builder()
                                        CustomDialog.setTitleText(("Vip") .. v2[v3[3]])
                                        CustomDialog.setContentText(("--> ^00FF00 Vip") .. v2[v3[3]] .. " NameColor ^FFFFFF<--")
                                        CustomDialog.setRightText("Done")
                                        CustomDialog.setRightClickListener(function(...) end)
                                        CustomDialog.show()
                                    end
                                end
                                UIHelper.showToast("Button is disabled.")
                            end
                            CustomDialog.setRightClickListener(r5)
                            local r5 = function(...)
                                if v2[v3[1]] then
                                    UIHelper.showToast("Operation Cancelled")
                                end
                                UIHelper.showToast("Button is disabled.")
                            end
                            CustomDialog.setLeftClickListener(r5)
                            CustomDialog.show()
                            I(q())
                            I(q())
                            I(q())
                            I(q())
                        end
                    end
                end
                Env["GMHelper"]["SetVipNicknameWithTerms"] = function(...)
                    if PlayerManager:getClientPlayer() then
                        if v2[v3[1]](v1[1].SavedSkinsPath).m_hairID then
                            r2 = PlayerManager:getClientPlayer().Player
                            r2.m_hairID = r8
                            if r8 then
                                r2.m_faceID = r10
                                if r10 then
                                    r2.m_topsID = r4
                                    if r4 then
                                        r2.m_pantsID = r3
                                        if r3 then
                                            r2.m_shoesID = r17
                                            if r17 then
                                                r2.m_glassesId = r22
                                                if r22 then
                                                    r2.m_scarfId = r18
                                                    if r18 then
                                                        r2.m_wingId = r25
                                                        if r25 then
                                                            r2.m_hatId = r21
                                                            if r21 then
                                                                r2.m_decorate_hatId = r27
                                                                if r27 then
                                                                    r2.m_tailId = r12
                                                                    if r12 then
                                                                        r2.m_bagId = r31
                                                                        if r31 then
                                                                            r2.m_crownId = r30
                                                                            if true then
                                                                                r2.m_outLooksChanged = true
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                Env["GMHelper"]["ApplySavedSkins"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeHair"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["ChangeFace"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeTops"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["ChangePants"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeShoes"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeGlasses"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["ChangeScarf"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeWing"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeHat"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeDecHat"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["ChangeTail"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({"number"}, function(...) end)
                    I(q())
                end
                Env["GMHelper"]["ChangeBagI"] = function(...)
                    v2[q()] = v1[1]
                    GMHelper:openInput({""}, function(...) end)
                    I(q())
                    I(q())
                end
                Env["GMHelper"]["ChangeCrown"] = function(...)
                    v2[q()] = v1[1]
                    r8 = v2[q()]:openInput()
                    I(q())
                end
                Env["GMHelper"]["ChangeSkinById"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 1)
                end
                Env["GMHelper"]["UpdatePlayerNickname"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 2)
                end
                Env["GMHelper"]["UpdatePlayerNickname2"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 3)
                end
                Env["GMHelper"]["UpdatePlayerNickname3"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 4)
                    I(q())
                end
                Env["GMHelper"]["UpdatePlayerNickname4"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 5)
                    I(q())
                end
                Env["GMHelper"]["UpdatePlayerNickname5"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 6)
                end
                Env["GMHelper"]["UpdatePlayerNickname6"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 7)
                    I(q())
                end
                Env["GMHelper"]["UpdatePlayerNickname7"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 8)
                end
                Env["GMHelper"]["UpdatePlayerNickname8"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 9)
                end
                Env["GMHelper"]["UpdatePlayerNickname9"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 10)
                end
                Env["GMHelper"]["UpdatePlayerNickname10"] = function(...)
                    v1[1]:SetVipNicknameWithTerms(v1[2], 11)
                    I(q())
                end
                Env["GMHelper"]["UpdatePlayerNickname11"] = function(...)
                    GMHelper:ApplySavedSkins()
                    GMHelper:UpdateNameDisplay()
                end
                Env.togGunAimBot = not togGunAimBot
                I(q())
                if togGunAimBot then
                    local r2 = function(...)
                        r6 = {v4(1, v5(v1))}
                        PlayerManager:getClientPlayer().Player:getTeamId()
                        PlayerManager:getClientPlayer().Player:getPosition()
                        r18 = v2[v3[1]](v1[1].SavedSkinsPath).m_wingId
                        r18 = {pairs(PlayerManager:getPlayers())}
                        if r18[3] then
                            if r21 then
                                r12 = v2[v3[1]](v1[1].SavedSkinsPath).m_bagId
                                r12 = r21 ~= PlayerManager:getClientPlayer()
                                if r27 then
                                    r21 = v2[v3[1]](v1[1].SavedSkinsPath).m_decorate_hatId
                                    r21:getTeamId()
                                    if r27 ~= r2 then
                                        r21:getPosition()
                                        if MathUtil:distanceSquare2d(r31, r5) < 999999999 then
                                            MathUtil:distanceSquare2d(r31, r5)
                                        end
                                    end
                                end
                            end
                        end
                        if true then
                            entity((_nil_).entityId)
                        end
                    end
                    Env.closestEnemyTimer = LuaTimer:scheduleTimer(r2, 500, -1)
                end
            end
            Env["GMHelper"]["GunAimBot"] = function(...)
                Env.togSpamChat = not togSpamChat
                if togSpamChat then
                    v1[1]:openInput({""}, function(...) end)
                end
            end
            Env["GMHelper"]["SpamChat"] = function(...)
                ChangeSkin(3000, "custom_wing")
            end
            Env["GMHelper"]["ParachuteWing"] = function(...)
            end
        end
    end
end
if r49[r53] == true then
    GMSetting:addTab("Sky Block")
    GMSetting:addItem("Sky Block", "Aim Bot", "AimBot")
    GMSetting:addItem("Sky Block", "Anti Void", "AntiVoid")
    GMSetting:addItem("Sky Block", "Auto Click", "AutoClick")
    GMSetting:addItem("Sky Block", "Auto Fishing", "AutoFish")
    GMSetting:addItem("Sky Block", "Auto Knock Back", "AutoKnockBack")
    GMSetting:addItem("Sky Block", "Auto Mob Killer", "AutoGayMobKiller")
    GMSetting:addItem("Sky Block", "Auto Submit Item", "AutoSubmitItem")
    GMSetting:addItem("Sky Block", "Ban Click CD", "BanClickCD")
    GMSetting:addItem("Sky Block", "Drop Speed", "DropSpeed")
    GMSetting:addItem("Sky Block", "Fast Break v2", "FastBreakSB")
    GMSetting:addItem("Sky Block", "Fast Jump", "FastJump")
    GMSetting:addItem("Sky Block", "Fly", "sooooooSB")
    GMSetting:addItem("Sky Block", "Free Camera", "FreeCamera")
    GMSetting:addItem("Sky Block", "High Jump", "HighJump")
    GMSetting:addItem("Sky Block", "Hit Box", "HitBox")
    GMSetting:addItem("Sky Block", "Hit Box Mob", "HitBoxMob")
    GMSetting:addItem("Sky Block", "Hit Box v2", "HitBoxV2")
    GMSetting:addItem("Sky Block", "Immortality", "Immortality")
    GMSetting:addItem("Sky Block", "Infinity Kill Aura Mob", "InfKillAuraMob")
    GMSetting:addItem("Sky Block", "Infinity Reach Players", "ReachPlayersSB")
    GMSetting:addItem("Sky Block", "Kill Aura", "KillAura")
    GMSetting:addItem("Sky Block", "Kill Aura Mob", "KillAuraMob")
    GMSetting:addItem("Sky Block", "No Clip", "DevNoClip")
    GMSetting:addItem("Sky Block", "No Fall", "NoFall")
    GMSetting:addItem("Sky Block", "No Fall Damage", "NoFallDmg")
    GMSetting:addItem("Sky Block", "Reach", "Reach")
    GMSetting:addItem("Sky Block", "Speed", "Speed")
    GMSetting:addItem("Sky Block", "Teleport Click", "TeleportClick")
    GMSetting:addItem("Sky Block", "Unlimited Jump", "Aeeeeee")
end
if r44[r53] == true then
    GMSetting:addTab("Egg War")
    GMSetting:addItem("Egg War", "Aim Bot", "AimBot")
    GMSetting:addItem("Egg War", "Aim Bow", "AimBow")
    GMSetting:addItem("Egg War", "Anti Kill Aura", "AntiKillAura")
    GMSetting:addItem("Egg War", "Anti Void", "AntiVoid")
    GMSetting:addItem("Egg War", "Attack Button", "AtkBtn")
    GMSetting:addItem("Egg War", "Auto Click", "AutoClick")
    GMSetting:addItem("Egg War", "Auto Knock Back", "AutoKnockBack")
    GMSetting:addItem("Egg War", "Ban Click CD", "BanClickCD")
    GMSetting:addItem("Egg War", "Blink", "Blink")
    GMSetting:addItem("Egg War", "Egg Breaker", "EggBreaker")
    GMSetting:addItem("Egg War", "Fast Break", "FastBreak")
    GMSetting:addItem("Egg War", "Fast Jump", "FastJump")
    GMSetting:addItem("Egg War", "Fly", "soooooo")
    GMSetting:addItem("Egg War", "Fly Parachute", "FlyParachute")
    GMSetting:addItem("Egg War", "Free Camera", "FreeCamera")
    GMSetting:addItem("Egg War", "High Jump", "HighJump")
    GMSetting:addItem("Egg War", "Hit Box", "HitBox")
    GMSetting:addItem("Egg War", "Hit Box v2", "HitBoxV2")
    GMSetting:addItem("Egg War", "Infinity Hit Box", "HitBoxV3")
    GMSetting:addItem("Egg War", "Infinity Kill Aura", "InfinityKillAura")
    GMSetting:addItem("Egg War", "Infinity Reach Players", "ReachPlayers")
    GMSetting:addItem("Egg War", "Kill Aura", "KillAura")
    GMSetting:addItem("Egg War", "Respawn", "RespawnV2")
    GMSetting:addItem("Egg War", "Respawn In Same Place", "RespawnInSamePlace")
    GMSetting:addItem("Egg War", "Speed", "Speed")
    GMSetting:addItem("Egg War", "Teleport Click", "TeleportClick")
    GMSetting:addItem("Egg War", "Teleport Killer", "TeleportKiller")
    GMSetting:addItem("Egg War", "Unlimited Jump", "Aeeeeee")
end
if r53 == "g1014" then
    GMSetting:addTab("Jail Break")
    GMSetting:addItem("Jail Break", "Aim Bot", "AimBot")
    GMSetting:addItem("Jail Break", "Anti KillAura", "AntiKillAura")
    GMSetting:addItem("Jail Break", "Anti Void", "AntiVoid")
    GMSetting:addItem("Jail Break", "Attack Button", "AtkBtn")
    GMSetting:addItem("Jail Break", "Auto Click", "AutoClick")
    GMSetting:addItem("Jail Break", "Auto Respawn", "AutoRespawn")
    GMSetting:addItem("Jail Break", "Ban Click CD", "BanClickCD")
    GMSetting:addItem("Jail Break", "Break Block", "BreakBlock")
    GMSetting:addItem("Jail Break", "Destroyed Block", "DestroyBlock")
    GMSetting:addItem("Jail Break", "Cannon Button", "CannonBtnBedWar")
    GMSetting:addItem("Jail Break", "Fast Jump", "FastJump")
    GMSetting:addItem("Jail Break", "Fly", "soooooo")
    GMSetting:addItem("Jail Break", "Free Camera", "FreeCamera")
    GMSetting:addItem("Jail Break", "Trigger Gun Bot", "GunAimBot")
    GMSetting:addItem("Jail Break", "High Jump", "HighJump")
    GMSetting:addItem("Jail Break", "Hit Box", "HitBox")
    GMSetting:addItem("Jail Break", "Hit Box v2", "HitBoxV2")
    GMSetting:addItem("Jail Break", "Kill Aura", "KillAura")
    GMSetting:addItem("Jail Break", "No Clip", "NoClip")
    GMSetting:addItem("Jail Break", "No Fall", "NoFall")
    GMSetting:addItem("Jail Break", "No Fall Damage", "NoFallDmg")
    GMSetting:addItem("Jail Break", "Respawn In Same Place", "RespawnInSamePlace")
    GMSetting:addItem("Jail Break", "Speed", "Speed")
    GMSetting:addItem("Jail Break", "Teleport Click", "TeleportClick")
    GMSetting:addItem("Jail Break", "Teleport Killer", "TeleportKiller")
    GMSetting:addItem("Jail Break", "Unlimited Jump", "Aeeeeee")
end
GMSetting:addTab("Hack")
GMSetting:addItem("Hack", "Aim Bot", "AimBot")
GMSetting:addItem("Hack", "Aim Bow", "AimBow")
GMSetting:addItem("Hack", "Anti Kill Aura", "AntiKillAura")
GMSetting:addItem("Hack", "Anti Void", "AntiVoid")
GMSetting:addItem("Hack", "Attack Button", "AtkBtn")
GMSetting:addItem("Hack", "Auto Click", "AutoClick")
GMSetting:addItem("Hack", "Auto Knock Back", "AutoKnockBack")
GMSetting:addItem("Hack", "Auto Respawn", "AutoRespawn")
GMSetting:addItem("Hack", "Ban Click CD", "BanClickCD")
GMSetting:addItem("Hack", "Blink", "Blink")
GMSetting:addItem("Hack", "Break Block", "BreakBlock")
GMSetting:addItem("Hack", "Cannon Button", "CannonBtn")
GMSetting:addItem("Hack", "Drop Speed", "DropSpeed")
GMSetting:addItem("Hack", "Destroyed Block", "DestroyBlock")
GMSetting:addItem("Hack", "Fast Break", "FastBreak")
GMSetting:addItem("Hack", "Fast Jump", "FastJump")
GMSetting:addItem("Hack", "Fly", "soooooo")
GMSetting:addItem("Hack", "Fly Parachute", "FlyParachute")
GMSetting:addItem("Hack", "Free Camera", "FreeCamera")
GMSetting:addItem("Hack", "High Jump", "HighJump")
GMSetting:addItem("Hack", "Hit Box", "HitBox")
GMSetting:addItem("Hack", "Hit Box v2", "HitBoxV2")
GMSetting:addItem("Hack", "Infinity Hit Box", "HitBoxV3")
GMSetting:addItem("Hack", "Infinity Kill Aura", "InfinityKillAura")
GMSetting:addItem("Hack", "Infinity Reach Players", "ReachPlayers")
GMSetting:addItem("Hack", "Kill Aura", "KillAura")
GMSetting:addItem("Hack", "Long Jump", "LongJump")
GMSetting:addItem("Hack", "No Clip", "DevNoClip")
GMSetting:addItem("Hack", "No Fall", "NoFall")
GMSetting:addItem("Hack", "No Fall Damage", "NoFallDmg")
GMSetting:addItem("Hack", "Raket Button", "RaketButton")
GMSetting:addItem("Hack", "Reach", "Reach")
GMSetting:addItem("Hack", "Respawn", "RespawnV2")
GMSetting:addItem("Hack", "Respawn In Same Place", "RespawnInSamePlace")
GMSetting:addItem("Hack", "Speed", "Speed")
GMSetting:addItem("Hack", "Teleport Click", "TeleportClick")
GMSetting:addItem("Hack", "Teleport Killer", "TeleportKiller")
GMSetting:addItem("Hack", "Unlimited Jump", "Aeeeeee")

GMHelper.extraTimers = GMHelper.extraTimers or {}
GMHelper.extraToggles = GMHelper.extraToggles or {}
GMHelper.extraHudLabels = GMHelper.extraHudLabels or {}
GMHelper.extraSessionStart = GMHelper.extraSessionStart or os.time()

function GMHelper:startExtraTimer(name, callback, interval)
    self:stopExtraTimer(name)
    self.extraTimers[name] = LuaTimer:scheduleTimer(callback, interval, -1)
end

function GMHelper:stopExtraTimer(name)
    if self.extraTimers[name] then
        LuaTimer:cancel(self.extraTimers[name])
        self.extraTimers[name] = nil
    end
end

function GMHelper:flipExtraToggle(name)
    local state = not self.extraToggles[name]
    self.extraToggles[name] = state
    _G["tog" .. name] = state
    return state
end

function GMHelper:getExtraClient()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer and clientPlayer.Player then
        return clientPlayer, clientPlayer.Player
    end
    return nil, nil
end

function GMHelper:getExtraPlayerName(playerWrapper)
    if playerWrapper.name then
        return tostring(playerWrapper.name)
    end
    if playerWrapper.getName then
        local success, result = pcall(playerWrapper.getName, playerWrapper)
        if success and result then
            return tostring(result)
        end
    end
    return tostring(playerWrapper.userId)
end

function GMHelper:getExtraTeamId(playerWrapper)
    if playerWrapper.getTeamId then
        local success, result = pcall(playerWrapper.getTeamId, playerWrapper)
        if success then
            return result
        end
    end
    if playerWrapper.Player and playerWrapper.Player.getTeamId then
        local success, result = pcall(playerWrapper.Player.getTeamId, playerWrapper.Player)
        if success then
            return result
        end
    end
    return -1
end

function GMHelper:getExtraWritablePath(fileName)
    local success, path = pcall(function()
        return Root.Instance():getWriteablePath()
    end)
    if success and path then
        return path .. fileName
    end
    return nil
end

function GMHelper:findExtraNearestPlayer(enemiesOnly)
    local clientPlayer, entity = self:getExtraClient()
    if not entity then
        return nil, nil
    end
    local myPosition = entity:getPosition()
    local myTeamId = self:getExtraTeamId(clientPlayer)
    local nearestPlayer = nil
    local nearestDistance = math.huge
    for _, playerWrapper in pairs(PlayerManager:getPlayers()) do
        if playerWrapper ~= clientPlayer and playerWrapper.Player then
            local isValid = true
            if enemiesOnly and myTeamId ~= -1 and self:getExtraTeamId(playerWrapper) == myTeamId then
                isValid = false
            end
            if isValid then
                local position = playerWrapper.Player:getPosition()
                local deltaX = position.x - myPosition.x
                local deltaY = position.y - myPosition.y
                local deltaZ = position.z - myPosition.z
                local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = playerWrapper
                end
            end
        end
    end
    return nearestPlayer, nearestDistance
end

function GMHelper:teleportExtra(x, y, z)
    local _, entity = self:getExtraClient()
    if not entity then
        UIHelper.showToast("^FF0000Player not found")
        return false
    end
    entity:setPosition(VectorUtil.newVector3(x, y, z))
    return true
end

function GMHelper:MoveRelative(forwardDistance, sideDistance, upDistance)
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    local position = entity:getPosition()
    local forwardYaw = math.rad(entity:getYaw())
    local sideYaw = math.rad(entity:getYaw() + 90)
    local newX = position.x - math.sin(forwardYaw) * (forwardDistance or 0) - math.sin(sideYaw) * (sideDistance or 0)
    local newZ = position.z + math.cos(forwardYaw) * (forwardDistance or 0) + math.cos(sideYaw) * (sideDistance or 0)
    local newY = position.y + (upDistance or 0)
    entity:setPosition(VectorUtil.newVector3(newX, newY, newZ))
    SoundUtil.playSound("random.orb", 1.0)
end

function GMHelper:TeleportToCoordinates()
    self:openInput({"X Y Z"}, function(text)
        local values = {}
        for number in string.gmatch(tostring(text), "[%-%d%.]+") do
            table.insert(values, tonumber(number))
        end
        if #values < 3 or not values[1] or not values[2] or not values[3] then
            UIHelper.showToast("^FF0000Format: X Y Z")
            return
        end
        if self:teleportExtra(values[1], values[2], values[3]) then
            UIHelper.showToast(string.format("^00FF00Teleported to %.1f %.1f %.1f", values[1], values[2], values[3]))
        end
    end)
end

function GMHelper:TeleportToPlayerName()
    self:openInput({"Player Name"}, function(text)
        local search = string.lower(tostring(text or ""))
        if search == "" then
            UIHelper.showToast("^FF0000Enter a name")
            return
        end
        local clientPlayer = self:getExtraClient()
        for _, playerWrapper in pairs(PlayerManager:getPlayers()) do
            if playerWrapper ~= clientPlayer and playerWrapper.Player then
                local name = self:getExtraPlayerName(playerWrapper)
                if string.find(string.lower(name), search, 1, true) then
                    local position = playerWrapper.Player:getPosition()
                    if self:teleportExtra(position.x, position.y + 2, position.z) then
                        UIHelper.showToast("^00FF00Teleported to " .. name)
                    end
                    return
                end
            end
        end
        UIHelper.showToast("^FF0000No player matches: " .. tostring(text))
    end)
end

function GMHelper:TeleportToRandomPlayer()
    local clientPlayer = self:getExtraClient()
    local candidates = {}
    for _, playerWrapper in pairs(PlayerManager:getPlayers()) do
        if playerWrapper ~= clientPlayer and playerWrapper.Player then
            table.insert(candidates, playerWrapper)
        end
    end
    if #candidates == 0 then
        UIHelper.showToast("^FF0000No other players found")
        return
    end
    local target = candidates[math.random(1, #candidates)]
    local position = target.Player:getPosition()
    if self:teleportExtra(position.x, position.y + 2, position.z) then
        UIHelper.showToast("^00FF00Teleported to " .. self:getExtraPlayerName(target))
    end
end

function GMHelper:TeleportNearestLoop()
    if self:flipExtraToggle("TeleportNearestLoop") then
        UIHelper.showToast("^00FF00Teleport Nearest Loop Enabled")
        self:startExtraTimer("TeleportNearestLoop", function()
            local target = self:findExtraNearestPlayer(true)
            if target then
                local position = target.Player:getPosition()
                self:teleportExtra(position.x, position.y + 2, position.z)
            end
        end, 200)
    else
        self:stopExtraTimer("TeleportNearestLoop")
        UIHelper.showToast("^FF0000Teleport Nearest Loop Disabled")
    end
end

function GMHelper:CopyCoordinates()
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    local position = entity:getPosition()
    local text = string.format("%.2f %.2f %.2f", position.x, position.y, position.z)
    ClientHelper.onSetClipboard(text)
    UIHelper.showToast("^00FF00Copied: " .. text)
end

function GMHelper:loadWaypoints()
    self.waypoints = {}
    local path = self:getExtraWritablePath("panel_waypoints.txt")
    if not path then
        return
    end
    local file = io.open(path, "r")
    if not file then
        return
    end
    for line in file:lines() do
        local slot, x, y, z = string.match(line, "^(%d+),([%-%d%.]+),([%-%d%.]+),([%-%d%.]+)")
        if slot then
            self.waypoints[tonumber(slot)] = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}
        end
    end
    file:close()
end

function GMHelper:saveWaypoints()
    local path = self:getExtraWritablePath("panel_waypoints.txt")
    if not path then
        return
    end
    local file = io.open(path, "w")
    if not file then
        return
    end
    for slot = 1, 5 do
        local waypoint = self.waypoints[slot]
        if waypoint then
            file:write(string.format("%d,%.3f,%.3f,%.3f\n", slot, waypoint.x, waypoint.y, waypoint.z))
        end
    end
    file:close()
end

function GMHelper:SetWaypoint(slot)
    if not self.waypoints then
        self:loadWaypoints()
    end
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    local position = entity:getPosition()
    self.waypoints[slot] = {x = position.x, y = position.y, z = position.z}
    self:saveWaypoints()
    UIHelper.showToast(string.format("^00FF00Waypoint %d saved (%.0f %.0f %.0f)", slot, position.x, position.y, position.z))
    SoundUtil.playSound("random.orb", 1.0)
end

function GMHelper:GoWaypoint(slot)
    if not self.waypoints then
        self:loadWaypoints()
    end
    local waypoint = self.waypoints[slot]
    if not waypoint then
        UIHelper.showToast("^FF0000Waypoint " .. tostring(slot) .. " is empty")
        return
    end
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    entity.noClip = true
    entity:setPosition(VectorUtil.newVector3(waypoint.x, waypoint.y, waypoint.z))
    entity:moveEntity(VectorUtil.newVector3(0, 1, 0))
    entity.noClip = false
    UIHelper.showToast("^00FF00Teleported to waypoint " .. tostring(slot))
    SoundUtil.playSound("random.orb", 1.0)
end

function GMHelper:ClearWaypoints()
    self.waypoints = {}
    self:saveWaypoints()
    UIHelper.showToast("^FF0000All waypoints cleared")
end

GMHelper.outfitFields = {
    "m_hairID", "m_faceID", "m_topsID", "m_pantsID", "m_shoesID", "m_glassesId",
    "m_scarfId", "m_wingId", "m_hatId", "m_tailId", "m_crownId", "m_bagId"
}

function GMHelper:rememberOriginalOutfit(entity)
    if self.originalOutfit then
        return
    end
    self.originalOutfit = {}
    for _, field in ipairs(self.outfitFields) do
        self.originalOutfit[field] = entity[field] or 0
    end
end

function GMHelper:OutfitIdStep(field, step)
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    self:rememberOriginalOutfit(entity)
    entity[field] = (entity[field] or 0) + step
    entity.m_outLooksChanged = true
    UIHelper.showToast(field .. " = " .. tostring(entity[field]))
end

function GMHelper:OutfitIdSet(field)
    self:openInput({"Enter ID"}, function(text)
        local value = tonumber(text)
        if not value then
            UIHelper.showToast("^FF0000Invalid ID")
            return
        end
        local _, entity = self:getExtraClient()
        if not entity then
            return
        end
        self:rememberOriginalOutfit(entity)
        entity[field] = value
        entity.m_outLooksChanged = true
        UIHelper.showToast(field .. " = " .. tostring(value))
    end)
end

function GMHelper:RandomOutfit()
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    self:rememberOriginalOutfit(entity)
    for _, field in ipairs(self.outfitFields) do
        if field ~= "m_bagId" then
            entity[field] = math.random(0, 30)
        end
    end
    entity.m_outLooksChanged = true
    UIHelper.showToast("^00FF00Random outfit applied")
end

function GMHelper:SaveOutfit()
    local _, entity = self:getExtraClient()
    local path = self:getExtraWritablePath("panel_outfit.txt")
    if not entity or not path then
        return
    end
    local file = io.open(path, "w")
    if not file then
        UIHelper.showToast("^FF0000Could not save outfit")
        return
    end
    for _, field in ipairs(self.outfitFields) do
        file:write(field .. "=" .. tostring(entity[field] or 0) .. "\n")
    end
    file:close()
    UIHelper.showToast("^00FF00Outfit saved")
end

function GMHelper:LoadOutfit()
    local _, entity = self:getExtraClient()
    local path = self:getExtraWritablePath("panel_outfit.txt")
    if not entity or not path then
        return
    end
    local file = io.open(path, "r")
    if not file then
        UIHelper.showToast("^FF0000No saved outfit")
        return
    end
    self:rememberOriginalOutfit(entity)
    for line in file:lines() do
        local field, value = string.match(line, "^([%w_]+)=(%-?%d+)")
        if field and value then
            entity[field] = tonumber(value)
        end
    end
    file:close()
    entity.m_outLooksChanged = true
    UIHelper.showToast("^00FF00Outfit loaded")
end

function GMHelper:ResetOutfit()
    local _, entity = self:getExtraClient()
    if not entity or not self.originalOutfit then
        UIHelper.showToast("^FF0000Nothing to reset")
        return
    end
    for field, value in pairs(self.originalOutfit) do
        entity[field] = value
    end
    entity.m_outLooksChanged = true
    UIHelper.showToast("^00FF00Original outfit restored")
end

function GMHelper:SetSky(skyName)
    HostApi.setSky(skyName)
    UIHelper.showToast("^00FF00Sky: " .. tostring(skyName))
end

function GMHelper:applyExtraFov(value)
    Blockman.Instance().m_gameSettings:setFovSetting(value)
end

function GMHelper:WideFov()
    if self:flipExtraToggle("WideFov") then
        self.extraToggles.ZoomFov = false
        _G["togZoomFov"] = false
        self:applyExtraFov(3)
        UIHelper.showToast("^00FF00Wide FOV")
    else
        self:applyExtraFov(0.8)
        UIHelper.showToast("^FF0000FOV Reset")
    end
end

function GMHelper:ZoomFov()
    if self:flipExtraToggle("ZoomFov") then
        self.extraToggles.WideFov = false
        _G["togWideFov"] = false
        self:applyExtraFov(0.25)
        UIHelper.showToast("^00FF00Zoom On")
    else
        self:applyExtraFov(0.8)
        UIHelper.showToast("^FF0000Zoom Off")
    end
end

function GMHelper:CustomFov()
    self:openInput({"FOV Value (default 0.8)"}, function(text)
        local value = tonumber(text)
        if not value then
            UIHelper.showToast("^FF0000Invalid number")
            return
        end
        self:applyExtraFov(value)
        UIHelper.showToast("^00FF00FOV: " .. tostring(value))
    end)
end

function GMHelper:SeparateCamera()
    if self:flipExtraToggle("SeparateCamera") then
        ClientHelper.putBoolPrefs("IsSeparateCamera", true)
        UIHelper.showToast("^00FF00Separate Camera Enabled")
    else
        ClientHelper.putBoolPrefs("IsSeparateCamera", false)
        UIHelper.showToast("^FF0000Separate Camera Disabled")
    end
end

function GMHelper:SpinBot()
    if self:flipExtraToggle("SpinBot") then
        UIHelper.showToast("^00FF00Spin Enabled")
        self.spinAngle = 0
        self:startExtraTimer("SpinBot", function()
            local _, entity = self:getExtraClient()
            if not entity then
                return
            end
            local pitch = entity.rotationPitch
            self.spinAngle = (self.spinAngle + 45) % 360
            entity.rotationYaw = self.spinAngle
            entity.rotationPitch = pitch
        end, 15)
    else
        self:stopExtraTimer("SpinBot")
        UIHelper.showToast("^FF0000Spin Disabled")
    end
end

function GMHelper:WatchMode()
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    if self:flipExtraToggle("WatchMode") then
        entity:setAllowFlying(true)
        entity:setFlying(true)
        entity:setWatchMode(true)
        entity:moveEntity(VectorUtil.newVector3(0, 1.35, 0))
        UIHelper.showToast("^00FF00Watch Mode Enabled")
    else
        entity:setAllowFlying(false)
        entity:setFlying(false)
        entity:setWatchMode(false)
        UIHelper.showToast("^FF0000Watch Mode Disabled")
    end
end

function GMHelper:DebugInfo()
    local state = self:flipExtraToggle("DebugInfo")
    CGame.Instance():toggleDebugMessageShown(state)
    if state then
        UIHelper.showToast("^00FF00Debug Shown")
    else
        UIHelper.showToast("^FF0000Debug Hidden")
    end
end

function GMHelper:PlayAnimation(animationName)
    ClientHelper.putStringPrefs("RunSkillName", animationName)
    UIHelper.showToast("^00FF00Animation: " .. tostring(animationName))
end

function GMHelper:CustomAnimation()
    self:openInput({"Animation Name"}, function(text)
        if text and text ~= "" then
            self:PlayAnimation(text)
        end
    end)
end

function GMHelper:ResetAnimation()
    ClientHelper.putStringPrefs("RunSkillName", "run")
    UIHelper.showToast("^00FF00Animation Reset")
end

function GMHelper:getExtraHudLabel(name, yOffset)
    local label = self.extraHudLabels[name]
    if label then
        return label
    end
    label = GUIManager:createGUIWindow(GUIType.StaticText, "ExtraHud_" .. name)
    label:SetWidth({0, 340})
    label:SetHeight({0, 28})
    label:SetXPosition({0, 10})
    label:SetYPosition({0, yOffset})
    label:SetTextHorzAlign(HorizontalAlignment.Left)
    label:SetTextVertAlign(HorizontalAlignment.Center)
    label:SetTextScale(1)
    label:SetTextBoader(Color.BLACK)
    label:SetBackgroundColor({0, 0, 0, 0.45})
    label:SetTouchable(false)
    label:SetLevel(2)
    GUISystem.Instance():GetRootWindow():AddChildWindow(label)
    self.extraHudLabels[name] = label
    return label
end

function GMHelper:toggleExtraHud(name, yOffset, interval, textProvider)
    if self:flipExtraToggle(name) then
        local label = self:getExtraHudLabel(name, yOffset)
        label:SetVisible(true)
        self:startExtraTimer(name, function()
            local success, text = pcall(textProvider)
            if success and text then
                label:SetText(text)
            end
        end, interval)
        UIHelper.showToast("^00FF00" .. name .. " Enabled")
    else
        self:stopExtraTimer(name)
        if self.extraHudLabels[name] then
            self.extraHudLabels[name]:SetVisible(false)
        end
        UIHelper.showToast("^FF0000" .. name .. " Disabled")
    end
end

function GMHelper:getCompassDirection(yaw)
    local directions = {"S", "SW", "W", "NW", "N", "NE", "E", "SE"}
    local normalized = (yaw % 360 + 360) % 360
    local index = math.floor((normalized + 22.5) / 45) % 8 + 1
    return directions[index]
end

function GMHelper:CoordinatesHud()
    self:toggleExtraHud("CoordinatesHud", 120, 200, function()
        local _, entity = self:getExtraClient()
        if not entity then
            return "^FF0000No player"
        end
        local position = entity:getPosition()
        return string.format("^00FFDDXYZ ^FFFFFF%.1f  %.1f  %.1f  ^FFD700%s", position.x, position.y, position.z, self:getCompassDirection(entity:getYaw()))
    end)
end

function GMHelper:NearestEnemyHud()
    self:toggleExtraHud("NearestEnemyHud", 152, 300, function()
        local target, distance = self:findExtraNearestPlayer(true)
        if not target then
            return "^00FF00No enemy nearby"
        end
        local health = "?"
        if target.getHealth then
            local success, value = pcall(target.getHealth, target)
            if success and value then
                health = tostring(math.floor(value))
            end
        end
        local color = "^00FF00"
        if distance < 8 then
            color = "^FF0000"
        elseif distance < 20 then
            color = "^FFFF00"
        end
        return string.format("%s%s ^FFFFFF%.1fm  ^FF5555HP %s", color, self:getExtraPlayerName(target), distance, health)
    end)
end

function GMHelper:SessionClockHud()
    self:toggleExtraHud("SessionClockHud", 184, 1000, function()
        local elapsed = os.time() - self.extraSessionStart
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60
        return string.format("^FFD700%s  ^FFFFFFSession %02d:%02d:%02d", os.date("%H:%M"), hours, minutes, seconds)
    end)
end

function GMHelper:ShowGameType()
    UIHelper.showToast("^00FFDDGame Type: " .. tostring(CGame.Instance():getGameType()))
end

function GMHelper:ShowRegion()
    local success, region = pcall(function()
        return Game:getRegionId()
    end)
    UIHelper.showToast("^00FFDDRegion: " .. tostring(success and region or "unknown"))
end

function GMHelper:ShowPlayerCount()
    local clientPlayer = self:getExtraClient()
    local myTeamId = clientPlayer and self:getExtraTeamId(clientPlayer) or -1
    local total = 0
    local teammates = 0
    for _, playerWrapper in pairs(PlayerManager:getPlayers()) do
        if playerWrapper.Player then
            total = total + 1
            if playerWrapper ~= clientPlayer and myTeamId ~= -1 and self:getExtraTeamId(playerWrapper) == myTeamId then
                teammates = teammates + 1
            end
        end
    end
    UIHelper.showToast(string.format("^00FFDDPlayers: %d  ^00FF00Team: %d  ^FF0000Enemies: %d", total, teammates, math.max(total - teammates - 1, 0)))
end

function GMHelper:CopyPlayerList()
    local lines = {}
    for _, playerWrapper in pairs(PlayerManager:getPlayers()) do
        if playerWrapper.Player then
            local health = "?"
            if playerWrapper.getHealth then
                local success, value = pcall(playerWrapper.getHealth, playerWrapper)
                if success and value then
                    health = tostring(math.floor(value))
                end
            end
            table.insert(lines, string.format("%s | ID: %s | Team: %s | HP: %s", self:getExtraPlayerName(playerWrapper), tostring(playerWrapper.userId), tostring(self:getExtraTeamId(playerWrapper)), health))
        end
    end
    ClientHelper.onSetClipboard(table.concat(lines, "\n"))
    UIHelper.showToast("^00FF00Copied " .. tostring(#lines) .. " players")
end

function GMHelper:ShowNearestPlayer()
    local target, distance = self:findExtraNearestPlayer(false)
    if not target then
        UIHelper.showToast("^FF0000No players nearby")
        return
    end
    UIHelper.showToast(string.format("^00FFDD%s ^FFFFFF%.1fm away", self:getExtraPlayerName(target), distance))
end

function GMHelper:CopyClientInfo()
    ClientHelper.onSetClipboard(tostring(HostApi.getClientInfo()))
    UIHelper.showToast("^00FF00Client info copied")
end

function GMHelper:CopyClientLog()
    local path = self:getExtraWritablePath("client.log")
    local file = path and io.open(path, "r")
    if not file then
        UIHelper.showToast("^FF0000Log not found")
        return
    end
    local content = file:read("*a")
    file:close()
    ClientHelper.onSetClipboard(content or "")
    UIHelper.showToast("^00FF00Client log copied")
end

function GMHelper:AntiAfk()
    if self:flipExtraToggle("AntiAfk") then
        UIHelper.showToast("^00FF00Anti AFK Enabled")
        self.antiAfkDirection = 1
        self:startExtraTimer("AntiAfk", function()
            local _, entity = self:getExtraClient()
            if not entity then
                return
            end
            entity.rotationYaw = entity.rotationYaw + 15 * self.antiAfkDirection
            self.antiAfkDirection = -self.antiAfkDirection
        end, 30000)
    else
        self:stopExtraTimer("AntiAfk")
        UIHelper.showToast("^FF0000Anti AFK Disabled")
    end
end

function GMHelper:WingFly()
    local _, entity = self:getExtraClient()
    if not entity then
        return
    end
    if self:flipExtraToggle("WingFly") then
        UIHelper.showToast("^00FF00Wing Fly Enabled")
        entity:setFloatProperty("JumpHeight", 1.0)
        self:startExtraTimer("WingFly", function()
            local _, player = self:getExtraClient()
            if not player then
                return
            end
            local position = player:getPosition()
            local footY = position.y - 1.7
            local inAir = true
            for depth = 0, 1 do
                if EngineWorld:getBlockId(VectorUtil.newVector3(position.x, footY - depth, position.z)) ~= 0 then
                    inAir = false
                    break
                end
            end
            if inAir then
                if player.m_wingId ~= 27 then
                    self.wingFlyPreviousWing = player.m_wingId
                    player.m_outLooksChanged = true
                    player.m_wingId = 27
                    player.m_isGlide = true
                    player.m_glideMoveAddition = 0.8
                    player.m_glideDropResistance = 0.5
                end
            elseif player.m_wingId == 27 then
                player.m_outLooksChanged = true
                player.m_wingId = self.wingFlyPreviousWing or 0
                player.m_isGlide = false
            end
        end, 50)
    else
        self:stopExtraTimer("WingFly")
        entity:setFloatProperty("JumpHeight", 0.4)
        if entity.m_wingId == 27 then
            entity.m_outLooksChanged = true
            entity.m_wingId = self.wingFlyPreviousWing or 0
            entity.m_isGlide = false
        end
        UIHelper.showToast("^FF0000Wing Fly Disabled")
    end
end

function GMHelper:TargetAura()
    if self:flipExtraToggle("TargetAura") then
        UIHelper.showToast("^00FF00Target Aura Enabled")
        self:startExtraTimer("TargetAura", function()
            local target, distance = self:findExtraNearestPlayer(true)
            if target and distance < 12 then
                local position = target.Player:getPosition()
                self:teleportExtra(position.x + math.random() * 6 - 3, position.y + 2, position.z + math.random() * 6 - 3)
            end
        end, 50)
    else
        self:stopExtraTimer("TargetAura")
        UIHelper.showToast("^FF0000Target Aura Disabled")
    end
end

function GMHelper:ItemCollector()
    if self:flipExtraToggle("ItemCollector") then
        UIHelper.showToast("^00FF00Item Collector Enabled")
        self:startExtraTimer("ItemCollector", function()
            local _, entity = self:getExtraClient()
            if not entity then
                return
            end
            local myPosition = entity:getPosition()
            local entities = {}
            if EntityCache and EntityCache.getAllEntity then
                entities = EntityCache:getAllEntity()
            elseif EngineWorld and EngineWorld.getAllEntitys then
                entities = EngineWorld:getAllEntitys()
            end
            local itemType = (EntityType and EntityType.Item) or 2
            local closestItem = nil
            local closestDistance = math.huge
            for _, object in pairs(entities or {}) do
                local candidate = nil
                if type(object) == "table" and object.type and object.entity then
                    if object.type == itemType then
                        candidate = object.entity
                    end
                elseif object.getType and object:getType() == itemType then
                    candidate = object
                end
                if candidate then
                    local itemPosition = candidate:getPosition()
                    local deltaX = myPosition.x - itemPosition.x
                    local deltaZ = myPosition.z - itemPosition.z
                    local distance = deltaX * deltaX + deltaZ * deltaZ
                    if distance < closestDistance then
                        closestDistance = distance
                        closestItem = candidate
                    end
                end
            end
            if closestItem and closestDistance > 1 then
                local itemPosition = closestItem:getPosition()
                self:teleportExtra(itemPosition.x, itemPosition.y + 2.2, itemPosition.z)
            end
        end, 60)
    else
        self:stopExtraTimer("ItemCollector")
        UIHelper.showToast("^FF0000Item Collector Disabled")
    end
end

function GMHelper:PanicDisableExtras()
    for name in pairs(self.extraTimers) do
        self:stopExtraTimer(name)
    end
    for name in pairs(self.extraToggles) do
        self.extraToggles[name] = false
        _G["tog" .. name] = false
    end
    for _, label in pairs(self.extraHudLabels) do
        label:SetVisible(false)
    end
    local _, entity = self:getExtraClient()
    if entity then
        entity:setFloatProperty("JumpHeight", 0.4)
        if entity.m_wingId == 27 then
            entity.m_outLooksChanged = true
            entity.m_wingId = self.wingFlyPreviousWing or 0
            entity.m_isGlide = false
        end
        pcall(function()
            entity:setWatchMode(false)
            entity:setAllowFlying(false)
            entity:setFlying(false)
        end)
    end
    pcall(function()
        CGame.Instance():toggleDebugMessageShown(false)
    end)
    ClientHelper.putBoolPrefs("IsSeparateCamera", false)
    self:applyExtraFov(0.8)
    UIHelper.showToast("^FF0000All extra features disabled")
end

GMSetting:addTab("^00FFDDTeleport+")
GMSetting:addItem("^00FFDDTeleport+", "^00FF00Set Waypoint 1", "SetWaypoint", 1)
GMSetting:addItem("^00FFDDTeleport+", "^00FF00Set Waypoint 2", "SetWaypoint", 2)
GMSetting:addItem("^00FFDDTeleport+", "^00FF00Set Waypoint 3", "SetWaypoint", 3)
GMSetting:addItem("^00FFDDTeleport+", "^00FF00Set Waypoint 4", "SetWaypoint", 4)
GMSetting:addItem("^00FFDDTeleport+", "^00FF00Set Waypoint 5", "SetWaypoint", 5)
GMSetting:addItem("^00FFDDTeleport+", "^FFD700Go Waypoint 1", "GoWaypoint", 1)
GMSetting:addItem("^00FFDDTeleport+", "^FFD700Go Waypoint 2", "GoWaypoint", 2)
GMSetting:addItem("^00FFDDTeleport+", "^FFD700Go Waypoint 3", "GoWaypoint", 3)
GMSetting:addItem("^00FFDDTeleport+", "^FFD700Go Waypoint 4", "GoWaypoint", 4)
GMSetting:addItem("^00FFDDTeleport+", "^FFD700Go Waypoint 5", "GoWaypoint", 5)
GMSetting:addItem("^00FFDDTeleport+", "^FF0000Clear Waypoints", "ClearWaypoints")
GMSetting:addItem("^00FFDDTeleport+", "Move Forward 5", "MoveRelative", 5, 0, 0)
GMSetting:addItem("^00FFDDTeleport+", "Move Back 5", "MoveRelative", -5, 0, 0)
GMSetting:addItem("^00FFDDTeleport+", "Move Left 5", "MoveRelative", 0, 5, 0)
GMSetting:addItem("^00FFDDTeleport+", "Move Right 5", "MoveRelative", 0, -5, 0)
GMSetting:addItem("^00FFDDTeleport+", "Move Up 10", "MoveRelative", 0, 0, 10)
GMSetting:addItem("^00FFDDTeleport+", "Move Up 50", "MoveRelative", 0, 0, 50)
GMSetting:addItem("^00FFDDTeleport+", "Move Down 5", "MoveRelative", 0, 0, -5)
GMSetting:addItem("^00FFDDTeleport+", "Teleport To Coordinates", "TeleportToCoordinates")
GMSetting:addItem("^00FFDDTeleport+", "Teleport To Player Name", "TeleportToPlayerName")
GMSetting:addItem("^00FFDDTeleport+", "Teleport To Random Player", "TeleportToRandomPlayer")
GMSetting:addItem("^00FFDDTeleport+", "Teleport Nearest Loop", "TeleportNearestLoop")
GMSetting:addItem("^00FFDDTeleport+", "Copy My Coordinates", "CopyCoordinates")

GMSetting:addTab("^FF66CCOutfit ID")
GMSetting:addItem("^FF66CCOutfit ID", "^00FF00Random Outfit", "RandomOutfit")
GMSetting:addItem("^FF66CCOutfit ID", "^00FF00Save Outfit", "SaveOutfit")
GMSetting:addItem("^FF66CCOutfit ID", "^00FF00Load Outfit", "LoadOutfit")
GMSetting:addItem("^FF66CCOutfit ID", "^FF0000Reset Outfit", "ResetOutfit")
GMSetting:addItem("^FF66CCOutfit ID", "", "nil")
GMSetting:addItem("^FF66CCOutfit ID", "Hair +", "OutfitIdStep", "m_hairID", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Hair -", "OutfitIdStep", "m_hairID", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Hair Set", "OutfitIdSet", "m_hairID")
GMSetting:addItem("^FF66CCOutfit ID", "Face +", "OutfitIdStep", "m_faceID", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Face -", "OutfitIdStep", "m_faceID", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Face Set", "OutfitIdSet", "m_faceID")
GMSetting:addItem("^FF66CCOutfit ID", "Tops +", "OutfitIdStep", "m_topsID", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Tops -", "OutfitIdStep", "m_topsID", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Tops Set", "OutfitIdSet", "m_topsID")
GMSetting:addItem("^FF66CCOutfit ID", "Pants +", "OutfitIdStep", "m_pantsID", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Pants -", "OutfitIdStep", "m_pantsID", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Pants Set", "OutfitIdSet", "m_pantsID")
GMSetting:addItem("^FF66CCOutfit ID", "Shoes +", "OutfitIdStep", "m_shoesID", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Shoes -", "OutfitIdStep", "m_shoesID", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Shoes Set", "OutfitIdSet", "m_shoesID")
GMSetting:addItem("^FF66CCOutfit ID", "Glasses +", "OutfitIdStep", "m_glassesId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Glasses -", "OutfitIdStep", "m_glassesId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Glasses Set", "OutfitIdSet", "m_glassesId")
GMSetting:addItem("^FF66CCOutfit ID", "Scarf +", "OutfitIdStep", "m_scarfId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Scarf -", "OutfitIdStep", "m_scarfId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Scarf Set", "OutfitIdSet", "m_scarfId")
GMSetting:addItem("^FF66CCOutfit ID", "Wings +", "OutfitIdStep", "m_wingId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Wings -", "OutfitIdStep", "m_wingId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Wings Set", "OutfitIdSet", "m_wingId")
GMSetting:addItem("^FF66CCOutfit ID", "Hat +", "OutfitIdStep", "m_hatId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Hat -", "OutfitIdStep", "m_hatId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Hat Set", "OutfitIdSet", "m_hatId")
GMSetting:addItem("^FF66CCOutfit ID", "Tail +", "OutfitIdStep", "m_tailId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Tail -", "OutfitIdStep", "m_tailId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Tail Set", "OutfitIdSet", "m_tailId")
GMSetting:addItem("^FF66CCOutfit ID", "Crown +", "OutfitIdStep", "m_crownId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Crown -", "OutfitIdStep", "m_crownId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Crown Set", "OutfitIdSet", "m_crownId")
GMSetting:addItem("^FF66CCOutfit ID", "Bag +", "OutfitIdStep", "m_bagId", 1)
GMSetting:addItem("^FF66CCOutfit ID", "Bag -", "OutfitIdStep", "m_bagId", -1)
GMSetting:addItem("^FF66CCOutfit ID", "Bag Set", "OutfitIdSet", "m_bagId")

GMSetting:addTab("^87CEFASky & Camera")
GMSetting:addItem("^87CEFASky & Camera", "^FFFF00Sky Day", "SetSky", "Qing")
GMSetting:addItem("^87CEFASky & Camera", "^4169E1Sky Night", "SetSky", "fanxing")
GMSetting:addItem("^87CEFASky & Camera", "^FF8C00Sky Evening", "SetSky", "Wanxia")
GMSetting:addItem("^87CEFASky & Camera", "^FFFFFFSky Snow", "SetSky", "xue")
GMSetting:addItem("^87CEFASky & Camera", "", "nil")
GMSetting:addItem("^87CEFASky & Camera", "Wide FOV", "WideFov")
GMSetting:addItem("^87CEFASky & Camera", "Zoom", "ZoomFov")
GMSetting:addItem("^87CEFASky & Camera", "Custom FOV", "CustomFov")
GMSetting:addItem("^87CEFASky & Camera", "Separate Camera", "SeparateCamera")
GMSetting:addItem("^87CEFASky & Camera", "Spin", "SpinBot")
GMSetting:addItem("^87CEFASky & Camera", "Watch Mode", "WatchMode")
GMSetting:addItem("^87CEFASky & Camera", "Debug Info", "DebugInfo")

GMSetting:addTab("^DA70D6Animations")
GMSetting:addItem("^DA70D6Animations", "^FF0000Reset Animation", "ResetAnimation")
GMSetting:addItem("^DA70D6Animations", "Walk", "PlayAnimation", "smg_walk")
GMSetting:addItem("^DA70D6Animations", "Sneak", "PlayAnimation", "sneak")
GMSetting:addItem("^DA70D6Animations", "Sit 1", "PlayAnimation", "sit1")
GMSetting:addItem("^DA70D6Animations", "Sit 2", "PlayAnimation", "sit2")
GMSetting:addItem("^DA70D6Animations", "Sit 3", "PlayAnimation", "sit3")
GMSetting:addItem("^DA70D6Animations", "Ride Dragon", "PlayAnimation", "ride_dragon")
GMSetting:addItem("^DA70D6Animations", "Swim", "PlayAnimation", "swim")
GMSetting:addItem("^DA70D6Animations", "^FFD700Custom Animation", "CustomAnimation")

GMSetting:addTab("^7CFC00HUD & Info")
GMSetting:addItem("^7CFC00HUD & Info", "^00FFDDCoordinates HUD", "CoordinatesHud")
GMSetting:addItem("^7CFC00HUD & Info", "^00FFDDNearest Enemy HUD", "NearestEnemyHud")
GMSetting:addItem("^7CFC00HUD & Info", "^00FFDDSession Clock HUD", "SessionClockHud")
GMSetting:addItem("^7CFC00HUD & Info", "", "nil")
GMSetting:addItem("^7CFC00HUD & Info", "Show Game Type", "ShowGameType")
GMSetting:addItem("^7CFC00HUD & Info", "Show Region", "ShowRegion")
GMSetting:addItem("^7CFC00HUD & Info", "Show Player Count", "ShowPlayerCount")
GMSetting:addItem("^7CFC00HUD & Info", "Show Nearest Player", "ShowNearestPlayer")
GMSetting:addItem("^7CFC00HUD & Info", "Copy Player List", "CopyPlayerList")
GMSetting:addItem("^7CFC00HUD & Info", "Copy Client Info", "CopyClientInfo")
GMSetting:addItem("^7CFC00HUD & Info", "Copy Client Log", "CopyClientLog")
GMSetting:addItem("^7CFC00HUD & Info", "Anti AFK", "AntiAfk")
GMSetting:addItem("^7CFC00HUD & Info", "^FF0000Panic: Disable All Extras", "PanicDisableExtras")

GMSetting:addItem("Hack", "Wing Fly", "WingFly")
GMSetting:addItem("Hack", "Target Aura", "TargetAura")
GMSetting:addItem("Hack", "Item Collector", "ItemCollector")

function GMHelper:ExchangeOwner()
    local clientPlayer = PlayerManager:getClientPlayer()
    if not clientPlayer then
        UIHelper.showToast("^FF0000Player not found")
        return
    end
    clientPlayer:sendPacket({data = CGame.Instance():getPlatformUserId(), pid = "exchangeOwner"})
    UIHelper.showToast("^00FF00Exchange Owner Sent")
end

function GMHelper:OpenDiscordLink()
    local link = "https://discord.gg/vScnrVFaF"
    ClientHelper.onSetClipboard(link)
    UIHelper.showToast("^5865F2Discord link copied: ^FFFFFF" .. link)
end

function GMHelper:OpenYouTubeLink()
    local link = "https://youtube.com/@novatexpanel"
    ClientHelper.onSetClipboard(link)
    UIHelper.showToast("^FF0000YouTube link copied: ^FFFFFF" .. link)
end

GMSetting:addItem("Community", "", "nil")
GMSetting:addItem("Community", "^5865F2NX Panel Discord", "OpenDiscordLink")
GMSetting:addItem("Community", "^FF0000NX Panel YouTube", "OpenYouTubeLink")

function GMHelper:findSafeBlockAbove(position)
    local check = {x = position.x, y = position.y, z = position.z}
    repeat
        if EngineWorld:getBlockId(VectorUtil.newVector3(check.x, check.y, check.z)) == BlockID.AIR then
            return VectorUtil.newVector3(check.x, check.y, check.z)
        end
        check.y = check.y + 1
    until check.y > 256
    return VectorUtil.newVector3(check.x, check.y, check.z)
end

function GMHelper:bypassTeleport(target)
    if target.y < 1 then
        return
    end
    local entity = PlayerManager:getClientPlayer().Player
    local position = entity:getPosition()
    local deltaX = target.x - position.x
    local deltaZ = target.z - position.z
    if math.sqrt(deltaX * deltaX + deltaZ * deltaZ) < 45 then
        entity:setPosition(self:findSafeBlockAbove(target))
        entity:setAllowFlying(false)
        entity:setFlying(false)
        return
    end
    local bedWarModes = {g1008 = true, g1046 = true, g1061 = true, g1062 = true, g1063 = true, g1064 = true, g1065 = true}
    if bedWarModes[CGame.Instance():getGameType()] then
        return
    end
    local newX = position.x
    local newY = position.y
    local newZ = position.z
    if newY < 165 then
        newY = 165
    end
    if math.abs(deltaX) > 8 then
        newX = newX + 8 * (deltaX > 0 and 1 or -1)
    else
        newX = target.x
    end
    if math.abs(deltaZ) > 8 then
        newZ = newZ + 8 * (deltaZ > 0 and 1 or -1)
    else
        newZ = target.z
    end
    entity:setPosition(VectorUtil.newVector3(newX, newY, newZ))
    LuaTimer:scheduleTimer(function()
        self:bypassTeleport(target)
    end, 20, 1)
end

function GMHelper:JetPack()
    _G.togJetPack = not _G.togJetPack
    if self.jetPackTimer then
        LuaTimer:cancel(self.jetPackTimer)
        self.jetPackTimer = nil
    end
    if not _G.togJetPack then
        UIHelper.showToast("^FF0000JetPack Disabled")
        return
    end
    UIHelper.showToast("^00FF00JetPack Enabled")
    self.jetPackTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer or not clientPlayer.Player then
            return
        end
        local entity = clientPlayer.Player
        local speed = 2.1
        local yaw = math.rad(entity:getYaw())
        local pitch = math.rad(entity:getPitch())
        local velocityX = -speed * math.cos(pitch) * math.sin(yaw)
        local velocityY = -speed * math.sin(pitch)
        local velocityZ = speed * math.cos(pitch) * math.cos(yaw)
        entity:setVelocity(VectorUtil.newVector3(velocityX, velocityY, velocityZ))
    end, 15, -1)
end

function GMHelper:AirSpeed()
    _G.togAirSpeed = not _G.togAirSpeed
    if not _G.togAirSpeed then
        if self.airSpeedCallback then
            CEvents.PlayerJumpEvent:unregisterCallBack(self.airSpeedCallback)
            self.airSpeedCallback = nil
        end
        UIHelper.showToast("^FF0000Air Speed Disabled")
        return
    end
    self.airSpeedCallback = function()
        if not _G.togAirSpeed then
            return
        end
        local entity = PlayerManager:getClientPlayer().Player
        entity:setGlide(true)
        entity.m_glideMoveAddition = 0.9
        entity.m_glideDropResistance = 0.01
    end
    CEvents.PlayerJumpEvent:registerCallBack(self.airSpeedCallback)
    UIHelper.showToast("^00FF00Air Speed Enabled")
end

function GMHelper:SharpMove()
    _G.togSharpMove = not _G.togSharpMove
    ClientHelper.putBoolPrefs("DisableInertialFly", _G.togSharpMove and true or false)
    if _G.togSharpMove then
        UIHelper.showToast("^00FF00Sharp Move Enabled")
    else
        UIHelper.showToast("^FF0000Sharp Move Disabled")
    end
end

function GMHelper:SmoothJumps()
    _G.togSmoothJumps = not _G.togSmoothJumps
    local entity = PlayerManager:getClientPlayer().Player
    if _G.togSmoothJumps then
        ClientHelper.putBoolPrefs("EnableDoubleJumps", true)
        entity.m_keepJumping = false
        UIHelper.showToast("^00FF00Smooth Jumps Enabled")
    else
        ClientHelper.putBoolPrefs("EnableDoubleJumps", false)
        entity.m_keepJumping = true
        UIHelper.showToast("^FF0000Smooth Jumps Disabled")
    end
end

function GMHelper:sendRebirthForMode()
    local gameType = CGame.Instance():getGameType()
    if gameType == "g1014" and respawn then
        respawn(1)
        LuaTimer:scheduleTimer(function()
            respawn(1)
        end, 1000, 6)
    elseif gameType == "g1027" and respawn then
        respawn(2)
        LuaTimer:scheduleTimer(function()
            respawn(2)
        end, 1000, 6)
    else
        PacketSender:getSender():sendRebirth()
        RootGuiLayout.Instance():showMainControl()
    end
end

function GMHelper:UnDeath()
    _G.togUnDeath = not _G.togUnDeath
    if self.unDeathTimer then
        LuaTimer:cancel(self.unDeathTimer)
        self.unDeathTimer = nil
    end
    if not _G.togUnDeath then
        UIHelper.showToast("^FF0000UnDeath Disabled")
        return
    end
    UIHelper.showToast("^00FF00UnDeath Enabled")
    local waitingForRebirth = false
    local deathPosition = nil
    self.unDeathTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer or not clientPlayer.Player then
            return
        end
        local entity = clientPlayer.Player
        local health = entity:getHealth() or 0
        local maxHealth = entity:getMaxHealth() or 1
        if health <= 0.374 then
            if not waitingForRebirth then
                deathPosition = entity:getPosition()
                UIHelper.showCenterToast("HP low - rebirthing....")
                waitingForRebirth = true
            end
            self:sendRebirthForMode()
        end
        if waitingForRebirth and health >= maxHealth * 0.9 and deathPosition then
            local position = entity:getPosition()
            local deltaX = position.x - deathPosition.x
            local deltaY = position.y - deathPosition.y
            local deltaZ = position.z - deathPosition.z
            if deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ > 16 then
                self:bypassTeleport(deathPosition)
                UIHelper.showCenterToast("Teleported to death spot!")
            end
            waitingForRebirth = false
            deathPosition = nil
        end
    end, 179, -1)
end

function GMHelper:BlockXRay()
    _G.togBlockXRay = not _G.togBlockXRay
    RenderExperimentSwitch.Instance():setZTestDisabled(_G.togBlockXRay and true or false)
    if _G.togBlockXRay then
        UIHelper.showToast("^00FF00Block XRay Enabled")
    else
        UIHelper.showToast("^FF0000Block XRay Disabled")
    end
end

function GMHelper:MobAimBow()
    _G.togMobAimBow = not _G.togMobAimBow
    if self.mobAimBowTimer then
        LuaTimer:cancel(self.mobAimBowTimer)
        self.mobAimBowTimer = nil
    end
    if not _G.togMobAimBow then
        UIHelper.showToast("^FF0000Mob AimBow Disabled")
        return
    end
    UIHelper.showToast("^00FF00Mob AimBow Enabled")
    self.mobAimBowTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer or not clientPlayer.Player then
            return
        end
        local entity = clientPlayer.Player
        local myPosition = entity:getPosition()
        if not myPosition then
            return
        end
        local closestDistance = math.huge
        local closestEntry = nil
        for _, entry in pairs(EntityCache:getAllEntity() or {}) do
            if EntityDefine and EntityDefine.isNotPlayer and EntityDefine:isNotPlayer(entry.type) and entry.entity then
                local mobPosition = entry.entity:getPosition()
                if mobPosition then
                    local deltaX = mobPosition.x - myPosition.x
                    local deltaZ = mobPosition.z - myPosition.z
                    local distance = deltaX * deltaX + deltaZ * deltaZ
                    if distance < closestDistance then
                        closestDistance = distance
                        closestEntry = entry
                    end
                end
            end
        end
        if not closestEntry or not entity:isUsingItem() then
            return
        end
        local heldItem = Item.getItemById(entity:getHeldItemId())
        if not heldItem or heldItem:getClassName() ~= "ItemBow" then
            return
        end
        local camera = SceneManager.Instance():getMainCamera()
        if not camera then
            return
        end
        local cameraPosition = camera:getPosition()
        local targetPosition = closestEntry.entity:getPosition()
        if not cameraPosition or not targetPosition then
            return
        end
        local direction = VectorUtil.sub3(targetPosition, cameraPosition)
        if not direction or (direction.x == 0 and direction.z == 0) then
            return
        end
        local horizontal = math.sqrt(direction.x * direction.x + direction.z * direction.z)
        entity.rotationYaw = math.atan2(direction.x, direction.z) / math.pi * -180
        entity.rotationPitch = -math.atan2(direction.y + 1.5, horizontal) / math.pi * 180
    end, 1, -1)
end

function GMHelper:NoHunger()
    _G.togNoHunger = not _G.togNoHunger
    if self.noHungerTimer then
        LuaTimer:cancel(self.noHungerTimer)
        self.noHungerTimer = nil
    end
    if not _G.togNoHunger then
        UIHelper.showToast("^FF0000No Hunger Disabled")
        return
    end
    UIHelper.showToast("^00FF00No Hunger Enabled")
    self.noHungerTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if clientPlayer and clientPlayer.Player then
            pcall(function()
                if clientPlayer.Player.getFoodStats then
                    local foodStats = clientPlayer.Player:getFoodStats()
                    if foodStats then
                        foodStats:setFoodLevel(20)
                    end
                end
            end)
        end
    end, 300, -1)
end

function GMHelper:ShowDurability()
    _G.togShowDurability = not _G.togShowDurability
    ClientHelper.putBoolPrefs("IsShowItemDurability", _G.togShowDurability and true or false)
    if _G.togShowDurability then
        UIHelper.showToast("^00FF00Show Durability Enabled")
    else
        UIHelper.showToast("^FF0000Show Durability Disabled")
    end
end

function GMHelper:EquipWing(wingId)
    local entity = PlayerManager:getClientPlayer().Player
    entity.m_outLooksChanged = true
    entity.m_wingId = tonumber(wingId) or wingId
    UIHelper.showToast("^00FF00Wing equipped")
end

function GMHelper:rememberOriginalName()
    if self.originalPlayerName then
        return
    end
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer and clientPlayer.Player then
        self.originalPlayerName = clientPlayer.Player:getEntityName()
    end
end

LuaTimer:schedule(function()
    pcall(function()
        GMHelper:rememberOriginalName()
    end)
end, 1000)

function GMHelper:ReturnName()
    self:rememberOriginalName()
    if not self.originalPlayerName then
        UIHelper.showToast("^FF0000Original name not found")
        return
    end
    local entity = PlayerManager:getClientPlayer().Player
    local teamTags = {
        [1] = "\226\150\162FF0000..[Red]",
        [2] = "\226\150\1620000FF..[Blue]",
        [3] = "\226\150\162008000..[Green]",
        [4] = "\226\150\162E3C00E..[Yellow]"
    }
    entity:setShowName(self.originalPlayerName .. (teamTags[entity:getTeamId()] or ""))
    UIHelper.showToast("^00FF00Name restored")
end

function GMHelper:TpRedClanWars()
    GUIGMControlPanel:hide()
    self:bypassTeleport(VectorUtil.newVector3(-174, 67, -23))
end

function GMHelper:TpBlueClanWars()
    GUIGMControlPanel:hide()
    self:bypassTeleport(VectorUtil.newVector3(60, 67, -53))
end

function GMHelper:MineReset()
    local entity = PlayerManager:getClientPlayer().Player
    entity:setPosition(VectorUtil.newVector3(536, 2.78, -136))
    entity:moveEntity(VectorUtil.newVector3(0, 0, 0))
end

function GMHelper:TreasureShowChests()
    _G.togTreasureShowChests = not _G.togTreasureShowChests
    for blockId = 3, 133 do
        local block = BlockManager.getBlockById(blockId)
        if block then
            if _G.togTreasureShowChests then
                block:setBlockBounds(0, 0, 0, 0, 0, 0)
            else
                block:setBlockBounds(0, 0, 0, 1, 1, 1)
            end
        end
    end
    if _G.togTreasureShowChests then
        UIHelper.showToast("^00FF00Show Chests Enabled")
    else
        UIHelper.showToast("^FF0000Show Chests Disabled")
    end
end

function GMHelper:TreasureTpBottom()
    GUIGMControlPanel:hide()
    self:bypassTeleport(VectorUtil.newVector3(547, 1, -123))
end

function GMHelper:DestroyAllButtons()
    local hidden = 0
    local fixedNames = {"GUIRoot-BwFly", "BlockToggleBtn"}
    for index = 1, 300 do
        table.insert(fixedNames, "GUIRoot-BtnUI-" .. tostring(index))
    end
    for _, name in ipairs(fixedNames) do
        local window = GUIManager:getWindowByName(name)
        if window then
            window:SetVisible(false)
            hidden = hidden + 1
        end
    end
    UIHelper.showToast("^00FF00Hidden " .. tostring(hidden) .. " buttons")
end

function GMHelper:CopyDeviceId()
    local deviceId = json.decode(HostApi.getClientInfo()).device_id
    ClientHelper.onSetClipboard(tostring(deviceId))
    UIHelper.showToast("^00FF00Device Id Copied: " .. tostring(deviceId))
end

function GMHelper:HoeAura()
    _G.togHoeAura = not _G.togHoeAura
    if self.hoeAuraTimer then
        LuaTimer:cancel(self.hoeAuraTimer)
        self.hoeAuraTimer = nil
    end
    if not _G.togHoeAura then
        UIHelper.showToast("^FF0000Hoe Aura Disabled")
        return
    end
    UIHelper.showToast("^00FF00Hoe Aura Enabled")
    self.hoeAuraTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer then
            return
        end
        local position = clientPlayer:getPosition()
        local baseX = math.floor(position.x)
        local baseY = math.floor(position.y)
        local baseZ = math.floor(position.z)
        for offsetX = -16, 16 do
            for offsetZ = -16, 16 do
                for offsetY = -2, 1 do
                    local blockPosition = VectorUtil.newVector3(baseX + offsetX, baseY + offsetY, baseZ + offsetZ)
                    if EngineWorld:getBlockId(blockPosition) == BlockID.GRASS and EngineWorld:getBlockId(VectorUtil.getPosY(blockPosition, 1)) == 0 then
                        clientPlayer:sendPacket({pid = "tryUseItemHoe", blockPos = blockPosition})
                    end
                end
            end
        end
    end, 1000, -1)
end

function GMHelper:BreakCropAura()
    _G.togBreakCropAura = not _G.togBreakCropAura
    if self.breakCropAuraTimer then
        LuaTimer:cancel(self.breakCropAuraTimer)
        self.breakCropAuraTimer = nil
    end
    if not _G.togBreakCropAura then
        UIHelper.showToast("^FF0000Break Crop Aura Disabled")
        return
    end
    UIHelper.showToast("^00FF00Break Crop Aura Enabled")
    self.breakCropAuraTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer then
            return
        end
        local position = clientPlayer:getPosition()
        local baseX = math.floor(position.x)
        local baseY = math.floor(position.y)
        local baseZ = math.floor(position.z)
        for offsetX = -16, 16 do
            for offsetZ = -16, 16 do
                for offsetY = -2, 1 do
                    local blockPosition = VectorUtil.newVector3(baseX + offsetX, baseY + offsetY, baseZ + offsetZ)
                    if EngineWorld:getBlockId(blockPosition) == BlockID.TILLED_FIELD then
                        local cropPosition = VectorUtil.getPosY(blockPosition, 1)
                        if EngineWorld:getBlockId(cropPosition) then
                            clientPlayer:sendPacket({pid = "tryBreakCrop", blockPos = cropPosition})
                        end
                    end
                end
            end
        end
    end, 1000, -1)
end

function GMHelper:PlaceCropAura()
    _G.togPlaceCropAura = not _G.togPlaceCropAura
    if self.placeCropAuraTimer then
        LuaTimer:cancel(self.placeCropAuraTimer)
        self.placeCropAuraTimer = nil
    end
    if not _G.togPlaceCropAura then
        UIHelper.showToast("^FF0000Place Crop Aura Disabled")
        return
    end
    UIHelper.showToast("^00FF00Place Crop Aura Enabled")
    self.placeCropAuraTimer = LuaTimer:scheduleTimer(function()
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer then
            return
        end
        local position = clientPlayer:getPosition()
        local baseX = math.floor(position.x)
        local baseY = math.floor(position.y)
        local baseZ = math.floor(position.z)
        for offsetX = -16, 16 do
            for offsetZ = -16, 16 do
                for offsetY = -2, 1 do
                    local blockPosition = VectorUtil.newVector3(baseX + offsetX, baseY + offsetY, baseZ + offsetZ)
                    if EngineWorld:getBlockId(blockPosition) == BlockID.TILLED_FIELD then
                        local cropPosition = VectorUtil.getPosY(blockPosition, 1)
                        if EngineWorld:getBlockId(cropPosition) then
                            clientPlayer:sendPacket({pid = "tryCreateCrop", blockPos = cropPosition})
                        end
                    end
                end
            end
        end
    end, 1000, -1)
end

function GMHelper:ClaimPassRewards()
    local clientPlayer = PlayerManager:getClientPlayer()
    if not clientPlayer then
        return
    end
    for attempt = 1, 2 do
        clientPlayer:sendPacket({pid = "tryGetAllPassReward"})
    end
    UIHelper.showToast("^00FF00Rewards Requested")
end

function GMHelper:ChatBypass()
    UIHelper.showToast("Attempting to Inject Chat Bypass")
    local folder = Root.Instance():getRootPath() .. "/Media/Setting/"
    pcall(function()
        lfs.mkdir(folder)
    end)
    local file = io.open(folder .. "words.txt", "w")
    if file then
        file:write("")
        file:close()
        UIHelper.showToast("^00FF00Chat Bypass ready, rejoin the game")
    else
        UIHelper.showToast("^FF0000Failed to Inject Chat Bypass")
    end
end

function GMHelper:NoHurtCam()
    _G.togNoHurtCam = not _G.togNoHurtCam
    if not self.noHurtCamRegistered then
        self.noHurtCamRegistered = true
        CEvents.HurtCameraEffectEvent:registerCallBack(function(...)
            return _G.togNoHurtCam
        end)
    end
    if _G.togNoHurtCam then
        UIHelper.showToast("^00FF00No Hurt Cam Enabled")
    else
        UIHelper.showToast("^FF0000No Hurt Cam Disabled")
    end
end

function GMHelper:executeAutoTreasure()
    if not _G.togAutoTreasure or self.autoTreasureDigging then
        return
    end
    local clientPlayer = PlayerManager:getClientPlayer()
    if not clientPlayer or not clientPlayer.Player then
        return
    end
    local treasurePointConfig = T(Global, "TreasurePointConfig")
    local treasurePacketSender = T(Global, "PidPacketSender")
    local activePointId = clientPlayer.info:getValue(Define.PlayerInfoKey.TreasurePointId)
    if activePointId == 0 then
        treasurePacketSender:tryOpenTreasureMap()
        return
    end
    local pointData = treasurePointConfig:getCfgById(activePointId)
    if not pointData or not pointData.position then
        return
    end
    local distance = VectorUtil.distance(clientPlayer.Player:getPosition(), pointData.position)
    if distance < 2.5 then
        treasurePacketSender:tryDigTreasureMap()
        self.autoTreasureDigging = true
        LuaTimer:scheduleTimer(function()
            self.autoTreasureDigging = false
        end, 2000, 1)
    else
        clientPlayer.Player:setPosition(pointData.position)
    end
end

function GMHelper:AutoTreasure()
    _G.togAutoTreasure = not _G.togAutoTreasure
    if self.autoTreasureTimer then
        LuaTimer:cancel(self.autoTreasureTimer)
        self.autoTreasureTimer = nil
    end
    self.autoTreasureDigging = false
    if not _G.togAutoTreasure then
        UIHelper.showToast("^FF0000Auto Treasure Disabled")
        return
    end
    UIHelper.showToast("^00FF00Auto Treasure Enabled")
    self.autoTreasureTimer = LuaTimer:scheduleTimer(function()
        local success, errorMessage = pcall(function()
            self:executeAutoTreasure()
        end)
        if not success then
            print("AutoTreasure error: " .. tostring(errorMessage))
        end
    end, 1000, -1)
end

function GMHelper:TriggerBot()
    _G.togTriggerBot = not _G.togTriggerBot
    if _G.togTriggerBot then
        UIHelper.showToast("^00FF00TriggerBot Enabled")
    else
        UIHelper.showToast("^FF0000TriggerBot Disabled")
        return
    end
    local shootButton = GUIManager:getWindowByName("Main-GunOperate-RightShootBtn")
    if not shootButton then
        UIHelper.showToast("^FF0000Shoot button not found")
        return
    end
    if self.triggerBotButton == shootButton then
        return
    end
    self.triggerBotButton = shootButton
    shootButton:registerEvent(GUIEvent.ButtonClick, function()
        if not _G.togTriggerBot then
            return
        end
        local clientPlayer = PlayerManager:getClientPlayer()
        if not clientPlayer then
            return
        end
        local myPosition = clientPlayer:getPosition()
        local myTeamId = clientPlayer.teamId
        local closestPlayer = nil
        local closestDistance = nil
        for _, player in pairs(PlayerManager:getPlayers() or {}) do
            if player ~= clientPlayer and player.teamId ~= myTeamId then
                local position = player:getPosition()
                local distance = (position.x - myPosition.x) ^ 2 + (position.y - myPosition.y) ^ 2 + (position.z - myPosition.z) ^ 2
                if not closestDistance or distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
        if closestPlayer then
            local targetPosition = closestPlayer:getPosition()
            local attackPosition = VectorUtil.newVector3(math.floor(targetPosition.x + 100), math.floor(targetPosition.y + 100), math.floor(targetPosition.z + 100))
            Attack(closestPlayer.entityId, attackPosition)
        end
    end)
end

GMSetting:addItem("Hack", "JetPack", "JetPack")
GMSetting:addItem("Hack", "Air Speed", "AirSpeed")
GMSetting:addItem("Hack", "Sharp Move", "SharpMove")
GMSetting:addItem("Hack", "Smooth Jumps", "SmoothJumps")
GMSetting:addItem("Hack", "UnDeath", "UnDeath")
GMSetting:addItem("Hack", "Block XRay", "BlockXRay")
GMSetting:addItem("Hack", "TriggerBot", "TriggerBot")
GMSetting:addItem("Mobs", "Mob AimBow", "MobAimBow")
GMSetting:addItem("Mobs", "No Hunger", "NoHunger")
GMSetting:addItem("Effects", "Show Durability", "ShowDurability")
GMSetting:addItem("Effects", "No Hurt Cam", "NoHurtCam")
GMSetting:addItem("Skins", "Chroma Wing", "EquipWing", "27")
GMSetting:addItem("View", "Return Name", "ReturnName")
GMSetting:addItem("Game & Panel", "Destroy All Buttons", "DestroyAllButtons")
GMSetting:addItem("Game & Panel", "Copy Device ID", "CopyDeviceId")
GMSetting:addItem("Sky Block", "Hoe Aura", "HoeAura")
GMSetting:addItem("Sky Block", "Break Crop Aura", "BreakCropAura")
GMSetting:addItem("Sky Block", "Place Crop Aura", "PlaceCropAura")
GMSetting:addItem("Sky Block", "Claim Rewards", "ClaimPassRewards")
GMSetting:addItem("Sky Block", "Auto Treasure", "AutoTreasure")
GMSetting:addItem("Chat", "Chat Bypass", "ChatBypass")

if CGame.Instance():getGameType() == "g1072" then
    GMSetting:addTab("^FF0000Clan Wars")
    GMSetting:addItem("^FF0000Clan Wars", "^FF0000Tp To Red", "TpRedClanWars")
    GMSetting:addItem("^FF0000Clan Wars", "^0000FFTp To Blue", "TpBlueClanWars")
end

if CGame.Instance():getGameType() == "g1015" then
    GMSetting:addTab("^FFD700Treasure Hunter")
    GMSetting:addItem("^FFD700Treasure Hunter", "Mine Reset", "MineReset")
    GMSetting:addItem("^FFD700Treasure Hunter", "Show Chests", "TreasureShowChests")
    GMSetting:addItem("^FFD700Treasure Hunter", "Tp To Bottom", "TreasureTpBottom")
end

GMHelper.nClientTimers = GMHelper.nClientTimers or {}
GMHelper.nClientHealthCache = GMHelper.nClientHealthCache or {}
GMHelper.nClientBoxCache = GMHelper.nClientBoxCache or {}

function GMHelper:nClientToggle(name)
    _G["tog" .. name] = not _G["tog" .. name]
    if self.nClientTimers[name] then
        LuaTimer:cancel(self.nClientTimers[name])
        self.nClientTimers[name] = nil
    end
    return _G["tog" .. name]
end

function GMHelper:nClientLoop(name, interval, callback)
    self.nClientTimers[name] = LuaTimer:scheduleTimer(function()
        pcall(callback)
    end, interval, -1)
end

function GMHelper:nClientPlayer()
    local clientPlayer = PlayerManager:getClientPlayer()
    if clientPlayer and clientPlayer.Player then
        return clientPlayer, clientPlayer.Player
    end
    return nil, nil
end

function GMHelper:nClientForward(entity, speed)
    local yaw = math.rad(entity:getYaw() or 0)
    local pitch = math.rad(entity:getPitch() or 0)
    return -speed * math.cos(pitch) * math.sin(yaw), -speed * math.sin(pitch), speed * math.cos(pitch) * math.cos(yaw)
end

function GMHelper:nClientNearestPlayer(maxDistanceSquared)
    local clientPlayer, entity = self:nClientPlayer()
    if not entity then
        return nil, nil
    end
    local myPosition = entity:getPosition()
    local best = nil
    local bestDistance = maxDistanceSquared or math.huge
    for _, player in pairs(PlayerManager:getPlayers() or {}) do
        if player and player ~= clientPlayer and player.getPosition and player:getPosition() then
            local position = player:getPosition()
            local distance = (position.x - myPosition.x) ^ 2 + (position.y - myPosition.y) ^ 2 + (position.z - myPosition.z) ^ 2
            if distance > 0.1 and distance < bestDistance then
                bestDistance = distance
                best = player
            end
        end
    end
    return best, clientPlayer
end

function GMHelper:nClientAttack(target)
    local position = target:getPosition()
    local attackPosition = VectorUtil.newVector3(math.floor(position.x), math.floor(position.y), math.floor(position.z))
    if Zentex then
        Zentex(target.entityId, attackPosition)
    elseif Attack then
        Attack(target.entityId, attackPosition)
    end
end

function GMHelper:glideTeleport(target)
    local _, entity = self:nClientPlayer()
    if not entity then
        return
    end
    pcall(function()
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
    end)
    local startPosition = entity:getPosition()
    local destination = VectorUtil.newVector3(target.x, target.y + 1.3, target.z)
    local deltaX = destination.x - startPosition.x
    local deltaY = destination.y - startPosition.y
    local deltaZ = destination.z - startPosition.z
    local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
    local steps = math.max(1, math.ceil(distance / 4))
    local step = 0
    entity:setAllowFlying(true)
    entity:setFlying(true)
    entity.noClip = true
    local timer = nil
    timer = LuaTimer:scheduleTimer(function()
        local _, player = self:nClientPlayer()
        if not player then
            if timer then
                LuaTimer:cancel(timer)
            end
            return
        end
        step = step + 1
        local progress = math.min(1, step / steps)
        player.noClip = true
        player:setPosition(VectorUtil.newVector3(startPosition.x + deltaX * progress, startPosition.y + deltaY * progress, startPosition.z + deltaZ * progress))
        if step >= steps then
            LuaTimer:cancel(timer)
            player.noClip = false
            player:setFlying(false)
        end
    end, 40, steps)
end

function GMHelper:AntiKnockback()
    if self:nClientToggle("AntiKnockback") then
        UIHelper.showToast("^00FF00Anti Knockback ON")
        self:nClientLoop("AntiKnockback", 20, function()
            local _, entity = self:nClientPlayer()
            if entity then
                entity.m_knockbackX = 0
                entity.m_knockbackZ = 0
            end
        end)
    else
        UIHelper.showToast("^FF0000Anti Knockback OFF")
    end
end

function GMHelper:Bhop()
    if self:nClientToggle("Bhop") then
        UIHelper.showToast("^00FF00Bunny Hop ON")
        self:nClientLoop("Bhop", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and entity.onGround then
                entity:setVelocity(VectorUtil.newVector3(0, 0.42, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Bunny Hop OFF")
    end
end

function GMHelper:Spider()
    if self:nClientToggle("Spider") then
        UIHelper.showToast("^00FF00Spider Climb ON")
        self:nClientLoop("Spider", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and (entity.horizontalCollision or entity.isCollidedHorizontally) then
                entity:setVelocity(VectorUtil.newVector3(0, 0.2, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Spider Climb OFF")
    end
end

function GMHelper:WaterWalk()
    if self:nClientToggle("WaterWalk") then
        UIHelper.showToast("^00FF00Water Walk ON")
        self:nClientLoop("WaterWalk", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and (entity.isInWater or entity.inWater) then
                entity:setVelocity(VectorUtil.newVector3(0, 0.1, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Water Walk OFF")
    end
end

function GMHelper:Glide()
    if self:nClientToggle("Glide") then
        UIHelper.showToast("^00FF00Glide ON")
        self:nClientLoop("Glide", 50, function()
            local _, entity = self:nClientPlayer()
            if not entity or entity.onGround then
                return
            end
            local velocityX, _, velocityZ = self:nClientForward(entity, 0.35)
            entity:setVelocity(VectorUtil.newVector3(velocityX, -0.08, velocityZ))
        end)
    else
        UIHelper.showToast("^FF0000Glide OFF")
    end
end

function GMHelper:FastFall()
    if self:nClientToggle("FastFall") then
        UIHelper.showToast("^00FF00Fast Fall ON")
        self:nClientLoop("FastFall", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and not entity.onGround then
                entity:setVelocity(VectorUtil.newVector3(0, -2.0, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Fast Fall OFF")
    end
end

function GMHelper:FastSwim()
    if self:nClientToggle("FastSwim") then
        UIHelper.showToast("^00FF00Fast Swim ON")
        self:nClientLoop("FastSwim", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and (entity.isInWater or entity.inWater) then
                local velocityX, velocityY, velocityZ = self:nClientForward(entity, 1.2)
                entity:setVelocity(VectorUtil.newVector3(velocityX, velocityY, velocityZ))
            end
        end)
    else
        UIHelper.showToast("^FF0000Fast Swim OFF")
    end
end

function GMHelper:InfSprint()
    if self:nClientToggle("InfSprint") then
        UIHelper.showToast("^00FF00Infinite Sprint ON")
        self:nClientLoop("InfSprint", 16, function()
            local _, entity = self:nClientPlayer()
            if entity then
                entity:setSprinting(true)
            end
        end)
    else
        local _, entity = self:nClientPlayer()
        if entity then
            pcall(function()
                entity:setSprinting(false)
            end)
        end
        UIHelper.showToast("^FF0000Infinite Sprint OFF")
    end
end

function GMHelper:AutoWalk()
    if self:nClientToggle("AutoWalk") then
        UIHelper.showToast("^00FF00Auto Walk ON")
        self:nClientLoop("AutoWalk", 50, function()
            local _, entity = self:nClientPlayer()
            if entity then
                local velocityX, _, velocityZ = self:nClientForward(entity, 0.5)
                entity:setVelocity(VectorUtil.newVector3(velocityX, 0, velocityZ))
            end
        end)
    else
        UIHelper.showToast("^FF0000Auto Walk OFF")
    end
end

function GMHelper:AutoSneak()
    if self:nClientToggle("AutoSneak") then
        UIHelper.showToast("^00FF00Auto Sneak ON")
        self:nClientLoop("AutoSneak", 100, function()
            local _, entity = self:nClientPlayer()
            if entity then
                entity:setSneaking(true)
            end
        end)
    else
        local _, entity = self:nClientPlayer()
        if entity then
            pcall(function()
                entity:setSneaking(false)
            end)
        end
        UIHelper.showToast("^FF0000Auto Sneak OFF")
    end
end

function GMHelper:Criticals()
    if self:nClientToggle("Criticals") then
        UIHelper.showToast("^00FF00Criticals ON")
        self:nClientLoop("Criticals", 250, function()
            local _, entity = self:nClientPlayer()
            if entity and entity.onGround then
                entity:setVelocity(VectorUtil.newVector3(0, 0.1, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Criticals OFF")
    end
end

function GMHelper:AutoMelee()
    if self:nClientToggle("AutoMelee") then
        UIHelper.showToast("^00FF00Auto Melee ON")
        self:nClientLoop("AutoMelee", 200, function()
            local target = self:nClientNearestPlayer(36)
            if target and target.entityId and target:getPosition() then
                self:nClientAttack(target)
            end
        end)
    else
        UIHelper.showToast("^FF0000Auto Melee OFF")
    end
end

function GMHelper:MultiAura()
    if self:nClientToggle("MultiAura") then
        UIHelper.showToast("^00FF00Multi Aura ON")
        self:nClientLoop("MultiAura", 400, function()
            local clientPlayer, entity = self:nClientPlayer()
            if not entity then
                return
            end
            local myPosition = entity:getPosition()
            for _, target in pairs(PlayerManager:getPlayers() or {}) do
                if target and target ~= clientPlayer and target.entityId and target:getPosition() then
                    local position = target:getPosition()
                    local distance = (position.x - myPosition.x) ^ 2 + (position.y - myPosition.y) ^ 2 + (position.z - myPosition.z) ^ 2
                    if distance < 100 then
                        self:nClientAttack(target)
                    end
                end
            end
        end)
    else
        UIHelper.showToast("^FF0000Multi Aura OFF")
    end
end

function GMHelper:TargetLock()
    if self:nClientToggle("TargetLock") then
        UIHelper.showToast("^00FF00Target Lock ON")
        self:nClientLoop("TargetLock", 20, function()
            local target, clientPlayer = self:nClientNearestPlayer(2500)
            if not target or not clientPlayer then
                return
            end
            local cameraPosition = SceneManager.Instance():getMainCamera():getPosition()
            local direction = VectorUtil.sub3(target:getPosition(), cameraPosition)
            local horizontal = math.sqrt(direction.x * direction.x + direction.z * direction.z)
            clientPlayer.Player.rotationYaw = math.atan2(direction.x, direction.z) / math.pi * -180
            clientPlayer.Player.rotationPitch = -math.atan2(direction.y + 1.5, horizontal) / math.pi * 180
        end)
    else
        UIHelper.showToast("^FF0000Target Lock OFF")
    end
end

function GMHelper:MineGod()
    _G.togMineGod = not _G.togMineGod
    local pickaxeConfig = T(Global, "PickaxeConfig")
    local outputConfig = T(Global, "OutputConfig")
    if _G.togMineGod then
        if pickaxeConfig and not self.mineGodOriginalGetConfig then
            self.mineGodOriginalGetConfig = pickaxeConfig.getPickaxeCfgById
            pickaxeConfig.getPickaxeCfgById = function(config, itemId)
                local result = GMHelper.mineGodOriginalGetConfig(config, itemId)
                if _G.togMineGod and result then
                    result.digSpeed = 1
                    result.efficiency = 1
                end
                return result
            end
            self.mineGodOriginalDigTimes = pickaxeConfig.getUnitDamageDigTimes
            pickaxeConfig.getUnitDamageDigTimes = function(config, itemId)
                if _G.togMineGod then
                    return 1
                end
                return GMHelper.mineGodOriginalDigTimes(config, itemId)
            end
        end
        if outputConfig and not self.mineGodOriginalOreCheck then
            self.mineGodOriginalOreCheck = outputConfig.checkOreRemoval
            outputConfig.checkOreRemoval = function(config, itemId)
                if _G.togMineGod then
                    return true
                end
                return GMHelper.mineGodOriginalOreCheck(config, itemId)
            end
        end
        UIHelper.showToast("^00FF00Mine God ON")
    else
        UIHelper.showToast("^FF0000Mine God OFF")
    end
end

function GMHelper:Ascend()
    local _, entity = self:nClientPlayer()
    if not entity then
        UIHelper.showToast("^FF0000No player")
        return
    end
    local position = entity:getPosition()
    self:glideTeleport(VectorUtil.newVector3(position.x, position.y + 10, position.z))
    UIHelper.showToast("^00FF00Ascend +10")
end

function GMHelper:Descend()
    local _, entity = self:nClientPlayer()
    if not entity then
        UIHelper.showToast("^FF0000No player")
        return
    end
    local position = entity:getPosition()
    self:glideTeleport(VectorUtil.newVector3(position.x, position.y - 10, position.z))
    UIHelper.showToast("^00FF00Descend -10")
end

function GMHelper:TPNearestEntity()
    local target = self:nClientNearestPlayer(math.huge)
    if not target or not target.getPosition then
        UIHelper.showToast("^FF0000No entity")
        return
    end
    local position = target:getPosition()
    self:glideTeleport(VectorUtil.newVector3(position.x, position.y + 1, position.z))
    UIHelper.showToast("^00FF00TP to nearest entity")
end

function GMHelper:TPToSpawn()
    local _, entity = self:nClientPlayer()
    local position = entity and entity:getPosition()
    self:glideTeleport(VectorUtil.newVector3((position and position.x) or 0, 100, (position and position.z) or 0))
    UIHelper.showToast("^00FF00TP to spawn area (y=100)")
end

function GMHelper:WalkToSaved()
    if not self.waypoints and self.loadWaypoints then
        self:loadWaypoints()
    end
    local saved = self.waypoints and self.waypoints[1]
    if not saved and not _G.togWalkToSaved then
        UIHelper.showToast("^FF0000Set Waypoint 1 first (Teleport+)")
        return
    end
    if not self:nClientToggle("WalkToSaved") then
        UIHelper.showToast("^FF0000Walk To Saved OFF")
        return
    end
    UIHelper.showToast("^00FF00Walking to Waypoint 1...")
    self:nClientLoop("WalkToSaved", 50, function()
        local _, entity = self:nClientPlayer()
        if not entity then
            return
        end
        local position = entity:getPosition()
        local deltaX = saved.x - position.x
        local deltaY = saved.y - position.y
        local deltaZ = saved.z - position.z
        local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
        if distance < 1.0 then
            UIHelper.showToast("^00FF00Arrived at Waypoint 1")
            self:nClientToggle("WalkToSaved")
            return
        end
        local scale = 0.4 / distance
        entity:setVelocity(VectorUtil.newVector3(deltaX * scale, deltaY * scale, deltaZ * scale))
    end)
end

function GMHelper:OrbitTarget()
    if not self:nClientToggle("OrbitTarget") then
        local _, entity = self:nClientPlayer()
        if entity then
            pcall(function()
                entity:setFlying(false)
            end)
        end
        UIHelper.showToast("^FF0000Orbit OFF")
        return
    end
    UIHelper.showToast("^00FF00Orbit ON")
    pcall(function()
        ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
    end)
    local angle = 0
    self:nClientLoop("OrbitTarget", 16, function()
        local target, clientPlayer = self:nClientNearestPlayer(math.huge)
        if not target or not clientPlayer then
            return
        end
        local targetPosition = target:getPosition()
        angle = (angle + 0.18) % (math.pi * 2)
        local newX = targetPosition.x + math.cos(angle) * 3.0
        local newZ = targetPosition.z + math.sin(angle) * 3.0
        local entity = clientPlayer.Player
        entity:setAllowFlying(true)
        entity:setFlying(true)
        entity:setPosition(VectorUtil.newVector3(newX, targetPosition.y + 1.2, newZ))
        entity.rotationYaw = math.atan2(targetPosition.x - newX, targetPosition.z - newZ) / math.pi * -180
        entity.rotationPitch = 0
    end)
end

function GMHelper:getHealthEspParts(userId)
    if self.nClientHealthCache[userId] then
        return self.nClientHealthCache[userId]
    end
    local root = GUISystem.Instance():GetRootWindow()
    local parts = {}
    parts.info = GUIManager:createGUIWindow(GUIType.StaticText, "NXPanel_HP_Info_" .. userId)
    parts.info:SetTextScale(0.85)
    parts.info:SetTextHorzAlign(HorizontalAlignment.Center)
    pcall(function()
        parts.info:SetLevel(99)
        parts.info:SetAlwaysOnTop(true)
    end)
    root:AddChildWindow(parts.info)
    parts.background = GUIManager:createGUIWindow(GUIType.StaticText, "NXPanel_HP_Background_" .. userId)
    parts.background:SetBackgroundColor({0, 0, 0, 1})
    pcall(function()
        parts.background:SetLevel(98)
        parts.background:SetAlwaysOnTop(true)
    end)
    root:AddChildWindow(parts.background)
    parts.foreground = GUIManager:createGUIWindow(GUIType.StaticText, "NXPanel_HP_Foreground_" .. userId)
    parts.foreground:SetBackgroundColor({0, 1, 0, 1})
    parts.background:AddChildWindow(parts.foreground)
    self.nClientHealthCache[userId] = parts
    return parts
end

function GMHelper:ToggleESPHealth()
    if not self:nClientToggle("ToggleESPHealth") then
        for _, parts in pairs(self.nClientHealthCache) do
            parts.info:SetVisible(false)
            parts.background:SetVisible(false)
            parts.foreground:SetVisible(false)
        end
        UIHelper.showToast("^FF0000ESP Health Disabled")
        return
    end
    UIHelper.showToast("^00FF00ESP Health Enabled")
    self:nClientLoop("ToggleESPHealth", 16, function()
        local clientPlayer = PlayerManager:getClientPlayer()
        local players = PlayerManager:getPlayers()
        local camera = SceneManager.Instance():getMainCamera()
        if not (clientPlayer and players and camera) then
            return
        end
        local pixelSize = GUISystem.Instance():GetRootWindow():GetPixelSize()
        local screenWidth = pixelSize.x
        local screenHeight = pixelSize.y
        local cameraPosition = camera:getPosition()
        local cameraDirection = camera:getDirection()
        for _, target in pairs(players) do
            if target and target.userId ~= clientPlayer.userId then
                local parts = self:getHealthEspParts(target.userId)
                local entity = target.Player
                local visible = false
                if entity and target:isEntityAlive() then
                    local position = entity:getPosition(0)
                    local distance = math.sqrt((position.x - cameraPosition.x) ^ 2 + (position.y - cameraPosition.y) ^ 2 + (position.z - cameraPosition.z) ^ 2)
                    local dot = (position.x - cameraPosition.x) * cameraDirection.x + (position.y - cameraPosition.y) * cameraDirection.y + (position.z - cameraPosition.z) * cameraDirection.z
                    if dot > 0 and distance < 500 then
                        local height = entity:getHeight() or 1.9
                        local top = Blockman.Instance():getScreenPos({x = position.x, y = position.y + height, z = position.z})
                        local bottom = Blockman.Instance():getScreenPos({x = position.x, y = position.y - 0.1, z = position.z})
                        if top and top.z > 0 and bottom and bottom.z > 0 then
                            visible = true
                            local health = target:getHealth() or 0
                            local maxHealth = target:getMaxHealth() or 1
                            if maxHealth <= 0 then
                                maxHealth = 1
                            end
                            local percent = math.max(0, math.min(1, health / maxHealth))
                            local isAlly = false
                            pcall(function()
                                isAlly = clientPlayer:getTeamId() == target:getTeamId()
                            end)
                            local healthColor = {0, 1, 0, 1}
                            if percent <= 0.2 then
                                healthColor = {1, 0, 0, 1}
                            elseif percent <= 0.5 then
                                healthColor = {1, 1, 0, 1}
                            end
                            parts.info:SetVisible(true)
                            parts.info:SetText(string.format("[%d HP] %dm", math.floor(health), math.floor(distance)))
                            parts.info:SetTextColor(isAlly and {0, 1, 0, 1} or {1, 0, 0, 1})
                            local topX = top.x * screenWidth
                            local topY = top.y * screenHeight
                            local bottomY = bottom.y * screenHeight
                            parts.info:SetArea({0, topX - 100}, {0, topY - 25}, {0, 200}, {0, 20})
                            local barHeight = math.max(1, bottomY - topY)
                            local barX = topX - ((barHeight * 0.225) + 6)
                            local fillHeight = barHeight * percent
                            parts.background:SetVisible(true)
                            parts.background:SetArea({0, barX - 1}, {0, topY - 1}, {0, 6}, {0, barHeight + 2})
                            parts.foreground:SetVisible(true)
                            parts.foreground:SetArea({0, 1}, {0, 1 + (barHeight - fillHeight)}, {0, 4}, {0, fillHeight})
                            parts.foreground:SetBackgroundColor(healthColor)
                        end
                    end
                end
                if not visible then
                    parts.info:SetVisible(false)
                    parts.background:SetVisible(false)
                    parts.foreground:SetVisible(false)
                end
            end
        end
    end)
end

function GMHelper:drawEspLine(window, pointA, pointB, color, thickness, screenWidth, screenHeight)
    local x1 = pointA.x * screenWidth
    local y1 = pointA.y * screenHeight
    local x2 = pointB.x * screenWidth
    local y2 = pointB.y * screenHeight
    local deltaX = x2 - x1
    local deltaY = y2 - y1
    local length = math.sqrt(deltaX * deltaX + deltaY * deltaY)
    if length <= 0.01 then
        window:SetVisible(false)
        return
    end
    window:SetVisible(true)
    window:SetBackgroundColor(color)
    pcall(function()
        window:SetHorizontalAlignment(HorizontalAlignment.Left)
        window:SetVerticalAlignment(VerticalAlignment.Top)
    end)
    window:SetWidth({0, length})
    window:SetHeight({0, thickness})
    window:SetXPosition({0, x1 + deltaX / 2 - length / 2})
    window:SetYPosition({0, y1 + deltaY / 2})
    window:SetRotate(math.deg(math.atan2(deltaY, deltaX)))
end

function GMHelper:getBoxEspParts(userId)
    if self.nClientBoxCache[userId] then
        return self.nClientBoxCache[userId]
    end
    local root = GUISystem.Instance():GetRootWindow()
    local parts = {}
    for index = 1, 4 do
        local line = GUIManager:createGUIWindow(GUIType.StaticText, "NXPanel_2D_" .. userId .. "_" .. index)
        pcall(function()
            line:SetLevel(99)
            line:SetAlwaysOnTop(true)
        end)
        root:AddChildWindow(line)
        parts[index] = line
    end
    self.nClientBoxCache[userId] = parts
    return parts
end

function GMHelper:ToggleESP2D()
    if not self:nClientToggle("ToggleESP2D") then
        for _, parts in pairs(self.nClientBoxCache) do
            for index = 1, 4 do
                parts[index]:SetVisible(false)
            end
        end
        UIHelper.showToast("^FF0000ESP 2D Box Disabled")
        return
    end
    UIHelper.showToast("^00FF00ESP 2D Box Enabled")
    self:nClientLoop("ToggleESP2D", 16, function()
        local clientPlayer = PlayerManager:getClientPlayer()
        local players = PlayerManager:getPlayers()
        local camera = SceneManager.Instance():getMainCamera()
        if not (clientPlayer and players and camera) then
            return
        end
        local pixelSize = GUISystem.Instance():GetRootWindow():GetPixelSize()
        local screenWidth = pixelSize.x
        local screenHeight = pixelSize.y
        local cameraPosition = camera:getPosition()
        local cameraDirection = camera:getDirection()
        for _, target in pairs(players) do
            if target and target.userId ~= clientPlayer.userId then
                local parts = self:getBoxEspParts(target.userId)
                local entity = target.Player
                local visible = false
                if entity and target:isEntityAlive() then
                    local position = entity:getPosition(0)
                    local dot = (position.x - cameraPosition.x) * cameraDirection.x + (position.y - cameraPosition.y) * cameraDirection.y + (position.z - cameraPosition.z) * cameraDirection.z
                    local distance = math.sqrt((position.x - cameraPosition.x) ^ 2 + (position.y - cameraPosition.y) ^ 2 + (position.z - cameraPosition.z) ^ 2)
                    if dot > 0 and distance < 500 then
                        local height = entity:getHeight() or 1.9
                        local top = Blockman.Instance():getScreenPos({x = position.x, y = position.y + height, z = position.z})
                        local bottom = Blockman.Instance():getScreenPos({x = position.x, y = position.y - 0.1, z = position.z})
                        if top and top.z > 0 and bottom and bottom.z > 0 then
                            visible = true
                            local isAlly = false
                            pcall(function()
                                isAlly = clientPlayer:getTeamId() == target:getTeamId()
                            end)
                            local color = isAlly and {0, 1, 0, 1} or {1, 0, 0, 1}
                            local boxHeight = bottom.y - top.y
                            local boxWidth = boxHeight * (screenHeight / screenWidth) * 0.45
                            local left = top.x - boxWidth / 2
                            local right = top.x + boxWidth / 2
                            local topLeft = {x = left, y = top.y}
                            local topRight = {x = right, y = top.y}
                            local bottomLeft = {x = left, y = bottom.y}
                            local bottomRight = {x = right, y = bottom.y}
                            self:drawEspLine(parts[1], topLeft, topRight, color, 2, screenWidth, screenHeight)
                            self:drawEspLine(parts[2], bottomLeft, bottomRight, color, 2, screenWidth, screenHeight)
                            self:drawEspLine(parts[3], topLeft, bottomLeft, color, 2, screenWidth, screenHeight)
                            self:drawEspLine(parts[4], topRight, bottomRight, color, 2, screenWidth, screenHeight)
                        end
                    end
                end
                if not visible then
                    for index = 1, 4 do
                        parts[index]:SetVisible(false)
                    end
                end
            end
        end
    end)
end

function GMHelper:Backflip()
    local _, entity = self:nClientPlayer()
    if not entity then
        UIHelper.showToast("^FF0000No player")
        return
    end
    pcall(function()
        entity:setVelocity(VectorUtil.newVector3(0, 0.9, 0))
    end)
    local startPitch = entity:getPitch() or 0
    local steps = 0
    LuaTimer:scheduleTimer(function()
        steps = steps + 1
        pcall(function()
            entity.rotationPitch = (startPitch + steps * 36) % 360
        end)
    end, 20, 10)
    UIHelper.showToast("^00FFFFBackflip!")
end

function GMHelper:ConfettiRain()
    local parts = {"^FF0000@", "^00FF00*", "^0000FF+", "^FFFF00o", "^FF00FF#", "^00FFFF~"}
    LuaTimer:scheduleTimer(function()
        local line = ""
        for _ = 1, 6 do
            line = line .. parts[math.random(#parts)] .. "  "
        end
        UIHelper.showToast(line)
    end, 200, 15)
    UIHelper.showToast("^FF00FFConfetti Rain!")
end

function GMHelper:DiscoMode()
    if self:nClientToggle("DiscoMode") then
        local colors = {"^FF0000", "^00FF00", "^0000FF", "^FFFF00", "^FF00FF", "^00FFFF"}
        local index = 0
        self:nClientLoop("DiscoMode", 250, function()
            index = (index % #colors) + 1
            UIHelper.showToast(colors[index] .. "*** DISCO PARTY ***")
        end)
    else
        UIHelper.showToast("^FF0000Disco Mode OFF")
    end
end

function GMHelper:EarthQuake()
    if self:nClientToggle("EarthQuake") then
        UIHelper.showToast("^FFFF00EARTHQUAKE!")
        self:nClientLoop("EarthQuake", 60, function()
            local _, entity = self:nClientPlayer()
            if entity then
                entity:setVelocity(VectorUtil.newVector3((math.random() - 0.5) * 0.6, 0.05, (math.random() - 0.5) * 0.6))
            end
        end)
    else
        UIHelper.showToast("^FF0000Earthquake OFF")
    end
end

function GMHelper:Tornado()
    if self:nClientToggle("Tornado") then
        UIHelper.showToast("^00FFFFTORNADO!")
        local angle = 0
        self:nClientLoop("Tornado", 50, function()
            local _, entity = self:nClientPlayer()
            if not entity then
                return
            end
            angle = angle + 0.5
            entity.rotationYaw = math.deg(angle) % 360
            entity:setVelocity(VectorUtil.newVector3(math.cos(angle) * 0.8, 0.3, math.sin(angle) * 0.8))
        end)
    else
        UIHelper.showToast("^FF0000Tornado OFF")
    end
end

function GMHelper:MoonGravity()
    if self:nClientToggle("MoonGravity") then
        UIHelper.showToast("^00FF00Moon Gravity ON")
        self:nClientLoop("MoonGravity", 50, function()
            local _, entity = self:nClientPlayer()
            if entity and not entity.onGround then
                entity:setVelocity(VectorUtil.newVector3(0, -0.03, 0))
            end
        end)
    else
        UIHelper.showToast("^FF0000Moon Gravity OFF")
    end
end

function GMHelper:GhostMode()
    if self:nClientToggle("GhostMode") then
        UIHelper.showToast("^00FF00Ghost Mode ON (fly + noclip)")
        pcall(function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        end)
        local _, entity = self:nClientPlayer()
        if entity then
            pcall(function()
                entity:setAllowFlying(true)
                entity:setFlying(true)
            end)
        end
        self:nClientLoop("GhostMode", 100, function()
            local _, player = self:nClientPlayer()
            if player then
                player.noClip = true
            end
        end)
    else
        local _, entity = self:nClientPlayer()
        if entity then
            pcall(function()
                entity.noClip = false
                entity:setFlying(false)
            end)
        end
        UIHelper.showToast("^FF0000Ghost Mode OFF")
    end
end

function GMHelper:FakeLag()
    if self:nClientToggle("FakeLag") then
        pcall(function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", false)
        end)
        UIHelper.showToast("^00FF00Fake Lag ON (blink)")
    else
        pcall(function()
            ClientHelper.putBoolPrefs("SyncClientPositionToServer", true)
        end)
        UIHelper.showToast("^FF0000Fake Lag OFF")
    end
end

function GMHelper:RubberBand()
    if self:nClientToggle("RubberBand") then
        UIHelper.showToast("^00FF00Rubber Band ON")
        local _, entity = self:nClientPlayer()
        local anchor = entity and entity:getPosition()
        self.rubberBandAnchor = anchor and VectorUtil.newVector3(anchor.x, anchor.y, anchor.z) or nil
        self:nClientLoop("RubberBand", 800, function()
            if not self.rubberBandAnchor then
                return
            end
            local _, player = self:nClientPlayer()
            if not player then
                return
            end
            player:setVelocity(VectorUtil.newVector3((math.random() - 0.5) * 4, 0.5, (math.random() - 0.5) * 4))
            LuaTimer:scheduleTimer(function()
                if _G.togRubberBand and self.rubberBandAnchor then
                    self:glideTeleport(self.rubberBandAnchor)
                end
            end, 300, 1)
        end)
    else
        UIHelper.showToast("^FF0000Rubber Band OFF")
    end
end

function GMHelper:PlayerMagnet()
    if self:nClientToggle("PlayerMagnet") then
        UIHelper.showToast("^00FF00Player Magnet ON")
        self:nClientLoop("PlayerMagnet", 100, function()
            local clientPlayer, entity = self:nClientPlayer()
            if not entity then
                return
            end
            local myPosition = entity:getPosition()
            for _, target in pairs(PlayerManager:getPlayers() or {}) do
                if target and target ~= clientPlayer and target.getPosition and target:getPosition() then
                    local position = target:getPosition()
                    local distance = (position.x - myPosition.x) ^ 2 + (position.y - myPosition.y) ^ 2 + (position.z - myPosition.z) ^ 2
                    if distance < 400 then
                        pcall(function()
                            target:setPosition(VectorUtil.newVector3(myPosition.x, myPosition.y, myPosition.z))
                        end)
                    end
                end
            end
        end)
    else
        UIHelper.showToast("^FF0000Player Magnet OFF")
    end
end

function GMHelper:Yeet()
    local target = self:nClientNearestPlayer(2500)
    if not target then
        UIHelper.showToast("^FF0000No target to yeet")
        return
    end
    pcall(function()
        target:setVelocity(VectorUtil.newVector3(0, 5, 0))
    end)
    local name = (target.getName and target:getName()) or "player"
    UIHelper.showToast("^FFFF00YEETED " .. tostring(name) .. " to the moon!")
end

function GMHelper:ResetPose()
    local _, entity = self:nClientPlayer()
    if not entity then
        return
    end
    entity:setBoolProperty("DisableUpdateAnimState", false)
    HostApi.setClientAction(entity, 0, 2, 0)
    UIHelper.showToast("^FF0000Pose: Reset")
end

function GMHelper:CrashGame()
    window.Main = GUIManager:createGUIWindow("Layout", "Main")
    UIHelper.showToast("GULULULU")
end

GMSetting:addItem("Hack", "Anti Knockback", "AntiKnockback")
GMSetting:addItem("Hack", "Bunny Hop", "Bhop")
GMSetting:addItem("Hack", "Spider Climb", "Spider")
GMSetting:addItem("Hack", "Water Walk", "WaterWalk")
GMSetting:addItem("Hack", "Glide", "Glide")
GMSetting:addItem("Hack", "Fast Fall", "FastFall")
GMSetting:addItem("Hack", "Fast Swim", "FastSwim")
GMSetting:addItem("Hack", "Infinite Sprint", "InfSprint")
GMSetting:addItem("Hack", "Auto Walk", "AutoWalk")
GMSetting:addItem("Hack", "Auto Sneak", "AutoSneak")
GMSetting:addItem("Hack", "Criticals", "Criticals")
GMSetting:addItem("Hack", "Auto Melee", "AutoMelee")
GMSetting:addItem("Hack", "Multi Aura", "MultiAura")
GMSetting:addItem("Hack", "Target Lock", "TargetLock")
GMSetting:addItem("Hack", "Mine God", "MineGod")
GMSetting:addItem("^00FFDDTeleport+", "Ascend", "Ascend")
GMSetting:addItem("^00FFDDTeleport+", "Descend", "Descend")
GMSetting:addItem("^00FFDDTeleport+", "TP Nearest Entity", "TPNearestEntity")
GMSetting:addItem("^00FFDDTeleport+", "TP To Spawn", "TPToSpawn")
GMSetting:addItem("^00FFDDTeleport+", "Walk To Waypoint 1", "WalkToSaved")
GMSetting:addItem("^00FFDDTeleport+", "Orbit Player", "OrbitTarget")
GMSetting:addItem("^7CFC00HUD & Info", "ESP Health", "ToggleESPHealth")
GMSetting:addItem("^7CFC00HUD & Info", "ESP 2D Box", "ToggleESP2D")
GMSetting:addItem("^DA70D6Animations", "Reset Pose", "ResetPose")
GMSetting:addItem("Game & Panel", "^FF0000Crash Game", "CrashGame")

GMSetting:addTab("^FF69B4Fun")
GMSetting:addItem("^FF69B4Fun", "Backflip", "Backflip")
GMSetting:addItem("^FF69B4Fun", "Confetti Rain", "ConfettiRain")
GMSetting:addItem("^FF69B4Fun", "Disco Mode", "DiscoMode")
GMSetting:addItem("^FF69B4Fun", "Earthquake", "EarthQuake")
GMSetting:addItem("^FF69B4Fun", "Tornado", "Tornado")
GMSetting:addItem("^FF69B4Fun", "Moon Gravity", "MoonGravity")
GMSetting:addItem("^FF69B4Fun", "Ghost Mode", "GhostMode")
GMSetting:addItem("^FF69B4Fun", "Fake Lag", "FakeLag")
GMSetting:addItem("^FF69B4Fun", "Rubber Band", "RubberBand")
GMSetting:addItem("^FF69B4Fun", "Player Magnet", "PlayerMagnet")
GMSetting:addItem("^FF69B4Fun", "Yeet Nearest", "Yeet")


r17 = v2[v3[1]](v1[1].SavedSkinsPath).m_glassesId
r27 = v2[v3[1]](v1[1].SavedSkinsPath).m_tailId
r13 = TeamConfig:getTeam(r10[1]).bedPos
r22 = v2[v3[1]](v1[1].SavedSkinsPath).m_scarfId
r29 = a:getDirection().y
r15 = TeamConfig:getTeam(r10[1]).bedPos
r25 = v2[v3[1]](v1[1].SavedSkinsPath).m_hatId
r31 = v2[v3[1]](v1[1].SavedSkinsPath).m_crownId
r5 = PlayerManager:getClientPlayer().Player
r4 = v2[v3[1]](v1[1].SavedSkinsPath).m_pantsID
r24 = PlayerManager:getClientPlayer().userId
r30 = v2[v3[1]](v1[1].SavedSkinsPath).m_crownId
r10 = v2[v3[1]](v1[1].SavedSkinsPath).m_topsID
r34 = EngineWorld:getBlockId(r45) == BlockID.AIR
r3 = v2[v3[1]](v1[1].SavedSkinsPath).m_shoesID