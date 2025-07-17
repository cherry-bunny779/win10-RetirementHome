echo Disable Windows Update Medic Service
sc stop WaasMedicSvc
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc /v Start /f /t REG_WORD /d 4
