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
	["```"]=")",
}
local function getluacode(data)
	local what
	local opened = false
	local r = {}
	local function clean(x)
		return x:gsub("\r$","")
	end
	local line
	for rawline, nl in data:gmatch("([^\n]*)(\n)") do
		line = clean(rawline)
		what = whatis[line]
		if not opened and what == "(" then
			opened=true
			table.insert(r, "\n")
		elseif opened and what == ")" then
			opened=false
			table.insert(r, "\n")
		elseif opened then
			table.insert(r, rawline..(nl or ""))
		else
			if rawline:find("^#") then -- a title
				table.insert(r, 'print("'..(line:gsub('(["\\])','\\%1'))..'")'..(nl or ""))
			else
				table.insert(r, "\n") -- add empty line for debug facility (get the good line number in case of error)
			end
		end
	end
	return table.concat(r,"")
end

local data = fd:read("*a")
local pre = [[if type((...) or nil)=="string" then pcall(require, (...or"").."-pre") end;]] -- README.md => README-pre.lua
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
