-- Decompiled with the Synapse X Luau decompiler.

math.randomseed(tick());
local v1 = game:GetService("RunService"):IsStudio();
local l__Value__2 = game:GetService("ReplicatedFirst"):WaitForChild("GameData"):WaitForChild("Version", 3).Value;
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
print("Waiting on game to finish loading");
while true do
	wait(1);
	if game:IsLoaded() and shared.require then
		break;
	end;
end;
local v4 = tick();
local v5 = shared.require("superusers")[l__LocalPlayer__3.UserId];
pcall(function()
	game:GetService("StarterGui"):SetCore("TopbarEnabled", false);
end);
local v6 = Instance.new("Folder");
v6.Name = "Players";
v6.Parent = workspace;
for v7, v8 in game:GetService("Teams")() do
	local v9 = Instance.new("Folder");
	v9.Name = v8.TeamColor.Name;
	v9.Parent = v6;
end;
local v10 = {};
local v11 = {};
local v12 = {};
local v13 = {};
local v14 = {};
local v15 = {
	raycastwhitelist = {}
};
shared.add("hud", v12);
shared.add("char", v10);
shared.add("roundsystem", v15);
shared.add("replication", v14);
shared.add("PlayerPolicy", (shared.require("PolicyHelper").new(l__LocalPlayer__3)));
local v16 = shared.require("GameClock");
print("Waiting on GameClock sync");
while true do
	wait();
	if v16.isReady() then
		break;
	end;
end;
print("Waiting on player data");
local v17 = shared.require("PlayerDataStoreClient");
while true do
	wait();
	if v17.isDataReady() then
		break;
	end;
end;
local v18 = shared.require("PublicSettings");
local v19 = shared.require("RenderSteppedRunner");
local v20 = shared.require("HeartbeatRunner");
local v21 = shared.require("network");
local v22 = shared.require("trash");
local v23 = shared.require("vector");
local v24 = shared.require("cframe");
local v25 = shared.require("spring");
local v26 = shared.require("Event");
local v27 = shared.require("ScreenCull");
shared.require("CameraRequire");
local v28 = shared.require("camera");
shared.require("MenuRequire");
local v29 = shared.require("MenuScreenGui");
local v30 = shared.require("sequencer");
local v31 = shared.require("animation");
local v32 = shared.require("input");
local v33 = shared.require("particle");
local v34 = shared.require("effects");
local v35 = shared.require("tween");
local v36 = shared.require("uiscaler");
local v37 = shared.require("InstanceType");
local v38 = shared.require("sound");
local l__getModifiedData__39 = shared.require("ModifyData").getModifiedData;
local v40 = shared.require("DayCycle");
local v41 = shared.require("GameClock");
local v42 = shared.require("ContentDatabase");
local v43 = shared.require("PlayerSettingsInterface");
local v44 = shared.require("PlayerSettingsEvents");
local v45 = shared.require("WeaponUtils");
local v46 = shared.require("Raycast");
local v47 = shared.require("LuaUtils");
for v48, v49 in v42.getAllWeaponsList() do
	v47.deepFreeze(v42.getWeaponData(v49));
end;
print("Loading chat module");
local l__LocalPlayer__50 = game:GetService("Players").LocalPlayer;
local l__ChatGame__51 = l__LocalPlayer__50.PlayerGui:WaitForChild("ChatGame");
local l__TextBox__52 = l__ChatGame__51:WaitForChild("TextBox");
local l__Warn__53 = l__ChatGame__51:WaitForChild("Warn");
local v54 = v37.IsVIP();
local u1 = l__ChatGame__51:WaitForChild("Version");
local u2 = v37.GetString();
function v11.updateversionstr(p1)
	u1.Text = string.format("<b>Version: %s-%s#%s</b>", l__Value__2, string.lower(u2), p1 and "N/A");
end;
local u3 = v36.getscale;
local u4 = game.ReplicatedStorage.Misc:WaitForChild("MsgerMain");
local u5 = l__ChatGame__51:WaitForChild("GlobalChat");
v21:add("console", function(p2)
	local v55 = u4:Clone();
	local l__Tag__56 = v55:FindFirstChild("Tag");
	v55.Text = "[Console]: ";
	v55.TextColor3 = Color3.new(0.4, 0.4, 0.4);
	v55.Msg.Text = p2;
	v55.Parent = u5;
	v55.Msg.Position = UDim2.new(0, v55.TextBounds.x / u3(), 0, 0);
end);
v21:add("announce", function(p3)
	local v57 = u4:Clone();
	local l__Tag__58 = v57:FindFirstChild("Tag");
	v57.Text = "[ANNOUNCEMENT]: ";
	v57.TextColor3 = Color3.new(0.9803921568627451, 0.6509803921568628, 0.10196078431372549);
	v57.Msg.Text = p3;
	v57.Parent = u5;
	v57.Msg.Position = UDim2.new(0, v57.TextBounds.x / u3(), 0, 0);
end);
v21:add("chatted", function(p4, p5, p6, p7, p8)
	local v59 = u3();
	local v60 = u4:Clone();
	local l__Tag__61 = v60:FindFirstChild("Tag");
	v60.Parent = u5;
	l__Tag__61.Text = p6 and p6 .. " " or "";
	if p6 then
		if string.sub(p6, 0, 1) == "$" then
			v60.Position = UDim2.new(0.01, 50, 1, 20);
			l__Tag__61.Staff.Visible = true;
			l__Tag__61.Staff.Image = "rbxassetid://" .. string.sub(p6, 2);
			l__Tag__61.Text = "    ";
		else
			local v62 = l__Tag__61.TextBounds.x / v59 + 5;
			v60.Position = UDim2.new(0.01, v62, 1, 20);
			l__Tag__61.Position = UDim2.new(0, -v62 + 5, 0, 0);
			if p7 then
				l__Tag__61.TextColor3 = p7;
			end;
		end;
	end;
	if v12.streamermode and v12.streamermode() then
		v60.Text = "Player : ";
	else
		v60.Text = p4.Name .. " : ";
	end;
	v60.TextColor = p4.TeamColor;
	v60.Msg.Text = p5;
	if p8 then
		v60.Msg.TextColor3 = Color3.new(1, 0, 0);
	end;
	v60.Msg.Position = UDim2.new(0, v60.TextBounds.x / v59, 0, 0);
end);
v21:add("printstring", function(...)
	local v63 = nil;
	local v64 = { ... };
	v63 = "";
	for v65 = 1, #v63 do
		v63 = v63 .. "\t" .. v64[v65];
	end;
	local v66 = 0;
	local v67 = "";
	for v68 in string.gmatch(local v69 .. "\n", "(^[\n]*)\n") do
		v66 = v66 + 1;
		v67 = v67 .. "\n" .. v68;
		if v66 == 64 then
			print(v67);
			v66 = 0;
			v67 = "";
		end;
	end;
end);
local u6 = l__TextBox__52;
local u7 = 0;
local u8 = l__Warn__53;
local u9 = 0;
local u10 = l__LocalPlayer__50;
function v11.hidechat(p9, p10)
	u5.Visible = p10;
	u6.Visible = p10;
end;
function v11.inmenu(p11)
	u5.Position = UDim2.new(0, 20, 1, -120);
	u6.Position = UDim2.new(0, 10, 1, -20);
end;
function v11.ingame(p12)
	u5.Position = UDim2.new(0, 150, 1, -50);
	u6.Position = UDim2.new(0, 10, 1, -20);
end;
u5.ChildAdded:connect(function(p13)
	task.wait();
	local v70 = u3();
	local v71 = u5:GetChildren();
	for v72 = 1, #v71 do
		local v73 = v71[v72];
		local l__Tag__74 = v73:FindFirstChild("Tag");
		local v75 = 20;
		if l__Tag__74.Text ~= "" then
			v75 = 20 + l__Tag__74.TextBounds.x / v70;
			v73.Position = UDim2.new(0, v75, 1, v73.Position.Y.Offset);
		end;
		if v73.Parent then
			v73:TweenPosition(UDim2.new(0, v75, 1, (v72 - #v71) * 20), "Out", "Sine", 0.2, true);
		end;
		if #v71 > 8 and v72 <= #v71 - 8 and v73.Name ~= "Deleted" then
			v73.Name = "Deleted";
			for v76 = 1, 5 do
				if v73:FindFirstChild("Msg") and v73:FindFirstChild("Tag") then
					v73.TextTransparency = v76 * 2 / 10;
					v73.TextStrokeTransparency = v76 * 2 / 10 + 0.1;
					v73.Msg.TextTransparency = v76 * 2 / 10;
					v73.Msg.TextStrokeTransparency = v76 * 2 / 10 + 0.1;
					v73.Tag.TextTransparency = v76 * 2 / 10;
					v73.Tag.TextStrokeTransparency = v76 * 2 / 10 + 0.1;
					task.wait(0.03333333333333333);
				end;
				if v73 and v73.Parent then
					v73:Destroy();
				end;
			end;
		end;
	end;
end);
u6.Focused:connect(function()
	u6.Active = true;
end);
local function u11()
	local v77 = u6.Text;
	u6.Text = "Press '/' or click here to chat";
	u6.ClearTextOnFocus = true;
	u6.Active = false;
	if string.sub(v77, 1, 1) == "/" then
		v21:send("modcmd", v77);
		u6.Text = "Press '/' or click here to chat";
		u6.ClearTextOnFocus = true;
		return;
	end;
	local v78 = nil;
	if string.sub(v77, 1, 1) == "%" then
		v78 = true;
		v77 = string.sub(v77, 2, string.len(v77));
	end;
	if not (u7 > 5) then
		if string.len(v77) > 256 then
			v77 = string.sub(v77, 1, 256);
		end;
		u7 = u7 + 1;
		v21:send("chatted", v77, v78);
		task.delay(10, function()
			u7 = u7 - 1;
		end);
		return;
	end;
	u8.Visible = true;
	u7 = u7 + 1;
	u9 = u9 + 1;
	u8.Text = "You have been blocked temporarily for spamming.   WARNING : " .. u9 .. " out of 3";
	if u9 > 3 then
		u10:Kick("Kicked for repeated spamming");
	end;
	task.delay(5, function()
		u7 = u7 - 5;
		u8.Visible = false;
	end);
end;
u6.FocusLost:connect(function(p14)
	u6.Active = false;
	if p14 and u6.Text ~= "" then
		u11();
	end;
end);
game:GetService("UserInputService").InputBegan:connect(function(p15)
	if u8.Visible then
		return;
	end;
	local l__KeyCode__79 = p15.KeyCode;
	if not u6.Active then
		if l__KeyCode__79 ~= Enum.KeyCode.Slash then
			if l__KeyCode__79 == Enum.KeyCode[v12.voteyes] then
				v12:vote("yes");
				return;
			elseif l__KeyCode__79 == Enum.KeyCode[v12.votedismiss] then
				v12:vote("dismiss");
				return;
			else
				if l__KeyCode__79 == Enum.KeyCode[v12.voteno] then
					v12:vote("no");
				end;
				return;
			end;
		end;
	else
		return;
	end;
	wait(0.03333333333333333);
	u6:CaptureFocus();
	u6.ClearTextOnFocus = false;
end);
v11.updateversionstr();
v11:hidechat(v43.getValue("togglechat"));
v44.onSettingChanged:connect(function(p16, p17)
	if p16 == "togglechat" then
		v11:hidechat(p17);
	end;
end);
u3 = print;
u2 = "Loading hud module";
u3(u2);
u3 = v36.getscale;
u10 = game;
u10 = u10.GetService;
u10 = u10(u10, "Players");
u2 = u10.LocalPlayer;
u4 = game;
u10 = u4.ReplicatedStorage.Character.PlayerTag;
local l__PlayerGui__80 = u2.PlayerGui;
u4 = game;
local l__ReplicatedStorage__81 = u4.ReplicatedStorage;
u4 = l__ReplicatedStorage__81.Misc;
u6 = u4.Spot;
u8 = u4.Feed;
u1 = u4.Headshot;
u5 = l__PlayerGui__80.WaitForChild;
u5 = u5(l__PlayerGui__80, "MainGui");
local l__GameGui__82 = u5:WaitForChild("GameGui");
local l__NonScaled__83 = l__PlayerGui__80:WaitForChild("NonScaled");
local l__CrossHud__84 = l__GameGui__82:WaitForChild("CrossHud");
local l__Sprint__85 = l__CrossHud__84:WaitForChild("Sprint");
local v86 = { l__CrossHud__84:WaitForChild("HR"), l__CrossHud__84:WaitForChild("HL"), l__CrossHud__84:WaitForChild("VD"), l__CrossHud__84:WaitForChild("VU") };
local l__AmmoHud__87 = l__GameGui__82:WaitForChild("AmmoHud");
local l__ScopeFrame__88 = l__NonScaled__83:WaitForChild("ScopeFrame");
local l__Hitmarker__89 = l__GameGui__82:WaitForChild("Hitmarker");
local l__NameTag__90 = l__NonScaled__83:WaitForChild("NameTag");
local l__Capping__91 = l__GameGui__82:WaitForChild("Capping");
local l__BloodScreen__92 = l__GameGui__82:WaitForChild("BloodScreen");
local l__Radar__93 = l__GameGui__82:WaitForChild("Radar");
local l__Killfeed__94 = l__GameGui__82:WaitForChild("Killfeed");
local l__Steady__95 = l__NonScaled__83:WaitForChild("Steady"):WaitForChild("Steady");
local l__Use__96 = l__GameGui__82:WaitForChild("Use");
local l__Round__97 = l__GameGui__82:WaitForChild("Round");
local l__Spotted__98 = l__GameGui__82:WaitForChild("Spotted");
local l__GlobalChat__99 = l__PlayerGui__80.ChatGame:WaitForChild("GlobalChat");
local l__Bar__100 = l__Steady__95:WaitForChild("Full"):WaitForChild("Bar");
local l__Folder__101 = l__Radar__93:WaitForChild("Folder");
local v102 = -l__Radar__93:WaitForChild("Me").Size.X.Offset / 2;
local l__Frame__103 = l__AmmoHud__87:WaitForChild("Frame");
local l__Ammo__104 = l__Frame__103:WaitForChild("Ammo");
local l__GAmmo__105 = l__Frame__103:WaitForChild("GAmmo");
local l__Mag__106 = l__Frame__103:WaitForChild("Mag");
local l__Health__107 = l__Frame__103:WaitForChild("Health");
local l__FMode__108 = l__Frame__103:WaitForChild("FMode");
local l__healthbar_back__109 = l__Frame__103:WaitForChild("healthbar_back");
local l__healthbar_fill__110 = l__healthbar_back__109:WaitForChild("healthbar_fill");
local v111 = { Color3.new(0.14901960784313725, 0.3137254901960784, 0.2784313725490196), Color3.new(0.17647058823529413, 0.5019607843137255, 0.43137254901960786), Color3.new(0.8745098039215686, 0.12156862745098039, 0.12156862745098039), Color3.new(0.5333333333333333, 0.06666666666666667, 0.06666666666666667) };
local l__Percent__112 = l__Capping__91:WaitForChild("Percent");
v12.crossscale = v25.new(0);
v12.crossscale.s = 10;
v12.crossscale.d = 0.8;
v12.crossscale.t = 1;
v12.crossspring = v25.new(0);
v12.crossspring.s = 12;
v12.crossspring.d = 0.65;
v12.hitspring = v25.new(1);
v12.hitspring.s = 5;
v12.hitspring.d = 0.7;
v12.streamermodetoggle = true;
local l__Votekick__113 = l__PlayerGui__80.ChatGame:WaitForChild("Votekick");
local l__Yes__114 = l__Votekick__113:WaitForChild("Yes");
local l__No__115 = l__Votekick__113:WaitForChild("No");
local l__Dismiss__116 = l__Votekick__113:WaitForChild("Dismiss");
v12.voteyes = "Y";
v12.voteno = "N";
v12.votedismiss = "J";
l__Yes__114.Text = "Yes [" .. string.upper(v12.voteyes) .. "]";
l__No__115.Text = "No [" .. string.upper(v12.voteno) .. "]";
l__Dismiss__116.Text = "Dismiss [" .. string.upper(v12.votedismiss) .. "]";
local u12 = v43.getValue("togglevotekick");
local u13 = nil;
local l__Timer__14 = l__Votekick__113:WaitForChild("Timer");
local u15 = 0;
local l__Votes__16 = l__Votekick__113:WaitForChild("Votes");
local u17 = 0;
local u18 = 0;
function v12.votestep()
	if u12 and u13 then
		l__Votekick__113.Visible = true;
		l__Timer__14.Text = "Time left: 0:" .. string.format("%.2d", (u15 - v41.getTime()) % 60);
		l__Votes__16.Text = "Votes: " .. u17 .. " out of " .. u18 .. " required";
		if not (u15 <= v41.getTime()) and not (u18 <= u17) then
			return;
		end;
	else
		l__Votekick__113.Visible = false;
		return;
	end;
	u13 = false;
	l__Votekick__113.Visible = false;
end;
local u19 = nil;
local l__Choice__20 = l__Votekick__113:WaitForChild("Choice");
function v12.vote(p18, p19)
	if u13 and not u19 then
		l__Yes__114.Visible = false;
		l__No__115.Visible = false;
		l__Dismiss__116.Visible = false;
		l__Choice__20.Visible = true;
		u19 = true;
		if p19 == "yes" then
			l__Choice__20.Text = "Voted Yes";
			l__Choice__20.TextColor3 = l__Yes__114.TextColor3;
		elseif p19 == "dismiss" then
			l__Choice__20.Text = "Vote Dismissed";
			l__Choice__20.TextColor3 = l__Dismiss__116.TextColor3;
			u13 = false;
			l__Votekick__113.Visible = false;
		else
			l__Choice__20.Text = "Voted No";
			l__Choice__20.TextColor3 = l__No__115.TextColor3;
		end;
		v21:send("votefromUI", p19);
	end;
end;
local l__Title__21 = l__Votekick__113:WaitForChild("Title");
v21:add("startvotekick", function(p20, p21, p22)
	if u12 then
		l__Title__21.Text = "Votekick " .. p20 .. " out of the server?";
		l__Votekick__113.Visible = true;
		l__Yes__114.Visible = true;
		l__No__115.Visible = true;
		l__Dismiss__116.Visible = true;
		l__Choice__20.Visible = false;
		u18 = p22;
		u17 = 0;
		u15 = v41.getTime() + p21;
		u13 = true;
		u19 = false;
		v12.votestep();
	end;
end);
v21:add("updatenumvotes", function(p23)
	u17 = p23;
end);
v44.onSettingChanged:connect(function(p24, p25)
	if p24 == "togglevotekick" then
		u12 = p25;
	end;
end);
local u22 = {};
function v12.streamermode()
	if not v43.getValue("togglestreamermode") then
		return;
	end;
	return v12.streamermodetoggle;
end;
function v12.updatehealth(p26, p27)
	local v117 = u22[p26];
	if not v117 then
		v117 = {
			health0 = 0, 
			healtick0 = 0, 
			alive = false, 
			healrate = 0.25, 
			maxhealth = 100, 
			healwait = 8
		};
		u22[p26] = v117;
	end;
	v117.alive = p27.alive;
	v117.health0 = p27.health0;
	v117.healtick0 = p27.healtick0;
end;
v21:add("updateothershealth", function(p28, p29, p30, p31)
	local v118 = u22[p28];
	if not v118 then
		v118 = {
			health0 = 0, 
			healtick0 = 0, 
			alive = false, 
			healrate = 0.25, 
			maxhealth = 100, 
			healwait = 8
		};
		u22[p28] = v118;
	end;
	v118.health0 = p29;
	v118.healtick0 = p30;
	v118.alive = p31;
end);
local u23 = {
	ammohud = {
		gui = l__AmmoHud__87, 
		enabled = true
	}, 
	radar = {
		gui = l__Radar__93, 
		enabled = true
	}, 
	killfeed = {
		gui = l__Killfeed__94, 
		enabled = true
	}, 
	crossframe = {
		gui = l__CrossHud__84, 
		enabled = true
	}, 
	round = {
		gui = l__Round__97, 
		enabled = true
	}
};
local u24 = l__Killfeed__94;
v21:add("killfeed", function(p32, p33, p34, p35, p36)
	if u23.killfeed.enabled then
		local v119 = v36.getscale();
		local v120 = u8:Clone();
		v120.Parent = u24;
		if v12.streamermode() then
			v120.Text = "Player";
			v120.Victim.Text = "Player";
		else
			v120.Text = p32.Name;
			v120.Victim.Text = p33.Name;
		end;
		v120.TextColor = p32.TeamColor;
		v120.GunImg.Text = p35;
		v120.Victim.TextColor = p33.TeamColor;
		v120.GunImg.Dist.Text = "Dist: " .. p34 .. " studs";
		v120.GunImg.Size = UDim2.new(0, v120.GunImg.TextBounds.x / v119, 0, 30);
		v120.GunImg.Position = UDim2.new(0, 15 + v120.TextBounds.x / v119, 0, -5);
		v120.Victim.Position = UDim2.new(0, 30 + v120.TextBounds.x / v119 + v120.GunImg.TextBounds.x / v119, 0, 0);
		if p36 then
			local v121 = u1:Clone();
			v121.Parent = v120.Victim;
			v121.Position = UDim2.new(0, 10 + v120.Victim.TextBounds.x / v119, 0, -5);
		end;
		task.spawn(function()
			v120.Visible = true;
			task.wait(20);
			for v122 = 1, 10 do
				if v120.Parent then
					v120.TextTransparency = v122 / 10;
					v120.TextStrokeTransparency = v122 / 10 + 0.5;
					v120.GunImg.TextStrokeTransparency = v122 / 10 + 0.5;
					v120.GunImg.TextTransparency = v122 / 10;
					v120.Victim.TextStrokeTransparency = v122 / 10 + 0.5;
					v120.Victim.TextTransparency = v122 / 10;
					task.wait(0.03333333333333333);
				end;
			end;
			if v120 and v120.Parent then
				v120:Destroy();
			end;
		end);
		local v123 = u24:GetChildren();
		for v124 = 1, #v123 do
			v123[v124]:TweenPosition(UDim2.new(0.01, 5, 1, (v124 - #v123) * 25 - 25), "Out", "Sine", 0.2, true);
			if #v123 > 5 and #v123 - v124 >= 5 then
				task.spawn(function()
					local v125 = v123[1];
					if v125.Name ~= "Deleted" then
						for v126 = 1, 10 do
							if v125:FindFirstChild("Victim") then
								v125.TextTransparency = v126 / 10;
								v125.TextStrokeTransparency = v126 / 10 + 0.5;
								v125.Victim.TextTransparency = v126 / 10;
								v125.Victim.TextStrokeTransparency = v126 / 10 + 0.5;
								v125.Name = "Deleted";
								v125.GunImg.TextTransparency = v126 / 10;
								v125.GunImg.TextStrokeTransparency = v126 / 10 + 0.5;
								task.wait(0.03333333333333333);
							end;
						end;
						v125:Destroy();
					end;
				end);
			end;
		end;
	end;
end);
local v127 = BrickColor.new("Bright blue");
local v128 = BrickColor.new("Bright orange");
local u25 = {
	caplight = nil, 
	[v127.Name] = {
		revealtime = 0, 
		droptime = 0, 
		carrier = nil, 
		carrymodel = nil, 
		dropmodel = nil, 
		dropped = false, 
		basecf = CFrame.new()
	}, 
	[v128.Name] = {
		revealtime = 0, 
		droptime = 0, 
		carrier = nil, 
		carrymodel = nil, 
		dropmodel = nil, 
		dropped = false, 
		basecf = CFrame.new()
	}
};
local u26 = { v127, v128 };
local function u27(p37, p38)
	local v129 = u25[p37.Name];
	v129.revealtime = 0;
	v129.carrier = nil;
	if p38 == u2 and u25.caplight and u25.caplight.Parent then
		u25.caplight:Destroy();
		u25.caplight = nil;
		return;
	end;
	if v129.carrymodel and v129.carrymodel.Parent then
		v129.carrymodel:Destroy();
		v129.carrymodel = nil;
	end;
end;
local u28 = l__ReplicatedStorage__81.GamemodeProps.FlagDrop;
local u29 = v127;
local u30 = v128;
local u31 = l__ReplicatedStorage__81.GamemodeProps.FlagCarry;
function v12.nearenemyflag(p39, p40)
	local v130 = p40.TeamColor == u29 and u30 or u29;
	if u25[v130.Name] and u25[v130.Name].basecf then
		local v131 = v12:getplayerpos(p40);
		if v131 and (u25[v130.Name].basecf.p - v131).Magnitude < 100 then
			return true;
		end;
	end;
	return false;
end;
local u32 = l__GameGui__82:WaitForChild("Captured");
local u33 = l__GameGui__82:WaitForChild("Revealed");
local u34 = l__ReplicatedStorage__81.ServerSettings.GameMode;
local function u35(p41)
	if not p41 or not p41.Parent or not v14.getbodyparts then
		return;
	end;
	local v132 = p41.TeamColor == u29 and u30 or u29;
	local v133 = v14.getbodyparts(p41);
	if v133 and v133.torso then
		local v134 = u31:Clone();
		v134.Tag.BrickColor = v132;
		v134.Tag.BillboardGui.Display.BackgroundColor3 = v132.Color;
		v134.Tag.BillboardGui.AlwaysOnTop = false;
		v134.Base.PointLight.Color = v132.Color;
		local v135, v136, v137 = v134:GetChildren();
		while true do
			local v138, v139 = v135(v136, v137);
			if not v138 then
				break;
			end;
			if v139 ~= v134.Base then
				local v140 = Instance.new("Weld");
				v140.Part0 = v134.Base;
				v140.Part1 = v139;
				v140.C0 = v134.Base.CFrame:inverse() * v139.CFrame;
				v140.Parent = v134.Base;
			end;
			if v139:IsA("BasePart") then
				v139.Massless = true;
				v139.CastShadow = false;
				v139.Anchored = false;
				v139.CanCollide = false;
			end;		
		end;
		local v141 = Instance.new("Weld");
		v141.Part0 = v133.torso;
		v141.Part1 = v134.Base;
		v141.Parent = v134.Base;
		v134.Parent = workspace.Ignore.Misc;
		u25[v132.Name].carrymodel = v134;
	end;
end;
local u36 = l__GameGui__82:WaitForChild("EnemyTags");
local u37 = l__GameGui__82:WaitForChild("TeamTags");
local u38 = 0;
local u39 = 0;
function v12.gamemodestep()
	u32.Visible = false;
	u33.Visible = false;
	if u34.Value == "Capture the Flag" then
		local v142 = u2.TeamColor == u29 and u30 or u29;
		if u25[v142.Name].carrier == u2 and u25[v142.Name].revealtime then
			u32.Visible = true;
			u32.Text = "Capturing Enemy Flag!";
			u33.Visible = true;
			local l__revealtime__143 = u25[v142.Name].revealtime;
			if v41.getTime() < l__revealtime__143 then
				u33.Text = "Position revealed in " .. math.ceil(l__revealtime__143 - v41.getTime()) .. " seconds";
			else
				u33.Text = "Flag position revealed to all enemies!";
			end;
		end;
		for v144, v145 in u26, nil do
			local v146 = u25[v145.Name];
			if v146.carrier and v146.carrier ~= u2 then
				if not v146.carrier.Parent then
					u27(v145, nil);
				end;
				if not v146.carrymodel then
					u35(v146.carrier);
				end;
				if v146.carrymodel and v146.carrymodel.Parent and v146.revealtime then
					local l__BillboardGui__147 = v146.carrymodel.Tag.BillboardGui;
					if u2.TeamColor == v146.carrier.TeamColor then
						local v148 = "Capturing!";
					else
						v148 = "Stolen!";
					end;
					local v149 = true;
					if u2.TeamColor ~= v146.carrier.TeamColor then
						v149 = v146.revealtime < v41.getTime();
					end;
					l__BillboardGui__147.AlwaysOnTop = v149;
					l__BillboardGui__147.Distance.Text = v148;
				end;
			end;
		end;
	end;
	if u34.value ~= "Tag Run" then
		u36.Visible = false;
		u37.Visible = false;
		return;
	end;
	u36.Visible = true;
	u37.Visible = true;
	u37.Text = u38 .. " Friendly Tags";
	u36.Text = u39 .. " Enemy Tags";
end;
local u40 = 0;
local u41 = math.pi / 180;
function v12.gamemoderenderstep()
	u40 = u40 + 1;
	if u34.Value == "Capture the Flag" then
		for v150, v151 in workspace.Ignore.GunDrop() do
			if v151.Name == "FlagDrop" then
				v151:SetPrimaryPartCFrame(v151.Location.Value * CFrame.new(0, 0.2 * math.sin(u40 * 5 * u41), 0) * CFrame.Angles(0, u40 * 4 * u41, 0));
				if u25[v151.TeamColor.Value.Name].dropped then
					local l__BillboardGui__152 = v151.Base:FindFirstChild("BillboardGui");
					local l__droptime__153 = u25[v151.TeamColor.Value.Name].droptime;
					if l__BillboardGui__152 and l__droptime__153 and v41.getTime() < l__droptime__153 + 60 then
						if u2.TeamColor ~= v151.TeamColor.Value then
							local v154 = "Pick up in: ";
						else
							v154 = "Returning in:";
						end;
						l__BillboardGui__152.Status.Text = v154 .. math.floor(l__droptime__153 + 60 - v41.getTime());
					end;
				end;
			end;
		end;
	end;
end;
v12.attachflag = u35;
local u42 = l__ReplicatedStorage__81.GamemodeProps.FlagDrop.Base.PointLight;
v21:add("stealflag", function(p42, p43)
	local v155 = p42.TeamColor == u29 and u30 or u29;
	u25[v155.Name].revealtime = p43;
	u25[v155.Name].carrier = p42;
	if u25[v155.Name].dropmodel then
		u25[v155.Name].dropmodel:Destroy();
		u25[v155.Name].dropmodel = nil;
	end;
	if p42 ~= u2 or not v10.rootpart then
		u35(p42);
		return;
	end;
	u25.caplight = u42:Clone();
	u25.caplight.Color = v155.Color;
	u25.caplight.Parent = v10.rootpart;
end);
v21:add("updateflagrecover", function(p44, p45, p46)
	local v156 = u25[p44.Name];
	if v156.dropmodel then
		local l__IsCapping__157 = v156.dropmodel:FindFirstChild("IsCapping");
		local l__CapPoint__158 = v156.dropmodel:FindFirstChild("CapPoint");
		if l__IsCapping__157 and l__CapPoint__158 then
			l__IsCapping__157.Value = p45;
			l__CapPoint__158.Value = p46;
		end;
	end;
end);
local function u43(p47, p48, p49, p50)
	local v159 = u25[p47.Name];
	if v159.dropmodel and v159.dropmodel.Parent then
		local v160 = v159.dropmodel;
	else
		v160 = u28:Clone();
	end;
	local l__Base__161 = v160:FindFirstChild("Base");
	if not l__Base__161 then
		print("no base", v160);
		return;
	end;
	local l__BillboardGui__162 = l__Base__161:FindFirstChild("BillboardGui");
	v160:FindFirstChild("Tag").BrickColor = p47;
	v160.TeamColor.Value = p47;
	l__BillboardGui__162.Display.BackgroundColor = p47;
	l__Base__161:FindFirstChild("PointLight").Color = p47.Color;
	if p47 == u2.TeamColor then
		if p50 then
			local v163 = "Protect";
		else
			v163 = "Dropped";
		end;
		l__BillboardGui__162.Status.Text = v163;
	else
		if p50 then
			local v164 = "Capture";
		else
			v164 = "Pick Up";
		end;
		l__BillboardGui__162.Status.Text = v164;
	end;
	v160:SetPrimaryPartCFrame(p48);
	v160.Location.Value = p48;
	v160.Parent = workspace.Ignore.GunDrop;
	v159.dropmodel = v160;
	v159.droptime = p49;
	v159.dropped = not p50;
	if p50 then
		u25[p47.Name].basecf = p48;
	end;
end;
v21:add("dropflag", function(p51, p52, p53, p54, p55)
	u43(p51, p53, p54, p55);
	u27(p51, p52);
end);
v21:add("updatetags", function(p56, p57)
	u39 = p56 and 0;
	u38 = p57 and 0;
end);
local function u44()
	for v165, v166 in u26, nil do
		u27(v166);
		local v167 = u25[v166.Name];
		if v167 and v167.dropmodel then
			v167.dropmodel:Destroy();
			v167.dropmodel = nil;
		end;
	end;
end;
v21:add("getrounddata", function(p58)
	print("received game round data");
	local l__ServerSettings__168 = game.ReplicatedStorage.ServerSettings;
	if l__ServerSettings__168.AllowSpawn.Value and l__ServerSettings__168.GameMode.Value == "Capture the Flag" and p58.ctf then
		for v169, v170 in u26, nil do
			local v171 = p58.ctf[v170.Name];
			if v171 and u25[v170.Name] then
				u25[v170.Name].basecf = v171.basecf;
				if v171.carrier and not v171.dropped then
					u25[v170.Name].carrier = v171.carrier;
					u25[v170.Name].revealtime = v171.revealtime;
					u35(v171.carrier);
				elseif v171.dropped then
					u25[v170.Name].dropped = true;
					u43(v170, v171.dropcf, v171.droptime, false);
				else
					u25[v170.Name].dropped = false;
					u43(v170, v171.basecf, v171.droptime, true);
				end;
			end;
		end;
	end;
end);
v22.Reset:connect(function()
	print("Clearing map");
	workspace.Ignore.GunDrop:ClearAllChildren();
	u44();
end);
u41 = function(p59)
	local v172 = nil;
	local v173 = u22[p59];
	if not v173 then
		v173 = {
			health0 = 0, 
			healtick0 = 0, 
			alive = false, 
			healrate = 0.25, 
			maxhealth = 100, 
			healwait = 8
		};
		u22[p59] = v173;
	end;
	if not v173 then
		return 0, 100;
	end;
	v172 = v173.health0;
	local l__maxhealth__174 = v173.maxhealth;
	if not v173.alive then
		return 0, l__maxhealth__174;
	end;
	local v175 = v41.getTime() - v173.healtick0;
	if v175 < 0 then
		return v172, l__maxhealth__174;
	end;
	local v176 = v172 + v175 * v175 * v173.healrate;
	return v176 < l__maxhealth__174 and v176 or l__maxhealth__174, l__maxhealth__174;
end;
u34 = l__ScopeFrame__88.SightFront;
u42 = l__ScopeFrame__88.SightRear;
u31 = u42.ReticleImage;
u28 = function(p60, p61, p62, p63)
	u34.Position = p60;
	u42.Position = p61;
	u34.Size = p62;
	u42.Size = p63;
end;
v12.updatescope = u28;
u28 = function(p64, p65)
	u34.BackgroundColor3 = p65.scopelenscolor or Color3.new(0, 0, 0);
	u34.BackgroundTransparency = p65.scopelenstrans and 1;
	local v177 = p65.scopeimagesize and 1;
	u31.Image = p65.scopeid;
	u31.ImageColor3 = p65.sightcolor and Color3.new(p65.sightcolor.r / 255, p65.sightcolor.g / 255, p65.sightcolor.b / 255) or (p65.scopecolor or Color3.new(1, 1, 1));
	u31.Size = UDim2.new(v177, 0, v177, 0);
	u31.Position = UDim2.new((1 - v177) / 2, 0, (1 - v177) / 2, 0);
end;
v12.setscopesettings = u28;
u34 = os.clock;
u34 = u34();
local u45 = {};
local u46 = l__Use__96;
u42 = function(p66, p67, p68)
	if p67 then
		local v178 = v42.getWeaponData(p68);
		if v178 then
			local l__currentgun__179 = u45.currentgun;
			if not l__currentgun__179 then
				return;
			end;
			if v32.getInputType() == "controller" then
				local v180 = "Hold Y";
			else
				v180 = "Hold V";
			end;
			u46.Text = v180 .. " to pick up [" .. (v178.displayname and p68) .. "]";
			if v178.type == l__currentgun__179.type or v178.ammotype == l__currentgun__179.ammotype then
				local v181 = os.clock();
				if u34 < v181 then
					local v182, v183 = l__currentgun__179:dropguninfo();
					if v183 and v183 < l__currentgun__179.sparerounds then
						u34 = v181 + 1;
						v21:send("getammo", p67);
						return;
					end;
				end;
			end;
		end;
	else
		u46.Text = "";
	end;
end;
v12.gundrop = u42;
u42 = function(p69)
	return u46.Text ~= "";
end;
v12.getuse = u42;
local u47 = l__GameGui__82;
u42 = function(p70, p71)
	u47.Visible = p71;
end;
v12.enablegamegui = u42;
u42 = function(p72, p73, p74)
	local v184 = u23[p73];
	if not v184 then
		warn("hud object not found");
		return;
	end;
	p74 = p74;
	v184.gui.Visible = p74;
	v184.enabled = p74;
end;
v12.togglehudobj = u42;
u42 = function(p75, p76)
	local v185 = nil;
	if p76 then
		v185 = v14.getupdater(p76);
		if not v185 then
			return;
		end;
	else
		return;
	end;
	return v185.isalive();
end;
v12.isplayeralive = u42;
local u48 = {};
u42 = function(p77, p78)
	return v41.getTime() - (u48[p78] and 0);
end;
v12.timesinceplayercombat = u42;
u42 = function(p79, p80)
	if not v12:isplayeralive(p80) then
		return;
	end;
	return v14.getupdater(p80).getpos();
end;
v12.getplayerpos = u42;
u42 = function(p81, p82)
	return u41(p82);
end;
v12.getplayerhealth = u42;
u42 = "Cross";
local u49 = nil;
local u50 = nil;
local u51 = v86;
u31 = function(p83, p84, p85, p86, p87, p88, p89)
	v12.crossspring.t = p85;
	v12.crossspring.s = p86;
	v12.crossspring.d = p87;
	u49 = p88;
	u50 = p89;
	if p84 ~= "SHOTGUN" then
		u42 = "Cross";
		for v186 = 1, 4 do
			for v187, v188 in u51[v186]() do
				v188.Visible = false;
			end;
		end;
		return;
	end;
	u42 = "Shot";
	for v189 = 1, 4 do
		for v190, v191 in u51[v189]() do
			if v191.Name == u42 then
				v191.Visible = true;
			end;
		end;
	end;
end;
v12.setcrosssettings = u31;
u31 = function(p90, p91, p92)
	u49 = p91;
	u50 = p92;
end;
v12.updatesightmark = u31;
local u52 = nil;
u31 = function(p93, p94)
	u52 = p94;
end;
v12.updatescopemark = u31;
local u53 = l__Sprint__85;
local u54 = l__Hitmarker__89;
u31 = function()
	if not v10.speed or not v10.sprint or not u23.crossframe.enabled then
		return;
	end;
	local v192 = v12.crossspring.p * 2 * v12.crossscale.p * (v10.speed / 14 * 0.19999999999999996 * 2 + 0.8) * (v10.sprint / 2 + 1);
	u53.Visible = false;
	if u42 == "Cross" then
		u51[1].BackgroundTransparency = 1 - v192 / 20;
		u51[2].BackgroundTransparency = 1 - v192 / 20;
		u51[3].BackgroundTransparency = 1 - v192 / 20;
		u51[4].BackgroundTransparency = 1 - v192 / 20;
	else
		for v193 = 1, 4 do
			u51[v193].BackgroundTransparency = 1;
			for v194, v195 in u51[v193]() do
				if v195.Name == u42 then
					v195.BackgroundTransparency = 1 - v192 / 20 * (v192 / 20);
				end;
			end;
		end;
	end;
	u51[1].Position = UDim2.new(0, v192, 0, 0);
	u51[2].Position = UDim2.new(0, -v192 - 7, 0, 0);
	u51[3].Position = UDim2.new(0, 0, 0, v192);
	u51[4].Position = UDim2.new(0, 0, 0, -v192 - 7);
	local v196 = u3();
	if not u50 and v12.crossspring.t == 0 and u49 and u49.Parent then
		local v197 = v28.currentcamera:WorldToViewportPoint(u49.Position);
		u54.Position = UDim2.new(0, v197.x / v196 - 125, 0, v197.y / v196 - 125);
		return;
	end;
	u54.Position = UDim2.new(0.5, -125, 0.5, -125);
end;
local u55 = {};
u28 = function(p95, p96)
	local v198 = u55[p96];
	if not v198 then
		return;
	end;
	return v198.Visible;
end;
v12.getplayervisible = u28;
u29 = game;
u26 = "GuiService";
u30 = u29;
u29 = u29.GetService;
u29 = u29(u30, u26);
u30 = u29;
u29 = u29.IsTenFootInterface;
u29 = u29(u30);
if u29 then
	u28 = -36;
else
	u28 = 0;
end;
u29 = {};
local u56 = l__NameTag__90;
local u57 = {};
u30 = function(p97)
	if p97 == u2 then
		return;
	end;
	local v199 = {};
	u29[p97] = v199;
	local u58 = nil;
	local u59 = nil;
	local function u60(p98)
		if p98 == "TeamColor" and u58 and u58.Parent then
			if p97.TeamColor == u2.TeamColor then
				u58.Visible = true;
				u59.Visible = false;
				u58.TextColor3 = Color3.new(0, 1, 0.9176470588235294);
				u58.Dot.BackgroundTransparency = 1;
				u58.Dot.Rotation = 90;
				u58.Dot.Size = UDim2.new(0, 6, 0, 6);
				return;
			end;
			u58.Visible = false;
			u59.Visible = false;
			u58.TextColor3 = Color3.new(1, 0.0392156862745098, 0.0784313725490196);
			u58.Dot.BackgroundTransparency = 1;
			u58.Dot.Rotation = 45;
			u58.Dot.Size = UDim2.new(0, 4, 0, 4);
		end;
	end;
	u58 = u10:Clone();
	u58.Text = p97.Name;
	u58.Visible = false;
	u59 = u58:WaitForChild("Health");
	u58.Dot.BackgroundTransparency = 1;
	u58.TextTransparency = 1;
	u58.TextStrokeTransparency = 1;
	u58.Parent = u56;
	u60("TeamColor");
	u55[p97] = u58;
	v199[#v199 + 1] = p97.Changed:connect(u60);
	v199[#v199 + 1] = u2.Changed:connect(u60);
	u57[p97] = function()
		if not u58.Parent or not u59.Parent then
			return;
		end;
		if v12:isplayeralive(p97) then
			local v200, v201 = v14.getupdater(p97).getpos();
			if v200 and v201 then
				if not v27.sphere(v200, 4) then
					u58.Visible = false;
					u59.Visible = false;
					return;
				end;
				local l__cframe__202 = v28.cframe;
				local v203 = v28.currentcamera:WorldToScreenPoint(v201 + l__cframe__202:VectorToWorldSpace(Vector3.new(0, 0.625, 0)));
				local v204 = v28.lookvector:Dot((v200 - l__cframe__202.Position).unit);
				local v205 = (1 / (v204 * v204) - 1) ^ 0.5 * (v200 - l__cframe__202.Position).magnitude;
				u58.Position = UDim2.new(0, v203.x - 75, 0, v203.y + u28);
				if v12.streamermode() then
					u58.Text = "Player";
				else
					u58.Text = p97.Name;
				end;
				if p97.TeamColor == u2.TeamColor then
					u58.Visible = true;
					u59.Visible = true;
					u58.TextColor3 = Color3.new(0, 1, 0.9176470588235294);
					u58.Dot.BackgroundColor3 = Color3.new(0, 1, 0.9176470588235294);
					local v206 = u22[p97];
					if not v206 then
						v206 = {
							health0 = 0, 
							healtick0 = 0, 
							alive = false, 
							healrate = 0.25, 
							maxhealth = 100, 
							healwait = 8
						};
						u22[p97] = v206;
					end;
					if v206 then
						local l__health0__207 = v206.health0;
						local l__maxhealth__208 = v206.maxhealth;
						if v206.alive then
							local v209 = v41.getTime() - v206.healtick0;
							if v209 < 0 then
								local v210 = l__health0__207;
								local v211 = l__maxhealth__208;
							else
								local v212 = l__health0__207 + v209 * v209 * v206.healrate;
								v210 = v212 < l__maxhealth__208 and v212 or l__maxhealth__208;
								v211 = l__maxhealth__208;
							end;
						else
							v210 = 0;
							v211 = l__maxhealth__208;
						end;
					else
						v210 = 0;
						v211 = 100;
					end;
					if v205 < 4 then
						u58.TextTransparency = 0.125;
						u59.BackgroundTransparency = 0.75;
						u59.Percent.BackgroundTransparency = 0.25;
						u59.Percent.Size = UDim2.new(v210 / v211, 0, 1, 0);
						u58.Dot.BackgroundTransparency = 1;
						return;
					elseif v205 < 8 then
						u58.TextTransparency = 0.125 + 0.875 * (v205 - 4) / 4;
						u59.BackgroundTransparency = 0.75 + 0.25 * (v205 - 4) / 4;
						u59.Percent.BackgroundTransparency = 0.25 + 0.75 * (v205 - 4) / 4;
						u59.Percent.Size = UDim2.new(v210 / v211, 0, 1, 0);
						u58.Dot.BackgroundTransparency = 1;
						return;
					else
						u58.Dot.BackgroundTransparency = 0.125;
						u58.TextTransparency = 1;
						u59.BackgroundTransparency = 1;
						u59.Percent.BackgroundTransparency = 1;
						return;
					end;
				else
					u58.Dot.BackgroundTransparency = 1;
					u59.Visible = false;
					u58.TextColor3 = Color3.new(1, 0.0392156862745098, 0.0784313725490196);
					u58.Dot.BackgroundColor3 = Color3.new(1, 0.0392156862745098, 0.0784313725490196);
					if v12:isspotted(p97) and v12:isinsight(p97) then
						u58.Visible = true;
						if v205 < 4 then
							u58.TextTransparency = 0;
							return;
						else
							u58.TextTransparency = 1;
							u58.Dot.BackgroundTransparency = 0;
							return;
						end;
					end;
					if not (not v12:isspotted(p97)) or not (v205 < 4) then
						u58.Visible = false;
						u59.Visible = false;
						return;
					end;
					local l__p__213 = v28.cframe.p;
					local v214 = not workspace:FindPartOnRayWithWhitelist(Ray.new(l__p__213, v200 - l__p__213), v15.raycastwhitelist);
					u58.Visible = v214;
					if v214 then
						if v205 < 2 then
							u58.Visible = true;
							u58.TextTransparency = 0.125;
							return;
						elseif v205 < 4 then
							u58.Visible = true;
							u58.TextTransparency = 0.4375 * v205 - 0.75;
							return;
						else
							u58.Visible = false;
							return;
						end;
					end;
				end;
			end;
		else
			u58.Visible = false;
			u59.Visible = false;
		end;
	end;
end;
v12.addnametag = u30;
u26 = function(p99)
	u57[p99] = nil;
	if u55[p99] then
		u55[p99]:Destroy();
	end;
	u55[p99] = nil;
end;
v12.removenametag = u26;
u32 = game;
u37 = "Players";
u33 = u32;
u32 = u32.GetService;
u32 = u32(u33, u37);
u26 = u32.PlayerAdded;
u33 = u30;
u32 = u26;
u26 = u26.connect;
u26(u32, u33);
u32 = game;
u37 = "Players";
u33 = u32;
u32 = u32.GetService;
u32 = u32(u33, u37);
u26 = u32.PlayerRemoving;
u33 = function(p100)
	u22[p100] = nil;
	u48[p100] = nil;
	v12.removenametag(p100);
	local v215 = u29[p100];
	if v215 then
		for v216 = 1, #v215 do
			v215[v216]:Disconnect();
			v215[v216] = nil;
		end;
		u29[p100] = nil;
	end;
end;
u32 = u26;
u26 = u26.connect;
u26(u32, u33);
u26 = game;
u33 = "Players";
u32 = u26;
u26 = u26.GetService;
u26 = u26(u32, u33);
u32 = u26;
u26 = u26.GetPlayers;
u26, u32, u33 = u26(u32);
while true do
	u37 = u26;
	u36 = u32;
	u37, u36 = u37(u36, u33);
	if not u37 then
		break;
	end;
	u33 = u37;
	u30(u36);
end;
u28 = function()
	for v217, v218 in u57, nil do
		if not v217 or not v217.Parent then
			u57[v217] = nil;
			if u55[v217] then
				u55[v217]:Destroy();
			end;
			u55[v217] = nil;
		else
			u57[v217]();
		end;
	end;
end;
local u61 = l__Capping__91;
u29 = function(p101, p102, p103, p104)
	if p104 == "ctf" then
		local v219 = 100;
	else
		v219 = 50;
	end;
	if not p102 then
		u61.Visible = false;
		return;
	end;
	u61.Visible = true;
	if p104 == "ctf" then
		local v220 = "Recovering...";
	else
		v220 = "Capturing...";
	end;
	u61.Note.Text = v220;
	l__Percent__112.Size = UDim2.new(p103 / v219, 0, 1, 0);
end;
v12.capping = u29;
local u62 = l__Bar__100;
u29 = function(p105, p106)
	u62.Size = p106;
end;
v12.setsteadybar = u29;
u29 = function(p107)
	return u62.Size.X.Scale;
end;
v12.getsteadysize = u29;
u29 = function(p108, p109)
	v12.crossscale.t = p109;
end;
v12.setcrossscale = u29;
u29 = function(p110, p111)
	v12.crossspring.t = p111;
end;
v12.setcrosssize = u29;
u29 = nil;
u30 = nil;
u26 = nil;
local u63 = l__ScopeFrame__88;
local u64 = l__Steady__95;
u32 = function(p112, p113, p114)
	v28.setdirectlookmode(p113);
	u63.Visible = p113;
	u64.Visible = p113 and not p114;
	if v32.getInputType() == "controller" then
		local v221 = "Tap LS to Toggle Steady Scope";
	else
		v221 = "Hold Shift to Steady Scope";
	end;
	u64.Text = v221;
	if p113 then
		v38.play("useScope", 0.25);
		u26 = true;
		task.delay(0.5, u29);
	end;
	if not p113 then
		u26 = false;
	end;
end;
v12.setscope = u32;
u29 = function()
	if u26 then
		local v222 = v12:getsteadysize() / 5;
		v38.play("heartBeatIn", 0.05 + v222);
		task.delay(0.3 + v222, u30);
	end;
end;
u30 = function()
	if u26 then
		local v223 = v12:getsteadysize() / 4;
		v38.play("heartBeatOut", 0.05 + v223);
		task.delay(0.5 + v223, u29);
	end;
end;
local u65 = l__Ammo__104;
function v12.updateammo(p115, p116, p117)
	if p116 == "KNIFE" then
		u65.Text = "- - -";
		l__Mag__106.Text = "- - -";
		return;
	end;
	if p116 ~= "GRENADE" then
		u65.Text = p117;
		l__Mag__106.Text = p116;
		return;
	end;
	u65.Text = "- - -";
	l__Mag__106.Text = "- - -";
	l__GAmmo__105.Text = u45.gammo .. "x";
end;
function v12.updatefiremode(p118, p119)
	if p119 == "KNIFE" then
		local v224 = "- - -";
	elseif p119 == true then
		v224 = "AUTO";
	elseif p119 == 1 then
		v224 = "SEMI";
	elseif p119 == "BINARY" then
		v224 = "BINARY";
	else
		v224 = "BURST";
	end;
	l__FMode__108.Text = v224;
end;
function v12.firehitmarker(p120, p121)
	v12.hitspring.p = -3;
	if p121 then
		u54.ImageColor3 = Color3.new(1, 0, 0);
		return;
	end;
	u54.ImageColor3 = Color3.new(1, 1, 1);
end;
local l__MiniMapModels__225 = l__ReplicatedStorage__81:WaitForChild("MiniMapModels");
local l__Radar__226 = u47:WaitForChild("Radar");
local l__X__227 = u5.AbsoluteSize.X;
local l__Y__228 = u5.AbsoluteSize.Y;
local l__X__229 = l__Radar__226.AbsoluteSize.X;
local l__Y__230 = l__Radar__226.AbsoluteSize.Y;
local l__Me__231 = l__Radar__226:WaitForChild("Me");
l__Me__231.Size = UDim2.new(0, 16, 0, 16);
l__Me__231.Position = UDim2.new(0.5, -8, 0.5, -8);
function v12.reset_minimap(p122)

end;
local l__Map__66 = workspace:FindFirstChild("Map");
local u67 = nil;
local u68 = nil;
local u69 = nil;
local l__MiniMapFrame__70 = u47:WaitForChild("MiniMapFrame");
local u71 = nil;
local u72 = l__ReplicatedStorage__81.ServerSettings:WaitForChild("MapName");
local u73 = l__MiniMapModels__225;
local u74 = nil;
local u75 = l__MiniMapModels__225:WaitForChild("Temp");
function v12.set_minimap(p123)
	if l__Map__66 then
		u67 = l__Map__66.PrimaryPart;
		u68 = l__Map__66:FindFirstChild("AGMP");
		u69 = l__MiniMapFrame__70:FindFirstChild("Camera") or Instance.new("Camera");
		u69.FieldOfView = 45;
		l__MiniMapFrame__70.CurrentCamera = u69;
		u69.Parent = l__MiniMapFrame__70;
		if u71 and u71.Name == u72.Value then
			return;
		end;
	else
		print("Did not find map");
		return;
	end;
	if u71 then
		u71:Destroy();
	end;
	local v232 = u73:FindFirstChild(u72.Value);
	if v232 then
		u71 = v232:Clone();
		u71.Parent = l__MiniMapFrame__70;
		u74 = u71.PrimaryPart;
		return;
	end;
	u71 = u75:Clone();
	u71.Parent = l__MiniMapFrame__70;
	u74 = u71.PrimaryPart;
end;
local u76 = nil;
local u77 = {
	players = {}, 
	objectives = {}, 
	rings = {}
};
local u78 = {
	lightred = Color3.new(0.7843137254901961, 0.19607843137254902, 0.19607843137254902), 
	lightblue = Color3.new(0, 0.7843137254901961, 1), 
	green = Color3.new(0, 1, 0.2), 
	red = Color3.new(1, 0, 0)
};
local l__Folder__79 = l__Radar__226:WaitForChild("Folder");
local u80 = {
	players = l__Me__231, 
	objectives = l__Radar__226:WaitForChild("Objective")
};
local function u81(p124)
	local v233, v234 = u69:WorldToViewportPoint((u67.CFrame:inverse() * p124).p * 0.2 + u74.Position);
	local v235 = v233.X;
	local v236 = v233.Y;
	local v237 = 0.5 - v236;
	local v238 = math.atan((v235 - 0.5) / v237) * 180 / math.pi;
	if v237 < 0 then
		v238 = v238 - 180;
	end;
	if v235 > 1 then
		v235 = 1;
	end;
	if v235 < 0 then
		v235 = 0;
	end;
	if v236 > 1 then
		v236 = 1;
	end;
	if v236 < 0 then
		v236 = 0;
	end;
	return v235, v236, math.abs(p124.p.Y - u76.CFrame.p.Y), v234, v238;
end;
local function u82(p125)
	if not u77.rings[p125] then
		local v239 = l__Me__231:Clone();
		v239.Size = UDim2.new(0, 0, 0, 0);
		v239.ImageColor3 = u78.lightred;
		v239.Image = "rbxassetid://2925606552";
		v239.Height.Visible = false;
		v239.Parent = l__Folder__79;
		u77.rings[p125] = v239;
	end;
	return u77.rings[p125];
end;
local u83 = 0;
local u84 = false;
local u85 = {};
local u86 = {};
function v12.fireradar(p126, p127, p128, p129, p130)
	local v240 = p127.TeamColor ~= u2.TeamColor;
	local v241 = u85[p127];
	if not v241 and v240 then
		v241 = {
			refcf = CFrame.new(), 
			shottime = 0, 
			lifetime = 0
		};
		u85[p127] = v241;
	end;
	local v242 = u86[p127];
	if not v242 then
		v242 = {
			refcf = CFrame.new(), 
			shottime = 0, 
			lifetime = 0, 
			teamcolor = p127.TeamColor
		};
		u86[p127] = v242;
	end;
	if v12:isplayeralive(p127) then
		v242.refcf = p130;
		v242.teamcolor = p127.TeamColor;
		v242.lifetime = p129.pinglife and 0.5;
		v242.size0 = p129.size0;
		v242.size1 = p129.size1;
		if v242.shottime + v242.lifetime < v41.getTime() then
			v242.shottime = v41.getTime();
		end;
		if not p128 and v240 then
			v241.refcf = p130;
			v241.lifetime = 5;
			v241.shottime = v41.getTime();
		end;
	end;
end;
local u87 = 0;
function v12.set_rel_height(p131)
	if u87 == 0 then
		local v243 = 1;
	else
		v243 = 0;
	end;
	u87 = v243;
end;
function v12.set_minimap_style(p132)
	u84 = not u84;
end;
local u88 = math.pi / 180;
local u89 = {};
local function u90(p133, p134, p135, p136, p137, p138, p139, p140)
	local v244, v245, v246, v247, v248 = u81(p136);
	if not u77[p139][p138] then
		local v249 = u80[p139]:Clone();
		v249.Size = UDim2.new(0, 14, 0, 14);
		v249.Parent = l__Folder__79;
		u77[p139][p138] = v249;
	end;
	local v250 = u77[p139][p138];
	local v251 = nil;
	if p139 == "players" then
		if p133 then
			local v252 = "rbxassetid://2911984939";
		else
			v252 = "rbxassetid://3116912054";
		end;
		v250.Image = v252;
		local v253 = p135 == u2.TeamColor and u78.lightblue or u78.red;
		if p134 then
			v253 = u78.green;
		end;
		v250.ImageColor3 = v253;
		v250.Height.ImageColor3 = v250.ImageColor3;
		v250.Height.Visible = not p134 or p133;
		v250.Height.ImageTransparency = p137 and 0;
		local v254, v255, v256 = p136:ToOrientation();
		local v257 = u83;
		if u84 then
			v257 = u67.Orientation.Y;
		end;
		if v247 then
			v250.Rotation = v257 - v255 * 180 / math.pi;
			v250.ImageTransparency = p137 and 0.002 * v246 ^ 2.5;
		else
			v250.Rotation = v248;
			if p133 then
				local v258 = "rbxassetid://2910531391";
			else
				v258 = "rbxassetid://3116912054";
			end;
			v250.Image = v258;
			v250.ImageTransparency = p137 and 0;
		end;
		v250.Size = UDim2.new(0, 14, 0, 14);
	elseif p139 == "objectives" then
		v251 = p135.Color;
		v250.Label.Text = p140;
		v250.Label.TextColor3 = v251;
		v250.Label.Visible = true;
	end;
	v250.ImageColor3 = v251;
	v250.Position = UDim2.new(v244, -14 / 2, v245, -14 / 2);
	v250.Visible = true;
end;
local function u91(p141, p142)
	local v259 = (v41.getTime() - p142.shottime) / p142.lifetime;
	if v259 > 1 then
		return;
	end;
	local v260, v261, v262, v263 = u81(p142.refcf);
	local v264 = u82(p141);
	local v265 = p142.size0 and 4;
	local v266 = v265 + ((p142.size1 and 30) - v265) * v259;
	v264.ImageColor3 = p142.teamcolor == u2.TeamColor and u78.lightblue or u78.lightred;
	v264.ImageTransparency = v259;
	v264.Size = UDim2.new(0, v266, 0, v266);
	v264.Position = UDim2.new(v260, -v266 / 2, v261, -v266 / 2);
	v264.Visible = true;
end;
local u92 = u23.radar;
local function u93()
	local v267 = l__Folder__79:GetChildren();
	for v268 = 1, #v267 do
		v267[v268].Visible = false;
	end;
	for v269 in u89, nil do
		if not v269.Parent then
			u89[v269] = nil;
		end;
	end;
end;
local function u94()
	local v270 = nil;
	local v271 = nil;
	if not u67 then
		return print("No map found");
	end;
	if not u74 then
		return print("No minimap found");
	end;
	u76 = v28:isspectating() or v28.currentcamera;
	if v10.alive then
		l__Me__231.Visible = true;
		l__Me__231.ImageColor3 = u78.lightblue;
	else
		l__Me__231.Visible = v28:isspectating();
		l__Me__231.ImageColor3 = u78.red;
	end;
	l__Me__231.Height.ImageColor3 = l__Me__231.ImageColor3;
	local v272 = (u67.CFrame:inverse() * u76.CFrame).p * 0.2 * Vector3.new(1, u87, 1);
	local v273, v274, v275 = v28.cframe:ToOrientation();
	u83 = v274 * 180 / math.pi;
	v271 = u67.Orientation.Y - u83;
	v270 = v272 + u74.Position;
	if u84 then
		u69.CFrame = CFrame.new(v270 + Vector3.new(0, 50, 0)) * CFrame.Angles(-90 * u88, 0, 0);
		l__Me__231.Rotation = v271;
	else
		u69.CFrame = CFrame.new(v270 + Vector3.new(0, 50, 0)) * CFrame.Angles(0, -v271 * u88, 0) * CFrame.Angles(-90 * u88, 0, 0);
		l__Me__231.Rotation = 0;
	end;
	local v276 = 0;
	local v277 = game:GetService("Players"):GetPlayers();
	for v278 = 1, #v277 do
		local v279 = nil;
		local v280 = v277[v278];
		local v281 = v14.getbodyparts(v280);
		local v282 = u89[v280];
		local v283 = u2 == v280;
		local v284 = v12:isplayeralive(v280) or v283 and v10.alive;
		if v281 then
			v279 = v281.torso;
		elseif v283 then
			v279 = v10.rootpart;
		end;
		if not v282 then
			v282 = {
				lastcf = CFrame.new(), 
				alivetick = 0
			};
			u89[v280] = v282;
		end;
		if v279 and v284 then
			v282.lastcf = v279.CFrame;
			v282.alivetick = v41.getTime();
		end;
		local v285 = nil;
		local v286 = not v283 and v280.TeamColor == u2.TeamColor;
		if not v284 then
			local v287 = (v41.getTime() - v282.alivetick) / 5;
			v285 = math.min(v287 > 0.1 and v287 ^ 0.5 or 0, 1);
			v286 = v285 ~= 1;
		elseif not v286 and v12:isspotted(v280) and v12:isinsight(v280) then
			v285 = 0;
			v286 = true;
		end;
		local l__lastcf__288 = v282.lastcf;
		if l__lastcf__288 and v286 then
			v276 = v276 + 1;
			u90(v284, v283, v280.TeamColor, l__lastcf__288, v285, v276, "players");
		end;
	end;
	for v289, v290 in u85, nil do
		local v291 = v41.getTime();
		if not v289.Parent then
			u85[v289] = nil;
		elseif v290.shottime + v290.lifetime - v291 > 0 then
			local v292 = v12:isplayeralive(v289);
			local v293 = (v41.getTime() - v290.shottime) / v290.lifetime;
			local v294 = math.min(v293 > 0.1 and v293 ^ 0.5 or 0, 1);
			if v292 and v294 ~= 1 then
				v276 = v276 + 1;
				u90(v292, false, v289.TeamColor, v290.refcf, v294, v276, "players");
			end;
		end;
	end;
	local v295 = 0;
	for v296, v297 in u86, nil do
		local v298 = v41.getTime();
		if not v296.Parent then
			u86[v296] = nil;
		elseif v297.shottime + v297.lifetime - v298 > 0 then
			v295 = v295 + 1;
			u91(v295, v297);
		end;
	end;
	local v299 = 0;
	if u68 then
		local v300 = u68:GetChildren();
		for v301 = 1, #v300 do
			local v302 = v300[v301];
			local l__Base__303 = v302:FindFirstChild("Base");
			local l__TeamColor__304 = v302:FindFirstChild("TeamColor");
			local l__Letter__305 = v302:FindFirstChild("Letter");
			local v306 = nil;
			if v302.Name == "Flag" then
				v306 = l__Letter__305 and l__Letter__305.Value or "";
			elseif v302.Name == "FlagBase" then
				v306 = "F";
			elseif v302.Name == "HPFlag" then
				v306 = "P";
			elseif v302.Name == "RedeemBase" then
				v306 = "R";
			end;
			if l__Base__303 then
				v299 = v299 + 1;
				u90(nil, nil, l__TeamColor__304.Value, l__Base__303.CFrame, nil, v299, "objectives", v306);
			end;
		end;
	end;
end;
function v12.radarstep()
	if not v10.alive then
		return;
	end;
	if u92.enabled then
		u93();
		u94();
	end;
end;
local u95 = 0;
local u96 = l__BloodScreen__92;
u78 = function()
	local v307 = v10.gethealth();
	local l__maxhealth__308 = v10.maxhealth;
	l__Health__107.Text = v307 + -v307 % 1;
	if v307 < u95 then
		local v309 = u95 - v307;
		u96.ImageTransparency = u96.ImageTransparency - v309 / u95 * 0.7;
		u96.BackgroundTransparency = u96.BackgroundTransparency - v309 / u95 * 0.5 + 0.3;
	elseif u95 < v307 or v307 == l__maxhealth__308 then
		u96.ImageTransparency = u96.ImageTransparency + 0.001;
		u96.BackgroundTransparency = u96.BackgroundTransparency + 0.001;
	elseif v307 <= 0 then
		u96.ImageTransparency = 1;
		u96.BackgroundTransparency = 1;
	end;
	u95 = v307;
	if v307 <= l__maxhealth__308 / 4 then
		l__healthbar_back__109.BackgroundColor3 = v111[4];
		l__healthbar_fill__110.BackgroundColor3 = v111[3];
	else
		l__healthbar_back__109.BackgroundColor3 = v111[1];
		l__healthbar_fill__110.BackgroundColor3 = v111[2];
	end;
	l__healthbar_fill__110.Size = UDim2.new(math.floor(v307) / l__maxhealth__308, 0, 1, 0);
end;
u92 = {};
u88 = {};
u73 = {};
u72 = function(p143)
	local v310 = {};
	if v10.alive then
		local l__cframe__311 = v28.cframe;
		local l__unit__312 = l__cframe__311.lookVector.unit;
		local v313 = game:GetService("Players"):GetPlayers();
		local l__TeamColor__314 = u2.TeamColor;
		for v315 = 1, #v313 do
			local v316 = v313[v315];
			if v12:isplayeralive(v316) and v316.TeamColor ~= l__TeamColor__314 then
				local v317 = v14.getbodyparts(v316);
				if v317 and v317.head then
					local v318 = v317.head.Position - v28.cframe.p;
					if l__unit__312:Dot(v318.unit) > 0.96592582628 and not workspace:FindPartOnRayWithWhitelist(Ray.new(l__cframe__311.p, v318), v15.raycastwhitelist) then
						u88[v316] = v41.getTime();
						v310[#v310 + 1] = v316;
					end;
				end;
			end;
		end;
		if #v310 > 0 then
			v21:send("spotplayers", v310, v41.getTime());
			return true;
		end;
	end;
end;
v12.spot = u72;
u75 = v21;
u72 = v21.add;
u72(u75, "brokensight", function(p144, p145)
	if p144 then
		u73[p144] = p145;
	end;
end);
u75 = v21;
u72 = v21.add;
u72(u75, "spotplayer", function(p146)
	if p146 then
		u92[p146] = true;
	end;
end);
u75 = v21;
u72 = v21.add;
u72(u75, "unspotplayer", function(p147)
	if p147 then
		u92[p147] = nil;
	end;
end);
u72 = function(p148, p149)
	return u92[p149];
end;
v12.isspotted = u72;
u72 = function(p150, p151)
	return not u73[p151] or u88[u2];
end;
v12.isinsight = u72;
local u97 = l__Spotted__98;
u72 = function()
	local v319 = nil;
	local v320 = nil;
	while true do
		local v321 = u92(v319, v320);
		if not v321 then
			break;
		end;
		local v322 = false;
		if v10.alive and v321.TeamColor ~= u2.TeamColor then
			local v323 = v14.getbodyparts(v321);
			if v323 and v323.torso and v27.sphere(v323.torso.Position, 4) and not workspace:FindPartOnRayWithWhitelist(Ray.new(v28.cframe.p, v323.head.Position - v28.cframe.p), v15.raycastwhitelist) then
				v322 = true;
				if not u88[v321] or u88[v321] < v41.getTime() then
					u88[v321] = v41.getTime() + 1;
					v21:send("updatesight", v321, true, v41.getTime());
				end;
			end;
		end;
		if not v322 and u88[v321] then
			u88[v321] = nil;
			v21:send("updatesight", v321, false, v41.getTime());
		end;	
	end;
	if v12:isspotted(u2) then
		u97.Visible = true;
		if v12:isinsight(u2) then
			u97.Text = "Spotted by enemy!";
			u97.TextColor3 = Color3.new(1, 0.125, 0.125);
			return;
		else
			u97.Text = "Hiding from enemy...";
			u97.TextColor3 = Color3.new(0.125, 1, 0.125);
			return;
		end;
	end;
	local l__Spottimer__324 = u97:FindFirstChild("Spottimer");
	if not l__Spottimer__324 or not (l__Spottimer__324.Timer.Value > 0) then
		u97.Visible = false;
		return;
	end;
	u97.Visible = true;
	u97.Text = "On Radar!";
	u97.TextColor3 = Color3.new(1, 0.8, 0);
end;
v12.spotstep = u72;
u72 = function(p152)
	local l__Spottimer__325 = u97:FindFirstChild("Spottimer");
	if not l__Spottimer__325 then
		local v326 = Instance.new("Model");
		v326.Name = "Spottimer";
		local v327 = Instance.new("IntValue");
		v327.Name = "Timer";
		v327.Parent = v326;
		v326.Parent = u97;
	else
		v327 = l__Spottimer__325.Timer;
	end;
	if v327.Value <= 30 then
		local v328 = 30;
	elseif v327.Value + 30 > 200 then
		v328 = 200;
	else
		v328 = v327.Value + 30;
	end;
	v327.Value = v328;
end;
v12.goingloud = u72;
u73 = "shot";
local u98 = u4.BloodArc;
u72 = function(p153, p154, p155)
	local v329 = u47:GetChildren();
	for v330 = 1, #v329 do
		if v329[v330].Name == "BloodArc" and v329[v330].Player.Value == p153.Name then
			v329[v330]:Destroy();
		end;
	end;
	local v331 = u98:Clone();
	v331.Pos.Value = p154;
	v331.Player.Value = p153.Name;
	v331.Parent = u47;
	v28:hit((-p155 / 12 + 4.166666666666667) * (v28.cframe.p - p154).unit);
end;
u88 = v21;
u92 = v21.add;
u92(u88, u73, u72);
u73 = "updatecombat";
u72 = function(p156)
	if p156 then
		u48[p156] = v41.getTime();
	end;
end;
u88 = v21;
u92 = v21.add;
u92(u88, u73, u72);
local u99 = {};
u92 = function(p157)
	v12:reset_minimap();
	v12:set_minimap();
	v12:setscope(false);
	v34:reload();
	u99:reset();
	v33:reset();
	local v332 = u47:GetChildren();
	for v333 = 1, #v332 do
		if v332[v333].Name == "BloodArc" then
			v332[v333]:Destroy();
		end;
	end;
	local l__KillBar__334 = u5:FindFirstChild("KillBar");
	if l__KillBar__334 then
		l__KillBar__334:Destroy();
	end;
end;
v12.reloadhud = u92;
u92 = function()
	u28();
	u78();
end;
v12.beat = u92;
local u100 = 0;
local u101 = 0;
u92 = function()
	u54.ImageTransparency = v12.hitspring.p;
	if u47.Visible then
		local v335 = v41.getTime();
		u31();
		if u100 + 0.016666666666666666 < v335 then
			v12.gamemoderenderstep();
			u100 = v335 + 0.016666666666666666;
		end;
		if u101 + 0.1 < v335 then
			v12.spotstep();
			v12.gamemodestep();
			local l__Spottimer__336 = u97:FindFirstChild("Spottimer");
			if l__Spottimer__336 and l__Spottimer__336.Timer.Value > 0 then
				l__Spottimer__336.Timer.Value = l__Spottimer__336.Timer.Value - 1;
			end;
			u101 = v335 + 0.1;
		end;
	end;
	v12.votestep();
end;
v12.step = u92;
u3 = print;
u2 = "Loading notify module";
u3(u2);
u3 = v36.getscale;
u2 = Vector3.zero.Dot;
u10 = workspace.FindPartOnRayWithIgnoreList;
u98 = "Players";
u4 = game;
local l__LocalPlayer__337 = game.GetService(u4, u98).LocalPlayer;
u4 = game;
u4 = u4.ReplicatedStorage.Misc;
u98 = l__LocalPlayer__337.PlayerGui;
u1 = "MainGui";
u8 = u98;
u6 = u98.WaitForChild;
u6 = u6(u8, u1);
u5 = "GameGui";
u1 = u6;
u8 = u6.WaitForChild;
u8 = u8(u1, u5);
u47 = "NotifyList";
u5 = u8;
u1 = u8.WaitForChild;
u1 = u1(u5, u47);
u5 = u4.Main;
u47 = u4.Side;
u53 = u4.AttachBar;
u51 = {};
local v338 = {};
u63 = "Enemy Killed!";
v338[1] = u63;
u51.kill = v338;
local v339 = {};
u63 = "Double Collateral!";
v339[1] = u63;
u51.collx2 = v339;
local v340 = {};
u63 = "Triple Collateral!";
v340[1] = u63;
u51.collx3 = v340;
local v341 = {};
u63 = "Multi Collateral!";
v341[1] = u63;
u51.collxn = v341;
local v342 = {};
u63 = "Double Kill!";
v342[1] = u63;
u51.killx2 = v342;
local v343 = {};
u63 = "Triple Kill!";
v343[1] = u63;
u51.killx3 = v343;
local v344 = {};
u63 = "Quad Kill!";
v344[1] = u63;
u51.killx4 = v344;
local v345 = {};
u63 = "Multi Kill!";
v345[1] = u63;
u51.killxn = v345;
local v346 = {};
u63 = "Backstab!";
v346[1] = u63;
u51.backstab = v346;
local v347 = {};
u63 = "Assist!";
v347[1] = u63;
u51.assist = v347;
local v348 = {};
u63 = "Suppressed Enemy!";
v348[1] = u63;
u51.suppression = v348;
local v349 = {};
u63 = "Assist Count As Kill!";
v349[1] = u63;
u51.assistkill = v349;
local v350 = {};
u63 = "Headshot Bonus!";
v350[1] = u63;
u51.head = v350;
local v351 = {};
u63 = "Wallbang Bonus!";
v351[1] = u63;
u51.wall = v351;
local v352 = {};
u63 = "Spot Bonus!";
v352[1] = u63;
u51.spot = v352;
local v353 = {};
u63 = "Killed from a distance!";
u54 = "Long Shot!";
v353[1] = u63;
v353[2] = u54;
u51.long = v353;
local v354 = {};
u63 = "Teammate spawned on you";
u54 = "Squadmate spawned on you";
v354[1] = u63;
v354[2] = u54;
u51.squad = v354;
local v355 = {};
u63 = "Acquired Enemy Flag!";
u54 = "Stolen Enemy Flag!";
v355[1] = u63;
v355[2] = u54;
u51.flagsteal = v355;
local v356 = {};
u63 = "Captured Enemy Flag!";
v356[1] = u63;
u51.flagcapture = v356;
local v357 = {};
u63 = "Team Captured Enemy Flag!";
v357[1] = u63;
u51.flagteamcap = v357;
local v358 = {};
u63 = "Recovered Team Flag!";
v358[1] = u63;
u51.flagrecover = v358;
local v359 = {};
u63 = "Killed Enemy Flag Carrier!";
v359[1] = u63;
u51.flagdef1 = v359;
local v360 = {};
u63 = "Protected Flag Carrier!";
v360[1] = u63;
u51.flagdef2 = v360;
local v361 = {};
u63 = "Denied Enemy Capture!";
v361[1] = u63;
u51.flagdef3 = v361;
local v362 = {};
u63 = "Denied Enemy Pick Up!";
v362[1] = u63;
u51.flagdef4 = v362;
local v363 = {};
u63 = "Flag Guard Kill!";
v363[1] = u63;
u51.flagdef5 = v363;
local v364 = {};
u63 = "Flag Recover Kill!";
v364[1] = u63;
u51.flagdef6 = v364;
local v365 = {};
u63 = "Flag Escort Kill!";
v365[1] = u63;
u51.flagsup1 = v365;
local v366 = {};
u63 = "Killed Enemy Flag Escort!";
v366[1] = u63;
u51.flagsup2 = v366;
local v367 = {};
u63 = "Assisted by Teammate!";
v367[1] = u63;
u51.flagsup3 = v367;
local v368 = {};
u63 = "Protected Flag Carrier Under Fire!";
u54 = "Protected Flag Carrier!";
v368[1] = u63;
v368[2] = u54;
u51.flagsup4 = v368;
local v369 = {};
u63 = "Saved by Teammate!";
v369[1] = u63;
u51.flagsup5 = v369;
local v370 = {};
u63 = "Protected by Teammate!";
v370[1] = u63;
u51.flagsup6 = v370;
local v371 = {};
u63 = "Offensive Flag Kill!";
v371[1] = u63;
u51.flagoff1 = v371;
local v372 = {};
u63 = "Denied Enemy Flag Recovery!";
v372[1] = u63;
u51.flagoff2 = v372;
local v373 = {};
u63 = "Killed Enemy Flag Guard!";
v373[1] = u63;
u51.flagoff3 = v373;
local v374 = {};
u63 = "Secured Personal Tag!";
v374[1] = u63;
u51.dogtagself = v374;
local v375 = {};
u63 = "Kill Confirmed!";
v375[1] = u63;
u51.dogtagconfirm = v375;
local v376 = {};
u63 = "Teammate Confirmed Kill!";
v376[1] = u63;
u51.dogtagteam = v376;
local v377 = {};
u63 = "Denied Enemy Kill!";
v377[1] = u63;
u51.dogtagdeny = v377;
local v378 = {};
u63 = "Captured a position!";
v378[1] = u63;
u51.domcap = v378;
local v379 = {};
u63 = "Capturing position";
v379[1] = u63;
u51.domcapping = v379;
local v380 = {};
u63 = "Defended a position!";
v380[1] = u63;
u51.domdefend = v380;
local v381 = {};
u63 = "Assaulted a position!";
v381[1] = u63;
u51.domassault = v381;
local v382 = {};
u63 = "Attacked a position!";
v382[1] = u63;
u51.domattack = v382;
local v383 = {};
u63 = "Stopped an enemy capture!";
v383[1] = u63;
u51.dombuzz = v383;
local v384 = {};
u63 = "Captured the hill!";
v384[1] = u63;
u51.kingcap = v384;
local v385 = {};
u63 = "Holding hill";
v385[1] = u63;
u51.kingholding = v385;
local v386 = {};
u63 = "Capturing hill";
v386[1] = u63;
u51.kingcapping = v386;
local v387 = {};
u63 = "Holding point!";
u54 = "Holding position!";
v387[1] = u63;
v387[2] = u54;
u51.hphold = v387;
local v388 = {};
u63 = "Defended position!";
u54 = "Defended point!";
v388[1] = u63;
v388[2] = u54;
u51.hpdefend = v388;
local v389 = {};
u63 = "Assaulted point!";
u54 = "Assaulted position!";
v389[1] = u63;
v389[2] = u54;
u51.hpassault = v389;
local v390 = {};
u63 = "Attacked position!";
u54 = "Attacked point!";
v390[1] = u63;
v390[2] = u54;
u51.hpattack = v390;
local v391 = {};
u63 = "Secured Enemy Tag!";
v391[1] = u63;
u51.tagsecure = v391;
local v392 = {};
u63 = "Secured Friendly Tag!";
v392[1] = u63;
u51.tagteam = v392;
local v393 = {};
u63 = "Redeemed Enemy Tags!";
v393[1] = u63;
u51.tagredeem = v393;
local v394 = {};
u63 = "Recovered Friendly Tags!";
v394[1] = u63;
u51.tagrecover = v394;
u51[" "] = {};
u63 = function(p158, p159)
	p158.AutoLocalize = false;
	local v395 = p159 and 3;
	local l__Text__396 = p158.Text;
	p158.Text = "";
	local v397 = 1;
	for v398, v399 in utf8.graphemes(l__Text__396) do
		p158.Text = p158.Text .. l__Text__396:sub(v398, v399);
		if v397 * v395 < v398 then
			v38.play("ui_typeout", 0.2);
			v397 = v397 + 1;
			task.wait(0.016666666666666666);
		end;
	end;
end;
u54 = function(p160)
	local v400 = u47:Clone();
	local l__Primary__401 = v400:FindFirstChild("Primary");
	v400.Parent = u1;
	v38.play("ui_smallaward", 0.2);
	local v402 = u1:GetChildren();
	for v403 = 1, #v402 do
		local v404 = v402[v403];
		if v404:IsA("Frame") and v404.Parent then
			v404:TweenPosition(UDim2.new(0, 0, 0, (#v402 - v403) * 20), "Out", "Sine", 0.05, true);
		end;
	end;
	task.spawn(function()
		l__Primary__401.Text = p160;
		l__Primary__401.TextTransparency = 0;
		l__Primary__401.AutoLocalize = false;
		l__Primary__401.Text = "";
		local u102 = l__Primary__401.Text;
		local u103 = l__Primary__401;
		local u104 = 3;
		task.spawn(function()
			local v405 = 1;
			for v406, v407 in utf8.graphemes(u102) do
				u103.Text = u103.Text .. u102:sub(v406, v407);
				if v405 * u104 < v406 then
					v38.play("ui_typeout", 0.2);
					v405 = v405 + 1;
					task.wait(0.016666666666666666);
				end;
			end;
		end);
		u103 = task.wait;
		u102 = 5.5;
		u103(u102);
		u103 = 10;
		u102 = 1;
		for v408 = 1, u103, u102 do
			u104 = v408 / 10;
			l__Primary__401.TextTransparency = u104;
			u104 = v408 / 10 + 0.4;
			l__Primary__401.TextStrokeTransparency = u104;
			u104 = 0.016666666666666666;
			task.wait(u104);
		end;
		u103 = task.wait;
		u102 = 0.1;
		u103(u102);
		u103 = v400;
		u102 = u103;
		u103 = u103.Destroy;
		u103(u102);
	end);
end;
u99.customaward = u54;
u54 = function(p161, p162)
	local v409 = u53:Clone();
	local l__Title__410 = v409.Title;
	local l__Attach__411 = v409.Attach;
	v409.Position = UDim2.new(0.5, 0, 0.15, 0);
	l__Title__410.Text = p161;
	l__Attach__411.Text = p162;
	v409.Parent = u6;
	local l__RenderStepped__412 = game:GetService("RunService").RenderStepped;
	local u105 = v41.getTime() + 6;
	local u106 = nil;
	u106 = l__RenderStepped__412:connect(function()
		local v413 = u105 - v41.getTime();
		if v413 < 5 then
			local v414 = 0;
		else
			v414 = v413 < 5.5 and (v413 - 5) / 0.5 or 1;
		end;
		l__Attach__411.TextTransparency = v414;
		if v413 < 5 then
			local v415 = 0;
		else
			v415 = v413 < 5.5 and (v413 - 5) / 0.5 or 1;
		end;
		l__Title__410.TextTransparency = v415;
		if v413 <= 0 then
			u106:disconnect();
			v409:Destroy();
		end;
	end);
end;
u56 = function(p163, p164)
	local v416 = u47:Clone();
	local l__Primary__417 = v416:FindFirstChild("Primary");
	local l__Point__418 = v416:FindFirstChild("Point");
	v38.play("ui_smallaward", 0.2);
	v416.Parent = u1;
	local v419 = u1:GetChildren();
	for v420 = 1, #v419 do
		local v421 = v419[v420];
		if v421:IsA("Frame") and v421.Parent then
			v421:TweenPosition(UDim2.new(0, 0, 0, (#v419 - v420) * 20), "Out", "Sine", 0.05, true);
		end;
	end;
	l__Point__418.Text = "[+" .. (p164 and 25) .. "]";
	local v422 = u51[p163];
	if v422 then
		if #v422 > 1 then
			l__Primary__417.Text = v422[math.random(1, #v422)];
		else
			l__Primary__417.Text = v422[1];
		end;
	else
		l__Primary__417.Text = p163;
	end;
	if p163 == "head" then
		v38.play("headshotkill", 0.45);
	end;
	l__Point__418.TextTransparency = 0;
	l__Primary__417.TextTransparency = 0;
	l__Point__418.AutoLocalize = false;
	l__Point__418.Text = "";
	local u107 = l__Point__418.Text;
	local u108 = 3;
	task.spawn(function()
		local v423 = 1;
		for v424, v425 in utf8.graphemes(u107) do
			l__Point__418.Text = l__Point__418.Text .. u107:sub(v424, v425);
			if v423 * u108 < v424 then
				v38.play("ui_typeout", 0.2);
				v423 = v423 + 1;
				task.wait(0.016666666666666666);
			end;
		end;
	end);
	u107 = false;
	l__Primary__417.AutoLocalize = u107;
	u107 = l__Primary__417.Text;
	l__Primary__417.Text = "";
	u108 = 3;
	task.spawn(function()
		local v426 = 1;
		for v427, v428 in utf8.graphemes(u107) do
			l__Primary__417.Text = l__Primary__417.Text .. u107:sub(v427, v428);
			if v426 * u108 < v427 then
				v38.play("ui_typeout", 0.2);
				v426 = v426 + 1;
				task.wait(0.016666666666666666);
			end;
		end;
	end);
	u107 = task.wait;
	u107(5.5);
	u107 = 10;
	for v429 = 1, u107 do
		u108 = v429 / 10;
		l__Point__418.TextTransparency = u108;
		u108 = v429 / 10;
		l__Primary__417.TextTransparency = u108;
		u108 = v429 / 10 + 0.4;
		l__Point__418.TextStrokeTransparency = u108;
		u108 = v429 / 10 + 0.4;
		l__Primary__417.TextStrokeTransparency = u108;
		u108 = task.wait;
		u108(0.016666666666666666);
	end;
	u107 = task.wait;
	u107(0.1);
	u107 = v416.Destroy;
	u107(v416);
end;
u61 = function(p165, p166, p167, p168)
	local v430 = u5:Clone();
	local l__Overlay__431 = v430:FindFirstChild("Overlay");
	local l__Primary__432 = v430:FindFirstChild("Primary");
	local l__Point__433 = v430:FindFirstChild("Point");
	local l__Enemy__434 = v430:FindFirstChild("Enemy");
	local v435 = u3();
	v430.Parent = u1;
	local v436 = u1:GetChildren();
	for v437 = 1, #v436 do
		local v438 = v436[v437];
		if v438:IsA("Frame") and v438.Parent then
			v438:TweenPosition(UDim2.new(0, 0, 0, (#v436 - v437) * 20), "Out", "Sine", 0.05, true);
		end;
	end;
	l__Point__433.Text = "[+" .. p168 .. "]";
	local v439 = u51[p165];
	if #v439 > 1 then
		l__Primary__432.Text = v439[math.random(1, #v439)];
	else
		l__Primary__432.Text = v439[1];
	end;
	if v12.streamermode() then
		l__Enemy__434.Text = "Player";
	else
		l__Enemy__434.Text = p166.Name and "";
	end;
	l__Enemy__434.TextColor3 = p166.TeamColor.Color;
	v38.play("ui_begin", 0.4);
	if p165 == "kill" then
		v38.play("killshot", 0.2);
	end;
	l__Point__433.TextTransparency = 0;
	l__Point__433.TextStrokeTransparency = 0;
	l__Primary__432.TextTransparency = 0;
	l__Primary__432.TextStrokeTransparency = 0;
	l__Enemy__434.TextTransparency = 1;
	l__Enemy__434.TextStrokeTransparency = 1;
	l__Overlay__431.ImageTransparency = 0.2;
	l__Overlay__431:TweenSizeAndPosition(UDim2.new(0, 200, 0, 80), UDim2.new(0.5, -150, 0.7, -40), "Out", "Linear", 0, true);
	l__Point__433.AutoLocalize = false;
	l__Point__433.Text = "";
	local u109 = l__Point__433.Text;
	local u110 = 2;
	task.spawn(function()
		local v440 = 1;
		for v441, v442 in utf8.graphemes(u109) do
			l__Point__433.Text = l__Point__433.Text .. u109:sub(v441, v442);
			if v440 * u110 < v441 then
				v38.play("ui_typeout", 0.2);
				v440 = v440 + 1;
				task.wait(0.016666666666666666);
			end;
		end;
	end);
	u109 = false;
	l__Primary__432.AutoLocalize = u109;
	u109 = l__Primary__432.Text;
	l__Primary__432.Text = "";
	u110 = 2;
	task.spawn(function()
		local v443 = 1;
		for v444, v445 in utf8.graphemes(u109) do
			l__Primary__432.Text = l__Primary__432.Text .. u109:sub(v444, v445);
			if v443 * u110 < v444 then
				v38.play("ui_typeout", 0.2);
				v443 = v443 + 1;
				task.wait(0.016666666666666666);
			end;
		end;
	end);
	u109 = task.delay;
	u109(0.05, function()
		for v446 = 1, 10 do
			l__Overlay__431.ImageTransparency = v446 / 10;
			task.wait(0.1);
		end;
		l__Overlay__431.Size = UDim2.new(0, 200, 0, 80);
		l__Overlay__431.Position = UDim2.new(0.55, -100, 0.3, -40);
	end);
	u110 = 0;
	u110 = UDim2.new;
	u110 = u110(0.5, -150, 0.7, -15);
	u109 = l__Overlay__431.TweenSizeAndPosition;
	u109(l__Overlay__431, UDim2.new(u110, 300, 0, 30), u110, "Out", "Linear", 0.05, true);
	u109 = task.wait;
	u109(0.05);
	u110 = 0;
	u110 = UDim2.new;
	u110 = u110(0.5, -150, 0.7, -4);
	u109 = l__Overlay__431.TweenSizeAndPosition;
	u109(l__Overlay__431, UDim2.new(u110, 500, 0, 8), u110, "Out", "Linear", 0.05, true);
	u109 = task.wait;
	u109(1.5);
	u109 = 2;
	for v447 = 1, u109 do
		u110 = 1;
		l__Primary__432.TextTransparency = u110;
		u110 = 1;
		l__Primary__432.TextStrokeTransparency = u110;
		u110 = v38.play;
		u110("ui_blink", 0.4);
		u110 = task.wait;
		u110(0.1);
		u110 = 0;
		l__Primary__432.TextTransparency = u110;
		u110 = 0;
		l__Primary__432.TextStrokeTransparency = u110;
		u110 = task.wait;
		u110(0.1);
	end;
	u109 = 1;
	l__Primary__432.TextTransparency = u109;
	u109 = 1;
	l__Primary__432.TextStrokeTransparency = u109;
	u109 = task.wait;
	u109(0.2);
	u109 = 0;
	l__Enemy__434.TextTransparency = u109;
	u109 = 0;
	l__Enemy__434.TextStrokeTransparency = u109;
	u109 = u63;
	u109(l__Enemy__434, 4);
	u109 = 0;
	l__Primary__432.TextTransparency = u109;
	u109 = 0;
	l__Primary__432.TextStrokeTransparency = u109;
	u109 = UDim2.new;
	u110 = l__Enemy__434.TextBounds.x / v435;
	u110 = 0.7;
	u109 = u109(0.5, u110 + 10, u110, -10);
	l__Primary__432.Position = u109;
	if p165 == "kill" then
		u110 = "]";
		u109 = "[" .. p167 .. u110;
		l__Primary__432.Text = u109;
	else
		l__Primary__432.Text = p167;
	end;
	u109 = u63;
	u109(l__Primary__432, 4);
	u109 = task.wait;
	u109(3);
	u109 = 10;
	for v448 = 1, u109 do
		u110 = v448 / 10;
		l__Point__433.TextTransparency = u110;
		u110 = v448 / 10;
		l__Primary__432.TextTransparency = u110;
		u110 = v448 / 10;
		l__Enemy__434.TextTransparency = u110;
		u110 = v448 / 10 + 0.4;
		l__Point__433.TextStrokeTransparency = u110;
		u110 = v448 / 10 + 0.4;
		l__Primary__432.TextStrokeTransparency = u110;
		u110 = v448 / 10 + 0.4;
		l__Enemy__434.TextStrokeTransparency = u110;
		u110 = task.wait;
		u110(0.016666666666666666);
	end;
	u109 = task.wait;
	u109(0.1);
	u109 = v430.Destroy;
	u109(v430);
end;
u96 = function(p169)
	local v449 = u53:Clone();
	local l__Title__450 = v449.Title;
	local l__Attach__451 = v449.Attach;
	v449.Position = UDim2.new(0.5, 0, 0.15, 0);
	v449.Parent = u6;
	l__Title__450.Text = "Unlocked New Weapon!";
	l__Attach__451.Text = p169;
	local u111 = v41.getTime();
	local u112 = nil;
	u112 = game:GetService("RunService").RenderStepped:connect(function()
		local v452 = v41.getTime() - u111;
		if v452 < 2 then
			local v453 = 0;
		else
			v453 = v452 < 2.5 and (v452 - 2) / 0.5 or 1;
		end;
		l__Attach__451.TextTransparency = v453;
		if v452 < 2 then
			local v454 = 0;
		else
			v454 = v452 < 2.5 and (v452 - 2) / 0.5 or 1;
		end;
		l__Title__450.TextTransparency = v454;
		if v452 > 3 then
			u112:disconnect();
			v449:Destroy();
		end;
	end);
end;
local l__RankBar__113 = u4.RankBar;
u24 = function(p170, p171, p172)
	local v455 = l__RankBar__113:Clone();
	local l__Money__456 = v455.Money;
	local l__Rank__457 = v455.Rank;
	local v458 = 0;
	local v459 = u6:GetChildren();
	for v460 = 1, #v459 do
		if v459[v460].Name == "RankBar" or v459[v460].Name == "AttachBar" then
			v458 = v458 + 1;
		end;
	end;
	v455.Parent = u6;
	l__Rank__457.Text = p171;
	l__Money__456.Text = "+" .. 5 * (p171 - p170) * (81 + p171 + p170) / 2 .. " CR";
	local u114 = v41.getTime();
	local l__Title__115 = v455.Title;
	local u116 = nil;
	u116 = game:GetService("RunService").RenderStepped:connect(function()
		local v461 = v41.getTime() - u114;
		if v461 < 3 then
			local v462 = 0;
		else
			v462 = v461 < 3.5 and (v461 - 3) / 0.5 or 1;
		end;
		l__Rank__457.TextTransparency = v462;
		if v461 < 3 then
			local v463 = 0;
		else
			v463 = v461 < 3.5 and (v461 - 3) / 0.5 or 1;
		end;
		l__Title__115.TextTransparency = v463;
		if v461 < 0.5 then
			local v464 = 1;
		elseif v461 < 3.5 then
			v464 = 0;
		else
			v464 = v461 < 4 and (v461 - 3.5) / 0.5 or 1;
		end;
		l__Money__456.TextTransparency = v464;
		if v461 > 4 then
			u116:disconnect();
			v455:Destroy();
			task.spawn(function()
				if p172 then
					for v465 = 1, #p172 do
						u96(p172[v465]);
						task.wait(3);
					end;
				end;
			end);
		end;
	end);
end;
u64 = function(p173)
	u6 = u98:WaitForChild("MainGui");
	u8 = u6:WaitForChild("GameGui");
	u1 = u8:WaitForChild("NotifyList");
	if u6:FindFirstChild("KillBar") then
		u6.KillBar:Destroy();
	end;
end;
u99.reset = u64;
u97 = u96;
u46 = v21;
u64 = v21.add;
u64(u46, "unlockweapon", u97);
u64 = nil;
u46 = game.ReplicatedStorage;
u97 = function(p174, p175)
	for v466, v467 in p174() do
		if v467:IsA("BasePart") then
			v467.Anchored = true;
			if v467.Name == "LaserLight" then
				v467.Material = "SmoothPlastic";
				if v467:FindFirstChild("Bar") then
					v467.Bar.Scale = Vector3.new(0.1, 1000, 0.1);
				end;
			end;
		end;
	end;
	v45.textureModel(p174, p175);
end;
local u117 = function(p176, p177, p178)
	local v468 = p176:GetChildren();
	local v469 = nil;
	for v470 = 1, #v468 do
		if p177 == "Optics" then
			if v468[v470].Name == "Iron" or v468[v470].Name == "IronGlow" then
				if p178 and not v468[v470]:FindFirstChild("Hide") then
					local v471 = Instance.new("IntValue");
					v471.Name = "Hide";
					v471.Parent = v468[v470];
				else
					local l__Hide__472 = v468[v470]:FindFirstChild("Hide");
					if l__Hide__472 then
						l__Hide__472:Destroy();
					end;
				end;
				if p178 then
					local v473 = 1;
				else
					v473 = 0;
				end;
				v468[v470].Transparency = v473;
			elseif v468[v470].Name == "SightMark" and v468[v470]:FindFirstChild("Decal") then
				if p178 then
					local v474 = 1;
				else
					v474 = 0;
				end;
				v468[v470].Decal.Transparency = v474;
			end;
		elseif p177 == "Underbarrel" then
			if v468[v470].Name == "Grip" then
				if p178 and not v468[v470]:FindFirstChild("Hide") then
					local v475 = Instance.new("IntValue");
					v475.Name = "Hide";
					v475.Parent = v468[v470];
				else
					local l__Hide__476 = v468[v470]:FindFirstChild("Hide");
					if l__Hide__476 then
						l__Hide__476:Destroy();
					end;
				end;
				if p178 then
					local v477 = 1;
				else
					v477 = 0;
				end;
				v468[v470].Transparency = v477;
				v469 = v468[v470]:FindFirstChild("Slot1") or v468[v470]:FindFirstChild("Slot2");
			end;
		elseif p177 == "Barrel" and v468[v470].Name == "Barrel" then
			if p178 and not v468[v470]:FindFirstChild("Hide") then
				local v478 = Instance.new("IntValue");
				v478.Name = "Hide";
				v478.Parent = v468[v470];
			else
				local l__Hide__479 = v468[v470]:FindFirstChild("Hide");
				if l__Hide__479 then
					l__Hide__479:Destroy();
				end;
			end;
			if p178 then
				local v480 = 1;
			else
				v480 = 0;
			end;
			v468[v470].Transparency = v480;
			v469 = v468[v470]:FindFirstChild("Slot1") or v468[v470]:FindFirstChild("Slot2");
		end;
	end;
	return v469;
end;
local u118 = function(p179, p180, p181, p182, p183, p184)
	local v481 = p180:GetChildren();
	local v482 = v42.getWeaponData(p179);
	local v483 = v482.attachments[p181] and v482.attachments[p181][p182] or {};
	local v484 = v483.altmodel and v42.getAttachmentModel(v483.altmodel) or v42.getAttachmentModel(p182);
	if not v484 then
		return;
	end;
	local v485 = v484:Clone();
	local l__Node__486 = v485:FindFirstChild("Node");
	local v487 = v483.sidemount and v42.getAttachmentModel(v483.sidemount):Clone();
	v485.Name = p182;
	if v487 then
		local l__Node__488 = v487.Node;
		if v483.mountnode then
			local v489 = p183[v483.mountnode];
			if not v489 then
				if p181 == "Optics" then
					v489 = p183.MountNode;
					if not v489 then
						v489 = false;
						if p181 == "Underbarrel" then
							v489 = p183.UnderMountNode;
						end;
					end;
				else
					v489 = false;
					if p181 == "Underbarrel" then
						v489 = p183.UnderMountNode;
					end;
				end;
			end;
		elseif p181 == "Optics" then
			v489 = p183.MountNode;
			if not v489 then
				v489 = false;
				if p181 == "Underbarrel" then
					v489 = p183.UnderMountNode;
				end;
			end;
		else
			v489 = false;
			if p181 == "Underbarrel" then
				v489 = p183.UnderMountNode;
			end;
		end;
		local v490 = {};
		local v491 = v487:GetChildren();
		local l__CFrame__492 = l__Node__488.CFrame;
		for v493 = 1, #v491 do
			if v491[v493]:IsA("BasePart") then
				v490[v493] = l__CFrame__492:ToObjectSpace(v491[v493].CFrame);
			end;
		end;
		l__Node__488.CFrame = v489.CFrame;
		for v494 = 1, #v491 do
			if v491[v494]:IsA("BasePart") then
				v491[v494].CFrame = v489.CFrame * v490[v494];
			end;
		end;
		local v495 = v483.node and p183[v483.node] or v487[p181 .. "Node"];
		v487.Parent = v485;
	else
		v495 = v483.node and p183[v483.node] or p183[p181 .. "Node"];
	end;
	if v483.auxmodels then
		local v496 = {};
		local l__auxmodels__497 = v483.auxmodels;
		local v498 = nil;
		local v499 = nil;
		while true do
			local v500, v501 = l__auxmodels__497(v498, v499);
			if not v500 then
				break;
			end;
			local v502 = v501.Name or p182 .. " " .. v501.PostName;
			local v503 = v42.getAttachmentModel(v502):Clone();
			local l__Node__504 = v503.Node;
			v496[v502] = v503;
			if v501.sidemount and v487 then
				local v505 = v487[v501.Node];
			elseif v501.auxmount and v496[v501.auxmount] and v496[v501.auxmount]:FindFirstChild(v501.Node) then
				v505 = v496[v501.auxmount][v501.Node];
			else
				v505 = p183[v501.Node];
			end;
			if v501.mainnode then
				v495 = v503[v501.mainnode];
			end;
			local v506 = {};
			local v507 = v503:GetChildren();
			local l__CFrame__508 = l__Node__504.CFrame;
			for v509 = 1, #v507 do
				if v507[v509]:IsA("BasePart") then
					v506[v509] = l__CFrame__508:ToObjectSpace(v507[v509].CFrame);
				end;
			end;
			l__Node__504.CFrame = v505.CFrame;
			for v510 = 1, #v507 do
				if v507[v510]:IsA("BasePart") then
					v507[v510].CFrame = v505.CFrame * v506[v510];
				end;
			end;
			v503.Parent = v485;		
		end;
	end;
	local v511 = {};
	local v512 = v485:GetChildren();
	local v513 = l__Node__486 and l__Node__486.CFrame;
	local v514 = u117(p180, p181, true);
	for v515 = 1, #v512 do
		if v512[v515]:IsA("BasePart") then
			v511[v515] = v513:ToObjectSpace(v512[v515].CFrame);
		end;
	end;
	for v516 = 1, #v481 do
		local v517 = v481[v516];
		if v483.transparencymod and v483.transparencymod[v517.Name] then
			local v518 = Instance.new("IntValue");
			v518.Parent = v517;
			v518.Name = p181 .. "Hide";
			v518.Value = v517.Transparency;
			v517.Transparency = v483.transparencymod[v517.Name];
		end;
	end;
	l__Node__486.CFrame = v495.CFrame;
	for v519 = 1, #v512 do
		if v512[v519]:IsA("BasePart") then
			local v520 = v512[v519];
			v520.CFrame = v495.CFrame * v511[v519];
			if v514 and (not (not v520:FindFirstChild("Mesh")) or not (not v520:IsA("UnionOperation")) or v520:IsA("MeshPart")) then
				v514:Clone().Parent = v520;
			end;
		end;
	end;
	v485.Parent = p180;
end;
u64 = function(p185, p186, p187)
	local v521 = v42.getWeaponModel(p185);
	if not v521 then
		v21:send("debug", "Failed to find weapon model for", p185);
		error("Failed to find weapon model for", p185);
		return;
	end;
	local v522 = v521:Clone();
	local l__MenuNodes__523 = v522:FindFirstChild("MenuNodes");
	l__MenuNodes__523.Parent = v522;
	v522.PrimaryPart = l__MenuNodes__523:FindFirstChild("MenuNode");
	if p186 then
		for v524, v525 in p186, nil do
			if v525 ~= "" then
				u118(p185, v522, v524, v525, l__MenuNodes__523);
			end;
		end;
	end;
	u97(v522, p187);
	return v522;
end;
u97 = "killed";
local u119 = l__LocalPlayer__337;
local l__KillBar__120 = u4.KillBar;
u118 = function(p188, p189, p190, p191, p192, p193, p194)
	local l__cframe__526 = v28.cframe;
	v10.deadcf = l__cframe__526;
	if p188 == u119 then
		v28:setfixedcam(CFrame.new(l__cframe__526.p, l__cframe__526.p + l__cframe__526.lookVector));
		return;
	end;
	local v527 = l__KillBar__120:Clone();
	if v12.streamermode() then
		v527.Killer.Label.Text = "Player";
	else
		v527.Killer.Label.Text = p189;
	end;
	local v528 = Instance.new("ObjectValue");
	v528.Name = "Player";
	v528.Value = p188;
	v528.Parent = v527.Killer;
	v527.Weapon.Label.Text = p191;
	v527.Parent = u6;
	v527.Rank.Label.Text = p192;
	local v529 = u64(p190, p193, p194);
	local v530 = v529.MenuNodes:FindFirstChild("ViewportNode") or v529.MenuNodes.MenuNode;
	v529.PrimaryPart = v530;
	v529:SetPrimaryPartCFrame(CFrame.new(0, 0, 0));
	local v531 = Instance.new("Camera");
	v531.CFrame = CFrame.new(v530.CFrame.p + v530.CFrame.RightVector * -7 + v530.CFrame.lookVector * 4 + v530.CFrame.upVector * 4, v530.CFrame.p + v530.CFrame.lookVector * 1.5);
	v531.FieldOfView = 16;
	v531.Parent = v529;
	v529.Parent = v527.WeaponViewport;
	v527.WeaponViewport.CurrentCamera = v531;
	for v532, v533 in v527.Attachments() do
		v533.Type.Text = "None";
	end;
	if p193 then
		for v534, v535 in p193, nil do
			if v534 ~= "Name" and v535 ~= "" then
				v527.Attachments[v534].Type.Text = v42.getAttachmentDisplayName(v535, p190, v534);
			end;
		end;
	end;
	if v12:isplayeralive(p188) then
		v28:setspectate(p188);
	else
		v28:setfixedcam(CFrame.new(l__cframe__526.p, l__cframe__526.p + l__cframe__526.lookVector));
	end;
	task.delay(5, function()
		v529:Destroy();
	end);
end;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "unlockedattach";
u118 = function(p195, p196, p197)
	for v536 = 1, #p196 do
		local v537 = p197[v536];
		local v538 = u53:Clone();
		local l__Money__539 = v538.Money;
		local l__Title__540 = v538.Title;
		local l__Attach__541 = v538.Attach;
		v538.Position = UDim2.new(0.5, 0, 0.15, 0);
		v538.Parent = u6;
		l__Title__540.Text = "Unlocked " .. p195 .. " Attachment";
		l__Attach__541.Text = p196[v536];
		l__Money__539.Text = "[+200]";
		local u121 = v41.getTime();
		local u122 = nil;
		u122 = game:GetService("RunService").RenderStepped:connect(function()
			local v542 = v41.getTime() - u121;
			if v542 < 2 then
				local v543 = 0;
			else
				v543 = v542 < 2.5 and (v542 - 2) / 0.5 or 1;
			end;
			l__Attach__541.TextTransparency = v543;
			if v542 < 2 then
				local v544 = 0;
			else
				v544 = v542 < 2.5 and (v542 - 2) / 0.5 or 1;
			end;
			l__Title__540.TextTransparency = v544;
			if v542 < 0.5 then
				local v545 = 1;
			elseif v542 < 2.5 then
				v545 = 0;
			else
				v545 = v542 < 3 and (v542 - 2.5) / 0.5 or 1;
			end;
			l__Money__539.TextTransparency = v545;
			if v542 > 3 then
				u122:disconnect();
				v538:Destroy();
			end;
		end);
		task.wait(3);
	end;
end;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "rankup";
u118 = u24;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "bigaward";
u118 = function(p198, p199, p200, p201)
	u61(p198, p199, p200, p201);
end;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "smallaward";
u118 = function(p202, p203)
	u56(p202, p203);
end;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "newevent";
u118 = u54;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u97 = "newroundid";
u118 = function(p204)
	v11.updateversionstr(p204);
end;
u117 = v21;
u46 = v21.add;
u46(u117, u97, u118);
u46 = function()
	local v546 = nil;
	local v547 = nil;
	if not v10.alive then
		v546 = u6:FindFirstChild("KillBar");
		if v546 then
			v547 = v546.Killer.Player.Value;
			if not v547 then
				v546.Health.Label.Text = 100;
				v546.Health.Label.TextColor3 = Color3.new(0, 1, 0);
				return;
			end;
		else
			return;
		end;
	else
		return;
	end;
	local v548 = v12:getplayerhealth(v547);
	v546.Health.Label.Text = math.ceil(v548);
	v546.Health.Label.TextColor3 = v548 < 20 and Color3.new(1, 0, 0) or (v548 < 50 and Color3.new(1, 1, 0) or Color3.new(0, 1, 0));
end;
u99.step = u46;
u46 = {};
u117 = "ammohud";
u46.toggleammohud = u117;
u117 = "round";
u46.toggleroundhud = u117;
u117 = "radar";
u46.toggleradarhud = u117;
u117 = "crossframe";
u46.togglecrosshairs = u117;
u117 = "killfeed";
u46.togglekillfeed = u117;
u117 = v44.onSettingChanged;
u118 = function(p205, p206)
	if p205 == "toggleammohud" then
		v12:togglehudobj("ammohud", p206);
		return;
	end;
	if p205 == "toggleradarhud" then
		v12:togglehudobj("radar", p206);
		return;
	end;
	if p205 == "toggleroundhud" then
		v12:togglehudobj("round", p206);
		return;
	end;
	if p205 == "togglecrosshairs" then
		v12:togglehudobj("crossframe", p206);
		return;
	end;
	if p205 == "togglekillfeed" then
		v12:togglehudobj("killfeed", p206);
	end;
end;
u97 = u117;
u117 = u117.connect;
u117(u97, u118);
u117 = u46;
u97 = nil;
u118 = nil;
while true do
	u62 = u97;
	local v549, u62 = u117(u62, u118);
	if not v549 then
		break;
	end;
	u118 = v549;
	u65 = v43.getValue(v549);
	v12:togglehudobj(u46[v549], u65);
end;
u3 = print;
u2 = "Loading leaderboard module";
u3(u2);
u3 = game;
u10 = "Players";
u2 = u3;
u3 = u3.GetService;
u3 = u3(u2, u10);
u2 = u3.LocalPlayer;
u4 = game;
u119 = u4.ReplicatedStorage.Character;
u10 = u119.PlayerTag;
u119 = u2.PlayerGui;
u98 = "ReplicatedStorage";
u4 = game;
local v550 = game.GetService(u4, u98);
u98 = "Misc";
u4 = v550;
local v551 = v550.WaitForChild(u4, u98);
u98 = "Player";
u4 = v551;
u98 = u119;
u4 = u119.WaitForChild;
u4 = u4(u98, "Leaderboard");
u98 = u4.WaitForChild;
u98 = u98(u4, "Main");
local l__Ping__552 = u98:WaitForChild("TopBar"):WaitForChild("Ping");
local u123 = u98:WaitForChild("Ghosts"):WaitForChild("DataFrame"):WaitForChild("Data");
local u124 = u98:WaitForChild("Phantoms"):WaitForChild("DataFrame"):WaitForChild("Data");
local u125 = v551.WaitForChild(u4, u98);
local u126 = function()
	local v553 = game:GetService("Players"):GetPlayers();
	for v554 = 1, #v553 do
		local v555 = v553[v554];
		local v556 = v555.TeamColor == game.Teams.Ghosts.TeamColor and u123 or u124;
		local v557 = (v555.TeamColor ~= game.Teams.Ghosts.TeamColor and u123 or u124):FindFirstChild(v555.Name);
		if not v556:FindFirstChild(v555.Name) and v557 then
			v557.Parent = v556;
		end;
	end;
	local v558 = u123:GetChildren();
	table.sort(v558, function(p207, p208)
		return tonumber(p208.Score.Text) < tonumber(p207.Score.Text);
	end);
	for v559 = 1, #v558 do
		local v560 = v558[v559];
		v560.Position = UDim2.new(0, 0, 0, v559 * 25);
		if v560.Name == u2.Name then
			v560.Username.TextColor3 = Color3.new(1, 1, 0);
		end;
	end;
	u123.Parent.CanvasSize = UDim2.new(0, 0, 0, (#v558 + 1) * 25);
	local v561 = u124:GetChildren();
	table.sort(v561, function(p209, p210)
		return tonumber(p210.Score.Text) < tonumber(p209.Score.Text);
	end);
	for v562 = 1, #v561 do
		local v563 = v561[v562];
		v563.Position = UDim2.new(0, 0, 0, v562 * 25);
		if v563.Name == u2.Name then
			v563.Username.TextColor3 = Color3.new(1, 1, 0);
		end;
	end;
	u124.Parent.CanvasSize = UDim2.new(0, 0, 0, (#v561 + 1) * 25);
end;
local function v564(p211)
	if u123:FindFirstChild(p211.Name) or u124:FindFirstChild(p211.Name) then
		return;
	end;
	local v565 = u125:Clone();
	v565.Name = p211.Name;
	if v12.streamermode() then
		v565.Username.Text = "Player";
	else
		v565.Username.Text = p211.Name;
	end;
	v565.Kills.Text = 0;
	v565.Deaths.Text = 0;
	v565.Streak.Text = 0;
	v565.Score.Text = 0;
	v565.Kdr.Text = 0;
	v565.Rank.Text = 0;
	if p211 == u2 then
		v565.Username.TextColor3 = Color3.new(1, 1, 0);
	end;
	v565.Parent = p211.TeamColor == game.Teams.Ghosts.TeamColor and u123 or u124;
	if u98.Visible then
		u126();
	end;
end;
local u127 = function()
	if v12.streamermode() then
		for v566, v567 in u123() do
			v567.Username.Text = "Player";
		end;
		for v568, v569 in u124() do
			v569.Username.Text = "Player";
		end;
		return;
	end;
	for v570, v571 in u123() do
		v571.Username.Text = v571.Name;
	end;
	for v572, v573 in u124() do
		v573.Username.Text = v573.Name;
	end;
end;
function v13.show(p212)
	u127();
	u126();
	u98.Visible = true;
end;
function v13.hide(p213)
	u98.Visible = false;
end;
local u128 = function(p214, p215)
	local v574 = u123:FindFirstChild(p214.Name) or u124:FindFirstChild(p214.Name);
	if v574 then
		for v575, v576 in p215, nil do
			v574[v575].Text = v576;
		end;
	end;
	if u98.Visible then
		u126();
	end;
end;
v21:add("updatestats", u128);
v21:add("fillboard", function(p216)
	for v577, v578 in p216, nil do
		u128(v578.player, v578.stats);
	end;
end);
u3.PlayerAdded:connect(v564);
u3.PlayerRemoving:connect(function(p217)
	local v579 = u123:FindFirstChild(p217.Name);
	local v580 = u124:FindFirstChild(p217.Name);
	if v579 then
		v579:Destroy();
	end;
	if v580 then
		v580:Destroy();
	end;
	if u98.Visible then
		u126();
	end;
end);
for v581, v582 in u3() do
	v564(v582);
end;
game:GetService("UserInputService").InputBegan:connect(function(p218)
	local l__KeyCode__583 = p218.KeyCode;
	if l__KeyCode__583 == Enum.KeyCode.Tab and not v32.iskeydown(Enum.KeyCode.LeftAlt) or l__KeyCode__583 == Enum.KeyCode.ButtonSelect then
		if u98.Visible then
			v13:hide();
			return;
		end;
		u126();
		v13:show();
	end;
end);
local u129 = 60;
local u130 = l__Ping__552;
local u131 = v41.getTime();
function v13.step(p219)
	u129 = 0.95 * u129 + 0.05 / p219;
	if u98.Visible and u130 and u131 < v41.getTime() then
		local v584 = u129 - u129 % 1;
		if v584 ~= v584 or v584 == (1 / 0) or v584 == (-1 / 0) then
			v584 = 60;
			u129 = v584;
		end;
		u130.Text = "Average FPS: " .. v584;
		u131 = v41.getTime() + 1;
	end;
end;
u3 = print;
u2 = "Loading char module";
u3(u2);
u2 = shared;
u3 = u2.require;
u2 = "WepScript";
u3 = u3(u2);
u10 = math.pi;
u2 = u10 * 2;
u10 = Instance.new;
u119 = CFrame.new;
u125 = u119;
u125 = u125();
u4 = CFrame.Angles;
u98 = Vector3.zero;
u130 = game.Debris;
u123 = nil;
u124 = nil;
u126 = nil;
u128 = "ReplicatedStorage";
u128 = "Character";
u128 = "Bodies";
u128 = "RefPlayer";
local v585 = game:GetService(u128):WaitForChild(u128):WaitForChild(u128):WaitForChild(u128);
u128 = game;
u127 = u128;
u128 = u128.GetService;
u128 = u128(u127, "Players");
u127 = u128.LocalPlayer;
local l__materialhitsound__586 = v38.materialhitsound;
local v587 = { Enum.HumanoidStateType.Dead, Enum.HumanoidStateType.Flying, Enum.HumanoidStateType.Seated, Enum.HumanoidStateType.Ragdoll, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.Swimming, Enum.HumanoidStateType.GettingUp, Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.PlatformStanding, Enum.HumanoidStateType.RunningNoPhysics, Enum.HumanoidStateType.StrafingNoPhysics };
local v588 = v25.new();
local v589 = v25.new();
local v590 = u10("Humanoid");
for v591 = 1, #v587 do
	v590:SetStateEnabled(v587[v591], false);
end;
v590.AutomaticScalingEnabled = false;
v590.AutoRotate = false;
v590.AutoJumpEnabled = false;
v590.BreakJointsOnDeath = false;
v590.HealthDisplayDistance = 0;
v590.NameDisplayDistance = 0;
v590.RequiresNeck = false;
v590.RigType = Enum.HumanoidRigType.R6;
local v592 = v25.new();
local v593 = v25.new(1);
v593.s = 12;
v593.d = 0.95;
v10.unaimedfov = 80;
v10.speed = 0;
v10.distance = 0;
v10.sprint = false;
v10.acceleration = u98;
function v10.setunaimedfov(p220)
	v10.unaimedfov = p220;
end;
local u132 = 0;
local u133 = {};
function v10.unloadguns()
	u132 = 0;
	u133 = {};
end;
local v594 = v25.new(u98);
local v595 = v25.new();
local v596 = v25.new(u98);
local v597 = v25.new(0);
local v598 = v25.new(0);
local v599 = v25.new(0);
local v600 = v25.new(0);
local v601 = v25.new(1);
v588.s = 12;
v588.d = 0.9;
v589.s = 12;
v589.d = 0.9;
v592.d = 0.9;
v594.s = 10;
v594.d = 0.75;
v595.s = 16;
v596.s = 16;
v597.s = 8;
v598.s = 8;
v599.s = 20;
v600.s = 8;
v601.s = 12;
v601.d = 0.75;
v10.crouchspring = v598;
v10.pronespring = v597;
v10.slidespring = v599;
v10.movementmode = "stand";
local v602 = u10("BodyVelocity");
v602.Name = "\n";
local v603 = v25.new(14);
v603.s = 8;
local v604 = v25.new(1.5);
v604.s = 8;
v602.MaxForce = u98;
local u134 = 14;
function v10.getslidecondition()
	return u134 * 1.2 < v603.p;
end;
local u135 = false;
local u136 = 1;
local u137 = "stand";
local u138 = 0;
local u139 = false;
local u140 = nil;
local function v605(p221, p222, p223)
	local v606 = nil;
	v606 = v10.movementmode;
	v10.movementmode = p222;
	u137 = p222;
	if p222 == "prone" then
		if not p223 and v606 ~= p222 then
			v38.play("stanceProne", 0.15);
		end;
		v604.t = -1.5;
		v597.t = 1;
		v598.t = 0;
		v603.t = u136 * u134 / 4;
		v12:setcrossscale(0.5);
		u138 = 0.25;
		if p223 and u135 and u123.Velocity.y > -5 then
			coroutine.wrap(function()
				local l__lookVector__607 = u123.CFrame.lookVector;
				u123.Velocity = l__lookVector__607 * 50 + Vector3.new(0, 40, 0);
				task.wait(0.1);
				u123.Velocity = l__lookVector__607 * 60 + Vector3.new(0, 30, 0);
				task.wait(0.4);
				u123.Velocity = l__lookVector__607 * 20 + Vector3.new(0, -10, 0);
			end)();
		end;
	elseif p222 == "crouch" then
		if not p223 and v606 ~= p222 then
			v38.play("stanceStandCrouch", 0.15);
		end;
		local v608 = v10.getslidecondition();
		v604.t = 0;
		v597.t = 0;
		v598.t = 1;
		v603.t = u136 * u134 / 2;
		v12:setcrossscale(0.75);
		u138 = 0.15;
		if p223 and v608 and v590:GetState() ~= Enum.HumanoidStateType.Freefall then
			u139 = true;
			v38.play("slideStart", 0.25);
			v10.slidespring.t = 1;
			local u141 = false;
			coroutine.wrap(function()
				local l__rootpart__609 = v10.rootpart;
				local v610 = l__rootpart__609.Velocity.unit;
				local v611 = l__rootpart__609.CFrame:VectorToObjectSpace(v610);
				v602.MaxForce = Vector3.new(40000, 10, 40000);
				local v612 = v41.getTime();
				while v41.getTime() < v612 + 0.6666666666666666 do
					if v32.keyboard.down.leftshift or v32.controller.down.l3 then
						if u141 then
							break;
						end;
						v610 = v28.cframe:VectorToWorldSpace(v611);
					else
						u141 = true;
					end;
					v602.Velocity = v610 * (40 - (v41.getTime() - v612) * 30 / 0.6666666666666666);
					task.wait();				
				end;
				v603.p = math.min(l__rootpart__609.Velocity.Magnitude, 70);
				v602.MaxForce = u98;
				v602.Velocity = u98;
				if u139 then
					u139 = false;
					v38.play("slideEnd", 0.15);
				end;
				v10.slidespring.t = 0;
			end)();
		end;
	elseif p222 == "stand" then
		if v606 ~= p222 then
			v38.play("stanceStandCrouch", 0.15);
		end;
		v604.t = 1.5;
		v597.t = 0;
		v598.t = 0;
		v603.t = u136 * u134;
		v12:setcrossscale(1);
		u138 = 0;
	end;
	if u140 and u140.stancechange then
		u140.stancechange(p222);
	end;
	v21:send("stance", p222);
	u135 = false;
	v21:send("sprint", u135);
	v588.t = 0;
end;
function v10.getstate()
	return v590:GetState();
end;
function v10.sprinting()
	return u135;
end;
v10.setmovementmode = v605;
local function u142()
	if u135 then
		v603.t = 1.4 * u136 * u134;
		return;
	end;
	if u137 == "prone" then
		v603.t = u136 * u134 / 4;
		return;
	end;
	if u137 == "crouch" then
		v603.t = u136 * u134 / 2;
		return;
	end;
	if u137 == "stand" then
		v603.t = u136 * u134;
	end;
end;
function v10.setbasewalkspeed(p224, p225)
	u134 = p225;
	u142();
end;
local u143 = false;
local u144 = false;
function v10.setsprint(p226, p227)
	local l__currentgun__613 = u45.currentgun;
	if not p227 then
		if u135 then
			u135 = false;
			v21:send("sprint", u135);
			v588.t = 0;
			v603.t = u136 * u134;
			if (v32.mouse.down.right or v32.controller.down.l2) and l__currentgun__613 and l__currentgun__613.type ~= "KNIFE" and l__currentgun__613.type ~= "Grenade" then
				l__currentgun__613:setaim(true);
			end;
		end;
		return;
	end;
	if u139 then
		u139 = false;
		v38.play("slideEnd", 0.15);
	end;
	v605(nil, "stand");
	u135 = true;
	v21:send("sprint", u135);
	if l__currentgun__613 then
		l__currentgun__613.auto = false;
		if l__currentgun__613 and l__currentgun__613.isaiming() and l__currentgun__613.type ~= "KNIFE" then
			l__currentgun__613:setaim(false);
		end;
	end;
	u136 = 1;
	if not u143 and not u144 then
		v588.t = 1;
	end;
	v603.t = 1.5 * u136 * u134;
end;
local u145 = {
	mid = {
		lower = 1.8, 
		upper = 4, 
		width = 1.5, 
		xrays = 5, 
		yrays = 8, 
		dist = 6, 
		sprintdist = 8, 
		color = BrickColor.new("Bright blue")
	}, 
	upper = {
		lower = 5, 
		upper = 6, 
		width = 1, 
		xrays = 5, 
		yrays = 7, 
		dist = 8, 
		sprintdist = 10, 
		color = BrickColor.new("Bright green")
	}
};
local u146 = Ray.new;
local l__Enum_Material_Air__147 = Enum.Material.Air;
local function u148()
	local v614 = u123.CFrame * u119(0, -3, 0);
	local v615 = false;
	local v616 = false;
	local l__lookVector__617 = u123.CFrame.lookVector;
	local v618 = {
		mid = {}, 
		upper = {}
	};
	local v619 = {};
	local v620 = nil;
	local v621 = nil;
	while true do
		local v622, v623 = u145(v620, v621);
		if not v622 then
			break;
		end;
		for v624 = 0, v623.xrays - 1 do
			for v625 = 0, v623.yrays - 1 do
				local v626 = (v624 / (v623.xrays - 1) - 0.5) * v623.width;
				local v627 = v614 * Vector3.new(v626, v625 / (v623.yrays - 1) * (v623.upper - v623.lower) + v623.lower, 0);
				local v628, v629 = workspace:FindPartOnRayWithWhitelist(u146(v627, l__lookVector__617 * (u135 and v623.sprintdist or v623.dist)), v15.raycastwhitelist);
				if v628 and v628.CanCollide then
					local l__Magnitude__630 = (v627 - v629).Magnitude;
					v618[v622][#v618[v622] + 1] = l__Magnitude__630;
					if v622 == "mid" then
						v615 = true;
						if v626 == 0 then
							v619[#v619 + 1] = l__Magnitude__630;
						end;
					elseif v622 == "upper" then
						v616 = true;
					end;
				end;
			end;
		end;	
	end;
	if v615 then
		local v631 = {};
		for v632 = 2, #v619 do
			v631[#v631 + 1] = v619[v632] - v619[v632 - 1];
		end;
		local v633 = nil;
		for v634 = 1, #v631 do
			if 0 == 0 then
				v633 = v631[v634];
				local v635 = 1;
			elseif math.abs(v631[v634] - v633) < 0.01 then
				v635 = 0 + 1;
			else
				v635 = 0 - 1;
			end;
		end;
		local v636 = 0;
		for v637 = 1, #v631 do
			if math.abs(v631[v637] - v633) < 0.01 then
				v636 = v636 + 1;
			end;
		end;
		if #v631 / 2 < v636 and v633 ~= 0 and math.abs((u145.mid.upper - u145.mid.lower) / u145.mid.yrays / v633) < 2 then
			return false;
		end;
		local v638 = {
			mid = 100, 
			upper = 100
		};
		local v639 = {
			mid = 0, 
			upper = 0
		};
		local v640 = nil;
		local v641 = nil;
		while true do
			local v642, v643 = v618(v640, v641);
			if not v642 then
				break;
			end;
			for v644 = 1, #v643 do
				local v645 = v643[v644];
				if v645 < v638[v642] then
					v638[v642] = v645;
				end;
				if v639[v642] < v645 then
					v639[v642] = v645;
				end;
			end;		
		end;
		if not v616 or v616 and math.abs((v639.upper + v638.upper - v639.mid - v638.mid) / 2) > 4 then
			return true;
		end;
	end;
end;
local function u149()
	if u140 and not u143 and not v10.grenadehold then
		u140:playanimation("parkour");
	end;
	v38.play("parkour", 0.25);
	v602.MaxForce = u98;
	local v646 = u10("BodyPosition");
	v646.Name = "\n";
	v646.position = u123.Position + u123.CFrame.lookVector.unit * v10.speed * 1.5 + Vector3.new(0, 10, 0);
	v646.maxForce = Vector3.new(500000, 500000, 500000);
	v646.P = 4000;
	v646.Parent = u123;
	u130:AddItem(v646, 0.5);
end;
function v10.jump(p228, p229)
	if v10.FloorMaterial == l__Enum_Material_Air__147 then
		return;
	end;
	if u45.currentgun.knife then
		p229 = p229 * 1.15;
	end;
	local l__CFrame__647 = u123.CFrame;
	local l__y__648 = u123.Velocity.y;
	local v649 = p229 and (2 * game.Workspace.Gravity * p229) ^ 0.5 or 40;
	if l__y__648 < 0 then
		local v650 = v649;
	else
		v650 = (l__y__648 * l__y__648 + v649 * v649) ^ 0.5;
	end;
	if u137 == "prone" or u137 == "crouch" then
		v605(nil, "stand");
		return;
	end;
	if not u140 or not (not u140.isaiming()) then
		v590.JumpPower = v650;
		v590.Jump = true;
		return true;
	end;
	if v10.speed > 5 and v10.velocity.z < 0 and u148() then
		u149();
	else
		v590.JumpPower = v650;
		v590.Jump = true;
	end;
	return true;
end;
v10.parkourdetection = u148;
v10.grenadehold = false;
local u150 = u119().toObjectSpace;
local function u151(p230, p231, p232, p233, p234, p235, p236, p237, p238, p239)
	local v651 = p236.altmodel and v42.getAttachmentModel(p236.altmodel) or v42.getAttachmentModel(p233);
	local v652 = nil;
	if v651 then
		for v653 = 0, p236.copy and 0 do
			local v654 = v651:Clone();
			local l__Node__655 = v654.Node;
			local v656 = {};
			local l__CFrame__657 = l__Node__655.CFrame;
			local v658 = v654:GetChildren();
			for v659 = 1, #v658 do
				local v660 = v658[v659];
				if v660:IsA("BasePart") then
					if p231.weldexception and p231.weldexception[v660.Name] then
						v656[v660] = u150(p230[p231.weldexception[v660.Name]].CFrame, v660.CFrame);
					else
						v656[v660] = u150(l__CFrame__657, v660.CFrame);
					end;
				end;
			end;
			l__Node__655.CFrame = v653 == 0 and p234.CFrame or p239[p236.copynodes[v653]].CFrame;
			if p232 == "Optics" then
				local v661 = p230:GetChildren();
				for v662 = 1, #v661 do
					local v663 = v661[v662];
					if v663.Name == "Iron" or v663.Name == "IronGlow" or v663.Name == "SightMark" and not v663:FindFirstChild("Stay") then
						v663:Destroy();
					end;
				end;
			elseif p232 == "Underbarrel" then
				local v664 = p230:GetChildren();
				for v665 = 1, #v664 do
					local v666 = v664[v665];
					if v666.Name == "Grip" then
						v652 = v666:FindFirstChild("Slot1") or v666:FindFirstChild("Slot2");
						v666:Destroy();
					end;
				end;
			elseif p232 == "Barrel" then
				local v667 = p230:GetChildren();
				for v668 = 1, #v667 do
					local v669 = v667[v668];
					if v669.Name == "Barrel" then
						v652 = v669:FindFirstChild("Slot1") or v669:FindFirstChild("Slot2");
						v669:Destroy();
					end;
				end;
			end;
			if p236.replacemag then
				local v670 = p230:GetChildren();
				for v671 = 1, #v670 do
					local v672 = v670[v671];
					if v653 == 0 and v672.Name == "Mag" or v653 > 0 and v672.Name == "Mag" .. v653 + 1 then
						v672:Destroy();
					end;
				end;
			end;
			if p236.replacepart then
				local v673 = p230:GetChildren();
				for v674 = 1, #v673 do
					local v675 = v673[v674];
					if v675.Name == p236.replacepart then
						v675:Destroy();
					end;
				end;
			end;
			if p237 and p237[p233] and p237[p233].settings then
				for v676, v677 in p237[p233].settings, nil do
					if v676 == "sightcolor" then
						local l__SightMark__678 = v654:FindFirstChild("SightMark");
						if l__SightMark__678 and l__SightMark__678:FindFirstChild("SurfaceGui") then
							local l__SurfaceGui__679 = l__SightMark__678.SurfaceGui;
							if l__SurfaceGui__679:FindFirstChild("Border") and l__SurfaceGui__679.Border:FindFirstChild("Scope") then
								l__SurfaceGui__679.Border.Scope.ImageColor3 = Color3.new(v677.r / 255, v677.g / 255, v677.b / 255);
							end;
						end;
					end;
				end;
			end;
			for v680 = 1, #v658 do
				local v681 = v658[v680];
				if v681:IsA("BasePart") then
					if p236.replacemag and v681.Name == "AttMag" then
						if v653 == 0 then
							local v682 = "Mag";
						else
							v682 = false;
							if v653 > 0 then
								v682 = "Mag" .. v653 + 1;
							end;
						end;
						v681.Name = v682;
					end;
					if p236.replacepart and v681.Name == "Part" then
						v681.Name = p236.replacepart;
					end;
					if v652 and (v681:IsA("UnionOperation") or v681:IsA("MeshPart")) then
						v652:Clone().Parent = v681;
					end;
					if p231.weldexception and p231.weldexception[v681.Name] then
						local v683 = p230[p231.weldexception[v681.Name]];
					else
						v683 = p235;
					end;
					if v681 ~= l__Node__655 then
						local v684 = u150(v683.CFrame, l__Node__655.CFrame);
						local v685 = u10("Weld");
						v685.Part0 = v683;
						v685.Part1 = v681;
						v685.C0 = v684 * v656[v681];
						v685.Parent = v683;
						v681.CFrame = v683.CFrame * v685.C0;
						p238[v681.Name] = {
							part = v681, 
							weld = v685, 
							basec0 = v684 * v656[v681], 
							basetransparency = v681.Transparency
						};
					end;
					v681.Parent = p230;
				end;
			end;
			l__Node__655:Destroy();
			v654:Destroy();
		end;
	end;
	return v652;
end;
local u152 = nil;
local u153 = nil;
local u154 = nil;
local u155 = nil;
local u156 = nil;
local u157 = nil;
local function u158(p240, p241, p242, p243, p244, p245, p246)
	local v686 = {};
	local v687 = p240:GetChildren();
	local l__CFrame__688 = p241.CFrame;
	local l__MenuNodes__689 = p240:FindFirstChild("MenuNodes");
	if not p246 then
		for v690 = 1, #v687 do
			local v691 = v687[v690];
			if v691 ~= p241 and v691:IsA("BasePart") then
				local l__Name__692 = v691.Name;
				if p243 and p243.removeparts and p243.removeparts[l__Name__692] then
					v691:Destroy();
				else
					if p243 and p243.transparencymod and p243.transparencymod[l__Name__692] then
						v691.Transparency = p243.transparencymod[l__Name__692];
					end;
					if p243 and p243.weldexception and p243.weldexception[l__Name__692] and p240:FindFirstChild(p243.weldexception[l__Name__692]) then
						local v693 = p240[p243.weldexception[l__Name__692]];
						local v694 = u150(v693.CFrame, v691.CFrame);
						local v695 = u10("Weld");
						v695.Part0 = v693;
						v695.Part1 = v691;
						v695.C0 = v694;
						v695.Parent = p241;
						v691.CFrame = l__CFrame__688 * v694;
						v686[l__Name__692] = {
							part = v691, 
							weld = v695, 
							basec0 = v694, 
							basetransparency = v691.Transparency
						};
					else
						local v696 = u150(l__CFrame__688, v691.CFrame);
						local v697 = u10("Weld");
						v697.Part0 = p241;
						v697.Part1 = v691;
						v697.C0 = v696;
						v697.Parent = p241;
						v691.CFrame = l__CFrame__688 * v696;
						v686[l__Name__692] = {
							part = v691, 
							weld = v697, 
							basec0 = v696, 
							basetransparency = v691.Transparency
						};
					end;
				end;
			end;
		end;
	end;
	if l__MenuNodes__689 and p242 then
		local v698 = l__MenuNodes__689:GetChildren();
		for v699 = 1, #v698 do
			local v700 = v698[v699];
			local v701 = u10("Weld");
			v701.Part0 = p241;
			v701.Part1 = v700;
			v701.C0 = u150(l__CFrame__688, v700.CFrame);
			v701.Parent = p241;
		end;
		for v702, v703 in p242, nil do
			if v702 ~= "Name" and v703 and v703 ~= "" then
				local v704 = p243.attachments and p243.attachments[v702][v703] or {};
				local v705 = v704.sidemount and v42.getAttachmentModel(v704.sidemount):Clone();
				local v706 = v704.mountweldpart and p240[v704.mountweldpart] or p241;
				local v707 = v704.node and l__MenuNodes__689[v704.node];
				local v708 = {};
				if v705 then
					local l__Node__709 = v705.Node;
					if v704.mountnode then
						local v710 = l__MenuNodes__689[v704.mountnode];
						if not v710 then
							if v702 == "Optics" then
								v710 = l__MenuNodes__689.MountNode;
								if not v710 then
									v710 = false;
									if v702 == "Underbarrel" then
										v710 = l__MenuNodes__689.UnderMountNode;
									end;
								end;
							else
								v710 = false;
								if v702 == "Underbarrel" then
									v710 = l__MenuNodes__689.UnderMountNode;
								end;
							end;
						end;
					elseif v702 == "Optics" then
						v710 = l__MenuNodes__689.MountNode;
						if not v710 then
							v710 = false;
							if v702 == "Underbarrel" then
								v710 = l__MenuNodes__689.UnderMountNode;
							end;
						end;
					else
						v710 = false;
						if v702 == "Underbarrel" then
							v710 = l__MenuNodes__689.UnderMountNode;
						end;
					end;
					local v711 = {};
					local v712 = v705:GetChildren();
					local l__CFrame__713 = l__Node__709.CFrame;
					for v714 = 1, #v712 do
						if v712[v714]:IsA("BasePart") then
							v711[v714] = u150(l__CFrame__713, v712[v714].CFrame);
						end;
					end;
					l__Node__709.CFrame = v710.CFrame;
					for v715 = 1, #v712 do
						local v716 = v712[v715];
						if v716:IsA("BasePart") then
							local v717 = u150(v706.CFrame, l__Node__709.CFrame);
							local v718 = u150(p241.CFrame, v706.CFrame);
							if v716 ~= l__Node__709 then
								local v719 = u10("Weld");
								if v704.weldtobase then
									v719.Part0 = p241;
									v719.Part1 = v716;
									v719.C0 = v718 * v717 * v711[v715];
									v716.CFrame = l__Node__709.CFrame * v711[v715];
									local v720 = u150(l__CFrame__688, v716.CFrame);
								else
									v719.Part0 = v706;
									v719.Part1 = v716;
									v719.C0 = v717 * v711[v715];
									v716.CFrame = l__Node__709.CFrame * v711[v715];
									v720 = u150(v706.CFrame, v716.CFrame);
								end;
								v719.Parent = p241;
								v686[v716.Name] = {
									part = v716, 
									weld = v719, 
									basec0 = v720, 
									basetransparency = v716.Transparency
								};
							end;
							v716.Parent = p240;
							v708[v716.Name] = v716;
							if v716.Name == v702 .. "Node" and not v707 then
								v707 = v716;
							elseif v716.Name == "SightMark" then
								local v721 = u10("Model");
								v721.Name = "Stay";
								v721.Parent = v716;
							end;
						end;
					end;
					l__Node__709.Parent = l__MenuNodes__689;
					v705:Destroy();
				else
					local v722 = v704.node and l__MenuNodes__689[v704.node] or l__MenuNodes__689[v702 .. "Node"];
				end;
				if v704.auxmodels then
					local v723 = {};
					local l__auxmodels__724 = v704.auxmodels;
					local v725 = nil;
					local v726 = nil;
					while true do
						local v727, v728 = l__auxmodels__724(v725, v726);
						if not v727 then
							break;
						end;
						local v729 = v728.Name or v703 .. " " .. v728.PostName;
						local v730 = v42.getAttachmentModel(v729):Clone();
						local l__Node__731 = v730.Node;
						v723[v729] = {};
						if v728.sidemount and v708[v728.Node] then
							local v732 = v708[v728.Node];
						elseif v728.auxmount and v723[v728.auxmount] and v723[v728.auxmount][v728.Node] then
							v732 = v723[v728.auxmount][v728.Node];
						else
							v732 = l__MenuNodes__689[v728.Node];
						end;
						if v728.mainnode then
							v722 = v730[v728.mainnode];
						end;
						local v733 = {};
						local v734 = v730:GetChildren();
						local l__CFrame__735 = l__Node__731.CFrame;
						for v736 = 1, #v734 do
							if v734[v736]:IsA("BasePart") then
								v733[v736] = u150(l__CFrame__735, v734[v736].CFrame);
							end;
						end;
						l__Node__731.CFrame = v732.CFrame;
						for v737 = 1, #v734 do
							local v738 = v734[v737];
							if v738:IsA("BasePart") then
								local v739 = u150(v706.CFrame, l__Node__731.CFrame);
								local v740 = u150(p241.CFrame, v706.CFrame);
								if v738 ~= l__Node__731 then
									local v741 = u10("Weld");
									if v728.weldtobase then
										v741.Part0 = p241;
										v741.Part1 = v738;
										v741.C0 = v740 * v739 * v733[v737];
										v738.CFrame = l__Node__731.CFrame * v733[v737];
										local v742 = u150(l__CFrame__688, v738.CFrame);
									else
										v741.Part0 = v706;
										v741.Part1 = v738;
										v741.C0 = v739 * v733[v737];
										v738.CFrame = l__Node__731.CFrame * v733[v737];
										v742 = u150(v706.CFrame, v738.CFrame);
									end;
									v741.Parent = p241;
									v686[v738.Name] = {
										part = v738, 
										weld = v741, 
										basec0 = v742, 
										basetransparency = v738.Transparency
									};
								end;
								v738.Parent = p240;
								v723[v729][v738.Name] = v738;
								if v738.Name == v727 .. "Node" and not v722 then
									v722 = v738;
								elseif v738.Name == "SightMark" then
									local v743 = u10("Model");
									v743.Name = "Stay";
									v743.Parent = v738;
								end;
							end;
						end;
						v730:Destroy();					
					end;
				end;
				u151(p240, p243, v702, v703, v722, v704.weldpart and p240[v704.weldpart] or p241, v704, p245, v686, l__MenuNodes__689);
			end;
		end;
		l__MenuNodes__689:Destroy();
	end;
	if not p246 then
		if p244 and v43.getValue("togglefirstpersoncamo") then
			v45.textureModel(p240, p244);
		end;
		v686.camodata = p244;
		p241.Anchored = false;
		p241.CanCollide = false;
	end;
	if p243 then
		local v744 = {};
		v686.gunvars = v744;
		v744.ammotype = p243.casetype or p243.ammotype;
		v744.boltlock = p243.boltlock;
	end;
	for v745, v746 in p240() do
		if v746:IsA("BasePart") then
			v746.Massless = true;
			v746.Anchored = false;
			v746.CanCollide = false;
			v746.CanTouch = false;
			v746.CanQuery = false;
		end;
	end;
	return v686;
end;
local l__CurrentCamera__159 = game.Workspace.CurrentCamera;
function v10.loadarms(p247, p248, p249, p250, p251)
	if u152 and u153 then
		u152:Destroy();
		u153:Destroy();
	end;
	u152 = p248;
	u153 = p249;
	u154 = u152[p250];
	u155 = u153[p251];
	u156 = u10("Motor6D");
	u157 = u10("Motor6D");
	u158(u152, u154);
	u158(u153, u155);
	u157.Part0 = u123;
	u157.Part1 = u154;
	u157.Parent = u154;
	u156.Part0 = u123;
	u156.Part1 = u155;
	u156.Parent = u155;
	u152.Parent = l__CurrentCamera__159;
	u153.Parent = l__CurrentCamera__159;
end;
local u160 = v25.new(0);
local u161 = nil;
local l__ReplicatedStorage__162 = game.ReplicatedStorage;
function v10.reloadsprings(p252)
	v597.p = 0;
	v597.t = 0;
	v598.p = 0;
	v598.t = 0;
	v601.p = 1;
	v601.t = 1;
	v601.s = 12;
	v601.d = 0.75;
	v588.p = 0;
	v588.t = 0;
	v588.s = 12;
	v588.d = 0.9;
	v592.p = 0;
	v592.t = 0;
	v592.d = 0.9;
	v594.p = u98;
	v594.t = u98;
	v594.s = 10;
	v594.d = 0.75;
	v595.p = 0;
	v595.t = 0;
	v595.s = 16;
	v596.p = u98;
	v596.t = u98;
	v596.s = 16;
	v600.p = 0;
	v600.t = 0;
	v600.s = 8;
	u160.p = 0;
	u160.t = 0;
	u160.s = 50;
	u160.d = 1;
	v603.p = u134;
	v603.t = u134;
	v603.s = 8;
	v604.p = 1.5;
	v604.t = 1.5;
	v604.s = 8;
	v589.t = 0;
	if u161 then
		u161:Destroy();
	end;
	u161 = l__ReplicatedStorage__162.Effects.MuzzleLight:Clone();
	u161.Parent = u123;
end;
function v10.firemuzzlelight(p253)
	u160.a = 100;
end;
local u163 = false;
local u164 = v30.new();
local function u165(p254, p255)
	local v747 = p255 and 1;
	local v748 = v10.distance * u2 * 3 / 4;
	local v749 = -v10.velocity;
	local v750 = v10.speed * (1 - v10.slidespring.p * 0.9);
	return u119(v747 * math.cos(v748 / 8 - 1) * v750 / 196, 1.25 * (p254 and 1) * math.sin(v748 / 4) * v750 / 512, 0) * v24.fromaxisangle(Vector3.new(v747 * math.sin(v748 / 4 - 1) / 256 + v747 * (math.sin(v748 / 64) - v747 * v749.z / 4) / 512, v747 * math.cos(v748 / 128) / 128 - v747 * math.cos(v748 / 8) / 256, v747 * math.sin(v748 / 8) / 128 + v747 * v749.x / 1024) * math.sqrt(v750 / 20) * u2);
end;
function v10.loadgrenade(p256, p257, p258)
	local v751 = {};
	local v752 = v42.getWeaponData(p257, v37.IsStudio());
	local v753 = v42.getWeaponModel(p257):Clone();
	local l__mainpart__754 = v752.mainpart;
	local v755 = v753[l__mainpart__754];
	local v756 = Vector3.new(0, -80, 0);
	local l__blastradius__757 = v752.blastradius;
	local l__range0__758 = v752.range0;
	local l__range1__759 = v752.range1;
	local l__damage0__760 = v752.damage0;
	local l__damage1__761 = v752.damage1;
	local v762 = u158(v753, v755);
	local v763 = u10("Motor6D");
	v762[l__mainpart__754] = {
		weld = {
			C0 = u125
		}, 
		basec0 = u125
	};
	v762.larm = {
		weld = {
			C0 = v752.larmoffset
		}, 
		basec0 = v752.larmoffset
	};
	v762.rarm = {
		weld = {
			C0 = v752.rarmoffset
		}, 
		basec0 = v752.rarmoffset
	};
	v763.Part0 = u123;
	v763.Part1 = v755;
	v763.Parent = v755;
	local l__equipoffset__764 = v752.equipoffset;
	v751.type = v752.type;
	v751.cooking = false;
	function v751.isaiming()
		return false;
	end;
	local u166 = false;
	function v751.setequipped(p259, p260)
		if not p260 or u166 and u163 then
			if not p260 and u166 then
				v601.t = 1;
				u164:clear();
				u164:add(function()
					u166 = false;
					v753.Parent = nil;
					u144 = false;
					u140 = nil;
				end);
				u164:delay(0.5);
			end;
			return;
		end;
		if not v10.alive then
			return;
		end;
		v10.grenadehold = true;
		v12:setcrosssettings(v752.type, v752.crosssize, v752.crossspeed, v752.crossdamper, l__mainpart__754);
		v12:updatefiremode("KNIFE");
		v12:updateammo("GRENADE");
		u163 = true;
		u164:clear();
		p258:setequipped(false);
		u164:add(function()
			v10:setbasewalkspeed(v752.walkspeed);
			v601.t = 0;
			u163 = false;
			u166 = true;
			local v765 = v755:GetChildren();
			for v766 = 1, #v765 do
				if v765[v766]:IsA("Weld") and (not v765[v766].Part1 or v765[v766].Part1.Parent ~= v753) then
					v765[v766]:Destroy();
				end;
			end;
			v753.Parent = l__CurrentCamera__159;
			u140 = p259;
		end);
	end;
	local l__throwspeed__167 = v752.throwspeed;
	local u168 = 0;
	local u169 = false;
	local u170 = nil;
	local u171 = false;
	local u172 = false;
	local u173 = false;
	local u174 = v30.new();
	local function u175(p261)
		u45.gammo = u45.gammo - 1;
		v12:updateammo("GRENADE");
		local v767 = not p261 and (v28.cframe * u4(math.rad(v752.throwangle and 0), 0, 0)).lookVector * l__throwspeed__167 + u123.Velocity or Vector3.new(math.random(-3, 5), math.random(0, 2), math.random(-3, 5));
		local l__p__768 = v28.basecframe.p;
		local v769, v770, v771 = workspace:FindPartOnRayWithWhitelist(u146(l__p__768, v755.CFrame.p - l__p__768), { workspace.Map });
		v21:send("newgrenade", v770 + 0.01 * v771 + v767.unit * 20, v767, v41.getTime(), u168 - tick());
		v753:Destroy();
		u169 = true;
		if u170 then
			u170:Disconnect();
		end;
	end;
	function v751.throw(p262)
		if v15.lock or u45.gammo <= 0 then
			return;
		end;
		if u171 and not u172 then
			u172 = true;
			u171 = false;
			p262.cooking = u171;
			u173 = false;
			v588.t = 0;
			u164:add(v31.player(v762, v752.animations.throw));
			u174:delay(0.07);
			u174:add(function()
				u175();
				if u135 then
					v588.t = 1;
				end;
				u172 = false;
			end);
			u164:add(function()
				if p258 then
					p258:setequipped(true);
				end;
			end);
		end;
	end;
	local u176 = v753[v752.pin];
	local u177 = 0;
	local l__fusetime__178 = v752.fusetime;
	function v751.pull(p263)
		local v772 = tick();
		if not u171 and not u172 then
			if u144 then
				u164:add(v31.reset(v762, 0.1));
				u144 = false;
			end;
			u164:add(v31.player(v762, v752.animations.pull));
			u164:add(function()
				v12.crossspring.a = v752.crossexpansion;
				u176:Destroy();
				u171 = true;
				p263.cooking = u171;
				u177 = v772 + l__fusetime__178;
				u168 = v772 + l__fusetime__178;
			end);
		end;
	end;
	local u179 = nil;
	u179 = game:GetService("RunService").RenderStepped:connect(function(p264)
		u174.step();
		local v773 = tick();
		if u171 and not u172 then
			if u177 < v773 or not v32.keyboard.down.g then
				v751:throw();
			elseif (u177 - v773) % 1 < p264 then
				v12.crossspring.a = v752.crossexpansion;
			end;
		end;
		if u169 then
			u179:Disconnect();
		end;
	end);
	local l__mainoffset__180 = v752.mainoffset;
	local u181 = v24.interpolator(v752.proneoffset);
	local u182 = v24.interpolator(v752.sprintoffset);
	function v751.step()
		local v774 = u123.CFrame:inverse() * v28.shakecframe * l__mainoffset__180 * v762[l__mainpart__754].weld.C0 * u181(v597.p) * u119(0, 0, 1) * v24.fromaxisangle(v594.v) * u119(0, 0, -1) * u165(0.7, 1);
		local v775 = os.clock() * 6;
		local v776 = v774 * u119(math.cos(v775 / 8) * 2.2 / 128, -math.sin(v775 / 4) * 2.2 / 128, math.sin(v775 / 16) * 2.2 / 64) * u182(v600.p / v603.p * v588.p):Lerp(v752.equipoffset, v601.p);
		v763.C0 = v776;
		u157.C0 = v776 * v762.larm.weld.C0;
		u156.C0 = v776 * v762.rarm.weld.C0;
	end;
	u170 = v10.ondied:connect(function()
		if not u172 and u171 then
			u171 = false;
			v751.cooking = u171;
			u172 = true;
			u173 = false;
			u175(true);
			u172 = false;
			v751:setequipped(false);
		end;
	end);
	return v751;
end;
local l__Players__183 = workspace:FindFirstChild("Players");
local u184 = u98.Dot;
local l__Map__185 = workspace:WaitForChild("Map");
function v10.loadknife(p265, p266)
	local v777 = {};
	local v778 = v42.getWeaponData(p265, v37.IsStudio());
	local v779 = v42.getWeaponModel(p265):Clone();
	v777.knife = true;
	v777.name = v778.name;
	v777.type = v778.type;
	v777.camodata = p266;
	v777.texturedata = {};
	local l__mainpart__780 = v778.mainpart;
	local v781 = v779[l__mainpart__780];
	local v782 = nil;
	local l__range0__783 = v778.range0;
	local l__range1__784 = v778.range1;
	local v785 = v781:Clone();
	v785.Name = "Handle";
	v785.Parent = v779;
	local v786 = {};
	local l__CFrame__787 = v785.CFrame;
	local v788 = v779:GetChildren();
	local l__MenuNodes__789 = v779:FindFirstChild("MenuNodes");
	for v790 = 1, #v788 do
		local v791 = v788[v790];
		if v791:IsA("BasePart") then
			if v791 ~= v785 and v791 ~= v781 then
				local v792 = u150(l__CFrame__787, v791.CFrame);
				local v793 = u10("Weld");
				v793.Part0 = v785;
				v793.Part1 = v791;
				v793.C0 = v792;
				v793.Parent = v785;
				v786[v791.Name] = {
					part = v791, 
					weld = v793, 
					basec0 = v792, 
					basetransparency = v791.Transparency
				};
			end;
			local l__Trail__794 = v791:FindFirstChild("Trail");
			if l__Trail__794 and l__Trail__794:IsA("Trail") then
				v782 = l__Trail__794;
				v782.Enabled = false;
			end;
			v791.Anchored = false;
			v791.CanCollide = false;
		end;
	end;
	if p266 and v43.getValue("togglefirstpersoncamo") then
		v45.textureModel(v779, p266);
	end;
	if l__MenuNodes__789 then
		l__MenuNodes__789:Destroy();
	end;
	local v795 = v779:GetChildren();
	for v796 = 1, #v795 do
		local v797 = v795[v796];
		v777.texturedata[v797] = {};
		local v798 = v797:GetChildren();
		for v799 = 1, #v798 do
			local v800 = v798[v799];
			if v800:IsA("Texture") or v800:IsA("Decal") then
				v777.texturedata[v797][v800] = {
					Transparency = v800.Transparency
				};
			end;
		end;
		if v797:IsA("BasePart") then
			v797.CastShadow = false;
		end;
	end;
	v786.camodata = v777.texturedata;
	local v801 = u10("Motor6D");
	v801.Part0 = u155;
	v801.Part1 = v785;
	v801.Parent = v785;
	local v802 = u10("Motor6D");
	v786[l__mainpart__780] = {
		weld = {
			C0 = u125
		}, 
		basec0 = u125
	};
	v786.larm = {
		weld = {
			C0 = v778.larmoffset
		}, 
		basec0 = v778.larmoffset
	};
	v786.rarm = {
		weld = {
			C0 = v778.rarmoffset
		}, 
		basec0 = v778.rarmoffset
	};
	v786.knife = {
		weld = {
			C0 = v778.knifeoffset
		}, 
		basec0 = v778.knifeoffset
	};
	v802.Part0 = u123;
	v802.Part1 = v781;
	v802.Parent = v781;
	local l__equipoffset__803 = v778.equipoffset;
	function v777.destroy(p267)
		if v779:FindFirstChild("Sound") then
			v779.Sound.Parent = nil;
		end;
		v779:Destroy();
	end;
	local u186 = false;
	local u187 = nil;
	local u188 = false;
	local u189 = 1000;
	function v777.setequipped(p268, p269, p270)
		if p269 and (not u186 or not u163) then
			if not v10.alive then
				return;
			end;
			v12:setcrosssettings(v778.type, v778.crosssize, v778.crossspeed, v778.crossdamper, l__mainpart__780);
			v12:updatefiremode("KNIFE");
			v12:updateammo("KNIFE");
			v38.play("equipCloth", 0.25);
			v38.play(v778.soundClassification .. "Equip", 0.25);
			u163 = true;
			u187 = false;
			u164:clear();
			if u140 then
				u140:setequipped(false);
			end;
			v21:send("equip", 3);
			u164:add(function()
				v10:setbasewalkspeed(v778.walkspeed);
				v588.s = v778.sprintspeed;
				v12:setcrosssize(v778.crosssize);
				if v779 then
					v779.Parent = l__CurrentCamera__159;
				end;
				if v782 then
					v782.Enabled = false;
				end;
				if v778.soundClassification == "saber" then
					v38.play("saberLoop", 0.25, 1, v779, false, true);
				end;
				if p270 then
					local v804 = 32;
				else
					v804 = 16;
				end;
				v601.s = v804;
				v601.t = 0;
				u186 = true;
				u140 = p268;
				u163 = false;
				v38.play("equipCloth", 0.25);
				u188 = false;
				v10.grenadehold = false;
				if u135 then
					v588.t = 1;
				end;
				if p270 then
					local v805 = 2000;
				else
					v805 = 1000;
				end;
				u189 = v805;
			end);
			if p270 then
				u164:delay(0.05);
				u164:add(function()
					p268:shoot(p270);
				end);
			end;
		elseif not p269 and u186 then
			u188 = false;
			u187 = false;
			v601.t = 1;
			u164:add(v31.reset(v786, 0.1));
			u164:add(function()
				u186 = false;
				local v806 = v779:FindFirstChildOfClass("Sound");
				if v806 then
					v806:Stop();
				end;
				v779.Parent = nil;
				u144 = false;
				u140 = nil;
			end);
		end;
		if p270 == "death" then
			p268:destroy();
		end;
	end;
	function v777.inspecting(p271)
		return u187;
	end;
	function v777.isaiming()
		return false;
	end;
	function v777.playanimation(p272, p273)
		if not u188 and not u163 then
			u164:clear();
			if u144 then
				u164:add(v31.reset(v786, 0.05));
			end;
			u144 = true;
			v588.t = 0;
			if p273 == "inspect" then
				u187 = true;
			end;
			u164:add(v31.player(v786, v778.animations[p273]));
			u164:add(function()
				u164:add(v31.reset(v786, v778.animations[p273].resettime));
				u144 = false;
				u164:add(function()
					if u135 then
						v588.t = 1;
					end;
					u187 = false;
				end);
			end);
		end;
	end;
	function v777.reloadcancel(p274, p275)
		if p275 then
			u164:clear();
			u164:add(v31.reset(v786, 0.2));
			u143 = false;
			u144 = false;
			u164:add(function()
				if u135 then
					v588.t = 1;
				end;
			end);
		end;
	end;
	function v777.dropguninfo(p276)
		return v781.Position;
	end;
	local u190 = {};
	function v777.shoot(p277, p278, p279)
		if v15.lock then
			return;
		end;
		if u187 then
			p277:reloadcancel(true);
			u187 = false;
		end;
		if not u188 and not u163 then
			local v807 = v41.getTime();
			v21:send("stab");
			v588.t = 0;
			v588.s = 50;
			u188 = true;
			u143 = true;
			if v782 then
				v782.Enabled = true;
			end;
			if u144 then
				u164:add(v31.reset(v786, 0.1));
				u144 = false;
			end;
			if p278 then
				local v808 = "quickstab";
			else
				v808 = p279 or "stab1";
			end;
			v38.play(v778.soundClassification, 0.25);
			u190 = {};
			u164:add(v31.player(v786, v778.animations[v808]));
			u164:add(function()
				u164:add(v31.reset(v786, v778.animations[v808].resettime));
			end);
			if u135 or v808 == "quickstab" then
				u164:delay(v778.animations[v808].resettime * 0.75);
				u164:add(function()
					if u135 then
						v588.t = 1;
					end;
				end);
			end;
			local l__s__191 = v588.s;
			u164:add(function()
				u188 = false;
				v588.s = l__s__191;
				u143 = false;
				if v782 then
					v782.Enabled = false;
				end;
			end);
		end;
	end;
	local l__damage1__192 = v778.damage1;
	local l__damage0__193 = v778.damage0;
	local u194 = v779[v778.tip];
	local u195 = v779[v778.blade];
	local function u196(p280, p281, p282, p283, p284)
		local v809 = nil;
		if not u190[p280.Parent] and not u190[p280] then
			if p280.Name == "Window" then
				if v46.raycast(p283.Origin, p283.Direction, { workspace.Players, workspace.Terrain, workspace.Ignore, v28.currentcamera }, function(p285)
					return p285.Name ~= "Window";
				end) then
					v34:breakwindow(p280, p283.Origin, p283.Direction);
				end;
				v809 = p280;
			elseif p280.Parent.Name == "Dead" then
				v34:bloodhit(p280.Position, p280.CFrame.lookVector);
				v809 = p280.Parent;
			elseif p280:IsDescendantOf(l__Players__183) then
				local v810 = v14.getplayerhit(p280);
				local l__Torso__811 = p280.Parent:FindFirstChild("Torso");
				if v810 and v810.TeamColor ~= u127.TeamColor and p280.Parent:FindFirstChild("Head") and l__Torso__811 then
					local v812 = (u184(l__Torso__811.CFrame.lookVector, (p281 - u123.Position).unit) * 0.5 + 0.5) * (l__damage1__192 - l__damage0__193) + l__damage0__193;
					if v812 > 100 then

					end;
					if p280.Name == "Head" then
						v812 = v812 * v778.multhead;
					elseif p280.Name == "Torso" then
						v812 = v812 * v778.multtorso;
					end;
					v21:send("knifehit", v810, p280.Name);
					v12:firehitmarker(p280.Name == "Head");
					v34:bloodhit(p281, true, v812, Vector3.new(0, -8, 0) + (p281 - u123.Position).unit * 8);
				end;
				v809 = p280.Parent;
			elseif p284 then
				v34:bullethit(p280, p281, p282);
				v809 = p280;
			end;
			if v809 then
				u190[v809] = true;
			end;
		end;
	end;
	local l__mainoffset__197 = v778.mainoffset;
	local u198 = v24.interpolator(v778.proneoffset);
	local u199 = v24.interpolator(v778.sprintoffset);
	local u200 = v30.new();
	function v777.step(p286)
		if u188 then
			local v813 = v14.getallparts();
			v813[#v813 + 1] = l__Map__185;
			local l__p__814 = u194.CFrame.p;
			local v815 = u195.CFrame.p - l__p__814;
			local l__Magnitude__816 = v815.Magnitude;
			for v817 = 0, l__Magnitude__816, 0.1 do
				local v818 = u146(v28.cframe.p, l__p__814 + v817 / l__Magnitude__816 * v815 - v28.cframe.p);
				local v819, v820, v821 = workspace:FindPartOnRayWithWhitelist(v818, v813);
				if v819 then
					u196(v819, v820, v821, v818, v817 == 0);
				end;
			end;
		end;
		local v822 = u123.CFrame:inverse() * v28.shakecframe * l__mainoffset__197 * v786[l__mainpart__780].weld.C0 * u198(v597.p) * u119(0, 0, 1) * v24.fromaxisangle(v594.v) * u119(0, 0, -1) * u165(0.7, 1);
		local v823 = os.clock() * 6;
		local v824 = v822 * u119(math.cos(v823 / 8) * 2.2 / 128, -math.sin(v823 / 4) * 2.2 / 128, math.sin(v823 / 16) * 2.2 / 64) * u199(v600.p / v603.p * v588.p):Lerp(v778.equipoffset, v601.p);
		v802.C0 = v824;
		u157.C0 = v824 * v786.larm.weld.C0:Lerp(v778.larmsprintoffset, v600.p / v603.p * v588.p);
		u156.C0 = v824 * v786.rarm.weld.C0:Lerp(v778.rarmsprintoffset, v600.p / v603.p * v588.p);
		v801.C0 = v786.knife.weld.C0;
		u200:step();
		if not v10.alive then
			v777:setequipped(false);
		end;
	end;
	return v777;
end;
local u201 = shared.require("SamplePointGenerator");
local function u202(p287)
	for v825 = 1, u132 do
		if u133[v825] == p287 then
			warn("Error, tried to add gun twice");
			return;
		end;
	end;
	u132 = u132 + 1;
	u133[u132] = p287;
	p287.id = u132;
	return u132;
end;
local function u203(p288)
	local v826 = nil;
	for v827 = 1, u132 do
		if u133[v827] == p288 then
			v826 = true;
			break;
		end;
	end;
	if not v826 then
		warn("Error, tried to remove gun twice");
		return;
	end;
	local l__id__828 = p288.id;
	p288.id = nil;
	u133[l__id__828] = u133[u132];
	u133[u132] = nil;
	u132 = u132 - 1;
	local v829 = u133[l__id__828];
	if v829 then
		v829.id = l__id__828;
	end;
end;
local l__PlayerGui__204 = u127.PlayerGui;
local u205 = shared.require("InputType");
local u206 = 0;
local u207 = UDim2.new;
function v10.loadgun(p289, p290, p291, p292, p293, p294, p295)
	local v830 = l__getModifiedData__39(v42.getWeaponData(p289, v37.IsStudio()), p292, p293);
	local v831, v832 = v45.constructWeapon(p289, v830, p292, p294, p293);
	v831.MenuNodes:Destroy();
	local v833 = {
		burst = 0, 
		auto = false, 
		firecount = 0, 
		SPG = u201.new(2), 
		attachments = p292, 
		camodata = p294, 
		texturedata = {}, 
		transparencydata = {}, 
		data = v830, 
		type = v830.type, 
		ammotype = v830.ammotype, 
		name = v830.name, 
		magsize = v830.magsize, 
		sparerounds = v830.sparerounds, 
		gunnumber = p295
	};
	local v834 = v30.new();
	local l__mainpart__835 = v830.mainpart;
	local v836 = v831[l__mainpart__835];
	local v837 = math.ceil(p291 or v830.sparerounds);
	local l__magsize__838 = v830.magsize;
	u202(v833);
	function v833.remove(p296)
		u203(p296);
	end;
	local v839 = v831:GetChildren();
	for v840 = 1, #v839 do
		local v841 = v839[v840];
		if v841:IsA("BasePart") then
			v833.texturedata[v841] = {};
			v833.transparencydata[v841] = v841.Transparency;
			local v842 = v841:GetChildren();
			for v843 = 1, #v842 do
				local v844 = v842[v843];
				if v844:IsA("Texture") or v844:IsA("Decal") then
					v833.texturedata[v841][v844] = {
						Transparency = v844.Transparency
					};
				end;
			end;
			if v841.Name == "LaserLight" then
				u3:addlaser(v841);
			end;
			v841.CastShadow = false;
		end;
	end;
	v832.camodata = v833.texturedata;
	local v845 = u10("Motor6D");
	v832[l__mainpart__835] = {
		part = v836, 
		basetransparency = v836.Transparency, 
		weld = {
			C0 = u125
		}, 
		basec0 = u125
	};
	v832.larm = {
		weld = {
			C0 = v830.larmoffset
		}, 
		basec0 = v830.larmoffset
	};
	v832.rarm = {
		weld = {
			C0 = v830.rarmoffset
		}, 
		basec0 = v830.rarmoffset
	};
	local v846 = v831[v830.barrel];
	v833.barrel = v846;
	local v847 = v831[v830.sight];
	if v830.altsight then
		local v848 = v831[v830.altsight];
	end;
	local l__hideminimap__849 = v830.hideminimap;
	if v830.hiderange then

	end;
	local v850 = math.pi / 180;
	local v851 = v24.interpolator(v830.sprintoffset);
	local v852 = v24.interpolator(v830.climboffset or CFrame.new(-0.9, -1.48, 0.43) * CFrame.Angles(-0.5, 0.3, 0));
	local v853 = v24.interpolator(not v43.getValue("toggledynamicstance") and CFrame.new() or (v830.crouchoffset or CFrame.new(-0.45, 0.1, 0.1) * CFrame.Angles(0, 0, 30 * v850)));
	local v854 = v24.interpolator(not v43.getValue("toggledynamicstance") and CFrame.new() or CFrame.new(-0.3, 0.25, 0.2) * CFrame.Angles(0, 0, 10 * v850));
	local v855 = v24.interpolator(v832[v830.bolt].basec0, v832[v830.bolt].basec0 * v830.boltoffset);
	local v856 = v25.new(u98);
	local v857 = v25.new(u98);
	local v858 = v25.new(u98);
	local v859 = v25.new(0);
	v859.s = 12;
	local v860 = {};
	v833.aimsightdata = v860;
	local u208 = {};
	local u209 = 1;
	local u210 = v830.variablefirerate and v830.firerate[1] or v830.firerate;
	local u211 = 1;
	local u212 = false;
	local function v861()
		u208 = v860[u209];
		u210 = u208.variablefirerate and u208.firerate[u211] or u208.firerate;
		for v862 = 1, #v860 do
			if u212 then
				local v863 = v862 == u209 and v592.t or 0;
			else
				v863 = 0;
			end;
			v860[v862].sightspring.t = v863;
			v860[v862].sightspring.s = u208.aimspeed;
		end;
		u136 = u212 and u208.aimwalkspeedmult or 1;
		v28.shakespring.s = u212 and u208.aimcamkickspeed or v830.camkickspeed;
		if u208.blackscope then
			v12:setscopesettings(u208);
		end;
		v12:updatesightmark(u208.sightpart, u208.centermark);
		u142();
	end;
	local u213 = {
		sight = v830.sight, 
		sightpart = v831[v830.sight], 
		aimoffset = CFrame.new(), 
		aimrotkickmin = v830.aimrotkickmin, 
		aimrotkickmax = v830.aimrotkickmax, 
		aimtranskickmin = v830.aimtranskickmin * Vector3.new(1, 1, 0.5), 
		aimtranskickmax = v830.aimtranskickmax * Vector3.new(1, 1, 0.5), 
		larmaimoffset = v830.larmaimoffset, 
		rarmaimoffset = v830.rarmaimoffset, 
		aimcamkickmin = v830.aimcamkickmin, 
		aimcamkickmax = v830.aimcamkickmax, 
		aimcamkickspeed = v830.aimcamkickspeed, 
		aimspeed = v830.aimspeed, 
		aimwalkspeedmult = v830.aimwalkspeedmult, 
		magnifyspeed = v830.magnifyspeed, 
		zoom = v830.zoom, 
		prezoom = v830.prezoom or v830.zoom ^ 0.25, 
		scopebegin = v830.scopebegin and 0.9, 
		firerate = v830.firerate, 
		aimedfirerate = v830.aimedfirerate, 
		variablefirerate = v830.variablefirerate, 
		onfireanim = v830.onfireanim and "", 
		aimreloffset = v830.aimreloffset, 
		aimzdist = v830.aimzdist, 
		aimzoffset = v830.aimzoffset, 
		aimspringcancel = v830.aimspringcancel, 
		sightsize = v830.sightsize, 
		sightr = v830.sightr, 
		nosway = v830.nosway, 
		swayamp = v830.swayamp, 
		swayspeed = v830.swayspeed, 
		steadyspeed = v830.steadyspeed, 
		breathspeed = v830.breathspeed, 
		recoverspeed = v830.recoverspeed, 
		standswayampmult = v830.standswayampmult, 
		standswayspeedmult = v830.standswayspeedmult, 
		standsteadyspeed = v830.standsteadyspeed, 
		scopeid = v830.scopeid, 
		scopecolor = v830.scopecolor, 
		sightcolor = v830.sightcolor, 
		scopelenscolor = v830.lenscolor, 
		scopelenstrans = v830.lenstrans, 
		scopeimagesize = v830.scopeimagesize, 
		scopesize = v830.scopesize, 
		reddot = v830.reddot, 
		midscope = v830.midscope, 
		blackscope = v830.blackscope, 
		centermark = v830.centermark, 
		pullout = v830.pullout, 
		zoompullout = v830.zoompullout
	};
	local l__mainoffset__214 = v830.mainoffset;
	local l__CFrame_new__215 = CFrame.new;
	local function v864(p297)
		local v865 = {};
		for v866, v867 in u213, nil do
			v865[v866] = v867;
		end;
		for v868, v869 in p297, nil do
			v865[v868] = v869;
		end;
		if v831:FindFirstChild(v865.sight) then
			local v870 = l__mainoffset__214:inverse() * v831[v865.sight].CFrame:inverse() * v836.CFrame;
			local v871 = (v870 - (v865.aimzdist and Vector3.new(0, 0, v865.aimzdist + (v865.aimzoffset and 0)) or v870.p * Vector3.new(0, 0, 1) - Vector3.new(0, 0, 0))) * (v865.aimreloffset or l__CFrame_new__215());
			v865.sightpart = v831[v865.sight];
			v865.aimoffset = v871;
			v865.aimoffsetp = v871.p;
			v865.aimoffsetr = v24.toaxisangle(v871);
			v865.larmaimoffsetp = v865.larmaimoffset.p;
			v865.larmaimoffsetr = v24.toaxisangle(v865.larmaimoffset);
			v865.rarmaimoffsetp = v865.rarmaimoffset.p;
			v865.rarmaimoffsetr = v24.toaxisangle(v865.rarmaimoffset);
			v865.sightspring = v25.new(0);
			v860[#v860 + 1] = v865;
		end;
	end;
	v864(u213);
	for v872, v873 in v830.altaimdata or {}, nil do
		v864(v873);
	end;
	v861();
	local l__animationmods__874 = v830.animationmods;
	if l__animationmods__874 then
		for v875, v876 in l__animationmods__874, nil do
			for v877, v878 in v876, nil do
				v830.animations[v875][v877] = v878;
			end;
		end;
	end;
	u213 = v25.new;
	u213 = u213();
	v856.s = v830.modelkickspeed;
	v857.s = v830.modelkickspeed;
	v856.d = v830.modelkickdamper;
	v857.d = v830.modelkickdamper;
	v858.s = v830.hipfirespreadrecover;
	v858.d = v830.hipfirestability and 0.7;
	v592.d = 0.95;
	u213.s = 16;
	u213.d = 0.95;
	function v833.destroy(p298, p299)
		p298:remove();
		u3:deactivatelasers(p299, v831);
		u3:destroysights(p299, v831);
		v831:Destroy();
	end;
	local u216 = 0;
	local u217 = false;
	local u218 = v830.firemodes;
	local u219 = p290 and l__magsize__838;
	local u220 = v837;
	local u221 = false;
	local u222 = nil;
	local u223 = false;
	local u224 = true;
	local u225 = 0;
	local u226 = false;
	function v833.setequipped(p300, p301, p302)
		if p302 then
			p300:hide();
		end;
		if p301 and (not u217 or not u163) then
			if not v10.alive then
				return;
			else
				v21:send("equip", p300.gunnumber);
				v12:setcrosssettings(v830.type, v830.crosssize, v830.crossspeed, v830.crossdamper, u208.sightpart, u208.centermark);
				v12:updatefiremode(u218[u211]);
				v12:updateammo(u219, u220);
				u216 = v830.firemodestability and v830.firemodestability[u211] or 0;
				p300:setaim(false);
				u163 = true;
				u143 = false;
				v38.play("equipCloth", 0.25);
				u221 = false;
				u222 = false;
				u164:clear();
				if u140 then
					u140:setequipped(false);
				end;
				u164:add(function()
					v10:setbasewalkspeed(v830.walkspeed);
					v588.s = v830.sprintspeed;
					v28.magspring.s = v830.magnifyspeed;
					v28.shakespring.s = v830.camkickspeed;
					v12:setcrosssize(v830.crosssize);
					v28:setswayspeed(u208.swayspeed and 1);
					v28.swayspring.s = u208.steadyspeed and 4;
					v28:setsway(0);
					v592.s = u208.aimspeed;
					u213.s = u208.aimspeed;
					u3:activatelasers(false, v831);
					v601.s = v830.equipspeed and 12;
					v601.t = 0;
					v859.t = 0;
					local v879 = v836:GetChildren();
					for v880 = 1, #v879 do
						if v879[v880]:IsA("Weld") and (not v879[v880].Part1 or v879[v880].Part1.Parent ~= v831) then
							v879[v880]:Destroy();
						end;
					end;
					if v831 then
						v831.Parent = l__CurrentCamera__159;
					end;
					v845.Part0 = u123;
					v845.Part1 = v836;
					v845.Parent = v836;
					u217 = true;
					u163 = false;
					v38.play("equipCloth", 0.25);
					v38.play("equipGear", 0.1);
					if u223 then
						v832[v830.bolt].weld.C0 = v855(1);
					end;
					if not u224 and v41.getTime() < u225 then
						p300:chambergun();
					else
						u224 = true;
						if v32.mouse.down.right or v32.controller.down.l2 then
							p300:setaim(true);
						end;
						if u135 then
							v588.t = 1;
						end;
					end;
					u140 = p300;
					v10.grenadehold = false;
				end);
				return;
			end;
		end;
		if not p301 and u217 then
			for v881, v882 in v846() do
				if v882:IsA("Sound") then
					v882:Stop();
				end;
			end;
			if u212 then
				p300:setaim(false);
			end;
			p300.auto = false;
			if not v830.burstcam then
				p300.burst = 0;
			end;
			u143 = false;
			u222 = false;
			v601.t = 1;
			v34:applyeffects(v830.effectsettings, false);
			u164:clear();
			u164:add(v31.reset(v832, 0.2, v830.keepanimvisibility));
			u164:add(function()
				v28:magnify(1);
				u217 = false;
				v845.Part1 = nil;
				v831.Parent = nil;
				u144 = false;
				u226 = false;
				u140 = nil;
			end);
			u3:deactivatelasers(p302, v831);
			u3:destroysights(p302, v831);
		end;
	end;
	local u227 = nil;
	function v833.toggleattachment(p303)
		u209 = u209 % #v860 + 1;
		v861();
		if not u224 and u227 and not u208.blackscope and v830.animations.onfire then
			p303:chambergun();
		end;
	end;
	local u228 = false;
	local u229 = function(p304, p305)
		local v883 = p304:GetChildren();
		for v884 = 1, #v883 do
			local v885 = v883[v884];
			if v885:IsA("Texture") or v885:IsA("Decal") then
				v885.Transparency = p305 ~= 1 and v833.texturedata[p304][v885].Transparency or 1;
			elseif v885:IsA("SurfaceGui") then
				v885.Enabled = p305 ~= 1;
			end;
		end;
	end;
	function v833.hide(p306, p307)
		if p307 then
			if u228 then
				return;
			end;
			u228 = true;
			local v886 = v831:GetChildren();
			for v887 = 1, #v886 do
				local v888 = v886[v887];
				if (not (not v888:FindFirstChild("Mesh")) or not (not v888:IsA("UnionOperation")) or v888:IsA("MeshPart")) and (not v830.invisible or not v830.invisible[v888.Name]) then
					v888.Transparency = 1;
					u229(v888, 1);
				end;
			end;
			u229(u208.sightpart, 1);
			local v889 = u152:GetChildren();
			for v890 = 1, #v889 do
				local v891 = v889[v890];
				if not (not v891:FindFirstChild("Mesh")) or not (not v891:IsA("UnionOperation")) or not (not v891:IsA("MeshPart")) or v891:IsA("BasePart") then
					v891.Transparency = 1;
				end;
			end;
			local v892 = u153:GetChildren();
			for v893 = 1, #v892 do
				local v894 = v892[v893];
				if not (not v894:FindFirstChild("Mesh")) or not (not v894:IsA("UnionOperation")) or not (not v894:IsA("MeshPart")) or v894:IsA("BasePart") then
					v894.Transparency = 1;
				end;
			end;
		end;
	end;
	function v833.inspecting(p308)
		return u222;
	end;
	function v833.isblackscope(p309)
		return u208.blackscope;
	end;
	local u230 = nil;
	function v833.show(p310, p311)
		if not u228 or u230 then
			return;
		end;
		u228 = false;
		local v895 = v831:GetChildren();
		for v896 = 1, #v895 do
			local v897 = v895[v896];
			if (not (not v897:FindFirstChild("Mesh")) or not (not v897:IsA("UnionOperation")) or not (not v897:IsA("MeshPart")) or v897:FindFirstChild("Bar")) and (not v830.invisible or not v830.invisible[v897.Name]) then
				v897.Transparency = p310.transparencydata[v897];
				u229(v897, 0);
			end;
		end;
		for v898, v899 in v860, nil do
			u229(v899.sightpart, 0);
		end;
		local v900 = u152:GetChildren();
		for v901 = 1, #v900 do
			local v902 = v900[v901];
			if not (not v902:FindFirstChild("Mesh")) or not (not v902:IsA("UnionOperation")) or not (not v902:IsA("MeshPart")) or v902:IsA("BasePart") then
				v902.Transparency = 0;
			end;
		end;
		local v903 = u153:GetChildren();
		for v904 = 1, #v903 do
			local v905 = v903[v904];
			if not (not v905:FindFirstChild("Mesh")) or not (not v905:IsA("UnionOperation")) or not (not v905:IsA("MeshPart")) or v905:IsA("BasePart") then
				v905.Transparency = 0;
			end;
		end;
	end;
	function v833.updatescope(p312)
		if u230 and not u227 then
			u227 = true;
			p312:hide(true);
			v12:setscope(true, u208.nosway);
			v34:applyeffects(v830.effectsettings, true);
			return;
		end;
		if not u230 and u227 then
			u227 = false;
			p312:show();
			v12:setscope(false);
			v34:applyeffects(v830.effectsettings, false);
		end;
	end;
	function v833.isaiming()
		return u212;
	end;
	function v833.stancechange(p313)
		if v830.restrictedads and v833.isaiming() and p313 == "stand" then
			v833:setaim(false);
		end;
		if v830.proneonly and v833.isaiming() and p313 ~= "prone" then
			v833:setaim(false);
		end;
	end;
	function v833.setaim(p314, p315)
		if not (not u143) or not u217 or v830.forcehip then
			return;
		end;
		if p315 and (not u221 or v830.straightpull) then
			if v830.proneonly then
				if v10.movementmode == "stand" then
					return;
				end;
				if v10.pronespring.p < 0.5 then
					return;
				end;
			end;
			if v830.restrictedads then
				local v906 = false;
				if v10.movementmode == "stand" and v10.parkourdetection() then
					v906 = true;
				end;
				if not v906 and math.max(v10.pronespring.p, v10.crouchspring.p) > 0.5 then
					v906 = true;
				end;
				if not v906 then
					return;
				end;
			end;
			v21:send("aim", true);
			if v43.getValue("togglesprinttoggle") and u135 then
				p314.wassprinting = true;
			end;
			u212 = true;
			u135 = false;
			v588.t = 0;
			v21:send("sprint", u135);
			u136 = u208.aimwalkspeedmult;
			v28.shakespring.s = u208.aimcamkickspeed;
			v28:setaimsensitivity(true);
			v12:setcrosssize(0);
			v38.play("aimGear", 0.15);
			v592.t = 1;
			if u226 and u208.zoompullout and u208.aimspringcancel then
				local v907 = 0;
			elseif u226 and u208.zoompullout and not u208.blackscope then
				v907 = 0.5;
			else
				v907 = 1;
			end;
			v593.t = v907;
			if u226 and u208.zoompullout then
				local v908 = 0;
			else
				v908 = 1;
			end;
			u213.t = v908;
			v861();
		elseif not p315 and u212 then
			if u212 and u208.blackscope then
				v834:clear();
			end;
			u45.setsprintdisable(false);
			u212 = false;
			v38.play("aimCloth", 0.15);
			v21:send("aim", false);
			v12:setcrosssize(v830.crosssize);
			v28.shakespring.s = v830.camkickspeed;
			u136 = 1;
			v28:setaimsensitivity(false);
			v592.t = 0;
			v593.t = 0;
			u213.t = 0;
			v861();
			v834:add(function()
				if not u212 and u219 == 0 and u220 > 0 and not u143 then
					p314:reload();
				end;
			end);
			if u219 > 0 and not u224 and not u221 and v830.animations.onfire and u208.pullout then
				u144 = true;
				u226 = true;
				u221 = true;
				v859.t = 1;
				u164:add(v31.player(v832, v830.animations.onfire));
				u164:add(function()
					u224 = true;
					u164:add(v31.reset(v832, v830.animations.onfire.resettime, v830.keepanimvisibility or u212));
					u164:add(function()
						u144 = false;
						u226 = false;
						u221 = false;
						v859.t = 0;
						if u135 then
							v588.t = 1;
						end;
						if v32.mouse.down.right or v32.controller.down.l2 then
							p314:setaim(true);
						end;
					end);
				end);
			end;
			if not u208.blackscope then
				v10:setsprint(v32.keyboard.down.leftshift or (v32.keyboard.down.w and l__PlayerGui__204:FindFirstChild("Doubletap") or p314.wassprinting));
			end;
			p314.wassprinting = false;
		end;
		u142();
	end;
	function v833.chambergun(p316)
		print("pretend to chamber gun");
		if not (u219 > 0) or not v830.animations.pullbolt then
			u224 = true;
			return;
		end;
		u143 = true;
		u226 = true;
		if u135 then
			v588.t = 0;
		end;
		u164:add(v31.player(v832, v830.animations.pullbolt));
		u164:add(function()
			u224 = true;
			u164:add(v31.reset(v832, v830.animations.pullbolt.resettime, v830.keepanimvisibility or u212));
			u164:add(function()
				u144 = false;
				u226 = false;
				u143 = false;
				if u135 then
					v588.t = 1;
				end;
				if v32.mouse.down.right or v32.controller.down.l2 then
					p316:setaim(true);
				end;
			end);
		end);
	end;
	function v833.playanimation(p317, p318)
		if not (not u143) or not (not u163) or not (not u226) then
			return true;
		end;
		u164:clear();
		if u144 then
			u164:add(v31.reset(v832, 0.05, v830.keepanimvisibility));
		end;
		if u212 and p318 ~= "selector" then
			p317:setaim(false);
		end;
		u144 = true;
		v588.t = 0;
		local v909 = {};
		if p318 == "inspect" then
			u222 = true;
		end;
		v859.t = 1;
		u164:add(v31.player(v832, v830.animations[p318]));
		u164:add(function()
			u164:add(v31.reset(v832, v830.animations[p318].resettime, v830.keepanimvisibility or u230));
			u164:add(function()
				u222 = false;
				u144 = false;
				if u143 then
					return;
				end;
				if (v32.mouse.down.right or v32.controller.down.l2) and not u212 then
					p317:setaim(true);
				end;
				if u135 then
					v588.t = 1;
				end;
				v859.t = 0;
			end);
		end);
	end;
	function v833.dropguninfo(p319)
		return u219, u220, v836.Position;
	end;
	function v833.addammo(p320, p321, p322)
		u220 = u220 + p321;
		v12:updateammo(u219, u220);
		u99.customaward("Picked up " .. p321 .. " rounds from dropped " .. p322);
	end;
	function v833.reloadcancel(p323, p324)
		if u143 or p324 then
			u164:clear();
			u164:add(v31.reset(v832, 0.2, v830.keepanimvisibility));
			u143 = false;
			u144 = false;
			u222 = false;
			v859.t = 0;
			if not u224 then
				p323:chambergun();
				return;
			end;
			if v32.mouse.down.right or v32.controller.down.l2 then
				p323:setaim(true);
			end;
			if u135 then
				v588.t = 1;
			end;
		end;
	end;
	local l__chamber__231 = v830.chamber;
	local u232 = l__magsize__838;
	function v833.reload(p325)
		if not u226 and not u163 and not u143 and u220 > 0 and u219 ~= (l__chamber__231 and u232 + 1 or u232) then
			if u144 then
				u164:clear();
				v834:clear();
				u164:add(v31.reset(v832, 0.1, v830.keepanimvisibility));
			end;
			if u212 then
				p325:setaim(false);
			end;
			u222 = false;
			u144 = true;
			u143 = true;
			v588.t = 0;
			p325.auto = false;
			p325.burst = 0;
			v859.t = 1;
			if v830.type == "SHOTGUN" and not v830.magfeed == true then
				u164:add(v31.player(v832, v830.animations.tacticalreload));
				u164:add(function()
					u219 = u219 + 1;
					u220 = u220 - 1;
					u224 = true;
					v21:send("reload");
					v12:updateammo(u219, u220);
				end);
				local v910 = u220 - 1;
				if u219 < u232 and u220 > 0 and v910 > 0 then
					for v911 = 2, u232 - u219 do
						if u220 > 0 and v910 > 0 then
							v910 = v910 - 1;
							u164:add(v31.player(v832, v830.altreload and v830.animations[v830.altreload .. "reload"] or v830.animations.reload));
							u164:add(function()
								u219 = u219 + 1;
								u220 = u220 - 1;
								v21:send("reload");
								v12:updateammo(u219, u220);
							end);
						end;
					end;
				end;
				if u219 == 0 then
					u164:add(v31.player(v832, v830.animations.pump));
				end;
				local u233 = true;
				u164:add(function()
					if u233 and v830.animations.tacticalreload.resettime then
						local v912 = v830.animations.tacticalreload.resettime;
						if not v912 then
							if not u233 then
								v912 = v830.animations.reload.resettime and v830.animations.reload.resettime or 0.5;
							else
								v912 = 0.5;
							end;
						end;
					elseif not u233 then
						v912 = v830.animations.reload.resettime and v830.animations.reload.resettime or 0.5;
					else
						v912 = 0.5;
					end;
					u164:add(v31.reset(v832, v912), v830.keepanimvisibility);
					u164:add(function()
						v859.t = 0;
						u143 = false;
						u144 = false;
						u222 = false;
						u223 = false;
						u224 = true;
						if u135 then
							v588.t = 1;
						end;
						if v32.mouse.down.right or v32.controller.down.l2 then
							p325:setaim(true);
						end;
					end);
				end);
			elseif v830.uniquereload then
				local v913 = u219 == 0;
				if v830.animations.initstage then
					u164:add(v31.player(v832, v830.animations.initstage));
				elseif v913 then
					v913 = true;
					if v830.animations.initemptystage then
						u164:add(v31.player(v832, v830.animations.initemptystage));
					end;
				end;
				local v914 = u220;
				if u219 < u232 and u220 > 0 and v914 > 0 then
					for v915 = 1, u232 - u219 do
						if u220 > 0 and v914 > 0 then
							v914 = v914 - 1;
							if v830.animations.reloadstage then
								u164:add(v31.player(v832, v830.animations.reloadstage));
							end;
							u164:add(function()
								u219 = u219 + 1;
								u220 = u220 - 1;
								v21:send("reload");
								v12:updateammo(u219, u220);
							end);
						end;
					end;
				end;
				if v913 then
					if v830.animations.emptyendstage then
						u164:add(v31.player(v832, v830.animations.emptyendstage));
					end;
				elseif v830.animations.endstage then
					u164:add(v31.player(v832, v830.animations.endstage));
				end;
				u164:add(function()
					u164:add(v31.reset(v832, v913 and v830.animations.emptyendstage.resettime and v830.animations.emptyendsstage.resettime or (not v913 and v830.animations.endstage.resettime and v830.animations.endstage.resettime or 0.5)), v830.keepanimvisibility);
					u164:add(function()
						v859.t = 0;
						u143 = false;
						u144 = false;
						u222 = false;
						u223 = false;
						u224 = true;
						if u135 then
							v588.t = 1;
						end;
						if v32.mouse.down.right or v32.controller.down.l2 then
							p325:setaim(true);
						end;
					end);
				end);
			else
				if u219 == 0 then
					local v916 = v830.altreloadlong and v830.animations[v830.altreloadlong .. "reload"] or v830.animations.reload;
				else
					v916 = v830.altreload and v830.animations[v830.altreload .. "tacticalreload"] or v830.animations.tacticalreload;
				end;
				u164:add(v31.player(v832, v916));
				u164:add(function()
					u220 = u220 + u219;
					local v917 = (u219 == 0 or not l__chamber__231) and u232 or u232 + 1;
					u219 = u220 < v917 and u220 or v917;
					u220 = u220 - u219;
					u223 = false;
					v21:send("reload");
					v12:updateammo(u219, u220);
					u164:add(v31.reset(v832, v916.resettime and 0.5, v830.keepanimvisibility));
					u164:add(function()
						v859.t = 0;
						u143 = false;
						u144 = false;
						u222 = false;
						u224 = true;
						if u135 then
							v588.t = 1;
						end;
						if v32.mouse.down.right or v32.controller.down.l2 then
							p325:setaim(true);
						end;
					end);
				end);
			end;
		end;
	end;
	function v833.memes(p326)
		u232 = 2 * u232;
		u219 = u232;
		u220 = 1000000;
		u210 = 1000;
		u218 = { true, 1, 2, 3 };
		for v918 = 1, #v860 do
			local v919 = v860[v918];
			v919.firerate = u210;
			v919.variablefirerate = nil;
		end;
	end;
	local u234 = 0;
	local u235 = 0;
	local u236 = 0;
	function v833.shoot(p327, p328)
		local v920 = v41.getTime();
		if p328 then
			if not u217 then
				return;
			end;
			if v15.lock then
				return;
			end;
			if u219 == 0 then
				p327:reload();
			end;
			if not u224 then
				return;
			end;
			if u143 and u219 > 0 then
				p327:reloadcancel();
				return;
			end;
			if v920 < u234 then
				return;
			end;
			if not u143 and not u163 then
				local v921 = u218[u211];
				v10:setsprint(false);
				if v921 == "BINARY" then
					v921 = 1;
				end;
				if v921 == true then
					p327.auto = true;
				elseif p327.burst == 0 and u235 < v920 then
					p327.burst = v921;
				end;
				if v830.burstcam then
					p327.auto = true;
				end;
				if u235 < v920 then
					u235 = v920;
				end;
				if v830.forcecap and not p327.auto then
					u234 = v920 + 60 / v830.firecap * (tonumber(v921) and 1);
					return;
				end;
			end;
		elseif not v830.loosefiring then
			if v830.autoburst and p327.auto and u236 > 0 then
				u235 = v920 + 60 / v830.firecap;
			end;
			u236 = 0;
			p327.auto = false;
			if not v830.burstlock and not v830.burstcam then
				p327.burst = 0;
			end;
			if not u143 and not u163 and u218[u211] == "BINARY" then
				p327.burst = 1;
			end;
		end;
	end;
	function v833.nextfiremode(p329)
		if u143 then
			return;
		end;
		local l__zoom__922 = u208.zoom;
		if v830.animations.selector then
			if u144 then
				u164:clear();
				u164:add(v31.reset(v832, 0.2, v830.keepanimvisibility or u230));
			end;
			u144 = true;
			if u212 and not u208.aimspringcancel then
				v593.t = 0.5;
				u213.t = 0;
				v861();
			end;
			if u135 then
				v588.t = 0.5;
			end;
			u226 = true;
			u164:add(v31.player(v832, v830.animations.selector));
			u164:add(function()
				u164:add(v31.reset(v832, v830.animations.selector.resettime, v830.keepanimvisibility or u230));
				u144 = false;
				u222 = false;
				u226 = false;
				if u135 then
					v588.t = 1;
				end;
				if u212 then
					v593.t = 1;
					u213.t = 1;
					v861();
				end;
			end);
		end;
		u164:add(function()
			u211 = u211 % #u218 + 1;
			v12:updatefiremode(u218[u211]);
			if u208.variablefirerate then
				u210 = u208.firerate[u211];
			end;
			if p329.auto then
				p329.auto = false;
			end;
			p329.burst = 0;
			u216 = v830.firemodestability and v830.firemodestability[u211] or 0;
			return u218[u211];
		end);
	end;
	u229 = function(p330)
		p330 = p330 / v830.bolttime * 1.5;
		if p330 > 0.5 then
			v832[v830.bolt].weld.C0 = v855(1);
			u223 = true;
			return true;
		end;
		v832[v830.bolt].weld.C0 = v855(1 - 4 * (p330 - 0.5) * (p330 - 0.5));
		u223 = false;
		return false;
	end;
	local l__range0__237 = v830.range0;
	local l__damage0__238 = v830.damage0;
	local l__range1__239 = v830.range1;
	local l__damage1__240 = v830.damage1;
	for v923, v924 in v860, nil do
		if v924.reddot then
			v924.sightpart.Transparency = 1;
			u3:addreddot(v924.sightpart);
		elseif v924.midscope then
			u3:addscope(v924);
		elseif v924.blackscope then
			u3:addscope(v924);
		end;
	end;
	local function u241(p331)
		p331 = p331 / v830.bolttime * 1.5;
		u223 = false;
		if p331 > 1.5 then
			v832[v830.bolt].weld.C0 = v855(0);
			return nil;
		end;
		if not (p331 > 0.5) then
			v832[v830.bolt].weld.C0 = v855(1 - 4 * (p331 - 0.5) * (p331 - 0.5));
			return false;
		end;
		p331 = (p331 - 0.5) * 0.5 + 0.5;
		v832[v830.bolt].weld.C0 = v855(1 - 4 * (p331 - 0.5) * (p331 - 0.5));
		return false;
	end;
	local function u242(p332, p333, p334, p335, p336, p337)
		if v10.alive then
			if p334.Parent then
				if p333.TeamColor == u127.TeamColor then
					return;
				end;
			else
				warn(string.format("We hit a bodypart that doesn't exist %s %s", u127.Name, p334.Name));
				return;
			end;
		else
			return;
		end;
		local l__Magnitude__925 = (p332.origin - p335).Magnitude;
		local v926 = l__Magnitude__925 < l__range0__237 and l__damage0__238 or (l__Magnitude__925 < l__range1__239 and (l__damage1__240 - l__damage0__238) / (l__range1__239 - l__range0__237) * (l__Magnitude__925 - l__range0__237) + l__damage0__238 or l__damage1__240);
		v12:firehitmarker(p334.Name == "Head");
		v34:bloodhit(p335, true, p334.Name == "Head" and v926 * v830.multhead or (p334.Name == "Torso" and v926 * v830.multtorso or v926), p332.velocity / 10);
		v38.PlaySound("hitmarker", nil, 1, 1.5);
		if not p337 then
			v21:send("bullethit", p333, p335, p334.Name, p336);
			return;
		end;
		table.insert(p337, { p333, p335, p334.Name, p336 });
	end;
	local function u243(p338, p339, p340, p341, p342, p343, p344, p345, p346, p347)
		if p339:IsDescendantOf(workspace.Ignore.DeadBody) then
			v34:bloodhit(p340);
			return;
		end;
		if p339.Anchored then
			if p339.Name == "Window" then
				v34:breakwindow(p339, p347);
			end;
			if p339.Name == "Hitmark" then
				v12:firehitmarker();
			elseif p339.Name == "HitmarkHead" then
				v12:firehitmarker(true);
			end;
			v34:bullethit(p339, p340, p341, p342, p343, p338.velocity, true, true, math.random(0, 2));
		end;
	end;
	local l__hideflash__244 = v830.hideflash;
	local function u245()
		if u3.sighttable then
			u3.sighteffect(true, v831, v12);
			if v592.p > 0.5 then
				local v927 = u3.activedot or (u3.activescope or u208.sightpart);
			else
				v927 = u208.sightpart;
			end;
			v12:updatesightmark(v927, u208.centermark);
			v12:updatescopemark(u3.activescope);
		end;
		if u3.lasertable then
			u3.lasereffect();
		end;
	end;
	local function u246(p348)
		local v928 = v41.getTime();
		while true do
			local u247 = nil;
			local u248 = nil;
			if not (u219 > 0) then
				break;
			end;
			if v41.getTime() < u235 or not u217 or v15.lock then
				local v929 = false;
			elseif v830.burstcam and u218[u211] ~= true then
				v929 = v833.auto and v833.burst > 0;
			else
				v929 = v833.auto or v833.burst > 0;
			end;
			if not v929 then
				break;
			end;
			if u222 then
				v833:reloadcancel(true);
				u222 = false;
			end;
			v834:clear();
			if v830.requirechamber then
				u224 = false;
				u225 = v928 + (v830.chambercooldown and 2);
			end;
			if v830.forceonfire or u219 > 1 and v830.animations.onfire and (not u212 or u212 and (not u208.pullout or v830.straightpull)) then
				local l__zoom__930 = u208.zoom;
				if u208.zoompullout then
					u213.t = v830.aimarmblend and 0;
					if u212 and not v830.aimspringcancel and not v830.straightpull then
						local v931 = 0.5;
					else
						v931 = 1;
					end;
					v593.t = v931;
					v861();
				end;
				u144 = true;
				u226 = true;
				if u208.onfireanim then
					local v932 = v830.animations["onfire" .. u208.onfireanim];
				else
					v932 = v830.animations.onfire;
				end;
				u221 = true;
				if not v830.ignorestanceanim then
					v859.t = 1;
				end;
				u164:clear();
				u164:add(v31.player(v832, v932));
				u164:add(function()
					u164:add(v31.reset(v832, v932.resettime, v830.keepanimvisibility or u212));
					if u212 then
						v593.t = 1;
						u213.t = 1;
						v861();
					end;
					u221 = false;
					u226 = false;
					u224 = true;
					u144 = false;
					v859.t = 0;
					if v32.mouse.down.right or v32.controller.down.l2 then
						v833:setaim(true);
					end;
					if u135 then
						v588.t = 1;
					end;
					if v830.forcereload and u219 == 0 and not u212 then
						v833:reload();
					end;
				end);
			elseif v830.shelloffset then
				if not v830.caselessammo then
					v34:ejectshell(v836.CFrame, v830.casetype or v830.ammotype, v830.shelloffset);
				end;
				if u219 > 0 then
					v834:add(u219 == 1 and v830.boltlock and u229 or u241);
				end;
			end;
			if not u212 then
				v12.crossspring.a = v830.crossexpansion * (1 - p348);
			end;
			if v833.burst ~= 0 then
				v833.burst = v833.burst - 1;
			end;
			if u205.purecontroller() then
				local v933 = 0.5;
			else
				v933 = 1;
			end;
			if v830.firedelay then
				task.delay(v830.firedelay, function()
					v858.a = v12.crossspring.p / v830.crosssize * 0.5 * (1 - u138) * (1 - p348) * v830.hipfirespread * v830.hipfirespreadrecover * Vector3.new(2 * math.random() - 1, 2 * math.random() - 1, 0);
					local l__transkickmin__934 = v830.transkickmin;
					local l__aimtranskickmin__935 = u208.aimtranskickmin;
					v856.a = (1 - u216) * (1 - u138) * ((1 - p348) * (l__transkickmin__934 + Vector3.new(math.random(), math.random(), math.random()) * (v830.transkickmax - l__transkickmin__934)) + p348 * (l__aimtranskickmin__935 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimtranskickmax - l__aimtranskickmin__935)));
					local l__rotkickmin__936 = v830.rotkickmin;
					local l__aimrotkickmin__937 = u208.aimrotkickmin;
					v857.a = (1 - u216) * (1 - u138) * ((1 - p348) * (l__rotkickmin__936 + Vector3.new(math.random(), math.random(), math.random()) * (v830.rotkickmax - l__rotkickmin__936)) + p348 * (l__aimrotkickmin__937 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimrotkickmax - l__aimrotkickmin__937)));
					local l__camkickmin__938 = v830.camkickmin;
					local l__aimcamkickmin__939 = u208.aimcamkickmin;
					v28:shake((1 - u216) * (1 - p348) * v933 * (l__camkickmin__938 + Vector3.new(math.random(), math.random(), math.random()) * (v830.camkickmax - l__camkickmin__938)) + (1 - u216) * v933 * p348 * (l__aimcamkickmin__939 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimcamkickmax - l__aimcamkickmin__939)));
				end);
			else
				v858.a = v12.crossspring.p / v830.crosssize * 0.5 * (1 - u138) * (1 - p348) * v830.hipfirespread * v830.hipfirespreadrecover * Vector3.new(2 * math.random() - 1, 2 * math.random() - 1, 0);
				local l__transkickmin__940 = v830.transkickmin;
				local l__aimtranskickmin__941 = u208.aimtranskickmin;
				v856.a = (1 - u216) * (1 - u138) * ((1 - p348) * (l__transkickmin__940 + Vector3.new(math.random(), math.random(), math.random()) * (v830.transkickmax - l__transkickmin__940)) + (1 - u216) * p348 * (l__aimtranskickmin__941 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimtranskickmax - l__aimtranskickmin__941)));
				local l__rotkickmin__942 = v830.rotkickmin;
				local l__aimrotkickmin__943 = u208.aimrotkickmin;
				v857.a = (1 - u216) * (1 - u138) * ((1 - p348) * (l__rotkickmin__942 + Vector3.new(math.random(), math.random(), math.random()) * (v830.rotkickmax - l__rotkickmin__942)) + (1 - u216) * p348 * (l__aimrotkickmin__943 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimrotkickmax - l__aimrotkickmin__943)));
				local l__camkickmin__944 = v830.camkickmin;
				local l__aimcamkickmin__945 = u208.aimcamkickmin;
				v28:shake((1 - u216) * (1 - p348) * v933 * (l__camkickmin__944 + Vector3.new(math.random(), math.random(), math.random()) * (v830.camkickmax - l__camkickmin__944)) + (1 - u216) * p348 * v933 * (l__aimcamkickmin__945 + Vector3.new(math.random(), math.random(), math.random()) * (u208.aimcamkickmax - l__aimcamkickmin__945)));
			end;
			task.delay(0.4, function()
				if v830.type == "SNIPER" then
					v38.play("metalshell", 0.15, 0.8);
					return;
				end;
				if v830.type == "SHOTGUN" then
					task.wait(0.3);
					v38.play("shotgunshell", 0.2);
					return;
				end;
				if v830.type ~= "REVOLVER" and not v830.caselessammo then
					v38.play("metalshell", 0.1);
				end;
			end);
			local v946 = v830.bulletcolor or Color3.new(0.7843137254901961, 0.27450980392156865, 0.27450980392156865);
			local v947 = { workspace.Players, workspace.Terrain, workspace.Ignore, v28.currentcamera };
			local v948 = {};
			local v949 = {};
			local l__CFrame__950 = (u212 and u208.sightpart or v846).CFrame;
			local l__p__951 = v28.basecframe.p;
			local v952, v953, v954 = workspace:FindPartOnRayWithIgnoreList(u146(l__p__951, l__CFrame__950.p - l__p__951), { workspace.Players:FindFirstChild(u127.TeamColor.Name), workspace.Terrain, workspace.Ignore, v28.currentcamera });
			local v955 = v953 + 0.01 * v954;
			v833.firecount = v833.firecount + 1;
			local v956, v957 = v833.SPG:getPoint(v833.firecount);
			local v958 = v830.type == "SHOTGUN" and v830.pelletcount or 1;
			local v959 = 1 - 1;
			while true do
				local u249 = nil;
				local u250 = nil;
				local v960 = nil;
				local v961 = nil;
				local v962 = nil;
				local v963 = nil;
				local v964 = nil;
				local v965 = nil;
				local v966 = nil;
				local v967 = nil;
				local v968 = nil;
				local v969 = nil;
				local v970 = nil;
				local v971 = nil;
				local v972 = nil;
				local v973 = nil;
				local v974 = nil;
				local v975 = nil;
				local v976 = nil;
				local v977 = nil;
				local v978 = nil;
				local v979 = nil;
				local v980 = nil;
				local v981 = nil;
				local v982 = nil;
				local v983 = nil;
				local v984 = nil;
				local v985 = nil;
				local v986 = nil;
				local v987 = nil;
				local v988 = nil;
				local v989 = nil;
				local v990 = nil;
				local v991 = nil;
				local v992 = nil;
				local v993 = nil;
				local v994 = nil;
				local v995 = nil;
				local v996 = nil;
				local v997 = nil;
				local v998 = nil;
				local v999 = nil;
				local v1000 = nil;
				local v1001 = nil;
				local v1002 = nil;
				local v1003 = nil;
				local v1004 = nil;
				local v1005 = nil;
				local v1006 = nil;
				local v1007 = nil;
				local v1008 = nil;
				local v1009 = nil;
				local v1010 = nil;
				local v1011 = nil;
				local v1012 = nil;
				local v1013 = nil;
				local v1014 = nil;
				local v1015 = nil;
				local v1016 = nil;
				local v1017 = nil;
				local v1018 = nil;
				local v1019 = nil;
				local v1020 = nil;
				local v1021 = nil;
				local v1022 = nil;
				local v1023 = nil;
				local u251 = nil;
				local u252 = nil;
				local v1024 = nil;
				local v1025 = nil;
				local v1026 = nil;
				local v1027 = nil;
				local v1028 = nil;
				local v1029 = nil;
				local v1030 = nil;
				local v1031 = nil;
				local v1032 = nil;
				local v1033 = nil;
				local v1034 = nil;
				local v1035 = nil;
				local v1036 = nil;
				local v1037 = nil;
				local v1038 = nil;
				local v1039 = nil;
				local v1040 = nil;
				local v1041 = nil;
				local v1042 = nil;
				local v1043 = nil;
				local v1044 = nil;
				local v1045 = nil;
				local v1046 = nil;
				local v1047 = nil;
				local v1048 = nil;
				local v1049 = nil;
				u206 = u206 + 1;
				local v1050 = {};
				if not v830.spread and (not v830.crosssize or not v830.aimchoke) then
					local v1051 = v830.bulletspeed * l__CFrame__950.lookVector;
					u249 = v1050;
					u250 = u206;
					u247 = v949;
					v1020 = function(p349, p350, p351, p352)
						if u249[p350] then
							return;
						end;
						u249[p350] = true;
						u242(p349, p350, p351, p352, u250, u247);
					end;
					v960 = v33;
					v961 = "new";
					v962 = v960;
					v963 = v961;
					v1027 = v962[v963];
					local v1052 = {};
					local v1053 = "position";
					v964 = v1052;
					v965 = v1053;
					v966 = v955;
					v964[v965] = v966;
					local v1054 = "velocity";
					v967 = v1052;
					v968 = v1054;
					v969 = v1051;
					v967[v968] = v969;
					v970 = v18;
					local v1055 = "bulletAcceleration";
					v971 = v970;
					v972 = v1055;
					v973 = v971[v972];
					local v1056 = "acceleration";
					v974 = v1052;
					v975 = v1056;
					v976 = v973;
					v974[v975] = v976;
					local v1057 = "color";
					v977 = v1052;
					v978 = v1057;
					v979 = v946;
					v977[v978] = v979;
					local v1058 = 0.2;
					local v1059 = "size";
					v980 = v1052;
					v981 = v1059;
					v982 = v1058;
					v980[v981] = v982;
					local v1060 = 0.005;
					local v1061 = "bloom";
					v983 = v1052;
					v984 = v1061;
					v985 = v1060;
					v983[v984] = v985;
					local v1062 = 400;
					local v1063 = "brightness";
					v986 = v1052;
					v987 = v1063;
					v988 = v1062;
					v986[v987] = v988;
					local v1064 = v18;
					local v1065 = "bulletLifeTime";
					v989 = v1064;
					v990 = v1065;
					local v1066 = v989[v990];
					local v1067 = "life";
					v991 = v1052;
					v992 = v1067;
					v993 = v1066;
					v991[v992] = v993;
					local v1068 = v846;
					local v1069 = "Position";
					v994 = v1068;
					v995 = v1069;
					local v1070 = v994[v995];
					local v1071 = "visualorigin";
					v996 = v1052;
					v997 = v1071;
					v998 = v1070;
					v996[v997] = v998;
					local v1072 = "physicsignore";
					v999 = v1052;
					v1000 = v1072;
					v1001 = v947;
					v999[v1000] = v1001;
					local v1073 = u235;
					v1002 = v928;
					v1003 = v1073;
					local v1074 = v1002 - v1003;
					local v1075 = "dt";
					v1004 = v1052;
					v1005 = v1075;
					v1006 = v1074;
					v1004[v1005] = v1006;
					local v1076 = v830;
					local v1077 = "penetrationdepth";
					v1007 = v1076;
					v1008 = v1077;
					local v1078 = v1007[v1008];
					local v1079 = "penetrationdepth";
					v1009 = v1052;
					v1010 = v1079;
					v1011 = v1078;
					v1009[v1010] = v1011;
					local v1080 = v830;
					local v1081 = "tracerless";
					v1012 = v1080;
					v1013 = v1081;
					local v1082 = v1012[v1013];
					local v1083 = "tracerless";
					v1014 = v1052;
					v1015 = v1083;
					v1016 = v1082;
					v1014[v1015] = v1016;
					local v1084 = nil;
					local v1085 = "wallbang";
					v1017 = v1052;
					v1018 = v1085;
					v1019 = v1084;
					v1017[v1018] = v1019;
					local v1086 = "onplayerhit";
					v1021 = v1052;
					v1022 = v1086;
					v1023 = v1020;
					v1021[v1022] = v1023;
					u251 = v955;
					u252 = v1051;
					u248 = v928;
					local v1087 = function(p353, p354, p355, p356, p357, p358)
						u243(p353, p354, p355, p356, p357, p358, u251, u252, u248, u250);
					end;
					local v1088 = "ontouch";
					v1024 = v1052;
					v1025 = v1088;
					v1026 = v1087;
					v1024[v1025] = v1026;
					v1028 = v1027;
					v1029 = v1052;
					v1028(v1029);
					v1030 = v948;
					local v1089 = #v1030;
					local v1090 = 1;
					v1031 = v1089;
					v1032 = v1090;
					local v1091 = v1031 + v1032;
					local v1092 = {};
					v1033 = u252;
					local v1093 = v1033;
					v1034 = u250;
					local v1094 = v1034;
					v1037 = v1093;
					v1040 = v1094;
					v1036 = 1;
					v1035 = v1092;
					v1035[v1036] = v1037;
					v1039 = 2;
					v1038 = v1092;
					v1038[v1039] = v1040;
					v1041 = v948;
					v1042 = v1091;
					v1043 = v1092;
					v1041[v1042] = v1043;
					local v1095 = 0;
					v1044 = v1095;
					v1045 = 1;
					if v1044 <= v1045 then
						if not (v959 < v958) then
							break;
						end;
					elseif not (v958 < v959) then
						break;
					end;
					v1046 = v959;
					v1047 = 1;
					v959 = v1046 + v1047;
				end;
				while true do
					local v1096 = math.sqrt((v959 - v957) / v958);
					local v1097 = 0.7639320225002102 * math.pi;
					local v1098 = v1096 * math.cos((v959 - v956) * v1097);
					v1048 = v1096 * math.sin((v959 - v956) * v1097);
					v1049 = v1098 * v1098 + v1048 * v1048;
					if v1049 <= 1.00001 then
						break;
					end;				
				end;
				local v1099 = (v830.spread or 0.6666666666666666 * v830.crosssize * v830.aimchoke / v830.bulletspeed) * math.sqrt(-math.log(v1049) / v1049);
				v1051 = v830.bulletspeed * l__CFrame__950:VectorToWorldSpace((Vector3.new(v1099 * (v830.choke and v830.xbias or 1) * v1098, v1099 * (v830.choke and v830.ybias or 1) * v1048, -1))).unit;
				u249 = v1050;
				u250 = u206;
				u247 = v949;
				v1020 = function(p359, p360, p361, p362)
					if u249[p360] then
						return;
					end;
					u249[p360] = true;
					u242(p359, p360, p361, p362, u250, u247);
				end;
				v960 = v33;
				v961 = "new";
				v962 = v960;
				v963 = v961;
				v1027 = v962[v963];
				v1052 = {};
				v1053 = "position";
				v964 = v1052;
				v965 = v1053;
				v966 = v955;
				v964[v965] = v966;
				v1054 = "velocity";
				v967 = v1052;
				v968 = v1054;
				v969 = v1051;
				v967[v968] = v969;
				v970 = v18;
				v1055 = "bulletAcceleration";
				v971 = v970;
				v972 = v1055;
				v973 = v971[v972];
				v1056 = "acceleration";
				v974 = v1052;
				v975 = v1056;
				v976 = v973;
				v974[v975] = v976;
				v1057 = "color";
				v977 = v1052;
				v978 = v1057;
				v979 = v946;
				v977[v978] = v979;
				v1058 = 0.2;
				v1059 = "size";
				v980 = v1052;
				v981 = v1059;
				v982 = v1058;
				v980[v981] = v982;
				v1060 = 0.005;
				v1061 = "bloom";
				v983 = v1052;
				v984 = v1061;
				v985 = v1060;
				v983[v984] = v985;
				v1062 = 400;
				v1063 = "brightness";
				v986 = v1052;
				v987 = v1063;
				v988 = v1062;
				v986[v987] = v988;
				v1064 = v18;
				v1065 = "bulletLifeTime";
				v989 = v1064;
				v990 = v1065;
				v1066 = v989[v990];
				v1067 = "life";
				v991 = v1052;
				v992 = v1067;
				v993 = v1066;
				v991[v992] = v993;
				v1068 = v846;
				v1069 = "Position";
				v994 = v1068;
				v995 = v1069;
				v1070 = v994[v995];
				v1071 = "visualorigin";
				v996 = v1052;
				v997 = v1071;
				v998 = v1070;
				v996[v997] = v998;
				v1072 = "physicsignore";
				v999 = v1052;
				v1000 = v1072;
				v1001 = v947;
				v999[v1000] = v1001;
				v1073 = u235;
				v1002 = v928;
				v1003 = v1073;
				v1074 = v1002 - v1003;
				v1075 = "dt";
				v1004 = v1052;
				v1005 = v1075;
				v1006 = v1074;
				v1004[v1005] = v1006;
				v1076 = v830;
				v1077 = "penetrationdepth";
				v1007 = v1076;
				v1008 = v1077;
				v1078 = v1007[v1008];
				v1079 = "penetrationdepth";
				v1009 = v1052;
				v1010 = v1079;
				v1011 = v1078;
				v1009[v1010] = v1011;
				v1080 = v830;
				v1081 = "tracerless";
				v1012 = v1080;
				v1013 = v1081;
				v1082 = v1012[v1013];
				v1083 = "tracerless";
				v1014 = v1052;
				v1015 = v1083;
				v1016 = v1082;
				v1014[v1015] = v1016;
				v1084 = nil;
				v1085 = "wallbang";
				v1017 = v1052;
				v1018 = v1085;
				v1019 = v1084;
				v1017[v1018] = v1019;
				v1086 = "onplayerhit";
				v1021 = v1052;
				v1022 = v1086;
				v1023 = v1020;
				v1021[v1022] = v1023;
				u251 = v955;
				u252 = v1051;
				u248 = v928;
				v1087 = function(p363, p364, p365, p366, p367, p368)
					u243(p363, p364, p365, p366, p367, p368, u251, u252, u248, u250);
				end;
				v1088 = "ontouch";
				v1024 = v1052;
				v1025 = v1088;
				v1026 = v1087;
				v1024[v1025] = v1026;
				v1028 = v1027;
				v1029 = v1052;
				v1028(v1029);
				v1030 = v948;
				v1089 = #v1030;
				v1090 = 1;
				v1031 = v1089;
				v1032 = v1090;
				v1091 = v1031 + v1032;
				v1092 = {};
				v1033 = u252;
				v1093 = v1033;
				v1034 = u250;
				v1094 = v1034;
				v1037 = v1093;
				v1040 = v1094;
				v1036 = 1;
				v1035 = v1092;
				v1035[v1036] = v1037;
				v1039 = 2;
				v1038 = v1092;
				v1038[v1039] = v1040;
				v1041 = v948;
				v1042 = v1091;
				v1043 = v1092;
				v1041[v1042] = v1043;
				v1095 = 0;
				v1044 = v1095;
				v1045 = 1;
				if v1044 <= v1045 then
					if not (v959 < v958) then
						break;
					end;
				elseif not (v958 < v959) then
					break;
				end;
				v1046 = v959;
				v1047 = 1;
				v959 = v1046 + v1047;			
			end;
			v21:send("newbullets", {
				camerapos = v28.basecframe.p, 
				firepos = v955, 
				bullets = v948
			}, u248);
			if #u247 > 0 then
				for v1100 = 1, #u247 do
					v21:send("bullethit", unpack(u247[v1100]));
				end;
			end;
			u219 = u219 - 1;
			u236 = u236 + 1;
			if v833.burst <= 0 and v830.firecap and u218[u211] ~= true then
				u235 = u248 + 60 / v830.firecap;
			elseif v830.autoburst and v833.auto and u236 < v830.autoburst then
				u235 = u235 + 60 / v830.burstfirerate;
			elseif u212 and u208.aimedfirerate then
				u235 = u235 + 60 / u208.aimedfirerate;
			else
				u235 = u235 + 60 / u210;
			end;
			if u219 == 0 then
				v833.burst = 0;
				v833.auto = false;
				if v830.magdisappear then
					v831[v830.mag].Transparency = 1;
				end;
				if (not u208.pullout and not u208.blackscope or not u212) and (u218[1] == true or not u212) then
					v833:reload();
				end;
			end;		
		end;
		if false then
			if v830.sniperbass then
				v38.play("1PsniperBass", 0.75);
				v38.play("1PsniperEcho", 1);
			end;
			if not v830.nomuzzleeffects then
				v34:muzzleflash(v846, l__hideflash__244);
			end;
			if not v830.hideminimap then
				v12:goingloud();
			end;
			v38.PlaySoundId(v830.firesoundid, v830.firevolume, v830.firepitch, v846, nil, 0, 0.05);
			v12:updateammo(u219, u220);
		end;
	end;
	function v833.step(p369)
		local v1101 = nil;
		local v1102 = nil;
		local v1103 = nil;
		local v1104 = nil;
		local v1105 = nil;
		local v1106 = nil;
		local v1107 = nil;
		local l__p__1108 = v593.p;
		local l__p__1109 = v592.p;
		local l__p__1110 = u213.p;
		v28.controllermult = (1 - l__p__1109) * 0.6 + l__p__1109 * 0.4;
		local v1111 = v600.p / v603.p * v588.p;
		if v1111 > 1 then
			local v1112 = 1;
		else
			v1112 = v1111;
		end;
		u230 = false;
		local v1113 = 0;
		for v1114 = 1, #v860 do
			local v1115 = v860[v1114];
			local l__p__1116 = v1115.sightspring.p;
			v1101 = u98 + l__p__1116 * v1115.aimoffsetp;
			v1102 = u98 + l__p__1116 * v1115.aimoffsetr;
			v1103 = u98 + l__p__1116 * v1115.larmaimoffsetp;
			v1104 = u98 + l__p__1116 * v1115.larmaimoffsetr;
			v1105 = u98 + l__p__1116 * v1115.rarmaimoffsetp;
			v1106 = u98 + l__p__1116 * v1115.rarmaimoffsetr;
			v1107 = v1113 + l__p__1116;
			if v1115.blackscope and v1115.scopebegin < l__p__1116 then
				u230 = true;
			end;
		end;
		local l__C0__1117 = v832.larm.weld.C0;
		local v1118 = v24.toaxisangle(l__C0__1117);
		local l__C0__1119 = v832.rarm.weld.C0;
		local v1120 = v24.toaxisangle(l__C0__1119);
		v833:updatescope();
		local v1121 = v12:getsteadysize();
		if u230 then
			local v1122 = u208.swayamp and 0;
			if v10.movementmode == "stand" then
				v1122 = v1122 * (u208.standswayampmult and 1);
			end;
			v28:setsway(v1122);
			if u208.breathspeed then
				if v1121 < 1 and (not (not v32.keyboard.down.leftshift) or not (not v32.controller.down.up) or not (not v32.controller.down.l3) or u45.steadytoggle) then
					v28:setswayspeed(v10.movementmode == "stand" and u208.standsteadyspeed or 0);
					v12:setsteadybar(u207(v1121 < 1 and v1121 + p369 * 60 * u208.breathspeed or v1121, 0, 1, 0));
				else
					u45.steadytoggle = false;
					local v1123 = u208.swayspeed and 1;
					if v10.movementmode == "stand" then
						v1123 = v1123 * (u208.standswayspeedmult and 1);
					end;
					v28:setswayspeed(v1123);
					v12:setsteadybar(u207(v1121 > 0 and v1121 - p369 * 60 * u208.recoverspeed or 0, 0, 1, 0));
				end;
			end;
		else
			v28:setswayspeed(0);
			if v1121 > 0 then
				local v1124 = v1121 - p369 * 60 * (u208.recoverspeed and 0.005) or 0;
			else
				v1124 = 0;
			end;
			v12:setsteadybar(u207(v1124, 0, 1, 0));
		end;
		local v1125 = l__CFrame_new__215(v1101 * l__p__1108) * v24.fromaxisangle(v1102 * l__p__1108);
		local v1126 = l__CFrame_new__215(v1103 + (1 - v1107) * l__C0__1117.p) * v24.fromaxisangle(v1104 + (1 - v1107) * v1118);
		local v1127 = l__CFrame_new__215(v1105 + (1 - v1107) * l__C0__1119.p) * v24.fromaxisangle(v1106 + (1 - v1107) * v1120);
		local v1128 = u123.CFrame:inverse() * v28.shakecframe * l__mainoffset__214 * v852(v589.p) * l__CFrame_new__215(v1125.p) * l__CFrame_new__215(0, 0, 1) * v24.fromaxisangle(v594.v * ((u208.blackscope and math.max(0.2, 1 - l__p__1109) or (v830.midscope and math.max(0.4, 1 - l__p__1109) or math.max(0.6, 1 - l__p__1109))) * (u212 and v830.aimswingmod or (v830.swingmod or 1)))) * l__CFrame_new__215(0, 0, -1) * u165(0.7 - 0.3 * l__p__1109, 1 - 0.8 * l__p__1109);
		local v1129 = os.clock() * 6;
		local v1130 = 2 * (1.1 - l__p__1109);
		local v1131 = v1128 * u119(math.cos(v1129 / 8) * v1130 / 128, -math.sin(v1129 / 4) * v1130 / 128, math.sin(v1129 / 16) * v1130 / 64) * v854(v10.pronespring.p * (1 - l__p__1109)):Lerp(u125, v859.p) * v853(v10.crouchspring.p):Lerp(u125, v859.p):Lerp(u125, l__p__1109) * v851(v1112):Lerp(v830.equipoffset, v601.p) * v24.fromaxisangle(v858.p) * l__CFrame_new__215(v856.p) * v24.fromaxisangle(v857.p) * (v1125 - v1125.p) * v832[l__mainpart__835].weld.C0;
		v845.C0 = v1131;
		u157.C0 = v1131 * l__C0__1117:Lerp(v1126, l__p__1110):Lerp(v830.larmsprintoffset, v1112);
		u156.C0 = v1131 * l__C0__1119:Lerp(v1127, l__p__1110):Lerp(v830.rarmsprintoffset, v1112);
		v834:step();
		if not v10.alive then
			v833:setequipped(false);
		end;
		if v589.t == 1 and u212 then
			v833:setaim(false);
		end;
		if v830.restrictedads and ((v32.mouse.down.right or v32.controller.down.l2) and not u212 and v10.movementmode ~= "stand" and u45.currentgun == v833) then
			v833:setaim(true);
		end;
		u245();
		u246(l__p__1109);
	end;
	return v833;
end;
if v5 then
	v32.keyboard.onkeydown:connect(function(p370)
		if p370 == "k" then
			u45.gammo = 9999999;
		end;
		if p370 == "l" and u45.currentgun then
			u45.currentgun:memes();
		end;
	end);
end;
v10.healwait = 8;
v10.healrate = 0.25;
v10.maxhealth = 100;
v10.ondied = v26.new();
local u253 = false;
local u254 = 0;
local u255 = 0;
function v10.gethealth()
	local l__maxhealth__1132 = v10.maxhealth;
	if not u253 then
		return 0;
	end;
	local v1133 = v41.getTime() - u254;
	if v1133 < 0 then
		return u255;
	end;
	local v1134 = u255 + v1133 * v1133 * v10.healrate;
	return v1134 < l__maxhealth__1132 and v1134 or l__maxhealth__1132, true;
end;
v10.ondied:connect(function()
	v10.alive = false;
end);
function v10.despawn(p371)
	if v10.alive then
		v21:send("forcereset");
		if u140 then
			u140:setequipped(false);
		end;
	end;
end;
v21:add("despawn", function(p372)
	v10.ondied:fire(p372);
	if u126 then
		u126.Parent = nil;
	end;
	v28.currentcamera:ClearAllChildren();
end);
v21:add("correctposition", function(p373)
	local l__rootpart__1135 = v10.rootpart;
	if v10.alive and l__rootpart__1135 then
		l__rootpart__1135.Position = p373;
		l__rootpart__1135.Velocity = u98;
	end;
end);
v21:add("updatepersonalhealth", function(p374, p375, p376, p377, p378)
	u253 = p378;
	u255 = p374;
	u254 = p375;
	v10.healrate = p376;
	v10.maxhealth = p377;
end);
local v1136 = shared.require("physics");
v1136.trajectory = nil;
local u256 = {};
local u257 = game:GetService("Players").LocalPlayer.PlayerGui.MainGui;
local u258 = v36.getscale;
local u259 = v1136.trajectory;
u256 = 0;
u259 = 0;
u258 = -1.5;
u257 = 0;
u259 = u119;
u258 = 0;
u257 = -1.5;
u259 = u259(u258, u257, 1.5, 1, 0, 0, 0, 0, 1, 0, -1, 0);
local u260 = u119(u259, u258, u257);
local l__soundfonts__261 = v38.soundfonts;
u258 = function(p379)
	local v1137 = nil;
	v1137 = 1;
	local v1138 = 1;
	local v1139 = false;
	local v1140 = math.tan(v28.basefov * math.pi / 360) / math.tan(v10.unaimedfov * math.pi / 360);
	for v1141 = 1, #u133 do
		local l__aimsightdata__1142 = u133[v1141].aimsightdata;
		for v1143 = 1, #l__aimsightdata__1142 do
			local v1144 = l__aimsightdata__1142[v1143];
			local l__p__1145 = v1144.sightspring.p;
			if v1144.blackscope then
				if v1144.scopebegin < l__p__1145 then
					v1138 = v1144.zoom;
					v1139 = true;
				end;
				local v1146 = v1137 * (v1144.prezoom / v1140) ^ l__p__1145;
			else
				v1146 = v1137 * (v1144.zoom / v1140) ^ l__p__1145;
			end;
		end;
	end;
	if v1139 then
		v28:setmagnification(v1138);
	else
		v28:setmagnification(v1140 * v1146 ^ v593.p);
	end;
	if u124 then
		local v1147 = v604.p / 1.5;
		if v1147 < 0 then
			u124.C0 = u260:lerp(u259, -v1147);
		else
			u124.C0 = u260:lerp(u125, v1147);
		end;
	end;
	if u253 and u123 then
		local v1148 = v596.v + Vector3.new(0, v604.v * 24, 0);
		local l__p__1149 = v603.p;
		local l__delta__1150 = v28.delta;
		v594.t = Vector3.new(v1148.z / 1024 / 32 - v1148.y / 1024 / 16 - l__delta__1150.x / 1024 * 3 / 2, v1148.x / 1024 / 32 - l__delta__1150.y / 1024 * 3 / 2, l__delta__1150.y / 1024 * 3 / 2);
		local v1151 = u123.CFrame:VectorToObjectSpace(u123.Velocity);
		if v1151.x == 0 and v1151.y == 0 and v1151.z == 0 then
			v1151 = Vector3.new(1E-06, 1E-06, 1E-06);
		end;
		local l__magnitude__1152 = (Vector3.new(1, 0, 1) * v1151).magnitude;
		local v1153 = (0.8 + 0.19999999999999996 * (1 - v1151.unit.z) / 2) * l__p__1149;
		if v1153 == v1153 then
			if v15.lock then
				local v1154 = 0;
			else
				v1154 = v1153;
			end;
			v590.WalkSpeed = v1154;
		end;
		u123.CFrame = u4(0, v28.angles.y, 0) + u123.Position;
		local l__FloorMaterial__1155 = v590.FloorMaterial;
		if l__FloorMaterial__1155 ~= l__Enum_Material_Air__147 then
			v595.t = l__magnitude__1152;
			local v1156 = v595.p;
			if u256 < v10.distance * 3 / 16 - 1 then
				u256 = u256 + 1;
				local v1157 = l__soundfonts__261[l__FloorMaterial__1155];
				if v1157 and not u139 and v10.movementmode ~= "prone" then
					if v1156 <= 15 then
						local v1158 = v1157 .. "walk";
					else
						v1158 = v1157 .. "run";
					end;
					if v1158 == "grasswalk" or v1158 == "sandwalk" then
						local v1159 = (v1156 / 40) ^ 2;
					else
						v1159 = (v1156 / 35) ^ 2;
					end;
					v38.PlaySound("friendly_" .. v1158, "SelfFoley", math.clamp(v1159 <= 0.75 and v1159 or 0.75, 0, 0.5), nil, 0, 0.2);
					v38.PlaySound("movement_extra", "SelfFoley", math.clamp((v1156 / 50) ^ 2, 0, 0.25));
					if v1156 >= 10 and v1156 <= 15 then
						v38.PlaySound("cloth_walk", "SelfFoley", math.clamp((v1156 / 20) ^ 2 / 6, 0, 0.25));
					elseif v1156 > 15 then
						v38.PlaySound("cloth_run", "SelfFoley", math.clamp((v1156 / 20) ^ 2 / 3, 0, 0.25));
					end;
				end;
			end;
		else
			v595.t = 0;
			v1156 = v595.p;
		end;
		v600.t = l__magnitude__1152 < l__p__1149 and l__magnitude__1152 or l__p__1149;
		v10.speed = v1156;
		v10.headheight = v604.p;
		v10.distance = v10.distance + p379 * v1156;
		v10.FloorMaterial = l__FloorMaterial__1155;
		v596.t = v1151;
		v10.velocity = v596.p;
		v10.acceleration = v1148;
		v10.sprint = v588.p;
		if v1151.magnitude < l__p__1149 * 1 / 3 and v32.getInputType() == "controller" and v10.sprinting() then
			v10:setsprint(false);
		end;
	end;
	if u161 then
		u161.Brightness = u160.p;
	end;
end;
v10.step = u258;
local function u262(p380)
	local v1160 = game:GetService("Players"):GetPlayers();
	local v1161 = v23.anglesyx(v28.angles.x, v28.angles.y);
	local v1162 = 0.004629629629629629 * u257.AbsoluteSize.y;
	local v1163 = 0.995;
	local v1164 = nil;
	local v1165 = nil;
	local v1166 = u258();
	local v1167 = nil;
	local v1168 = nil;
	while true do
		local v1169, v1170 = v1160(v1167, v1168);
		if not v1169 then
			break;
		end;
		if not u256[v1169] then
			local v1171 = Instance.new("Frame");
			v1171.Rotation = 45;
			v1171.BorderSizePixel = 0;
			v1171.SizeConstraint = "RelativeYY";
			v1171.BackgroundColor3 = Color3.new(1, 1, 0.7);
			v1171.Size = UDim2.new(0.009259259259259259 * v1166, 0, 0.009259259259259259 * v1166, 0);
			v1171.Parent = u257;
			u256[v1169] = v1171;
		end;
		u256[v1169].BackgroundTransparency = 1;
		if v1170.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor and v12:isplayeralive(v1170) then
			local l__p__1172 = v28.cframe.p;
			local v1173, v1174 = v14.getupdater(v1170).getpos();
			if v1174 and not workspace:FindPartOnRayWithWhitelist(u146(l__p__1172, v1174 - l__p__1172), v15.raycastwhitelist) then
				local v1175 = u259(l__p__1172, v18.bulletAcceleration, v1174, p380.bulletspeed);
				if v1175 then
					local v1176 = v1175.unit:Dot(v1161);
					if v1163 < v1176 then
						v1163 = v1176;
						v1165 = v1169;
						v1164 = v28.currentcamera:WorldToViewportPoint(l__p__1172 + v1175);
					end;
				end;
			end;
		end;	
	end;
	if v1165 then
		u256[v1165].BackgroundTransparency = 0;
		u256[v1165].Position = UDim2.new(0, v1164.x / v1166 - v1162, 0, v1164.y / v1166 - v1162);
		u256[v1165].Size = UDim2.new(0.009259259259259259 * v1166, 0, 0.009259259259259259 * v1166, 0);
	end;
	for v1177 = #v1160 + 1, #u256 do
		u256[v1177]:Destroy();
		u256[v1177] = nil;
	end;
end;
local function u263()
	for v1178 = 1, #u256 do
		u256[v1178].BackgroundTransparency = 1;
	end;
end;
u258 = function(p381)
	if v10.alive then
		u164:step(p381);
		if not u140 or not u140.step then
			return;
		end;
	else
		u263();
		return;
	end;
	u140.step(p381);
	if u140.attachments and u140.attachments.Other == "Ballistics Tracker" and u140.isaiming() and v592.p > 0.95 then
		u262(u140.data);
		return;
	end;
	u263();
end;
v10.animstep = u258;
u258 = function(p382)
	if p382:IsA("Script") then
		p382.Disabled = true;
		return;
	end;
	if p382:IsA("BodyMover") and p382.Name ~= "\n" then
		v21:send("logmessage", "BodyMover");
		u127:Kick();
		return;
	end;
	if p382:IsA("BasePart") then
		p382.Transparency = 1;
		p382.CollisionGroupId = 1;
		p382.CanCollide = true;
		p382.CanTouch = false;
		p382.CanQuery = false;
		return;
	end;
	if p382:IsA("Decal") then
		p382.Transparency = 1;
	end;
end;
u257 = Instance.new;
u257 = u257("Sound");
u257.Looped = true;
u257.SoundId = "rbxassetid://9057212926";
u257.Volume = 0;
u257.Parent = workspace;
v590.StateChanged:connect(function(p383, p384)
	if p383 == Enum.HumanoidStateType.Climbing and p384 ~= Enum.HumanoidStateType.Climbing then
		v589.t = 0;
	end;
	if p384 == Enum.HumanoidStateType.Freefall then
		u257.Volume = 0;
		u257:Play();
		while u257.Playing do
			if not v10.alive then
				u257:Stop();
				u257.Volume = 0;
			end;
			local v1179 = math.abs(u123.Velocity.Y / 80) ^ 5;
			if v1179 < 0 then
				v1179 = 0;
			end;
			u257.Volume = v1179 <= 0.75 and v1179 or 0.75;
			task.wait();		
		end;
	elseif p384 == Enum.HumanoidStateType.Climbing then
		local v1180 = workspace:FindPartOnRayWithWhitelist(u146(v28.cframe.p, v28.lookvector * 2), v15.raycastwhitelist);
		if v1180 and v1180:IsA("TrussPart") then
			v589.t = 1;
			return;
		end;
	elseif p384 == Enum.HumanoidStateType.Landed then
		u257:Stop();
		local v1181 = u4(0, v28.angles.y, 0) + u123.Position;
		local l__FloorMaterial__1182 = v10.FloorMaterial;
		local l__y__1183 = u123.Velocity.y;
		local v1184 = l__y__1183 * l__y__1183 / (2 * workspace.Gravity);
		if v1184 > 2 and l__FloorMaterial__1182 and v10.alive then
			local v1185 = l__soundfonts__261[l__FloorMaterial__1182];
			if v1185 then
				v38.PlaySound(v1185 .. "Land", "SelfFoley", 0.25);
			end;
		end;
		if v1184 > 12 then
			v38.PlaySound("landHard", "SelfFoley", 0.25);
		end;
		if v1184 > 16 then
			v38.PlaySound("landNearDeath", "SelfFoley", 0.25);
			local v1186 = true;
			if v1184 == v1184 then
				v1186 = true;
				if v1184 ~= (1 / 0) then
					v1186 = v1184 == (-1 / 0);
				end;
			end;
			if v1186 then
				v1184 = 100;
			end;
			v21:send("falldamage", v1184);
		end;
	end;
end);
local u264 = {};
function v10.updatecharacter(p385)
	u126 = v585:Clone();
	local v1187 = u126:GetDescendants();
	for v1188 = 1, #v1187 do
		u258(v1187[v1188]);
	end;
	u256 = 0;
	v10.distance = 0;
	v10.velocity = u98;
	v10.acceleration = u98;
	v10.speed = 0;
	u123 = u126:WaitForChild("HumanoidRootPart");
	u123.Position = p385;
	u123.Velocity = u98;
	u123.CanCollide = false;
	v10.rootpart = u123;
	v10.torso = u126:WaitForChild("Torso");
	u124 = u123:WaitForChild("RootJoint");
	u124.C0 = u125;
	u124.C1 = u125;
	v28.currentcamera.CameraSubject = v590;
	v590:ChangeState(Enum.HumanoidStateType.Running);
	v590.Parent = u126;
	v602.Velocity = u98;
	v602.Parent = u123;
	u127.Character = u126;
	u126.Parent = workspace.Ignore;
	u264[#u264 + 1] = u126.DescendantAdded:connect(u258);
	u264[#u264 + 1] = u123.Touched:connect(function(p386)
		if string.lower(p386.Name) == "killwall" then
			v21:send("forcereset");
		end;
	end);
end;
v10.ondied:connect(function()
	for v1189 = 1, #u264 do
		u264[v1189]:Disconnect();
		u264[v1189] = nil;
	end;
end);
u2 = shared;
u3 = u2.require;
u2 = "PlayerStatusEvents";
u3 = u3(u2);
u10 = 1;
u119 = v18.actorClientReplicationRate;
u2 = u10 / u119;
u119 = 2;
u125 = math.pi;
u10 = u119 * u125;
u119 = Vector3.zero;
u125 = u119.Dot;
u4 = v23.anglesyx;
u98 = v24.direct;
u146 = v24.jointleg;
u130 = v24.jointarm;
u184 = CFrame.new;
u184 = u184();
u150 = 0;
u207 = Vector3.new;
u207 = u207(u150, 0, -1);
u150 = Vector3.new;
u150 = u150(0, 1, 0);
local v1190 = Vector3.new(0, -1.5, 0);
local v1191 = RaycastParams.new();
v1191.FilterType = Enum.RaycastFilterType.Whitelist;
v1191.IgnoreWater = true;
v1191.FilterDescendantsInstances = { workspace.Map };
local v1192 = v41.getTime();
local v1193 = table.create(game:GetService("Players").MaxPlayers);
local l__ReplicatedStorage__1194 = game:GetService("ReplicatedStorage");
local l__MuzzleLight__1195 = l__ReplicatedStorage__1194:WaitForChild("Effects"):WaitForChild("MuzzleLight");
local l__Players__1196 = workspace:FindFirstChild("Players");
local l__Map__1197 = workspace:FindFirstChild("Map");
local l__Ignore__1198 = workspace:FindFirstChild("Ignore");
local v1199 = CFrame.new(0, 0, -0.5, 1, 0, 0, 0, 0, -1, 0, 1, 0);
local l__Bodies__1200 = l__ReplicatedStorage__1194:WaitForChild("Character"):WaitForChild("Bodies");
local v1201 = v24.interpolator(CFrame.new(0, -0.125, 0), CFrame.new(0, -1, 0) * CFrame.Angles(-u10 / 24, 0, 0));
local v1202 = v24.interpolator(CFrame.new(0, -1, 0) * CFrame.Angles(-u10 / 24, 0, 0), CFrame.new(0, -2, 0.5) * CFrame.Angles(-u10 / 4, 0, 0));
local v1203 = CFrame.new(0.5, 0.5, 0, 0.918751657, -0.309533417, -0.245118901, 0.369528353, 0.455418497, 0.809963167, -0.139079139, -0.834734678, 0.532798767);
local v1204 = CFrame.new(-0.5, 0.5, 0, 0.918751657, 0.309533417, 0.245118901, -0.369528353, 0.455418497, 0.809963167, 0.139079139, -0.834734678, 0.532798767);
for v1205, v1206 in game:GetService("Teams")() do
	local v1207 = l__Bodies__1200:WaitForChild(v1206.Name);
	if v1207 then
		local l__Cosmetics__1208 = v1207:FindFirstChild("Cosmetics");
		if l__Cosmetics__1208 then
			for v1209, v1210 in l__Cosmetics__1208() do
				v1210.Anchored = false;
				v1210.CastShadow = false;
				v1210.CanCollide = false;
				v1210.CanTouch = false;
				v1210.CanQuery = false;
				v1210.CollisionGroupId = 1;
				v1210.Massless = true;
				local v1211 = v1207:FindFirstChild(v1210.Name);
				if v1211 then
					local v1212 = Instance.new("Weld");
					v1212.Part0 = v1211;
					v1212.Part1 = v1210;
					v1212.C0 = v1211.CFrame:inverse() * v1210.CFrame;
					v1212.Parent = v1210;
				else
					warn(string.format("%s is not a valid part of character", v1210.Name));
					v1210:Destroy();
				end;
			end;
		end;
	end;
end;
local u265 = {};
local u266 = {};
function v14.getplayerhit(p387)
	local l__Parent__1213 = p387.Parent;
	if not l__Parent__1213 then
		return;
	end;
	return u265[l__Parent__1213];
end;
function v14.removecharacterhash(p388)
	for v1214, v1215 in u265, nil do
		if v1215 == p388 then
			u265[v1214] = nil;
		end;
	end;
	u266[p388] = nil;
end;
local u267 = shared.require("HitBoxConfig");
local u268 = shared.require("InputType");
local u269 = game:GetService("Players").LocalPlayer;
local u270 = shared.require("Math");
local u271 = { "head", "torso", "lleg", "rleg", "larm", "rarm" };
local u272 = nil;
local u273 = shared.require("CloseCast");
function v14.thickcastplayers(p389, p390)
	local v1216 = {};
	local v1217 = u267:get(u268.purecontroller());
	for v1218, v1219 in u266, nil do
		if v1218.TeamColor ~= u269.TeamColor then
			local v1220 = p390 - p389;
			if u270.doesRayIntersectSphere(p389, v1220, v1219.torso.Position, 6) then
				local v1221 = nil;
				local v1222 = nil;
				local v1223 = (1 / 0);
				local v1224 = nil;
				local v1225 = nil;
				local v1226 = (1 / 0);
				local v1227 = nil;
				for v1228 = 1, #u271 do
					local v1229 = v1219[u271[v1228]];
					local l__precedence__1230 = v1217[v1229.Name].precedence;
					local v1231, v1232, v1233, v1234 = u273.closeCastPart(v1229, p389, v1220);
					if l__precedence__1230 < v1223 and v1234 < (u272 or v1217[v1229.Name].radius) then
						v1223 = l__precedence__1230;
						v1221 = v1229;
						v1222 = v1234;
						v1224 = v1233;
					end;
					if l__precedence__1230 < v1226 and v1234 == 0 then
						v1226 = l__precedence__1230;
						v1225 = v1229;
						v1227 = v1233;
					end;
				end;
				if v1221 then
					v1216[v1218] = {
						bestPart = v1221, 
						bestDistance = v1222, 
						bestNearestPosition = v1224, 
						bestDirectPart = v1225, 
						bestDirectNearestPosition = v1227
					};
				end;
			end;
		end;
	end;
	return v1216;
end;
v21:add("lolhi", function(p391)
	u272 = p391;
end);
function v14.getbodyparts(p392)
	return u266[p392];
end;
function v14.getallparts()
	local v1235 = {};
	for v1236, v1237 in u266, nil do
		for v1238, v1239 in v1237, nil do
			if v1239.Parent then
				v1235[#v1235 + 1] = v1239;
			end;
		end;
	end;
	return v1235;
end;
local v1240 = shared.require("FibDecoder");
local u274 = shared.require("SmoothReplicationPackager");
local u275 = shared.require("Fib3Decoder");
local u276 = shared.require("Fib2Decoder");
local u277 = shared.require("ReplicationSmoother");
local u278 = shared.require("Holode4");
local u279 = v1199;
local u280 = function(p393, p394)
	local v1241 = nil;
	local l__Slot1__1242 = p393:FindFirstChild("Slot1");
	if not l__Slot1__1242 or not p393:FindFirstChild("Slot2") then
		print("Incomplete third person model", p393);
		return;
	end;
	for v1243, v1244 in p393() do
		if v1244:IsA("BasePart") then
			if v1244.Name == "Flame" then
				v1241 = v1244;
			end;
			if v1244 ~= l__Slot1__1242 then
				local v1245 = Instance.new("Weld");
				v1245.Part0 = l__Slot1__1242;
				v1245.Part1 = v1244;
				v1245.C0 = l__Slot1__1242.CFrame:inverse() * v1244.CFrame;
				v1245.Parent = l__Slot1__1242;
			end;
			if v43.getValue("togglethirdpersoncamo") and p394 then
				v45.textureModel(p393, p394);
			end;
			v1244.CastShadow = false;
			v1244.Massless = true;
			v1244.Anchored = false;
			v1244.CanCollide = false;
		end;
	end;
	return v1241;
end;
local u281 = l__Ignore__1198;
local u282 = l__Map__1197;
local u283 = l__Players__1196;
local u284 = {};
local u285 = v1201;
local u286 = v1202;
local u287 = function(p395, p396, p397, p398)
	local v1246 = p396 - p395;
	local l__magnitude__1247 = v1246.magnitude;
	if not (l__magnitude__1247 > 0) then
		return 0;
	end;
	local v1248 = p395 - p398;
	local v1249 = u125(v1248, v1246) / l__magnitude__1247;
	local v1250 = p397 * p397 + v1249 * v1249 - u125(v1248, v1248);
	if not (v1250 > 0) then
		return 1;
	end;
	local v1251 = v1250 ^ 0.5 - v1249;
	if not (v1251 > 0) then
		return 1;
	end;
	return l__magnitude__1247 / v1251, v1251 - l__magnitude__1247;
end;
local u288 = v1190;
local u289 = v1191;
local u290 = v38.soundfonts;
local u291 = v1204;
local u292 = v1203;
local u293 = l__Bodies__1200;
local u294 = l__ReplicatedStorage__1194;
local function u295(p399)
	local v1252 = p399(11);
	local v1253 = p399(52);
	if p399(1) == 0 then
		local v1254 = 1;
	else
		v1254 = -1;
	end;
	if v1252 == 2047 then
		if v1253 == 0 then
			return v1254 / 0;
		elseif v1253 == 1 then
			return (0 / 0);
		else
			return (0 / 0);
		end;
	end;
	if v1252 == 0 then
		return v1254 * v1253 * 5E-324;
	end;
	return v1254 * (v1253 / 4503599627370496 + 1) * 2 ^ (v1252 - 1023);
end;
local u296 = v1193;
local function u297(p400)
	if p400 == u269 then
		return;
	end;
	local v1255 = Instance.new("Motor6D");
	local v1256 = Instance.new("Motor6D");
	local v1257 = {};
	local v1258 = v25.new();
	v1258.s = 12;
	v1258.d = 0.8;
	local v1259 = v25.new(1);
	v1259.s = 12;
	local v1260 = v25.new();
	v1260.s = 20;
	v1260.d = 0.8;
	v1257.breakcount = 0;
	v1257.lastbreakcount = nil;
	v1257.lastPacketTime = nil;
	v1257.receivedFrameTime = nil;
	v1257.receivedPosition = nil;
	v1257.lastSmoothTime = nil;
	v1257.updaterecieved = false;
	v1257.alive = false;
	local v1261 = v25.new(0);
	v1261.s = 4;
	v1261.d = 0.8;
	local v1262 = v25.new(0);
	v1262.s = 8;
	local v1263 = v25.new(1);
	v1263.s = 8;
	local v1264 = v25.new(0);
	v1264.s = 50;
	v1264.d = 1;
	local v1265 = Instance.new("SoundGroup");
	local v1266 = Instance.new("EqualizerSoundEffect");
	v1266.HighGain = 0;
	v1266.MidGain = 0;
	v1266.LowGain = 0;
	v1266.Parent = v1265;
	v1265.Parent = game:GetService("SoundService");
	local u298 = v30.new();
	local u299 = nil;
	local u300 = Instance.new("Motor6D");
	local u301 = nil;
	local u302 = nil;
	local u303 = u184;
	local u304 = u184;
	local u305 = u184;
	local u306 = u184;
	local u307 = Vector3.new(0, 0, -1);
	local u308 = u184;
	local u309 = Vector3.new(0, -1, 0);
	local u310 = u119;
	local u311 = u184;
	local u312 = nil;
	local u313 = nil;
	function v1257.equipknife(p401, p402, p403)
		if p401 then
			u298:clear();
			if u299 then
				v1258.t = 0;
				u298:add(function()
					return v1258.p < 0;
				end);
				u298:add(function()
					u299.Slot1.Transparency = 1;
					u299.Slot2.Transparency = 1;
					u300.Part1 = nil;
					u299:Destroy();
				end);
			end;
			u298:add(function()
				u301 = "KNIFE";
				u302 = p401.dualhand;
				u303 = CFrame.new(p401.offset3p.p);
				u304 = p401.offset3p - p401.offset3p.p;
				u305 = p401.pivot3p;
				u306 = p401.drawcf3p;
				u307 = p401.forward3p;
				u308 = p401.sprintcf3p;
				u309 = p401.lhold3p;
				u310 = p401.rhold3p;
				u311 = p401.stabcf3p;
				u299 = p402:Clone();
				u312 = u280(u299, p403);
				u299.Name = "Model";
				u299.Parent = u313.Parent;
				u300.Part1 = u299.Slot1;
				v1258.t = 1;
				if v14.disable3psounds then
					for v1267, v1268 in u299() do
						if v1268:IsA("Sound") then
							v1268.Playing = false;
						end;
					end;
				end;
			end);
		end;
	end;
	local u314 = u119;
	local u315 = u119;
	local u316 = u119;
	local u317 = u119;
	local u318 = 0;
	local u319 = u184;
	local u320 = v25.new(u119);
	local u321 = v25.new(u119);
	local u322 = nil;
	function v1257.equip(p404, p405, p406)
		if p404 then
			u298:clear();
			if u299 then
				v1258.t = 0;
				u298:add(function()
					return v1258.p < 0;
				end);
				u298:add(function()
					u299.Slot1.Transparency = 1;
					u299.Slot2.Transparency = 1;
					u300.Part1 = nil;
					u299:Destroy();
				end);
			end;
			u298:add(function()
				u301 = "gun";
				u314 = p404.transkickmax;
				u315 = p404.transkickmin;
				u316 = p404.rotkickmax;
				u317 = p404.rotkickmin;
				u303 = CFrame.new(p404.offset3p.p);
				u304 = p404.offset3p - p404.offset3p.p;
				u305 = p404.pivot3p;
				u306 = p404.drawcf3p;
				u307 = p404.forward3p;
				u318 = p404.headaimangle3p and 0;
				u308 = p404.sprintcf3p;
				u319 = p404.aimpivot3p;
				u320.s = p404.modelkickspeed;
				u320.d = p404.modelkickdamper;
				u321.s = p404.modelkickspeed;
				u321.d = p404.modelkickdamper;
				u309 = p404.lhold3p;
				u310 = p404.rhold3p;
				u299 = p405:Clone();
				u312 = u280(u299, p406);
				u299.Name = "Model";
				u299.Parent = u313.Parent;
				u300.Part1 = u299.Slot1;
				v1258.t = 1;
				if p404.firesoundid then
					u322 = p404.firesoundid;
				end;
				if v14.disable3psounds then
					for v1269, v1270 in u299() do
						if v1270:IsA("Sound") then
							v1270.Playing = false;
						end;
					end;
				end;
			end);
		end;
	end;
	local u323 = v25.new(u119, 1, 32);
	function v1257.getweaponpos()
		if u312 then
			return u312.CFrame.p;
		end;
		if not u299 then
			return u323.p;
		end;
		return u299.Slot1.CFrame * u304:inverse() * Vector3.new(0, 0, -2);
	end;
	function v1257.stab()
		if u299 and u301 == "KNIFE" then
			v1260.a = 47;
			local l__CFrame__1271 = u313.CFrame;
			local v1272, v1273, v1274 = workspace:FindPartOnRayWithIgnoreList(Ray.new(l__CFrame__1271.p, l__CFrame__1271.LookVector * 5), { u281, u282, u283:FindFirstChild(p400.TeamColor.Name) });
			if v1272 then
				v34:bloodhit(v1273, true, 85, Vector3.new(0, -8, 0) + (v1273 - l__CFrame__1271.p).unit * 8, true);
			end;
		end;
	end;
	function v1257.kickweapon(p407, p408, p409, p410)
		if u299 and u301 == "gun" then
			local l__p__1275 = v1259.p;
			u320.a = u315 + Vector3.new(math.random(), math.random(), math.random()) * (u314 - u315);
			u321.a = u317 + Vector3.new(math.random(), math.random(), math.random()) * (u316 - u317);
			if #u284 == 0 then
				local v1276 = Instance.new("Sound");
				v1276.Ended:connect(function()
					v1276.Parent = nil;
					table.insert(u284, v1276);
				end);
			else
				v1276 = table.remove(u284, 1);
			end;
			v1276.SoundGroup = v1265;
			v1276.SoundId = p408 or u322;
			if p409 then
				v1276.Pitch = p409;
			end;
			if p410 then
				v1276.Volume = p410;
			end;
			local v1277 = -(u313.Position - v28.cframe.p).magnitude / 14.6484;
			v1266.HighGain = v1277;
			v1266.MidGain = v1277;
			v1276.Parent = u313;
			v1276:Play();
			if v43.getValue("togglemuzzleffects") and u312 and v27.point(u312.Position) then
				if not p407 then
					v1264.a = 125;
				end;
				local l__Smoke__1278 = u312:FindFirstChild("Smoke");
				if not p407 then
					for v1279, v1280 in u312() do
						if v1280 ~= l__Smoke__1278 and v1280:IsA("ParticleEmitter") then
							v1280:Emit(1);
						end;
					end;
				end;
			end;
		end;
	end;
	function v1257.getweapon()
		return u299;
	end;
	function v1257.setsprint(p411)
		if p411 then
			local v1281 = 0;
		else
			v1281 = 1;
		end;
		v1263.t = v1281;
	end;
	function v1257.setaim(p412)
		if p412 then
			local v1282 = 0;
		else
			v1282 = 1;
		end;
		v1259.t = v1282;
	end;
	function v1257.setstance(p413)
		if p413 == "stand" then
			local v1283 = 0;
		elseif p413 == "crouch" then
			v1283 = 0.5;
		else
			v1283 = 1;
		end;
		v1261.t = v1283;
	end;
	local u324 = nil;
	function v1257.getpos()
		if not v1257.alive then
			return;
		end;
		return u323.p, u324 and u324.Position;
	end;
	function v1257.gethead()
		return u324;
	end;
	local u325 = v25.new(Vector2.new(), 0.75, 12);
	function v1257.getlookangles()
		return u325.p;
	end;
	function v1257.isalive()
		return v1257.alive and v1257.updaterecieved;
	end;
	local u326 = v25.new(u119, 1, 6);
	local u327 = u278.new(u119, 12);
	function v1257.resetSprings(p414)
		p414 = p414 or u119;
		u323.t = p414;
		u323.p = p414;
		u323.v = u119;
		u326.t = u119;
		u326.p = u119;
		u326.v = u119;
		u327._p0 = p414;
		u327._p1 = p414;
		u327._a0 = u119;
		u327._j0 = u119;
		u327._v0 = u119;
		u327._t0 = 0;
	end;
	local u328 = u277.new(10, 0.25, 0.5, function(p415, p416, p417, p418, p419)
		if p417 == p418 then
			return p415;
		end;
		local v1284 = (p418 - p419) / (p418 - p417);
		local v1285 = (p419 - p417) / (p418 - p417);
		return {
			t = v1284 * p415.t + v1285 * p416.t, 
			position = v1284 * p415.position + v1285 * p416.position, 
			velocity = v1284 * p415.velocity + v1285 * p416.velocity, 
			angles = v1284 * p415.angles + v1285 * p416.angles, 
			breakcount = p415.breakcount
		};
	end);
	local u329 = nil;
	local u330 = 0;
	local u331 = false;
	local u332 = 1;
	local u333 = {
		center = u184, 
		pos = u119, 
		sdown = CFrame.new(0.5, -3, 0), 
		pdown = CFrame.new(0.5, -2.75, 0), 
		weld = v1256, 
		hipcf = CFrame.new(0.5, -0.5, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0), 
		legcf = u279, 
		angm = 1, 
		torsoswing = 0.1
	};
	local u334 = {
		makesound = true, 
		center = u184, 
		pos = u119, 
		sdown = CFrame.new(-0.5, -3, 0), 
		pdown = CFrame.new(-0.5, -2.75, 0), 
		weld = v1255, 
		hipcf = CFrame.new(-0.5, -0.5, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0), 
		legcf = u279, 
		angm = -1, 
		torsoswing = -0.1
	};
	local u335 = {};
	local u336 = nil;
	local u337 = nil;
	local u338 = Instance.new("Motor6D");
	local u339 = Instance.new("Motor6D");
	function v1257.step(p420, p421)
		debug.profilebegin("rep char " .. p420 .. " " .. p400.Name);
		if not u313 then
			debug.profileend();
			return;
		end;
		local v1286 = nil;
		local v1287 = nil;
		local v1288 = nil;
		local v1289 = nil;
		local v1290 = 0;
		if u328:isReady() then
			local v1291 = u328:getFrame(v41.getTime());
			if v1291.breakcount ~= v1257.lastbreakcount then
				v1257.resetSprings(v1291.position);
				u329.Parent = u283[p400.TeamColor.Name];
				v1257.lastbreakcount = v1291.breakcount;
			end;
			v1286 = v1291.position;
			v1288 = v1291.position;
			v1287 = v1291.angles;
			v1289 = v1291.velocity;
			v1290 = v1291.t - (v1257.lastSmoothTime or v1291.t);
			v1257.lastSmoothTime = v1291.t;
		end;
		local v1292 = u325:update(v1287);
		local v1293 = u323:update(v1286);
		local v1294 = u326:update(v1289);
		local v1295, v1296, v1297, v1298 = u327:update(v1290, v1288);
		local v1299 = CFrame.Angles(0, u330, 0) + (0 * v1295 + 1 * v1293);
		if u299 then
			if p421 and not u331 then
				u299.Slot1.Transparency = 0;
				u299.Slot2.Transparency = 0;
				u331 = true;
			elseif not p421 and u331 then
				u299.Slot1.Transparency = 1;
				u299.Slot2.Transparency = 1;
				u331 = false;
			end;
		end;
		u313.CFrame = v1299;
		if p420 >= 1 then
			u298:step();
			local l__p__1300 = v1261.p;
			local l__p__1301 = v1263.p;
			local v1302 = l__p__1300 < 0.5 and u285(2 * l__p__1300) or u286(2 * l__p__1300 - 1);
			local l__y__1303 = v1292.y;
			local v1304 = l__p__1301 * 0.5;
			u330 = u330 - l__y__1303 < -v1304 and l__y__1303 - v1304 or (v1304 < u330 - l__y__1303 and l__y__1303 + v1304 or u330);
			local v1305 = CFrame.Angles(0, u330, 0) * CFrame.new(0, 0.05 * math.sin(2 * os.clock()) - 0.55, 0) * v1302 * CFrame.new(0, 0.5, 0) + v1299.p;
			local v1306 = l__p__1300 > 0.5 and 2 * l__p__1300 - 1 or 0;
			u332 = 0.5 * (1 - l__p__1300) + 0.5 + (1 - l__p__1301) * 0.5;
			local v1307 = (v1299 * u333.sdown):Lerp(v1305 * u333.pdown, v1306);
			local v1308 = (v1299 * u334.sdown):Lerp(v1305 * u334.pdown, v1306);
			local l__p__1309 = v1308.p;
			local v1310, v1311 = u287(u333.center.p, v1307.p, u332, u333.pos);
			if v1311 then
				u335.remp = v1311;
			end;
			v1262.t = (0 * v1296 + 1 * v1294).magnitude;
			local v1312 = l__p__1309 - u334.center.p;
			local l__magnitude__1313 = v1312.magnitude;
			if l__magnitude__1313 > 0 then
				local v1314 = l__p__1309 + u332 / l__magnitude__1313 * v1312;
			else
				v1314 = l__p__1309;
			end;
			if v1310 < 1 then
				u334.pos = (1 - v1310) * (v1308 * u334.center:inverse() * u334.pos) + v1310 * v1314;
				u333.center = v1307;
				u334.center = v1308;
			else
				u333.center = v1307;
				u334.center = v1308;
				local l__magnitude__1315 = (v28.basecframe.p - l__p__1309).magnitude;
				if u334.makesound and l__magnitude__1315 < 128 then
					local v1316 = workspace:Raycast(l__p__1309 + u150, u288, u289);
					if v1316 then
						local v1317 = u290[v1316.Material];
						if v1317 then
							if p400.TeamColor ~= u269.TeamColor then
								local v1318 = "enemy_" .. v1317;
								local v1319 = 3.872983346207417 / (l__magnitude__1315 / 5);
							else
								v1318 = "friendly_" .. v1317;
								v1319 = 1.4142135623730951 / (l__magnitude__1315 / 5);
							end;
							if v1318 == "enemy_wood" then
								v1319 = 3.1622776601683795 / (l__magnitude__1315 / 5);
							end;
							if v1262.p <= 15 then
								local v1320 = v1318 .. "walk";
							else
								v1320 = v1318 .. "run";
							end;
							v38.PlaySound(v1320, nil, v1319, 1, nil, nil, u313, 128, 10);
						end;
					end;
				end;
				u333.pos = v1307.p + u332 * (u333.pos - v1307.p).unit;
				u334.pos = v1314;
				u333 = u334;
				u334 = u333;
			end;
			if p420 >= 2 then
				local l__p__1321 = v1258.p;
				local v1322 = u4(v1292.x, l__y__1303);
				local v1323 = v1262.p / 8;
				local v1324 = v1323 < 1 and v1323 or 1;
				local v1325 = u335.remp * (2 - u335.remp / u332);
				if v1325 < 0 then
					local v1326 = 0;
				else
					v1326 = v1325;
				end;
				local v1327 = u98(v1305, u207, v1322, 0.5 * l__p__1301 * (1 - l__p__1300) * l__p__1321) * CFrame.Angles(0, v1326 * u333.torsoswing, 0) * CFrame.new(0, -3, 0);
				local v1328 = u98(u184, Vector3.new(0, 1, 0), Vector3.new(0, 333.3333333333333, 0) + v1297, 1 - v1306) * (v1327 - v1327.p) * CFrame.new(0, 3, 0) + v1327.p + Vector3.new(0, v1326 * v1324 / 16, 0);
				u313.CFrame = v1328;
				u333.weld.C0 = u146(1, 1.5, u333.hipcf, v1328:inverse() * u333.pos, v1306 * u10 / 5 * u333.angm) * u333.legcf;
				u334.weld.C0 = u146(1, 1.5, u334.hipcf, v1328:inverse() * (u334.pos + v1326 * v1324 / 3 * Vector3.new(0, 1, 0)), v1306 * u10 / 5 * u334.angm) * u334.legcf;
				local l__p__1329 = v1259.p;
				u336.C0 = v1328:inverse() * u98(v1328 * CFrame.new(0, 0.825, 0), u207, v1322) * CFrame.Angles(0, 0, (1 - l__p__1329) * u318) * CFrame.new(0, 0.675, 0);
				if u337 then
					u337.Brightness = v1264.p;
				end;
				if u299 then
					if u301 == "gun" then
						local v1330 = u306:Lerp(CFrame.Angles(v1326 / 10, v1326 * u333.torsoswing, 0) * u308:Lerp(v1328:inverse() * u98(v1328 * u319:Lerp(u305, l__p__1329), u207, v1322) * u303 * CFrame.new(u320.p) * v24.fromaxisangle(u321.p) * u304, l__p__1301), l__p__1321);
						u338.C0 = u130(1, 1.5, u291, v1330 * u309) * u279;
						u339.C0 = u130(1, 1.5, u292, v1330 * u310) * u279;
						u300.C0 = v1330;
					elseif u301 == "KNIFE" then
						local v1331 = u306:Lerp(u308:Lerp(v1328:inverse() * u98(v1328 * u305, u207, v1322) * u303 * u304 * u184:Lerp(u311, v1260.p), l__p__1301), l__p__1321);
						if u302 then
							u338.C0 = u130(1, 1.5, u291, v1331 * u309) * u279;
						else
							u338.C0 = u130(1, 1.5, u291, u309) * u279;
						end;
						u339.C0 = u130(1, 1.5, u292, v1331 * u310) * u279;
						u300.C0 = v1331;
					end;
				end;
			end;
		end;
		debug.profileend();
	end;
	function v1257.spawn(p422)
		if v1257.alive then
			return;
		end;
		v1257.alive = true;
		v1257.updaterecieved = false;
		if p400.TeamColor == game:GetService("Teams").Ghosts.TeamColor then
			local v1332 = "Ghosts";
		else
			v1332 = "Phantoms";
		end;
		u329 = u293:WaitForChild(v1332):Clone();
		u329.Name = "Player";
		u329.Torso.Anchored = true;
		u313 = u329.Torso;
		u324 = u329.Head;
		u336 = u313.Neck;
		u338.Part0 = u313;
		u339.Part0 = u313;
		v1255.Part0 = u313;
		v1256.Part0 = u313;
		u338.Part1 = u329["Left Arm"];
		u339.Part1 = u329["Right Arm"];
		v1255.Part1 = u329["Left Leg"];
		v1256.Part1 = u329["Right Leg"];
		u338.Parent = u313;
		u339.Parent = u313;
		v1255.Parent = u313;
		v1256.Parent = u313;
		u300.Part0 = u313;
		u300.Parent = u313;
		u337 = u294.Effects.MuzzleLight:Clone();
		u337.Parent = u313;
		u265[u329] = p400;
		u266[p400] = {
			torso = u329.Torso, 
			head = u329.Head, 
			lleg = u329["Left Leg"], 
			rleg = u329["Right Leg"], 
			larm = u329["Left Arm"], 
			rarm = u329["Right Arm"]
		};
		v1257.setsprint(false);
		v1257.setstance("stand");
		v1257.setaim(false);
		v12.updatehealth(p400, {
			alive = true, 
			health0 = 100, 
			healtick0 = v41.getTime()
		});
		u3.onPlayerSpawned:fire(p400);
	end;
	function v1257.died()
		if not v1257.alive then
			return;
		end;
		u329 = nil;
		v1257.alive = false;
		u338.Parent = nil;
		u339.Parent = nil;
		v1255.Parent = nil;
		v1256.Parent = nil;
		u300.Parent = nil;
		u337:Destroy();
		u337 = nil;
		if u299 then
			u299:Destroy();
			u299 = nil;
		end;
		for v1333, v1334 in u313() do
			if v1334:IsA("Sound") then
				v1334:Stop();
				v1334.Parent = nil;
			end;
		end;
		for v1335, v1336 in u265, nil do
			if v1336 == p400 then
				u265[v1335] = nil;
			end;
		end;
		u266[p400] = nil;
		v12.updatehealth(p400, {
			alive = false, 
			health0 = 0, 
			healtick0 = v41.getTime()
		});
		v1257.breakcount = 0;
		v1257.lastbreakcount = nil;
		v1257.lastPacketTime = nil;
		v1257.receivedFrameTime = nil;
		v1257.receivedPosition = nil;
		v1257.lastSmoothTime = nil;
		u328:init();
		u3.onPlayerDied:fire(p400);
		return u329;
	end;
	function v1257.updatestate(p423)
		if p423.healthstate then
			v12.updatehealth(p400, p423.healthstate);
		end;
		if p423.stance then
			v1257.setstance(p423.stance);
		end;
		if p423.sprint then
			v1257.setsprint(p423.sprint);
		end;
		if p423.aim then
			v1257.setaim(p423.aim);
		end;
		if p423.weapon then
			local l__weapon__1337 = p423.weapon;
			local v1338 = v42.getWeaponData(l__weapon__1337);
			local v1339 = v42.getExternalModel(l__weapon__1337);
			if v1338 and v1339 then
				if v1338.type == "KNIFE" then
					v1257.equipknife(v1338, v1339);
				else
					v1257.equip(v1338, v1339);
				end;
			else
				print("Couldn't find a 3rd person weapon");
			end;
		end;
		if p423.healthstate and p423.healthstate.alive then
			v1257.spawn();
		end;
	end;
	local u340 = u274.new(u275.new(0.020833333333333332), Vector3.zero);
	local u341 = u274.new(u276.new(0.020833333333333332), Vector2.new());
	function v1257.updateReplication(p424)
		local v1340 = v41.getTime();
		local v1341 = u295(p424);
		local v1342 = u340:readAndUpdate(p424);
		local v1343 = u119;
		if v1257.receivedPosition and v1257.receivedFrameTime then
			v1343 = (v1342 - v1257.receivedPosition) / (v1341 - v1257.receivedFrameTime);
		end;
		local v1344 = false;
		if v1257.lastPacketTime and v1340 - v1257.lastPacketTime > 0.5 then
			v1344 = true;
			v1257.breakcount = v1257.breakcount + 1;
		end;
		u328:receive(v1340, v1341, {
			t = v1341, 
			position = v1342, 
			velocity = v1343, 
			angles = u341:readAndUpdate(p424), 
			breakcount = v1257.breakcount
		}, v1344);
		v1257.updaterecieved = true;
		v1257.receivedPosition = v1342;
		v1257.receivedFrameTime = v1341;
		v1257.lastPacketTime = v1340;
	end;
	function v1257.initstate(p425)
		local v1345, v1346 = unpack(p425);
		u340:initializeState(unpack(v1345));
		u341:initializeState(unpack(v1346));
	end;
	p400:GetPropertyChangedSignal("TeamColor"):Connect(function()
		if v1257.alive then
			u329.Parent = u283[p400.TeamColor.Name];
		end;
	end);
	v21:send("state", p400);
	return v1257;
end;
local function v1347(p426)
	local v1348 = nil;
	if not u296[p426] then
		v1348 = u297(p426);
		if not v1348 then
			return;
		end;
	elseif u296[p426] then
		return u296[p426].updater;
	else
		return;
	end;
	u296[p426] = {
		updater = v1348, 
		lastupdate = 0, 
		lastlevel = 0, 
		lastupframe = 0
	};
	return v1348;
end;
v14.getupdater = v1347;
v21:add("state", function(p427, p428)
	local v1349 = v1347(p427);
	if v1349 then
		v1349.updatestate(p428);
	end;
end);
v21:add("stance", function(p429, p430)
	local v1350 = v1347(p429);
	if v1350 then
		v1350.setstance(p430);
	end;
end);
v21:add("sprint", function(p431, p432)
	local v1351 = v1347(p431);
	if v1351 then
		v1351.setsprint(p432);
	end;
end);
v21:add("aim", function(p433, p434)
	local v1352 = v1347(p433);
	if v1352 then
		v1352.setaim(p434);
	end;
end);
v21:add("stab", function(p435)
	local v1353 = v1347(p435);
	if v1353 then
		v1353.stab();
	end;
end);
v21:add("newspawn", function(p436, p437)
	local v1354 = v1347(p436);
	if v1354 then
		v1354.spawn(p437);
	end;
end);
v21:add("equip", function(p438, p439, p440)
	local v1355 = v1347(p438);
	if v1355 then
		local v1356 = v42.getWeaponData(p439);
		local v1357 = v42.getExternalModel(p439);
		if v1356 and v1357 then
			if v1356.type == "KNIFE" then
				v1355.equipknife(v1356, v1357, p440);
				return;
			end;
			v1355.equip(v1356, v1357, p440);
		end;
	end;
end);
local u342 = {
	Frag = function(p441, p442, p443, p444)
		local l__range0__1358 = p441.range0;
		local l__range1__1359 = p441.range1;
		local l__damage0__1360 = p441.damage0;
		local l__damage1__1361 = p441.damage1;
		local l__magnitude__1362 = (v28.basecframe.p - p443).magnitude;
		p442.Position = p443;
		if l__magnitude__1362 <= 50 then
			v38.play("fragClose", 2, 1, p442, true);
		elseif l__magnitude__1362 <= 200 then
			v38.play("fragMed", 3, 1, p442, true);
		elseif l__magnitude__1362 > 200 then
			v38.play("fragFar", 3, 1, p442, true);
		end;
		local l__Explosion__1363 = p442:FindFirstChild("Explosion");
		if l__Explosion__1363 and l__Explosion__1363:IsA("Attachment") then
			local v1364 = Instance.new("Part");
			v1364.Position = p443;
			v1364.Transparency = 1;
			v1364.Size = p442.Size;
			v1364.CanCollide = false;
			v1364.CanQuery = false;
			v1364.CanTouch = false;
			v1364.Anchored = true;
			v1364.Parent = u281.Misc;
			l__Explosion__1363.Parent = v1364;
			for v1365, v1366 in l__Explosion__1363() do
				if v1366:IsA("ParticleEmitter") then
					v1366:Emit(v1366:GetAttribute("EmitCount") and 1);
				end;
			end;
			delay(5, function()
				v1364:Destroy();
			end);
		else
			local v1367 = Instance.new("Explosion");
			v1367.Position = p443;
			v1367.BlastRadius = p441.blastradius;
			v1367.BlastPressure = 0;
			v1367.DestroyJointRadiusPercent = 0;
			v1367.Parent = workspace;
		end;
		for v1368, v1369 in game:GetService("Players")() do
			if v1369.TeamColor ~= u269.TeamColor and v12:isplayeralive(v1369) then
				local v1370 = v1347(v1369).getpos();
				if v1370 then
					local v1371 = v1370 - p443;
					local l__magnitude__1372 = v1371.magnitude;
					if l__magnitude__1372 < l__range1__1359 and not workspace:Raycast(p443, v1371, u289) then
						v34:bloodhit(v1370, true, l__magnitude__1372 < l__range0__1358 and l__damage0__1360 or (l__magnitude__1372 < l__range1__1359 and (l__damage1__1361 - l__damage0__1360) / (l__range1__1359 - l__range0__1358) * (l__magnitude__1372 - l__range0__1358) + l__damage0__1360 or l__damage1__1361), v1371.unit * 50);
						if p444 then
							v12:firehitmarker();
						end;
					end;
				end;
			end;
		end;
	end
};
local u343 = shared.require("BinarySearchLib");
local u344 = function(p445, p446, p447, p448, p449, p450, p451)
	if p445 == p448 and p445 == p451 then
		return p449, p450;
	end;
	local v1373 = p448 - p445;
	local v1374 = (p451 - p445) / v1373;
	local v1375 = (p448 - p451) / v1373;
	return v1375 * v1375 * (v1375 + 3 * v1374) * p446 + v1373 * v1375 * v1375 * v1374 * p447 - v1373 * v1375 * v1374 * v1374 * p450 + v1374 * v1374 * (v1374 + 3 * v1375) * p449, 6 * v1375 * v1374 / v1373 * p449 - 6 * v1375 * v1374 / v1373 * p446 + v1375 * (v1375 - 2 * v1374) * p447 + v1374 * (v1374 - 2 * v1375) * p450;
end;
v21:add("newgrenade", function(p452, p453, p454, p455, p456)
	local v1376 = v42.getWeaponData(p453);
	local v1377 = v42.getWeaponModel(p453).Trigger:Clone();
	local l__Indicator__1378 = v1377:FindFirstChild("Indicator");
	v1377.Trail.Enabled = true;
	if l__Indicator__1378 then
		if p452.TeamColor ~= u269.TeamColor then
			l__Indicator__1378.Enemy.Visible = true;
		else
			l__Indicator__1378.Friendly.Visible = true;
		end;
	end;
	v1377.Anchored = true;
	v1377.Ticking:Play();
	v1377.Parent = u281.Misc;
	local u345 = p452 == u269;
	local l__t__346 = p454[1].t;
	local u347 = v41.getTime();
	local u348 = 1;
	local u349 = nil;
	u349 = game:GetService("RunService").RenderStepped:connect(function()
		local v1379 = v41.getTime();
		local v1380 = ((p456 - v1379) * l__t__346 + (v1379 - u347) * p456) / (p456 - u347);
		local v1381, v1382 = u343.spanSearchNodes(p454, "t", v1380);
		local v1383 = p454[v1381];
		local v1384 = p454[v1382];
		local v1385 = Vector3.zero;
		if v1383 and v1384 then
			local v1386, v1387 = u344(v1383.t, v1383.p, v1383.v, v1384.t, v1384.p, v1384.v, v1380);
			v1385 = v1386;
		elseif v1383 then
			v1385 = v1383.p;
			local l__v__1388 = v1383.v;
		elseif v1384 then
			v1385 = v1384.p;
			local l__v__1389 = v1384.v;
		end;
		v1377.CFrame = CFrame.new(v1385);
		if l__Indicator__1378 then
			if v27.sphere(v1385, 4) then
				l__Indicator__1378.Enabled = not workspace:Raycast(v1385, v28.cframe.p - v1385, u289);
			else
				l__Indicator__1378.Enabled = false;
			end;
		end;
		local v1390 = p455[u348];
		if v1390 and v1390.t <= v1380 then
			v34:breakwindow(v1390.part);
			u348 = u348 + 1;
		end;
		if p456 <= v1379 then
			if v1376.grenadetype then
				local v1391 = u342[v1376.grenadetype] and v1376.grenadetype or "Frag";
			else
				v1391 = "Frag";
			end;
			u342[v1391](v1376, v1377, v1385, u345);
			v1377:Destroy();
			u349:Disconnect();
		end;
	end);
end);
u342 = nil;
u344 = nil;
u343 = 1.25;
local u350 = os.clock();
u342 = function()
	return 2.718281828459045 ^ (-(os.clock() - u350) / 1) * (1.25 - u343) + u343;
end;
u344 = function()
	u343 = (u342() - 0.5) / 1.1331484530668263 + 0.5;
	u350 = os.clock();
end;
v21:add("newbullets", function(p457)
	local v1392 = nil;
	local l__player__1393 = p457.player;
	local l__hideminimap__1394 = p457.hideminimap;
	local l__snipercrack__1395 = p457.snipercrack;
	local l__firepos__1396 = p457.firepos;
	local v1397 = p457.pitch * (1 + 0.05 * math.random());
	local l__bullets__1398 = p457.bullets;
	local v1399 = p457.bulletcolor or Color3.new(0.7843137254901961, 0.27450980392156865, 0.27450980392156865);
	local l__penetrationdepth__1400 = p457.penetrationdepth;
	local v1401 = p457.suppression and 1;
	local v1402 = l__player__1393.TeamColor ~= u269.TeamColor;
	local v1403 = { u283, workspace.Terrain, workspace.Ignore, v28.currentcamera };
	local v1404 = v1347(l__player__1393);
	if v1404 then
		v1404.kickweapon(p457.hideflash, p457.soundid, v1397, p457.volume);
		v1392 = v1404:getweaponpos();
	end;
	if not l__hideminimap__1394 or l__hideminimap__1394 and (l__firepos__1396 - v28.cframe.p).Magnitude < p457.hiderange then
		local v1405 = v1404.getlookangles();
		local v1406 = CFrame.new(l__firepos__1396) * CFrame.Angles(v1405.x, v1405.y, 0);
		if v1406 then
			v12:fireradar(l__player__1393, l__hideminimap__1394, p457.pingdata, v1406);
		end;
	end;
	local v1407 = false;
	local v1408 = false;
	for v1409 = 1, #l__bullets__1398 do
		local v1410 = l__bullets__1398[v1409];
		local v1411 = {
			position = l__firepos__1396, 
			velocity = v1410.velocity, 
			acceleration = v18.bulletAcceleration, 
			physicsignore = v1403, 
			color = v1399, 
			size = 0.2, 
			bloom = 0.005, 
			brightness = 400, 
			life = v18.bulletLifeTime, 
			visualorigin = v1392, 
			penetrationdepth = l__penetrationdepth__1400, 
			tracerless = p457.tracerless, 
			thirdperson = true
		};
		local v1412 = v1402;
		if v1412 then
			local u351 = v1407;
			local u352 = v1408;
			v1412 = function(p458, p459)
				local v1413 = p459 * p458.velocity;
				local v1414 = p458.position - v1413;
				local l__p__1415 = v28.cframe.p;
				local v1416 = u125(l__p__1415 - v1414, v1413) / u125(v1413, v1413);
				if v1416 > 0 and v1416 < 1 then
					local l__magnitude__1417 = (v1414 + v1416 * v1413 - l__p__1415).magnitude;
					if l__magnitude__1417 < 2 then
						local v1418 = 2;
					else
						v1418 = l__magnitude__1417;
					end;
					local v1419 = u342() * v1401 / v1418 * p457.bulletspeed / 512 * (math.clamp(((l__p__1415 - p457.firepos).magnitude - p457.range0) / (p457.range1 - p457.range0), 0, 1) * (p457.damage1 - p457.damage0) + p457.damage0) / p457.damage0;
					if l__magnitude__1417 < 50 then
						if not u351 then
							if l__snipercrack__1395 and l__magnitude__1417 < 25 then
								v38.PlaySound("crackBig", nil, 8 / l__magnitude__1417);
							elseif l__magnitude__1417 <= 5 then
								v38.PlaySound("crackSmall", nil, 2);
							end;
							v38.PlaySound("whizz", nil, 2 / l__magnitude__1417, nil, -0.05, 0.05);
							u351 = true;
						end;
						if not u352 and l__magnitude__1417 < 15 then
							u352 = true;
							v21:send("suppressionassist", l__player__1393, v1419, v1410.id);
						end;
					end;
					v28:suppress(v23.random(v1419, v1419));
					u344();
				end;
			end;
		end;
		v1411.onstep = v1412;
		function v1411.ontouch(p460, p461, p462, p463, p464, p465)
			if p461:IsDescendantOf(u282) then
				v34:bullethit(p461, p462, p463, p464, p465, p460.velocity, true, true);
				return;
			end;
			if p461:IsDescendantOf(u283) then
				v34:bloodhit(p462, true, nil, p460.velocity / 10, true);
			end;
		end;
		v33.new(v1411);
	end;
end);
local u353 = 2;
function v14.sethighms(p466)
	u353 = p466;
end;
local u354 = 1;
function v14.setlowms(p467)
	u354 = p467;
end;
local u355 = table.create(game:GetService("Players").MaxPlayers);
local u356 = 0;
local u357 = 0;
local u358 = table.create(game:GetService("Players").MaxPlayers);
local u359 = coroutine.create(function()
	while true do
		if u355[1].lastupframe == u356 then
			coroutine.yield(true);
		elseif u357 < v41.getTime() then
			coroutine.yield(true);
		end;
		local v1420 = table.remove(u355, 1);
		local l__updater__1421 = v1420.updater;
		if l__updater__1421.alive then
			local v1422 = false;
			if l__updater__1421 then
				local v1423, v1424 = l__updater__1421.getpos();
				if v1423 and v1424 then
					v1422 = v27.sphere(v1423, 4) or v27.sphere(v1424, 4);
				end;
			end;
			if v1422 then
				l__updater__1421.step(3, true);
			else
				l__updater__1421.step(1, false);
			end;
		end;
		v1420.lastupframe = u356;
		table.insert(u355, v1420);	
	end;
end);
local u360 = nil;
local u361 = os.clock();
function v14.update()
	local v1425 = os.clock();
	if v10.alive and u361 < v1425 then
		u361 = v1425 + u2;
		local l__angles__1426 = v28.angles;
		v21:send("repupdate", v10.rootpart.Position, Vector2.new(l__angles__1426.x, l__angles__1426.y), v41.getTime());
	end;
end;
local function u362()
	for v1427, v1428 in u296, nil do
		if v1427.Parent then
			if v1428 and v1428.updater and not u358[v1428] then
				u358[v1428] = true;
				table.insert(u355, v1428);
			end;
		else
			print("PLAYER IS GONE", v1427);
			for v1429 = 1, #u355 do
				if u355[v1429] == v1428 then
					table.remove(u355, v1429);
				end;
			end;
			if v1428 and v1428.updater then
				local l__updater__1430 = v1428.updater;
				local v1431 = l__updater__1430.died();
				if v1431 then
					v1431:Destroy();
				end;
				for v1432 in l__updater__1430, nil do
					l__updater__1430[v1432] = nil;
				end;
			end;
			u296[v1427] = nil;
			u358[v1428] = nil;
			for v1433, v1434 in u265, nil do
				if v1434 == v1427 then
					u265[v1433] = nil;
				end;
			end;
			u266[v1427] = nil;
		end;
	end;
	u356 = u356 + 1;
	u357 = v41.getTime() + (u354 + u353) / 1000;
	if #u355 > 0 then
		local v1435, v1436 = coroutine.resume(u359);
		if not v1435 then
			warn("CRITICAL: Replication thread yielded or errored");
			if not u360 then
				u360 = true;
				v21:send("debug", string.format("Replication thread broke.\n%s", v1436));
			end;
		end;
	end;
end;
function v14.step()
	u362();
end;
function v14.cleanup()
	for v1437 = 1, #u284 do
		u284[v1437]:Destroy();
		u284[v1437] = nil;
	end;
end;
local u363 = shared.require("BitBuffer229").newReader();
local u364 = {};
local u365 = u274.new(u275.new(0.020833333333333332), Vector3.zero);
local u366 = u274.new(u276.new(0.020833333333333332), Vector2.new());
local function u367(p468)
	return u363:read(p468);
end;
v21:add("bulkplayerupdate", function(p469)
	if p469.newarray then
		u364 = p469.newarray;
	end;
	if p469.initstates then
		local l__initstates__1438 = p469.initstates;
		for v1439 = 1, #l__initstates__1438 do
			local v1440 = nil;
			v1440 = l__initstates__1438[v1439];
			local v1441 = u364[v1439];
			if v1441 == u269 then
				local v1442, v1443 = unpack(v1440);
				u365:initializeState(unpack(v1442));
				u366:initializeState(unpack(v1443));
			else
				v1347(v1441).initstate(v1440);
			end;
		end;
	end;
	if p469.packets then
		local l__packets__1444 = p469.packets;
		for v1445 = 1, #u364 do
			local v1446 = u364[v1445];
			local v1447 = u363:load(l__packets__1444[v1445]);
			if u363:read(1) == 1 then
				if v1446 == u269 then
					local v1448 = u363:read(64);
					u365:readAndUpdate(u367);
					u366:readAndUpdate(u367);
				else
					v1347(v1446).updateReplication(u367);
				end;
			end;
		end;
	end;
end);
v22.Reset:connect(v14.cleanup);
u3 = print;
u2 = "Loading roundsystem module client";
u3(u2);
u2 = shared;
u3 = u2.require;
u2 = "Quotes";
u3 = u3(u2);
u10 = shared;
u2 = u10.require;
u10 = "ObjectiveManagerClient";
u2 = u2(u10);
u119 = workspace;
u10 = u119.Map;
u119 = game;
u4 = "ReplicatedStorage";
u125 = u119;
u119 = u119.GetService;
u119 = u119(u125, u4);
u98 = "ServerSettings";
u4 = u119;
u125 = u119.WaitForChild;
u125 = u125(u4, u98);
u146 = "Countdown";
u98 = u125;
u4 = u125.WaitForChild;
u4 = u4(u98, u146);
u130 = "Timer";
u146 = u125;
u98 = u125.WaitForChild;
u98 = u98(u146, u130);
u184 = "MaxScore";
u130 = u125;
u146 = u125.WaitForChild;
u146 = u146(u130, u184);
u207 = "GhostScore";
u184 = u125;
u130 = u125.WaitForChild;
u130 = u130(u184, u207);
u150 = "PhantomScore";
u207 = u125;
u184 = u125.WaitForChild;
u184 = u184(u207, u150);
u288 = "ShowResults";
u150 = u125;
u207 = u125.WaitForChild;
u207 = u207(u150, u288);
u289 = "Winner";
u288 = u125;
u150 = u125.WaitForChild;
u150 = u150(u288, u289);
u289 = u125;
u288 = u125.WaitForChild;
u288 = u288(u289, "GameMode");
u296 = "Players";
u284 = game;
u289 = game.GetService(u284, u296).LocalPlayer;
u296 = "PlayerGui";
u284 = u289;
local v1449 = u289.WaitForChild(u284, u296);
u269 = "MainGui";
u296 = v1449;
u284 = v1449.WaitForChild;
u284 = u284(u296, u269);
u294 = "CountDown";
u269 = u284;
u296 = u284.WaitForChild;
u296 = u296(u269, u294);
u294 = u296;
u269 = u296.WaitForChild;
u269 = u269(u294, "TeamName");
u283 = "Title";
u294 = u296.WaitForChild;
u294 = u294(u296, u283);
u282 = "Number";
u283 = u296;
local v1450 = u296.WaitForChild(u283, u282);
u281 = "Tip";
u282 = u296;
u283 = u296.WaitForChild;
u283 = u283(u282, u281);
u279 = "GameGui";
u281 = u284;
u282 = u284.WaitForChild;
u282 = u282(u281, u279);
u293 = "Round";
u279 = u282;
u281 = u282.WaitForChild;
u281 = u281(u279, u293);
u285 = "Score";
u293 = u281;
u279 = u281.WaitForChild;
u279 = u279(u293, u285);
u286 = "GameMode";
u285 = u281;
u293 = u281.WaitForChild;
u293 = u293(u285, u286);
u290 = "Ghosts";
u286 = u279;
u285 = u279.WaitForChild;
u285 = u285(u286, u290);
u287 = "Phantoms";
u290 = u279;
u286 = u279.WaitForChild;
u286 = u286(u290, u287);
u287 = u279;
u290 = u279.WaitForChild;
u290 = u290(u287, "Time");
u292 = "EndMatch";
u287 = u284.WaitForChild;
u287 = u287(u284, u292);
u291 = "Quote";
u292 = u287;
local v1451 = u287.WaitForChild(u292, u291);
u291 = u287;
u292 = u287.WaitForChild;
u292 = u292(u291, "Result");
u265 = "Mode";
u291 = u287.WaitForChild;
u291 = u291(u287, u265);
v15.lock = false;
local v1452 = {};
u265 = u10;
v1452[1] = u265;
v15.raycastwhitelist = v1452;
local u368 = nil;
u265 = function(p470)
	u2:clear();
	if u368 then
		u368:Disconnect();
	end;
	local l__AGMP__1453 = p470:FindFirstChild("AGMP");
	if l__AGMP__1453 then
		for v1454, v1455 in l__AGMP__1453() do
			u2:add(v1455);
		end;
		u368 = l__AGMP__1453.ChildAdded:connect(function(p471)
			u2:add(p471);
		end);
	end;
	if v34.highperf then
		v34:simplify();
	end;
end;
u266 = v21.add;
u266(v21, "newmap", u265);
u266 = u265;
u266(u10);
u266 = function(p472)
	u293.Text = u288.Value;
	if u289.TeamColor == game.Teams.Phantoms.TeamColor then
		u285.Position = UDim2.new(0.5, -48, 0, 44);
		u286.Position = UDim2.new(0.5, -48, 0, 28);
		return;
	end;
	u286.Position = UDim2.new(0.5, -48, 0, 44);
	u285.Position = UDim2.new(0.5, -48, 0, 28);
end;
v12.updateteam = u266;
u266 = function()
	u285.Percent.Size = UDim2.new(u130.Value / u146.Value, 0, 1, 0);
	u285.Point.Text = u130.Value;
	u286.Percent.Size = UDim2.new(u184.Value / u146.Value, 0, 1, 0);
	u286.Point.Text = u184.Value;
end;
local u369 = v1450;
local function u370()
	v15.lock = true;
	if v32.consoleon then
		local v1456 = "Press ButtonSelect to return to menu";
	else
		v1456 = "Press F5 to return to menu";
	end;
	u283.Text = v1456;
	if v10.alive then
		if u289.TeamColor == game.Teams.Ghosts.TeamColor then
			local v1457 = "Ghosts";
		else
			v1457 = "Phantoms";
		end;
		u269.Text = v1457;
		u269.Visible = true;
		u269.TextColor3 = u289.TeamColor.Color;
		u296.Visible = true;
		u369.FontSize = 9;
		u369.Text = u98.Value;
		u369.FontSize = 9;
		task.wait(0.03333333333333333);
		u369.FontSize = 8;
		task.wait(0.03333333333333333);
		u369.FontSize = 7;
		task.wait(0.03333333333333333);
		if u98.Value ~= 0 then
			u296.BackgroundTransparency = 0.5;
			u369.TextTransparency = 0;
			u294.TextTransparency = 0;
			u294.TextStrokeTransparency = 0.5;
			return;
		end;
	else
		return;
	end;
	task.wait(1);
	v15.lock = false;
	task.wait(2);
	u296.Visible = false;
end;
local u371 = v1451;
u280 = function()
	if not u207.Value then
		u287.Visible = false;
		return;
	end;
	v15.lock = true;
	u371.Text = u3[math.random(1, #u3)];
	u287.Visible = true;
	u291.Text = u288.Value;
	if u150.Value == u289.TeamColor then
		u292.Text = "VICTORY";
		u292.TextColor = BrickColor.new("Bright green");
		return;
	end;
	if u150.Value == BrickColor.new("Black") then
		u292.Text = "STALEMATE";
		u292.TextColor = BrickColor.new("Bright orange");
		return;
	end;
	u292.Text = "DEFEAT";
	u292.TextColor = BrickColor.new("Bright red");
end;
u278 = u4.Value;
if u278 then
	u278 = u370;
	u278();
end;
u278 = u280;
u278();
u278 = u98.Changed;
u276 = function()
	if u4.Value then
		u290.Text = "COUNTDOWN";
		u370();
		return;
	end;
	if not u207.Value then
		v15.lock = false;
	end;
	u296.Visible = false;
	local v1458 = u98.Value % 60;
	if v1458 < 10 then
		v1458 = "0" .. v1458;
	end;
	u290.Text = math.floor(u98.Value / 60) .. ":" .. v1458;
end;
u278 = u278.connect;
u278(u278, u276);
u278 = u130.Changed;
u276 = u266;
u278 = u278.connect;
u278(u278, u276);
u278 = u184.Changed;
u276 = u266;
u278 = u278.connect;
u278(u278, u276);
u278 = u207.Changed;
u276 = u280;
u278 = u278.connect;
u278(u278, u276);
u278 = u266;
u278();
u3 = print;
u2 = "Loading game logic module";
u3(u2);
u3 = v10.loadknife;
u2 = v10.loadgun;
u10 = nil;
v10.loadknife = u10;
u10 = nil;
v10.loadgun = u10;
u119 = game;
u10 = u119.Debris;
u125 = game;
u119 = u125.ReplicatedStorage;
u125 = game;
u98 = "RunService";
u4 = u125;
u125 = u125.GetService;
u125 = u125(u4, u98);
u98 = game;
u130 = "Players";
u146 = u98;
u98 = u98.GetService;
u98 = u98(u146, u130);
u4 = u98.LocalPlayer;
u98 = u4.PlayerGui;
u146 = {};
u130 = 1;
u184 = nil;
u207 = nil;
u150 = nil;
u288 = nil;
u289 = nil;
u284 = nil;
u296 = nil;
u269 = nil;
u294 = nil;
u369 = 0;
u283 = nil;
u45.currentgun = u283;
u283 = 3;
u45.gammo = u283;
u283 = function(p473)
	u296 = p473;
end;
u45.setsprintdisable = u283;
u283 = function(p474)
	if not u288 and u45.currentgun and not v10.grenadehold then
		if p474 == "one" then
			local v1459 = 1;
		elseif p474 == "two" then
			v1459 = 2;
		else
			v1459 = (u130 + p474 - 1) % #u146 + 1;
		end;
		u130 = v1459;
		local v1460 = u146[u130];
		if v1460 and v1460 ~= u45.currentgun then
			u45.currentgun:setequipped(false);
			u45.currentgun = v1460;
			v1460:setequipped(true);
			u288 = true;
			task.wait(0.4);
			u288 = false;
		end;
	end;
end;
u282 = function(p475, p476, p477, p478, p479, p480, p481, p482)
	for v1461 = 1, #u146 do
		local v1462 = u146[v1461];
		if v1462 then
			v1462:destroy("death");
			u146[v1461] = nil;
		end;
	end;
	if u207 then
		u207:destroy();
	end;
	v28:setlookvector(p476);
	v10.updatecharacter(p475);
	v10:loadarms(u119.Character["Left Arm"]:Clone(), u119.Character["Right Arm"]:Clone(), "Arm", "Arm");
	u130 = 1;
	u146[1] = u2(p477.Name, false, false, p477.Attachments, p479, p477.Camo, 1);
	if p478 then
		u146[2] = u2(p478.Name, false, false, p478.Attachments, p480, p478.Camo, 2);
	end;
	u207 = u3(p481.Name and "KNIFE", p481.Camo);
	u184 = p482.Name;
	if u184 then
		u45.gammo = v42.getWeaponData(u184, v37.IsStudio()).spare;
	else
		u45.gammo = 3;
	end;
	v12:updateammo("GRENADE", u45.gammo);
	v10.setunaimedfov(v43.getValue("fov"));
	v10.deadcf = nil;
	v10.grenadehold = false;
	v10:reloadsprings();
	v32.mouse.hide();
	v32.mouse.lockcenter();
	v29.disable();
	v12:updateteam();
	v12:enablegamegui(true);
	v12:set_minimap();
	v11:ingame();
	v34:setuplighting(true);
	v10.alive = true;
	v28:setfirstpersoncam();
	u45.currentgun = u146[u130];
	u45.currentgun:setequipped(true);
end;
u281 = function(p483, p484, p485)
	u288 = true;
	if u45.currentgun ~= u207 then
		u207:destroy();
	else
		u45.currentgun:setequipped(false);
	end;
	if not p485 then
		task.wait(0.4);
	end;
	u207 = nil;
	if not p485 then
		task.wait(0.1);
	end;
	u207 = u3(p483, p484);
	u45.currentgun = u207;
	u45.currentgun:setequipped(true);
	if not p485 then
		task.wait(0.4);
	end;
	u288 = false;
end;
u279 = function(p486, p487, p488, p489, p490, p491, p492, p493)
	u288 = true;
	u130 = p492;
	if u45.currentgun then
		u45.currentgun:setequipped(false);
	end;
	if not p493 then
		task.wait(0.4);
	end;
	if u146[p492] then
		u146[p492]:destroy();
		u146[p492] = nil;
	end;
	if not p493 then
		task.wait(0.4);
	end;
	local v1463 = u2(p486, p487, p488, p489, p490, p491, p492);
	u146[p492] = v1463;
	u45.currentgun = v1463;
	u289 = v1463;
	v1463:setequipped(true);
	if not p493 then
		task.wait(0.4);
	end;
	u288 = false;
end;
u293 = function(p494)
	if u146[p494] then
		u146[p494]:remove();
		u146[p494] = nil;
	end;
end;
u286 = v32.mouse;
u285 = u286.onbuttondown;
u290 = function(p495)
	if not u45.currentgun or u288 then
		return;
	end;
	if p495 == "left" and u45.currentgun.shoot then
		if u45.currentgun.inspecting() then
			u45.currentgun:reloadcancel(true);
		end;
		if u45.currentgun.type == "KNIFE" then
			u45.currentgun:shoot(false, "stab1");
			return;
		else
			u45.currentgun:shoot(true);
			return;
		end;
	end;
	if p495 == "right" then
		if u45.currentgun.inspecting() then
			u45.currentgun:reloadcancel(true);
		end;
		if u45.currentgun.setaim then
			u45.currentgun:setaim(true);
			return;
		end;
		if u45.currentgun.type == "KNIFE" then
			u45.currentgun:shoot(false, "stab2");
		end;
	end;
end;
u286 = u285;
u285 = u285.connect;
u285(u286, u290);
u286 = v32.mouse;
u285 = u286.onscroll;
u290 = function(p496)
	if not v10.grenadehold then
		if p496 > 0 then
			local v1464 = 1;
		else
			v1464 = -1;
		end;
		u283(v1464);
	end;
end;
u286 = u285;
u285 = u285.connect;
u285(u286, u290);
u286 = v32.mouse;
u285 = u286.onbuttonup;
u290 = function(p497)
	if not u45.currentgun then
		return;
	end;
	if p497 == "left" and u45.currentgun.shoot then
		if u45.currentgun.type ~= "KNIFE" then
			u45.currentgun:shoot(false);
			return;
		end;
	elseif p497 == "right" and u45.currentgun.setaim then
		u45.currentgun:setaim(false);
	end;
end;
u286 = u285;
u285 = u285.connect;
u285(u286, u290);
u286 = v32.keyboard;
u285 = u286.onkeydown;
local u372 = nil;
u290 = function(p498)
	if p498 == "f6" and not v32.keyboard.down.leftcontrol then
		v12.streamermodetoggle = not v12.streamermodetoggle;
	end;
	if not u45.currentgun or not v10.alive then
		return;
	end;
	if v15.lock and p498 ~= "h" and p498 ~= "q" and p498 ~= "f" and p498 ~= "one" and p498 ~= "two" and p498 ~= "three" then
		return;
	end;
	if u125:IsStudio() then
		v32.mouse:lockcenter();
	end;
	if p498 == "space" then
		if u369 < v41.getTime() then
			if v10:jump(4) then
				u369 = v41.getTime() + 0.6666666666666666;
				return;
			else
				u369 = v41.getTime() + 0.25;
				return;
			end;
		end;
	else
		if p498 == "c" then
			if v10.getslidecondition() and not u150 then
				u150 = true;
				u296 = true;
				v10:setmovementmode("crouch", u150);
				task.wait(0.2);
				u296 = false;
				task.wait(0.9);
				u150 = false;
				return;
			else
				if v10.movementmode == "crouch" then
					local v1465 = "prone";
				else
					v1465 = "crouch";
				end;
				v10:setmovementmode(v1465);
				return;
			end;
		end;
		if p498 == "x" then
			local v1466 = nil;
			local v1467 = nil;
			if v10.sprinting() then
				if not u150 then
					u150 = true;
					u296 = true;
					v10:setmovementmode("prone", u150);
					task.wait(0.8);
					u296 = false;
					if v10.sprinting() and not u296 then
						v10:setsprint(true);
					end;
					task.wait(1.8);
					u150 = false;
					return;
				end;
				v1466 = u150;
				v1467 = v1466;
				if not v1467 then
					if v10.movementmode == "crouch" then
						local v1468 = "stand";
					else
						v1468 = "crouch";
					end;
					v10:setmovementmode(v1468);
					return;
				end;
			else
				v1466 = u150;
				v1467 = v1466;
				if not v1467 then
					if v10.movementmode == "crouch" then
						v1468 = "stand";
					else
						v1468 = "crouch";
					end;
					v10:setmovementmode(v1468);
					return;
				end;
			end;
		else
			if p498 == "leftcontrol" then
				if v10.getslidecondition() and not u150 then
					u150 = true;
					u296 = true;
					v10:setmovementmode("crouch", u150);
					task.wait(0.2);
					u296 = false;
					task.wait(0.9);
					u150 = false;
					return;
				else
					v10:setmovementmode("prone");
					return;
				end;
			end;
			if p498 == "z" then
				local v1469 = nil;
				local v1470 = nil;
				if v10.sprinting() then
					if not u150 then
						u150 = true;
						u296 = true;
						v10:setmovementmode("prone", u150);
						task.wait(0.8);
						u296 = false;
						task.wait(1.8);
						u150 = false;
						return;
					end;
					v1469 = u150;
					v1470 = v1469;
					if not v1470 then
						v10:setmovementmode("stand");
						return;
					end;
				else
					v1469 = u150;
					v1470 = v1469;
					if not v1470 then
						v10:setmovementmode("stand");
						return;
					end;
				end;
			elseif p498 == "r" then
				if not (not u269) or not (not v10.grenadehold) or u288 then
					return;
				end;
				if u45.currentgun.reload and not u45.currentgun.data.loosefiring then
					u45.currentgun:reload();
					return;
				end;
			elseif p498 == "e" then
				if not v10.grenadehold and u45.currentgun.playanimation and not u284 then
					u284 = true;
					if v12:spot() then
						u45.currentgun:playanimation("spot");
					end;
					task.wait(1);
					u284 = false;
					return;
				end;
			else
				if p498 == "f" then
					if u269 or v10.grenadehold then
						return;
					elseif u45.currentgun == u207 then
						u45.currentgun:shoot();
						return;
					else
						u269 = true;
						if u207 then
							u289 = u45.currentgun;
							u45.currentgun = u207;
						end;
						u45.currentgun:setequipped(true, "stab1");
						u288 = true;
						task.wait(0.5);
						if not v32.keyboard.down.f and u289 then
							u45.currentgun = u289;
							if u289 then
								u289:setequipped(true);
							end;
						end;
						u288 = false;
						task.wait(0.5);
						u269 = false;
						return;
					end;
				end;
				if p498 == "g" then
					if not u269 and not u288 and not v10.grenadehold and u45.gammo > 0 then
						u372 = v10:loadgrenade(u184 and "FRAG", u45.currentgun);
						u372:setequipped(true);
						u288 = true;
						task.wait(0.3);
						u288 = false;
						u372:pull();
						return;
					end;
				elseif p498 == "h" then
					if u45.currentgun.isaiming() and u45.currentgun.isblackscope() then
						return;
					end;
					if not v10.grenadehold and not u284 and not u45.currentgun.inspecting() then
						u45.currentgun:playanimation("inspect");
						return;
					end;
				elseif p498 == "leftshift" then
					if u45.currentgun.isaiming() and u45.currentgun.isblackscope() then
						return;
					end;
					if not u296 then
						if v43.getValue("togglesprinttoggle") then
							v10:setsprint(not v10.sprinting());
							return;
						else
							v10:setsprint(true);
							return;
						end;
					end;
				elseif p498 == "w" then
					if not u98:FindFirstChild("Doubletap") and not v10.sprinting() then
						local v1471 = Instance.new("Model");
						v1471.Name = "Doubletap";
						v1471.Parent = u98;
						u10:AddItem(v1471, 0.2);
						return;
					end;
					if u45.currentgun.isaiming() and u45.currentgun.isblackscope() then
						return;
					end;
					if not u296 then
						v10:setsprint(true);
						return;
					end;
				elseif p498 == "q" then
					if v10.grenadehold or u288 then
						return;
					end;
					if u45.currentgun.inspecting() then
						u45.currentgun:reloadcancel(true);
					end;
					if u45.currentgun.setaim then
						u45.currentgun:setaim(not u45.currentgun.isaiming());
						return;
					end;
				elseif p498 == "m" then
					if v5 then
						if v32.mouse:visible() then
							v32.mouse:hide();
							return;
						else
							v32.mouse:show();
							return;
						end;
					end;
				elseif p498 == "t" then
					if u45.currentgun.toggleattachment then
						u45.currentgun:toggleattachment();
						return;
					end;
				elseif p498 == "v" then
					if u288 or v10.grenadehold then
						return;
					end;
					if v12:getuse() then
						local u373 = u45.currentgun;
						task.delay(0.15, function()
							if not v32.keyboard.down.v then
								return;
							end;
							local v1472 = workspace.Ignore.GunDrop:GetChildren();
							local v1473 = 8;
							local v1474 = nil;
							local v1475 = nil;
							for v1476 = 1, #v1472 do
								local v1477 = v1472[v1476];
								if v1477.Name == "Dropped" then
									local l__magnitude__1478 = (v1477.Slot1.Position - v10.rootpart.Position).magnitude;
									if l__magnitude__1478 < v1473 then
										if v1477:FindFirstChild("Gun") then
											v1473 = l__magnitude__1478;
											v1474 = v1477;
											v1475 = nil;
										elseif v1477:FindFirstChild("Knife") then
											v1473 = l__magnitude__1478;
											v1475 = v1477;
											v1474 = nil;
										end;
									end;
								end;
							end;
							if not v1474 then
								if v1475 then
									v21:send("swapweapon", v1475, 3);
									print("sent knife");
								end;
								return;
							end;
							if u373 == u207 then
								u130 = 2;
								u45.currentgun = u146[u130];
								u373 = u45.currentgun;
								u45.currentgun:setequipped(true);
							end;
							v21:send("swapweapon", v1474, u130);
						end);
						return;
					end;
					if u45.currentgun.nextfiremode then
						u45.currentgun:nextfiremode();
						return;
					end;
				elseif p498 == "one" or p498 == "two" then
					if not v10.grenadehold then
						u283(p498);
						return;
					end;
				else
					if p498 == "three" then
						if u45.currentgun == u207 or v10.grenadehold then
							return;
						else
							if u207 then
								u289 = u45.currentgun;
								u45.currentgun = u207;
							end;
							u45.currentgun:setequipped(true);
							u288 = true;
							task.wait(0.5);
							u288 = false;
							return;
						end;
					end;
					if p498 == "f5" or p498 == "f8" then
						if u294 or v32.keyboard.down.leftshift then
							return;
						end;
						u294 = true;
						v10:despawn();
						if not v37.IsTest() and not v37.IsVIP() then
							local v1479 = game:GetService("ReplicatedStorage"):WaitForChild("Misc").RespawnGui.Title:Clone();
							v1479.Parent = u4.PlayerGui:FindFirstChild("MainGui");
							for v1480 = 5, 0, -1 do
								if not v1 then
									v1479.Count.Text = v1480;
									task.wait(1);
								end;
							end;
							v1479:Destroy();
						end;
						u294 = false;
					end;
				end;
			end;
		end;
	end;
end;
u286 = u285;
u285 = u285.connect;
u285(u286, u290);
u286 = v32.keyboard;
u285 = u286.onkeyup;
u290 = function(p499)
	if not u45.currentgun then
		return;
	end;
	if p499 ~= "leftshift" then
		if p499 == "w" and not v32.keyboard.down.leftshift and not v43.getValue("togglesprinttoggle") then
			v10:setsprint(false);
		end;
	elseif not v43.getValue("togglesprinttoggle") then
		v10:setsprint(false);
	end;
end;
u286 = u285;
u285 = u285.connect;
u285(u286, u290);
u285 = v32.controller;
u290 = "a";
u287 = "space";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "x";
u287 = "r";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "r1";
u287 = "g";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "up";
u287 = "h";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "r3";
u287 = "f";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "right";
u287 = "v";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "down";
u287 = "e";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = v32.controller;
u290 = "left";
u287 = "t";
u286 = u285;
u285 = u285.map;
u285(u286, u290, u287);
u285 = nil;
u290 = v32.controller;
u286 = u290.onbuttondown;
u287 = function(p500)
	if not u45.currentgun then
		return;
	end;
	if v15.lock then
		return;
	end;
	if p500 == "b" then
		if v10.movementmode == "crouch" then
			v10:setmovementmode("prone");
			return;
		elseif v10.sprinting() and not u150 then
			u150 = true;
			v10:setmovementmode("crouch", u150);
			task.wait(1);
			u150 = false;
			return;
		else
			v10:setmovementmode("crouch");
			return;
		end;
	end;
	if p500 == "r2" and u45.currentgun.shoot then
		if u45.currentgun.inspecting() then
			u45.currentgun:reloadcancel(true);
		end;
		u45.currentgun:shoot(true);
		return;
	end;
	if p500 == "l2" then
		if u45.currentgun.inspecting() then
			u45.currentgun:reloadcancel(true);
		end;
		if u45.currentgun.setaim then
			u45.currentgun:setaim(true);
			return;
		end;
		if u45.currentgun.type == "KNIFE" then
			u45.currentgun:shoot(false, "stab2");
			return;
		end;
	elseif p500 == "l1" then
		if v10.sprinting() and not u150 then
			u150 = true;
			u296 = true;
			v10:setmovementmode("prone", u150);
			task.wait(0.8);
			u296 = false;
			task.wait(1.8);
			u150 = false;
			return;
		end;
		if not v10.grenadehold and u45.currentgun.playanimation and not u284 then
			u284 = true;
			if v12:spot() then
				u45.currentgun:playanimation("spot");
			end;
			task.wait(1);
			u284 = false;
			return;
		end;
	elseif p500 == "y" then
		if u288 or v10.grenadehold then
			return;
		end;
		u285 = false;
		if v12:getuse() then
			task.delay(0.2, function()
				if not v32.controller.down.y then
					return;
				end;
				u285 = true;
				local v1481 = workspace.Ignore.GunDrop:GetChildren();
				local v1482 = 8;
				local v1483 = nil;
				local v1484 = nil;
				for v1485 = 1, #v1481 do
					local v1486 = v1481[v1485];
					if v1486.Name == "Dropped" then
						local l__magnitude__1487 = (v1486.Slot1.Position - v10.rootpart.Position).magnitude;
						if l__magnitude__1487 < v1482 then
							if v1486:FindFirstChild("Gun") then
								v1482 = l__magnitude__1487;
								v1483 = v1486;
								v1484 = nil;
							elseif v1486:FindFirstChild("Knife") then
								v1482 = l__magnitude__1487;
								v1484 = v1486;
								v1483 = nil;
							end;
						end;
					end;
				end;
				if not v1483 then
					if v1484 then
						v21:send("swapweapon", v1484, 3);
					end;
					return;
				end;
				if u45.currentgun == u207 then
					u130 = 2;
					u45.currentgun = u146[u130];
					u45.currentgun:setequipped(true);
				end;
				v21:send("swapweapon", v1483, u130);
			end);
			return;
		end;
	elseif p500 == "l3" then
		if u45.currentgun.isaiming() and u45.currentgun.isblackscope() then
			u45.steadytoggle = not u45.steadytoggle;
			return;
		end;
		if not u296 then
			if u45.currentgun.isaiming() and u45.currentgun.setaim then
				u45.steadytoggle = false;
				u45.currentgun:setaim(false);
			end;
			v10:setsprint(not v10.sprinting());
			return;
		end;
	elseif p500 == "select" then
		if u294 then
			return;
		end;
		u294 = true;
		for v1488 = 1, 20 do
			task.wait(0.1);
			if not u294 then
				return;
			end;
		end;
		if u294 then
			u294 = false;
			v10:despawn();
		end;
	end;
end;
u290 = u286;
u286 = u286.connect;
u286(u290, u287);
u290 = v32.controller;
u286 = u290.onbuttonup;
u287 = function(p501)
	if not u45.currentgun then
		return;
	end;
	if p501 == "r2" then
		u45.currentgun:shoot(false);
		return;
	end;
	if p501 == "y" then
		if not u285 then
			u283(1);
			return;
		end;
	elseif p501 == "l2" and u45.currentgun.setaim then
		u45.steadytoggle = false;
		if u45.currentgun.isaiming() then
			u45.currentgun:setaim(false);
			return;
		end;
	elseif p501 == "select" and u294 then
		u294 = false;
	end;
end;
u290 = u286;
u286 = u286.connect;
u286(u290, u287);
u286 = function()
	if not u45.currentgun then
		return;
	end;
	if v32.controller.down.b and (v32.controller.down.b + 0.5 < v41.getTime() and v10.movementmode ~= "prone") then
		v10:setmovementmode("prone");
	end;
end;
u45.controllerstep = u286;
u286 = v10.ondied;
u287 = function(p502)
	u369 = 0;
	v12:setscope(false);
	if u45.currentgun then
		u45.currentgun:setequipped(false, "death");
		u45.currentgun = nil;
	end;
	if not p502 then
		task.wait(5);
	end;
	v29.enable();
	v28:setdisabled();
	v12:enablegamegui(false);
	v12:reloadhud();
	v11:inmenu();
	v34:setuplighting(false);
	v32.mouse.show();
	v32.mouse.free();
	v10:setmovementmode("stand");
end;
u290 = u286;
u286 = u286.connect;
u286(u290, u287);
u287 = "spawn";
u371 = u282;
u290 = v21;
u286 = v21.add;
u286(u290, u287, u371);
u287 = "swapgun";
u371 = u279;
u290 = v21;
u286 = v21.add;
u286(u290, u287, u371);
u287 = "removeweapon";
u371 = u293;
u290 = v21;
u286 = v21.add;
u286(u290, u287, u371);
u287 = "swapknife";
u371 = u281;
u290 = v21;
u286 = v21.add;
u286(u290, u287, u371);
u287 = "addammo";
u371 = function(p503, p504, p505)
	if u146[p503] then
		u146[p503]:addammo(p504, p505);
	end;
end;
u290 = v21;
u286 = v21.add;
u286(u290, u287, u371);
u290 = v11;
u286 = v11.inmenu;
u286(u290);
u287 = false;
u290 = v12;
u286 = v12.enablegamegui;
u286(u290, u287);
u287 = false;
u290 = v34;
u286 = v34.setuplighting;
u286(u290, u287);
u286 = v29.enable;
u286();
u10 = "setuiscale";
u119 = function(p506)
	v36.setscale(p506);
end;
u2 = v21;
u3 = v21.add;
u3(u2, u10, u119);
u10 = "setmenuscale";
u119 = function(p507)
	v29.setUIScale(p507);
end;
u2 = v21;
u3 = v21.add;
u3(u2, u10, u119);
u10 = "setmenuaspectratio";
u119 = function(p508)
	v29.setUIAspectRatio(p508);
end;
u2 = v21;
u3 = v21.add;
u3(u2, u10, u119);
u10 = workspace;
u2 = u10.Ignore;
u3 = u2.DeadBody;
u10 = shared;
u2 = u10.require;
u10 = "ExplosionForce";
u2 = u2(u10);
u119 = shared;
u10 = u119.require;
u119 = "ExplosionForceMesh";
u10 = u10(u119);
u125 = shared;
u119 = u125.require;
u125 = "ragdolltable";
u119 = u119(u125);
u125 = function(p509)
	local v1489 = Instance.new("Part");
	v1489.TopSurface = 0;
	v1489.BottomSurface = 0;
	v1489.Size = p509.Size;
	v1489.Color = p509.Color;
	v1489.CastShadow = false;
	v1489.Anchored = false;
	v1489.CanTouch = false;
	v1489.CanQuery = false;
	v1489.Name = p509.Name;
	v1489.CFrame = p509.CFrame;
	v1489.Velocity = p509.Velocity;
	v1489.CollisionGroupId = 3;
	return v1489;
end;
u4 = function(p510, p511)
	local v1490 = Instance.new("Part");
	v1490:BreakJoints();
	v1490.Shape = "Ball";
	v1490.TopSurface = 0;
	v1490.BottomSurface = 0;
	v1490.formFactor = "Custom";
	v1490.Size = Vector3.new(0.25, 0.25, 0.25);
	v1490.Transparency = 1;
	v1490.CastShadow = false;
	v1490.Massless = true;
	v1490.CollisionGroupId = 3;
	local v1491 = Instance.new("Weld");
	v1491.Part0 = p510;
	v1491.Part1 = v1490;
	v1491.C0 = not p511 and CFrame.new(0, -0.5, 0) or p511;
	v1491.Parent = v1490;
	v1490.Parent = p510;
	game.Debris:AddItem(v1490, 5);
end;
u98 = function(p512, p513)
	local v1492 = Instance.new("Part");
	v1492.CastShadow = false;
	v1492.Size = Vector3.new(0.1, 0.1, 0.1);
	v1492.Shape = "Ball";
	v1492.TopSurface = "Smooth";
	v1492.BottomSurface = "Smooth";
	v1492.Transparency = 1;
	v1492.CanCollide = false;
	v1492.Massless = true;
	v1492.CollisionGroupId = 3;
	v1492.Parent = p512;
	game.Debris:AddItem(v1492, 5);
	local v1493 = Instance.new("Weld");
	v1493.Part0 = p512;
	v1493.Part1 = v1492;
	v1493.C0 = u119[p512.Name].c;
	v1493.Parent = v1492;
	local v1494 = Instance.new("Attachment");
	v1494.CFrame = u119[p512.Name].a;
	v1494.Parent = p513;
	local v1495 = Instance.new("Attachment");
	v1495.CFrame = u119[p512.Name].b;
	v1495.Parent = p512;
	if u119[p512.Name].d0 then
		v1494.Axis = u119[p512.Name].d0;
		v1495.Axis = u119[p512.Name].d1;
	end;
	local v1496 = Instance.new("BallSocketConstraint");
	v1496.Attachment0 = v1494;
	v1496.Attachment1 = v1495;
	v1496.Restitution = 0.5;
	v1496.LimitsEnabled = true;
	v1496.UpperAngle = 70;
	v1496.Parent = p513;
end;
u146 = function(p514, p515, p516, p517, p518)
	p517 = p517 or Vector3.zero;
	p518 = p518 and 20;
	local v1497 = p514:Clone();
	local v1498 = nil;
	local l__Torso__1499 = v1497:FindFirstChild("Torso");
	for v1500, v1501 in v1497() do
		if v1501:IsA("BasePart") and v1501.Transparency == 0 then
			v1501.TopSurface = 0;
			v1501.BottomSurface = 0;
			v1501.CastShadow = false;
			v1501.Anchored = false;
			v1501.CanCollide = true;
			v1501.CanTouch = false;
			v1501.CanQuery = false;
			v1501.CollisionGroupId = 3;
			if v1501.Name == p515 then
				v1498 = v1501;
			end;
		end;
	end;
	for v1502 in u119, nil do
		local v1503 = v1497:FindFirstChild(v1502);
		if v1503 then
			u98(v1503, l__Torso__1499);
		end;
	end;
	u4(l__Torso__1499, CFrame.new(0, 0.5, 0));
	v1497.Name = "Dead";
	v1497.Parent = u3;
	if p516 then
		for v1504, v1505 in v1497() do
			if v1505:IsA("BasePart") and u10[v1505.Name] then
				v1505:ApplyImpulseAtPosition(u2.computeMeshExplosionForce(p516, v1505.CFrame, v1505.Size, u10[v1505.Name]) * 300, p516);
			end;
		end;
	elseif v1498 then
		v1498:ApplyImpulseAtPosition(p517 * p518, v1498.Position);
	end;
	local v1506 = {};
	for v1507, v1508 in v1497() do
		if v1508:IsA("BasePart") or v1508:IsA("Decal") then
			table.insert(v1506, v1508);
		end;
	end;
	task.delay(5, function()
		for v1509, v1510 in v1506, nil do
			if v1510:IsA("BasePart") then
				v1510.Anchored = true;
			end;
		end;
	end);
	task.delay(30, function()
		for v1511 = 1, 20 do
			for v1512, v1513 in v1506, nil do
				v1513.Transparency = v1511 / 20;
			end;
			task.wait(0.016666666666666666);
		end;
		v1497:Destroy();
	end);
end;
v21:add("died", function(p519, p520, p521, p522, p523)
	local v1514 = v14.getupdater(p519);
	if v1514 then
		local v1515 = v1514.died();
		if v1515 then
			if v43.getValue("toggleragdolls") then
				u146(v1515, p520, p521, p522, p523);
			end;
			v1515:Destroy();
		end;
	end;
end);
u3 = {};
u2 = "failed to load";
u10 = "http request failed";
u119 = "could not fetch";
u125 = "download sound";
u4 = "thumbnail";
u3[1] = u2;
u3[2] = u10;
u3[3] = u119;
u3[4] = u125;
u3[5] = u4;
u10 = game;
u125 = "LogService";
u119 = u10;
u10 = u10.GetService;
u10 = u10(u119, u125);
u2 = u10.MessageOut;
u119 = function(p524, p525)
	if p525 == Enum.MessageType.MessageError then
		for v1516 = 1, #u3 do
			if string.find(string.lower(p524), u3[v1516]) then
				return;
			end;
		end;
		v21:send("debug", p524);
	end;
end;
u10 = u2;
u2 = u2.connect;
u2(u10, u119);
u119 = "lightingt";
u125 = function(p526)
	v40.setSeed(p526);
end;
u10 = v21;
u2 = v21.add;
u2(u10, u119, u125);
u2 = print;
u10 = "Framework finished loading, duration:";
u125 = tick;
u125 = u125();
u119 = u125 - v4;
u2(u10, u119);
u10 = game;
u125 = "RunService";
u119 = u10;
u10 = u10.GetService;
u10 = u10(u119, u125);
u2 = u10.Heartbeat;
u10 = u2;
u2 = u2.wait;
u2(u10);
u10 = v21;
u2 = v21.ready;
u2(u10);
u2 = v37.IsStudio;
u2 = u2();
if not u2 then

end;
u2 = v22.Reset;
u119 = v38.clear;
u10 = u2;
u2 = u2.connect;
u2(u10, u119);
u10 = shared;
u2 = u10.require;
u10 = "RunUpdater";
u2 = u2(u10);
u119 = shared;
u10 = u119.require;
u119 = "HeartbeatUpdater";
u10 = u10(u119);
u125 = shared;
u119 = u125.require;
u125 = "PageMainMenuDisplayMenu";
u119 = u119(u125);
u98 = "input";
u146 = v32.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146);
u98 = "char";
u146 = v10.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146);
u98 = "notify";
u146 = u99.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "char" });
u98 = "camera";
u146 = v28.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "input", "char" });
u98 = "particle";
u146 = v33.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "camera" });
u98 = "weaponstep";
u146 = v10.animstep;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "char", "particle", "camera" });
u98 = "hud";
u146 = v12.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "char", "camera", "weaponstep" });
u98 = "leaderboard";
u146 = v13.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146);
u98 = "controllerstep";
u146 = u45.controllerstep;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "char", "input" });
u98 = "tween";
u146 = v35.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "weaponstep" });
u98 = "repupdate";
u146 = v14.update;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146, { "char", "camera" });
u98 = "RunUpdater";
u146 = u2.step;
u4 = v19;
u125 = v19.addTask;
u125(u4, u98, u146);
u98 = "replication";
u146 = v14.step;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "daycycle";
u146 = v40.step;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "dynobj";
u146 = v40.objStep;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "blood";
u146 = v34.bloodstep;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "hudbeat";
u146 = v12.beat;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "radar";
u146 = v12.radarstep;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "HeartbeatUpdater";
u146 = u10.step;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u98 = "MenuStep";
u146 = u119.step;
u4 = v20;
u125 = v20.addTask;
u125(u4, u98, u146);
u125 = workspace;
u98 = "Map";
u4 = u125;
u125 = u125.FindFirstChild;
u125 = u125(u4, u98);
u146 = workspace;
u98 = u146.Ignore;
u4 = u98.GunDrop;
u98 = function(p527, p528)
	if not v10.alive then
		return false;
	end;
	local v1517 = v10.rootpart.Position - p527;
	if not (v1517.magnitude < p528) then
		return false;
	end;
	if not (v1517.Y > 10) and not (v1517.Y < 0) then
		return true;
	end;
	return false;
end;
u146 = v20.addTask;
u146(v20, "dropcheck", function()
	local v1518 = u4:GetChildren();
	local v1519 = 8;
	v12:gundrop(false);
	if v10.alive then
		for v1520 = 1, #v1518 do
			local v1521 = v1518[v1520];
			if v1521.Name == "Dropped" and v1521:FindFirstChild("Slot1") then
				local l__magnitude__1522 = (v1521.Slot1.Position - v10.rootpart.Position).magnitude;
				if l__magnitude__1522 < v1519 then
					v1519 = l__magnitude__1522;
					if v1521:FindFirstChild("Gun") then
						v12:gundrop(v1521, v1521.Gun.Value);
					elseif v1521:FindFirstChild("Knife") then
						v12:gundrop(v1521, v1521.Knife.Value);
					end;
				end;
			end;
		end;
	end;
end);
u146 = v20.addTask;
u146(v20, "flagcheck", function()
	local v1523 = nil;
	if v10.alive then
		v1523 = u4:GetChildren();
		v12:capping(false);
		if not u125 then
			return;
		end;
	else
		v12:capping(false);
		return;
	end;
	local l__AGMP__1524 = u125:FindFirstChild("AGMP");
	if l__AGMP__1524 then
		local v1525 = l__AGMP__1524:GetChildren();
		for v1526 = 1, #v1525 do
			local v1527 = v1525[v1526];
			if v1527:FindFirstChild("IsCapping") and v1527.IsCapping.Value and v1527.TeamColor.Value ~= l__LocalPlayer__3.TeamColor and v10.rootpart then
				if not v10.alive then
					local v1528 = false;
				else
					local v1529 = v10.rootpart.Position - v1527.Base.Position;
					if v1529.magnitude < 15 then
						if v1529.Y > 10 or v1529.Y < 0 then
							v1528 = false;
						else
							v1528 = true;
						end;
					else
						v1528 = false;
					end;
				end;
				if v1528 then
					v12:capping(v1527, v1527.CapPoint.Value);
				end;
			end;
		end;
	end;
	for v1530 = 1, #v1523 do
		local v1531 = v1523[v1530];
		if v1531:FindFirstChild("Base") then
			if v1531.Name == "FlagDrop" then
				if not v10.alive then
					local v1532 = false;
				else
					local v1533 = v10.rootpart.Position - v1531.Base.Position;
					if v1533.magnitude < 8 then
						if v1533.Y > 10 or v1533.Y < 0 then
							v1532 = false;
						else
							v1532 = true;
						end;
					else
						v1532 = false;
					end;
				end;
				if v1532 then
					if v1531.TeamColor.Value == l__LocalPlayer__3.TeamColor and v1531:FindFirstChild("IsCapping") and v1531.IsCapping.Value then
						v12:capping(v1531, v1531.CapPoint.Value, "ctf");
					end;
					v21:send("captureflag", v1531.TeamColor.Value);
				end;
			elseif v1531.Name == "DogTag" then
				if not v10.alive then
					local v1534 = false;
				else
					local v1535 = v10.rootpart.Position - v1531.Base.Position;
					if v1535.magnitude < 6 then
						if v1535.Y > 10 or v1535.Y < 0 then
							v1534 = false;
						else
							v1534 = true;
						end;
					else
						v1534 = false;
					end;
				end;
				if v1534 then
					v21:send("capturedogtag", v1531);
				end;
			end;
		end;
	end;
end);
u125 = Instance.new;
u4 = "BindableEvent";
u125 = u125(u4);
u4 = u125.Event;
u146 = function()
	v10:despawn();
end;
u98 = u4;
u4 = u4.Connect;
u4(u98, u146);
u4 = game;
u146 = "StarterGui";
u98 = u4;
u4 = u4.GetService;
u4 = u4(u98, u146);
u146 = "ResetButtonCallback";
u98 = u4;
u4 = u4.SetCore;
u4(u98, u146, u125);
u4 = shared;
u125 = u4.require;
u4 = "PageMainMenuDisplayMenu";
u125 = u125(u4);
u98 = tick;
u98 = u98();
u146 = 1;
u4 = u98 + u146;
u146 = game;
u146 = u146.GetService;
u146 = u146(u146, "UserInputService");
u98 = u146.InputBegan;
u146 = u98;
u98 = u98.connect;
u98(u146, function(p529, p530)
	if p530 then
		return;
	end;
	if v29.isEnabled() then
		local l__KeyCode__1536 = p529.KeyCode;
		local l__Name__1537 = p529.UserInputType.Name;
		if l__Name__1537 == "Keyboard" and l__KeyCode__1536 == Enum.KeyCode.Space or l__Name__1537 == "Gamepad1" and l__KeyCode__1536 == Enum.KeyCode.ButtonX then
			if tick() < u4 then
				return;
			end;
			u4 = tick() + 1;
			if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Loadscreen") then
				return;
			end;
			v21:send("spawn", u125.getSquadSpawnPlayer());
		end;
	end;
end);
u125 = nil;
v32.controller.onstatuschanged:connect(function(p531)
	if p531 ~= u125 and v29.isEnabled() then
		if p531 then
			v32.mouse:hide();
		else
			v32.mouse:show();
		end;
	end;
	u125 = p531;
end);
v29.onEnabled:connect(function()
	if u125 then
		v32.mouse:hide();
	end;
end);
