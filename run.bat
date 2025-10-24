@echo off
cd /d %~dp0
echo Installing dependencies...
pip install -r requirements.txt
echo Starting web application...
start /b python quan_ly_nhan_su.py
timeout /t 5 /nobreak > nul
echo Opening web browser...
start http://127.0.0.1:5000
pause