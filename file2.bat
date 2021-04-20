@echo off
:: 判断输入路径是不是文件夹，如果是，则获取文件夹下的所有文件名(包括子文件夹下的)
:: 如果要文件名带上路径，则需要在dir这一句的%%~nxi上作改动
::       code by jm CMD@XP 2006-7-20
if exist data.json del data.json /q
:input
cls
set input=:
set /p input=      please input file path:
set "input=%input:"=%"
:: 上面这句为判断%input%中是否存在引号，有则剔除。
if "%input%"==":" goto input
if not exist "%input%" goto input
for %%i in ("%input%") do if /i "%%~di"==%%i goto input
pushd %cd%
cd /d "%input%">nul 2>nul || exit
set cur_dir=%cd%
popd
for /f "delims=" %%i in ('dir /b /a-d /s "%input%"') do echo %%~nxi>>data.json
exit
 
:no_file
cls
echo    %cur_dir% current path no file
pause