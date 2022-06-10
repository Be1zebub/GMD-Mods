-- Этот файл обязательно должен присутствовать
-- Его не нужно изменять

local files = file.Find("igs/modules/mixed/*", "LUA")

for _, filename in ipairs(files or {}) do
	local includer = filename[3] == "_" and IGS[filename:sub(1, 2)] or IGS.sh
	includer(filename)
end
