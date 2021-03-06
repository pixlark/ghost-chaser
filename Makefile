# Independent
src=src/main.cc src/astar.cc
out=-o bin/nes -Wno-write-strings
opts=-std=c++11
dyn_libs=-lSDL2main -lSDL2 -lSDL2_mixer -lrender -lutility

# Windows
win_incl_dirs=-I"G:\.minlib\SDL2-2.0.7\x86_64-w64-mingw32\include" -I"G:\.libraries\GLEW\include" -I"G:\C++\2018\gl-backend\src" -I"G:\C++\2018\utility"
win_lib_dirs =-L"G:\.minlib\SDL2-2.0.7\x86_64-w64-mingw32\lib" -L"G:\.minlib\SDL2_mixer-2.0.2\x86_64-w64-mingw32\lib" -L"G:\.minlib\glew-2.1.0\lib" -L"G:\C++\2018\gl-backend\bin" -L"G:\C++\2018\utility"

# Filled options
# TODO(pixlark): nix support
win_full=$(out) $(opts) $(src) $(win_incl_dirs) $(win_lib_dirs) $(dyn_libs)
get_atlas=pushd pallette; \
		  ./pallette.exe atlas.pal \
			32,00,16,16,8 \
			32,16,16,16,8 \
			32,32,16,16,8 \
			32,48,16,16,8 \
		  > nul; \
		  cp expanded.png ../atlas.png; \
		  popd;

win:
	@echo Building Release...
	g++ $(win_full)
	cp "G:\C++\2018\gl-backend\bin\render.dll" "bin\render.dll"
	cp "G:\C++\2018\utility\utility.dll" "bin\utility.dll"
	@echo Building Texture Atlas...
	$(get_atlas)

wing:
	@echo Building Debug...
	g++ -g $(win_full)
	cp "G:\C++\2018\gl-backend\bin\render.dll" "bin\render.dll"
	cp "G:\C++\2018\utility\utility.dll" "bin\utility.dll"
	@echo Building Texture Atlas...
	$(get_atlas)
