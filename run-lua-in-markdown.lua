#!/usr/bin/env lua

local fd
if not arg[1] or arg[1] == "-" then
	fd = io.stdin
else
	fd = io.open(arg[1], "r")
	if not fd then
		error("can not open file: "..(arg[1]))
	end
end

local whatis = {
	["```lua"]="(",
	["```lua\r"]="(",
	["```"]=")",
	["```\r"]=")",
}
local function getluacode(data)
	local what
	local opened = false
	local r = {}
	for line, nl in data:gmatch("([^\n]*)(\n)") do
		what = whatis[line]
		if not opened and what == "(" then
			opened=true
		elseif opened and what == ")" then
			opened=false
		elseif opened then
			table.insert(r, line..(nl or ""))
		end
	end
	return table.concat(r,"")
end

local data = fd:read("*a")
local pre = [[if type(...)=="string" then pcall(require, (...).."-pre") end;]] -- README.md => README-pre.lua
local luacode = pre..getluacode(data)

local fakemodname = (arg[1]):gsub("%.[^%.]+$", ""):gsub("/%./", "/"):gsub("^%./",""):gsub("/",".")
local fakefilename = nil

arg={[0]=arg[1], select(2, ...)} -- little hack

local r = assert( load(luacode) )(fakemodname, fakefilename)
if r==nil then
	print("=>")
else
	print("=> ("..type(r)..") "..(tostring(r)))
end
